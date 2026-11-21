with
     openCV.Errors,
     openCV_c.Binding,

     interfaces.C;


package body openCV.Features
is
   use openCV_c.Binding,
       openCV_c.Pointers,
       interfaces.C;

   use type openCV_c.Pointers.cv_Features_Pointer;


   ---------
   --- Forge
   --

   function find (in_Image : in Image;
                  Most     : in Positive := 500) return Set
   is
      the_Grey : constant Image := in_Image.to_Grey;     -- Which raises 'Error' for an image with no value.
   begin
      return Result : Set
      do
         Result.Thin := cv_find_features (the_Grey.thin, int (Most));
         Errors.check;
      end return;
   end find;



   function find_Corners (in_Image       : in Image;
                          Most           : in Positive   := 100;
                          Quality        : in Long_Float := 0.01;
                          least_Distance : in Long_Float := 10.0) return Set
   is
      the_Grey : constant Image := in_Image.to_Grey;
   begin
      return Result : Set
      do
         Result.Thin := cv_find_corners (the_Grey.thin, int (Most), double (Quality), double (least_Distance));
         Errors.check;
      end return;
   end find_Corners;



   --------------
   --- Attributes
   --

   function Count (Self : in Set) return Natural
   is
   begin
      return (if Self.Thin = null then 0
                                  else Natural (cv_feature_count (Self.Thin)));
   end Count;



   function Element (Self : in Set;   Index : in Positive) return Feature
   is
      Column, Row, Size, Angle, Strength : aliased double := 0.0;
   begin
      if Index > Self.Count
      then
         raise Constraint_Error with "There is no feature" & Index'Image & " in a set of" & Self.Count'Image & ".";
      end if;

      cv_feature (Self.Thin, int (Index - 1),
                  Column  'unchecked_Access,
                  Row     'unchecked_Access,
                  Size    'unchecked_Access,
                  Angle   'unchecked_Access,
                  Strength'unchecked_Access);
      Errors.check;

      return (Row      => Long_Float (Row),
              Column   => Long_Float (Column),
              Size     => Long_Float (Size),
              Angle    => Long_Float (Angle),
              Strength => Long_Float (Strength));
   end Element;



   function drawn (Self : in Set;   Onto : in Image;
                                    Ink  : in Colour := Green) return Image
   is
   begin
      return Result : Image := Onto.to_Colour
      do
         if Self.Thin /= null
         then
            cv_draw_features (Onto.thin, Self.Thin, Result.thin,
                              double (Ink.Blue), double (Ink.Green), double (Ink.Red));
            Errors.check;
         end if;
      end return;
   end drawn;



   ------------
   --- Matching
   --

   function matched (Left, Right : in Set) return Matches
   is
      use type openCV_c.Pointers.cv_Matches_Pointer;

      the_Matches : cv_Matches_Pointer;
   begin
      if        Left .Thin = null
        or else Right.Thin = null
      then
         return [1 .. 0 => <>];
      end if;

      the_Matches := cv_match_features (Left.Thin, Right.Thin);
      Errors.check;

      declare
         Result             : Matches (1 .. Natural (cv_match_count (the_Matches)));
         the_Left,
         the_Right          : aliased int    := 0;
         the_Distance       : aliased double := 0.0;
      begin
         for i in Result'Range
         loop
            cv_match (the_Matches, int (i - 1),
                      the_Left    'unchecked_Access,
                      the_Right   'unchecked_Access,
                      the_Distance'unchecked_Access);

            Result (i) := (Left     => Positive (the_Left  + 1),
                           Right    => Positive (the_Right + 1),
                           Distance => Long_Float (the_Distance));
         end loop;

         cv_delete_matches (the_Matches);
         Errors.check;

         return Result;
      end;
   end matched;



   ------------------
   --- Controlled ops
   --

   overriding
   procedure finalize (Self : in out Set)
   is
   begin
      if Self.Thin /= null
      then
         cv_delete_features (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;

end openCV.Features;
