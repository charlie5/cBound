with
     openCV.Images,
     openCV.Cameras,

     ada.Text_IO,
     ada.Command_Line;


procedure Cameras
--
--  Measures a camera from several views of a grid of points, and finds the corners of a chessboard
--  in a picture, checking each result.
--
--  There is no camera to hand, so the views are worked out: where a camera of a known focal length
--  and centre would see the grid, from several angles. The measuring should then give that camera back.
--
is
   use openCV,
       openCV.Images,
       openCV.Cameras,
       ada.Text_IO;

   Failures : Natural := 0;


   procedure check (Condition : in Boolean;   What : in String)
   is
   begin
      if Condition
      then
         put_Line ("   ok      " & What);
      else
         put_Line ("   FAILED  " & What);
         Failures := Failures + 1;
      end if;
   end check;


   function near (Value, Target, Within : in Long_Float) return Boolean
   is (abs (Value - Target) <= Within);

begin
   openCV.use_OpenCL (False);     -- So that the demo runs where there is no usable graphics card.

   measuring :
   declare
      the_focal_Length : constant Long_Float := 500.0;
      the_Centre       : constant Spot       := (Row => 240.0,  Column => 320.0);

      --  A flat grid of 6 by 5 points, 30 apart.
      --
      the_Grid   : Places (1 .. 30);
      the_Camera : Camera;
      the_Error  : Long_Float;

      type View is
         record
            Rotation,
            Translation : Place;
         end record;

      the_Views : constant array (1 .. 5) of View
        := [(Rotation => ( 0.00,  0.00, 0.0),  Translation => ( -75.0,  -60.0, 600.0)),
            (Rotation => ( 0.35,  0.00, 0.0),  Translation => ( -75.0,  -60.0, 650.0)),
            (Rotation => ( 0.00,  0.35, 0.1),  Translation => ( -60.0,  -60.0, 700.0)),
            (Rotation => (-0.30,  0.20, 0.2),  Translation => ( -90.0,  -40.0, 620.0)),
            (Rotation => ( 0.20, -0.35, 0.0),  Translation => ( -50.0,  -70.0, 580.0))];
   begin
      for Row in 0 .. 4
      loop
         for Column in 0 .. 5
         loop
            the_Grid (Row * 6 + Column + 1) := (X => 30.0 * Long_Float (Column),
                                                Y => 30.0 * Long_Float (Row),
                                                Z => 0.0);
         end loop;
      end loop;

      check (the_Camera.view_Count = 0 and the_Camera.focal_Length_across = 1.0,   "a camera has no views or measures at first");

      for Each of the_Views
      loop
         the_Camera.add_View (the_Grid,
                              seen_at => seen_at (the_Grid,
                                                  focal_Length => the_focal_Length,
                                                  Centre       => the_Centre,
                                                  Rotation     => Each.Rotation,
                                                  Translation  => Each.Translation));
      end loop;

      check (the_Camera.view_Count = 5,                                    "views of a grid of points are added");

      the_Camera.measure (Width => 640,  Height => 480,  Error => the_Error);

      put_Line ("    Focal length" & the_Camera.focal_Length_across'Image & ", centre at row" & the_Camera.Centre.Row'Image
                & ", column" & the_Camera.Centre.Column'Image & ", error" & the_Error'Image);

      check (the_Error < 0.01,                                             "the camera is measured, to a small error");
      check (near (the_Camera.focal_Length_across, the_focal_Length, 1.0), "its focal length across is that of the camera which made the views");
      check (near (the_Camera.focal_Length_down,   the_focal_Length, 1.0), "and its focal length down");
      check (    near (the_Camera.Centre.Row,    the_Centre.Row,    1.0)
             and near (the_Camera.Centre.Column, the_Centre.Column, 1.0),  "and its centre");
      check (near (the_Camera.Distortion (1), 0.0, 0.01),                  "and its lens has no distortion");

      declare
         Picture : constant Image := to_Image (Width => 640,  Height => 480,  Ground => Blue);
         Mended  : constant Image := the_Camera.undistorted (Picture);
      begin
         check (Mended.Width = 640 and Mended.Element (240, 320) = Blue,   "a picture is given with the distortion taken out");
      end;
   end measuring;

   chessboards :
   declare
      Square  : constant := 40;
      Picture : Image    := to_Image (Width => 400,  Height => 320,  in_Colour => False,  Ground => White);
   begin
      --  A board of 7 by 5 squares, which has 6 by 4 inner corners, with its top left corner at row 60, column 60.
      --
      for Row in 0 .. 4
      loop
         for Column in 0 .. 6
         loop
            if (Row + Column) mod 2 = 0
            then
               Picture.draw_Rectangle (Row    => 60 + Square * Row,
                                       Column => 60 + Square * Column,
                                       Width  => Square,
                                       Height => Square,
                                       Ink    => Black,
                                       Thickness => Filled);
            end if;
         end loop;
      end loop;

      declare
         the_Corners : constant Spots := Chessboard (Picture,  Columns => 6,  Rows => 4);
         In_place    :          Natural := 0;
      begin
         check (the_Corners'Length = 24,                                   "the inner corners of a chessboard are found");

         --  Each should be where four squares meet, whichever end of the board the library began at.
         --
         for Each of the_Corners
         loop
            declare
               Down   : constant Long_Float := (Each.Row    - 60.0) / Long_Float (Square);
               Across : constant Long_Float := (Each.Column - 60.0) / Long_Float (Square);
            begin
               if         near (Down,   Long_Float'Rounding (Down),   0.05)  and then Down   > 0.5 and then Down   < 4.5
                 and then near (Across, Long_Float'Rounding (Across), 0.05)  and then Across > 0.5 and then Across < 6.5
               then
                  In_place := In_place + 1;
               end if;
            end;
         end loop;

         check (In_place = the_Corners'Length,                             "each where four squares meet");
      end;

      check (Chessboard (Picture,  Columns => 9,  Rows => 9)'Length = 0,   "a board of another size is not found");
   end chessboards;

   new_Line;

   if Failures = 0
   then
      put_Line ("All of the checks passed.");
   else
      put_Line (Failures'Image & " checks failed.");
      ada.Command_Line.set_exit_Status (ada.Command_Line.Failure);
   end if;
end Cameras;
