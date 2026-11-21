with
     openCV.Errors,
     openCV_c.Binding,

     interfaces.C;


package body openCV.Contours
is
   use openCV_c.Binding,
       openCV_c.Pointers,
       interfaces.C;

   use type openCV_c.Pointers.cv_Contours_Pointer;


   procedure require (Self : in Set;   Index : in Positive)
   is
   begin
      if Index > Self.Count
      then
         raise Constraint_Error with "There is no outline" & Index'Image & " in a set of" & Self.Count'Image & ".";
      end if;
   end require;



   ---------
   --- Forge
   --

   function find (in_Image   : in Image;
                  outer_Only : in Boolean := True) return Set
   is
      the_Grey : constant Image := in_Image.to_Grey;     -- Which raises 'Error' for an image with no value.
   begin
      return Result : Set
      do
         Result.Thin := cv_find_contours (the_Grey.thin,
                                          (if outer_Only then 1 else 0));
         Errors.check;
      end return;
   end find;



   --------------
   --- Attributes
   --

   function Count (Self : in Set) return Natural
   is
   begin
      return (if Self.Thin = null then 0
                                  else Natural (cv_contour_count (Self.Thin)));
   end Count;



   function Area (Self : in Set;   Index : in Positive) return Long_Float
   is
   begin
      require (Self, Index);

      return Result : constant Long_Float := Long_Float (cv_contour_area (Self.Thin, int (Index - 1)))
      do
         Errors.check;
      end return;
   end Area;



   function Perimeter (Self : in Set;   Index : in Positive) return Long_Float
   is
   begin
      require (Self, Index);

      return Result : constant Long_Float := Long_Float (cv_contour_perimeter (Self.Thin, int (Index - 1)))
      do
         Errors.check;
      end return;
   end Perimeter;



   function Bounds (Self : in Set;   Index : in Positive) return Box
   is
      Column, Row, Width, Height : aliased int := 0;
   begin
      require (Self, Index);

      cv_contour_bounds (Self.Thin, int (Index - 1),
                         Column'unchecked_Access,
                         Row   'unchecked_Access,
                         Width 'unchecked_Access,
                         Height'unchecked_Access);
      Errors.check;

      return (Row    => Integer (Row),
              Column => Integer (Column),
              Width  => Natural (Width),
              Height => Natural (Height));
   end Bounds;



   function the_Points (Self : in Set;   Index : in Positive) return Points
   is
   begin
      require (Self, Index);

      declare
         Result      : Points (1 .. Natural (cv_contour_size (Self.Thin, int (Index - 1))));
         Column, Row : aliased int := 0;
      begin
         for i in Result'Range
         loop
            cv_contour_point (Self.Thin, int (Index - 1), int (i - 1),
                              Column'unchecked_Access,
                              Row   'unchecked_Access);

            Result (i) := (Row    => Integer (Row),
                           Column => Integer (Column));
         end loop;

         Errors.check;
         return Result;
      end;
   end the_Points;



   function Largest (Self : in Set) return Natural
   is
      Result     : Natural    := 0;
      the_Area   : Long_Float := -1.0;
   begin
      for i in 1 .. Self.Count
      loop
         if Self.Area (i) > the_Area
         then
            the_Area := Self.Area (i);
            Result   := i;
         end if;
      end loop;

      return Result;
   end Largest;



   --------------
   --- Operations
   --

   procedure draw (Self : in Set;   Onto      : in out Image;
                                    Ink       : in     Colour;
                                    Index     : in     Natural := 0;
                                    Thickness : in     Integer := 1)
   is
   begin
      if Self.Count = 0
      then
         return;
      end if;

      if Index /= 0
      then
         require (Self, Index);
      end if;

      cv_draw_contours (Onto.thin, Self.Thin,
                        int (Index) - 1,     -- All of them, for -1.
                        double (Ink.Blue), double (Ink.Green), double (Ink.Red),
                        int (Thickness));
      Errors.check;
   end draw;



   ------------------
   --- Controlled ops
   --

   overriding
   procedure finalize (Self : in out Set)
   is
   begin
      if Self.Thin /= null
      then
         cv_delete_contours (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;

end openCV.Contours;
