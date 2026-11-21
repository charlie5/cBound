with
     openCV.Images,

     ada.Text_IO,
     ada.Command_Line,
     ada.Directories,
     ada.Exceptions;


procedure Images
--
--  Draws a picture with the thick binding, puts it through a few operations, saves it
--  and reads it back, checking each result. Given the argument 'show', it also shows
--  the picture in a window until a key is pressed.
--
is
   use openCV,
       openCV.Images,
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


   the_File : constant String := "build/picture.png";
   Navy     : constant Colour := (Red => 10,  Green => 20,  Blue => 80);

   Picture  : Image := to_Image (Width => 160,  Height => 120,  Ground => Navy);

begin
   put_Line ("OpenCV version " & openCV.Version);
   new_Line;

   --  A picture of 160 by 120, in colour: a navy ground, with a white square, a red disc and some text.
   --
   check (Picture.Width = 160 and Picture.Height = 120,   "a picture is made with its size");
   check (Picture.in_Colour,                              "in colour");
   check (Picture.Element (5, 5) = Navy,                  "and on its ground");

   Picture.draw_Rectangle (Row => 30,  Column => 20,  Width => 50,  Height => 50,  Ink => White,  Thickness => Filled);
   Picture.draw_Circle    (Row => 60,  Column => 115, Radius => 25,                Ink => Red,    Thickness => Filled);
   Picture.draw_Text      ("openCV from Ada",  Row => 110,  Column => 8,  Ink => to_Colour (200),  Scale => 0.5);

   check (Picture.Element (55,  45) = White,              "a filled square is drawn");
   check (Picture.Element (60, 115) = Red,                "and a filled disc");
   check (Picture.Element ( 5,   5) = Navy,               "which leave the ground as it was");

   Picture.set (0, 0, To => Green);
   check (Picture.Element (0, 0) = Green,                 "an element is set and read");

   --  An image is a value: a copy does not change with the original.
   --
   declare
      the_Copy : constant Image := Picture;
   begin
      Picture.set (1, 1, To => White);
      check (the_Copy.Element (1, 1) = Navy,              "a copy keeps its own elements");
      check (Picture .Element (1, 1) = White,             "when the original is changed");
   end;

   --  To shades of grey, blurred, and marked where it is bright.
   --
   declare
      the_Grey : constant Image := Picture.to_Grey;
      Marked   : constant Image := the_Grey.blurred (Size => 9,  Sigma => 3.0).above (128);
   begin
      check (not the_Grey.in_Colour and the_Grey.Height = 120,          "a picture is converted to grey");
      check (the_Grey.Grey (55, 45) = 255,                              "in which the white square is still white");
      check (the_Grey.Brightest = 255 and the_Grey.Darkest < 40,        "its darkest and brightest elements are found");
      check (the_Grey.mean_Grey > 40.0 and the_Grey.mean_Grey < 120.0,  "and its mean");

      check (Marked.Grey (55, 45) = 255 and Marked.Grey (5, 5) = 0,     "a blurred picture is marked where it is bright");
      check (Marked.non_zero_Count in 2_000 .. 2_600,                   "which is about the area of the square");

      check (Difference (the_Grey, the_Grey).Brightest = 0,             "a picture does not differ from itself");

      declare
         the_Sum : constant Image := the_Grey + the_Grey;
      begin
         check (the_Sum.Grey (5, 5) = 2 * the_Grey.Grey (5, 5),         "pictures are added");
      end;
   end;

   --  Other operations.
   --
   check (Picture.resized (Width => 80,  Height => 60,  By => Area).Width = 80,   "a picture is made smaller");
   check (Picture.flipped (Horizontally).Element (60, 159 - 115) = Red,           "and flipped");
   check (Picture.Edges (50.0, 150.0).non_zero_Count > 100,                       "and its edges are found");

   --  To a file, and back.
   --
   Picture.write (the_File);

   declare
      Read_back : constant Image := read (the_File);
   begin
      check (Read_back.Width = 160 and Read_back.Height = 120,          "a picture is written to a file and read back");
      check (Read_back.Element (60, 115) = Red,                         "with its elements");
   end;

   ada.Directories.delete_File (the_File);

   --  Errors.
   --
   declare
      Unused : Image;
   begin
      Unused := read ("no/such/file.png");
      check (False,                                                     "a file which does not exist cannot be read");
   exception
      when openCV.Error =>
         check (True,                                                   "a file which does not exist cannot be read");
   end;

   declare
      Unused : Image;
   begin
      Unused := Picture + Picture.resized (10, 10);
      check (False,                                                     "pictures of different sizes cannot be added");
   exception
      when the_Error : openCV.Error =>
         check (ada.Exceptions.Exception_Message (the_Error)'Length > 0,   "an error which OpenCV reports is raised, with its message");
   end;

   declare
      Unused : Colour;
   begin
      Unused := Picture.Element (Row => 500,  Column => 0);
      check (False,                                                     "an element outside the picture cannot be read");
   exception
      when Constraint_Error =>
         check (True,                                                   "an element outside the picture cannot be read");
   end;

   if         ada.Command_Line.Argument_Count = 1
     and then ada.Command_Line.Argument (1) = "show"
   then
      new_Line;
      put_Line ("Press a key, in the window, to end.");
      Picture.show ("images");

      declare
         Key : constant Integer := wait_for_Key with Unreferenced;
      begin
         close_all;
      end;
   end if;

   new_Line;

   if Failures = 0
   then
      put_Line ("All of the checks passed.");
   else
      put_Line (Failures'Image & " checks failed.");
      ada.Command_Line.set_exit_Status (ada.Command_Line.Failure);
   end if;
end Images;
