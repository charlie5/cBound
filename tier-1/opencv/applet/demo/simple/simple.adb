with
     openCV_c.Binding,
     openCV_c.Pointers,

     Interfaces.C.Strings,

     Ada.Text_IO,
     Ada.Command_Line,
     Ada.Directories;


procedure Simple
--
--  Draws a picture, puts it through a few operations, saves it and reads it back,
--  checking each result. Given the argument 'show', it also shows the picture in
--  a window until a key is pressed.
--
is
   use openCV_c,
       openCV_c.Binding,
       openCV_c.Pointers,
       Interfaces.C,
       Interfaces.C.Strings,
       Ada.Text_IO;

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


   the_File  : constant String := "build/picture.png";

   Picture   : constant Mat_Pointer := cv_new_image_of (Rows => 120,  Columns => 160,  the_Type => CV_8UC3_type);
   Grey      : constant Mat_Pointer := cv_new_image;
   Blurred   : constant Mat_Pointer := cv_new_image;
   Marked    : constant Mat_Pointer := cv_new_image;
   Small     : constant Mat_Pointer := cv_new_image;
   Read_back : constant Mat_Pointer := cv_new_image;

   Name      : chars_ptr := new_String (the_File);
   Title     : chars_ptr := new_String ("openCV from Ada");
   Window    : chars_ptr := new_String ("simple");

   Least,
   Greatest  : aliased double;

begin
   put_Line ("OpenCV version " & Value (cv_version));
   new_Line;

   --  A picture of 160 by 120, in colour.
   --
   check (cv_rows (Picture) = 120 and cv_columns (Picture) = 160,   "a picture is made with its size");
   check (cv_channels (Picture) = 3,                                "and three channels");
   check (cv_get (Picture, 10, 10, 0) = 0,                          "and is black at first");

   --  A dark blue ground, with a white square, a red disc and some text.
   --
   cv_fill (Picture,  Blue => 80.0,  Green => 20.0,  Red => 10.0);
   check (cv_get (Picture, 5, 5, 0) = 80 and cv_get (Picture, 5, 5, 2) = 10,   "it is filled with a colour");

   cv_draw_rectangle (Picture,  Column => 20,  Row => 30,  Width => 50,  Height => 50,
                      Blue => 255.0,  Green => 255.0,  Red => 255.0,  Thickness => FILLED);
   check (cv_get (Picture, 55, 45, 1) = 255,                        "a filled square is drawn");
   check (cv_get (Picture, 5, 5, 1) = 20,                           "which leaves the ground as it was");

   cv_draw_circle    (Picture,  Column => 115,  Row => 60,  Radius => 25,
                      Blue => 0.0,  Green => 0.0,  Red => 255.0,  Thickness => FILLED);
   check (cv_get (Picture, 60, 115, 2) = 255 and cv_get (Picture, 60, 115, 0) = 0,   "a filled disc is drawn");

   cv_draw_text      (Picture,  Title,  Column => 8,  Row => 110,  Scale => 0.5,
                      Blue => 200.0,  Green => 200.0,  Red => 200.0,  Thickness => 1);

   cv_set (Picture, 0, 0, 1, 123);
   check (cv_get (Picture, 0, 0, 1) = 123,                          "an element is set and read");

   --  To shades of grey.
   --
   cv_convert_colour (Picture, Grey, BGR_TO_GREY);
   check (cv_channels (Grey) = 1 and cv_rows (Grey) = 120,          "a picture is converted to grey");
   check (cv_get (Grey, 55, 45, 0) = 255,                           "in which the white square is still white");

   cv_least_and_greatest (Grey, Least'unchecked_Access, Greatest'unchecked_Access);
   check (Greatest = 255.0 and Least < 40.0,                        "its least and greatest elements are found");
   check (cv_mean (Grey, 0) > 40.0 and cv_mean (Grey, 0) < 120.0,   "and its mean");

   --  Blurred, and then marked where it is bright.
   --
   cv_gaussian_blur (Grey, Blurred,  Size => 9,  Sigma => 3.0);
   check (cv_get (Blurred, 30, 20, 0) < 255 and cv_get (Blurred, 30, 20, 0) > 30,   "a blur softens the corner of the square");

   check (cv_threshold (Blurred, Marked,  Threshold => 128.0,  Greatest => 255.0,  Kind => THRESHOLD_BINARY) = 128.0,
          "a threshold is applied");
   check (cv_get (Marked, 55, 45, 0) = 255 and cv_get (Marked, 5, 5, 0) = 0,   "which leaves only white and black");
   check (cv_count_non_zero (Marked) > 2_000 and cv_count_non_zero (Marked) < 2_600,   "and marks about the area of the square");

   --  Smaller.
   --
   cv_resize (Picture, Small,  Columns => 80,  Rows => 60,  Interpolation => INTERPOLATE_AREA);
   check (cv_columns (Small) = 80 and cv_rows (Small) = 60,         "a picture is made smaller");

   --  To a file, and back.
   --
   check (cv_write (Name, Picture) = 1,                             "a picture is written to a file");
   check (cv_read  (Name, READ_COLOUR, Read_back) = 1,              "and read from it");
   check (cv_rows (Read_back) = 120 and cv_columns (Read_back) = 160,   "with its size");
   check (cv_get (Read_back, 60, 115, 2) = 255 and cv_get (Read_back, 5, 5, 0) = 80,   "and its elements");

   Ada.Directories.delete_File (the_File);

   --  An error which the library reports does not stop the program.
   --
   cv_convert_colour (Grey, Marked, BGR_TO_GREY);     -- 'Grey' is not a picture in colour.
   check (True,                                                     "an error which OpenCV reports is survived");

   if         Ada.Command_Line.Argument_Count = 1
     and then Ada.Command_Line.Argument (1) = "show"
   then
      new_Line;
      put_Line ("Press a key, in the window, to end.");
      cv_show (Window, Picture);

      declare
         Key : constant int := cv_wait_for_key (0) with Unreferenced;
      begin
         cv_close_all;
      end;
   end if;

   cv_delete (Read_back);
   cv_delete (Small);
   cv_delete (Marked);
   cv_delete (Blurred);
   cv_delete (Grey);
   cv_delete (Picture);

   free (Window);
   free (Title);
   free (Name);

   new_Line;

   if Failures = 0
   then
      put_Line ("All of the checks passed.");
   else
      put_Line (Failures'Image & " checks failed.");
      Ada.Command_Line.set_exit_Status (Ada.Command_Line.Failure);
   end if;
end Simple;
