with
     openCV.Errors,
     openCV_c.Binding,

     interfaces.C;


package body openCV.Cameras
is
   use openCV_c.Binding,
       openCV_c.Pointers,
       interfaces.C;

   use type openCV_c.Pointers.cv_Camera_Pointer;


   type Reals is array (Natural range <>) of aliased double;     -- As the library takes its points: one number after another.


   function to_Reals (the_Places : in Places) return Reals
   is
      Result : Reals (0 .. 3 * the_Places'Length - 1);
   begin
      for i in the_Places'Range
      loop
         declare
            Offset : constant Natural := 3 * (i - the_Places'First);
         begin
            Result (Offset)     := double (the_Places (i).X);
            Result (Offset + 1) := double (the_Places (i).Y);
            Result (Offset + 2) := double (the_Places (i).Z);
         end;
      end loop;

      return Result;
   end to_Reals;



   function to_Reals (the_Spots : in Spots) return Reals
   is
      Result : Reals (0 .. 2 * the_Spots'Length - 1);
   begin
      for i in the_Spots'Range
      loop
         declare
            Offset : constant Natural := 2 * (i - the_Spots'First);
         begin
            Result (Offset)     := double (the_Spots (i).Column);
            Result (Offset + 1) := double (the_Spots (i).Row);
         end;
      end loop;

      return Result;
   end to_Reals;



   function to_Spots (the_Reals : in Reals) return Spots
   is
      Result : Spots (1 .. the_Reals'Length / 2);
   begin
      for i in Result'Range
      loop
         Result (i) := (Column => Long_Float (the_Reals (the_Reals'First + 2 * (i - 1))),
                        Row    => Long_Float (the_Reals (the_Reals'First + 2 * (i - 1) + 1)));
      end loop;

      return Result;
   end to_Spots;



   -------------
   --- Measuring
   --

   procedure add_View (Self : in out Camera;   the_Places : in Places;
                                               seen_at    : in Spots)
   is
   begin
      if        the_Places'Length = 0
        or else the_Places'Length /= seen_at'Length
      then
         raise Constraint_Error with "A view needs as many places as spots, and some of each.";
      end if;

      declare
         the_Objects : aliased Reals := to_Reals (the_Places);
         the_Images  : aliased Reals := to_Reals (seen_at);
      begin
         cv_add_view (Self.Thin,
                      the_Objects (0)'unchecked_Access,
                      the_Images  (0)'unchecked_Access,
                      int (the_Places'Length));
         Errors.check;
      end;
   end add_View;



   function view_Count (Self : in Camera) return Natural
   is
   begin
      return Natural (cv_view_count (Self.Thin));
   end view_Count;



   procedure measure (Self : in out Camera;   Width, Height : in     Positive;
                                              Error         :    out Long_Float)
   is
   begin
      Error := Long_Float (cv_calibrate (Self.Thin, int (Width), int (Height)));
      Errors.check;
   end measure;



   function focal_Length_across (Self : in Camera) return Long_Float
   is
   begin
      return Long_Float (cv_focal_length_across (Self.Thin));
   end focal_Length_across;



   function focal_Length_down (Self : in Camera) return Long_Float
   is
   begin
      return Long_Float (cv_focal_length_down (Self.Thin));
   end focal_Length_down;



   function Centre (Self : in Camera) return Spot
   is
   begin
      return (Row    => Long_Float (cv_centre_row    (Self.Thin)),
              Column => Long_Float (cv_centre_column (Self.Thin)));
   end Centre;



   function Distortion (Self : in Camera;   Index : in distortion_Index) return Long_Float
   is
   begin
      return Result : constant Long_Float := Long_Float (cv_distortion (Self.Thin, int (Index - 1)))
      do
         Errors.check;
      end return;
   end Distortion;



   function undistorted (Self : in Camera;   the_Image : in Image) return Image
   is
   begin
      if the_Image.is_Empty
      then
         raise Error with "The image is empty.";
      end if;

      return Result : Image := to_Image (Width => 1,  Height => 1)     -- An image for the library to fill.
      do
         cv_undistort (Self.Thin, the_Image.thin, Result.thin);
         Errors.check;
      end return;
   end undistorted;



   ------------
   --- Utility
   --

   function Chessboard (in_Image      : in Image;
                        Columns, Rows : in Positive) return Spots
   is
      the_Grey    : constant Image := in_Image.to_Grey;     -- Which raises 'Error' for an image with no value.
      the_Corners : aliased  Reals (0 .. 2 * Columns * Rows - 1) := [others => 0.0];
      Found       :          Boolean;
   begin
      Found := cv_find_chessboard (the_Grey.thin, int (Columns), int (Rows), the_Corners (0)'unchecked_Access) /= 0;
      Errors.check;

      return (if Found then to_Spots (the_Corners)
                       else [1 .. 0 => <>]);
   end Chessboard;



   function seen_at (the_Places   : in Places;
                     focal_Length : in Long_Float;
                     Centre       : in Spot;
                     Rotation     : in Place := (0.0, 0.0, 0.0);
                     Translation  : in Place := (0.0, 0.0, 0.0)) return Spots
   is
   begin
      if the_Places'Length = 0
      then
         return [1 .. 0 => <>];
      end if;

      declare
         the_Objects     : aliased Reals := to_Reals (the_Places);
         the_Images      : aliased Reals (0 .. 2 * the_Places'Length - 1) := [others => 0.0];
         the_Rotation    : aliased Reals := [double (Rotation   .X), double (Rotation   .Y), double (Rotation   .Z)];
         the_Translation : aliased Reals := [double (Translation.X), double (Translation.Y), double (Translation.Z)];
      begin
         cv_project (double (focal_Length),
                     double (focal_Length),
                     double (Centre.Column),
                     double (Centre.Row),
                     the_Rotation    (0)'unchecked_Access,
                     the_Translation (0)'unchecked_Access,
                     the_Objects     (0)'unchecked_Access,
                     int (the_Places'Length),
                     the_Images      (0)'unchecked_Access);
         Errors.check;

         return to_Spots (the_Images);
      end;
   end seen_at;



   ------------------
   --- Controlled ops
   --

   overriding
   procedure initialize (Self : in out Camera)
   is
   begin
      Self.Thin := cv_new_camera;
   end initialize;



   overriding
   procedure finalize (Self : in out Camera)
   is
   begin
      if Self.Thin /= null
      then
         cv_delete_camera (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;

end openCV.Cameras;
