with
     openCV.Images,
     openCV.Videos,

     ada.Text_IO,
     ada.Command_Line,
     ada.Directories;


procedure Video
--
--  Writes a short video, of a square which moves across the picture, and reads it back,
--  checking each result. Given the argument 'camera', it also takes a frame from a camera.
--
is
   use openCV,
       openCV.Images,
       ada.Text_IO;

   use type ada.Directories.File_Size;

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


   the_File    : constant String := "build/clip.avi";
   frame_Count : constant        := 12;

   function is_Bright (the_Colour : in Colour) return Boolean
   is (the_Colour.Red > 200 and the_Colour.Green > 200 and the_Colour.Blue > 200);

   function is_Dark   (the_Colour : in Colour) return Boolean
   is (the_Colour.Red <  60 and the_Colour.Green <  60 and the_Colour.Blue <  60);

begin
   --  Write the frames: a white square of 20, which moves 10 to the right in each.
   --
   declare
      the_Sink : openCV.Videos.Sink := openCV.Videos.create (the_File,  Width => 160,  Height => 120,  frame_Rate => 10.0);
   begin
      for i in 1 .. frame_Count
      loop
         declare
            the_Frame : Image := to_Image (Width => 160,  Height => 120);
         begin
            the_Frame.draw_Rectangle (Row => 50,  Column => 10 * i,  Width => 20,  Height => 20,  Ink => White,  Thickness => Filled);
            the_Sink.put (the_Frame);
         end;
      end loop;

      the_Sink.close;
      check (ada.Directories.exists (the_File) and then ada.Directories.Size (the_File) > 1000,   "a video is written to a file");
   end;

   --  Read them back. (The pictures are compressed, so a colour is near what was written, not equal to it.)
   --
   declare
      the_Source : openCV.Videos.Source := openCV.Videos.open_File (the_File);
      the_Frame  : Image;
      Found      : Boolean;
      Count      : Natural := 0;
      All_moved  : Boolean := True;
   begin
      check (the_Source.Width = 160 and the_Source.Height = 120,      "it is opened, with its size");
      check (the_Source.frame_Count = frame_Count,                    "and its count of frames");
      check (abs (the_Source.frame_Rate - 10.0) < 0.01,               "and its rate");

      loop
         the_Source.take (the_Frame, Found);
         exit when not Found;

         Count := Count + 1;

         if not (         is_Bright (the_Frame.Element (60, 10 * Count + 10))       -- Within the square of this frame,
                 and then is_Dark   (the_Frame.Element (60, 10 * Count - 8)))       -- and to the left of it.
         then
            All_moved := False;
         end if;
      end loop;

      check (Count = frame_Count,                                     "each frame is taken, and then no more");
      check (the_Frame.Width = 160 and the_Frame.Height = 120,        "the last frame is kept, and has the size of the video");
      check (All_moved,                                               "the square is where it was drawn, in each frame");
   end;

   ada.Directories.delete_File (the_File);

   --  Errors.
   --
   begin
      declare
         the_Source : openCV.Videos.Source := openCV.Videos.open_File ("no/such/clip.avi") with Unreferenced;
      begin
         check (False,                                                "a video which does not exist cannot be opened");
      end;
   exception
      when openCV.Error =>
         check (True,                                                 "a video which does not exist cannot be opened");
   end;

   if         ada.Command_Line.Argument_Count = 1
     and then ada.Command_Line.Argument (1) = "camera"
   then
      declare
         the_Camera : openCV.Videos.Source := openCV.Videos.open_Camera;
         the_Frame  : Image;
         Found      : Boolean;
      begin
         the_Camera.take (the_Frame, Found);
         check (Found and then the_Frame.Width > 0,                   "a frame is taken from the camera");
         put_Line ("   The camera's frames are" & the_Frame.Width'Image & " by" & the_Frame.Height'Image & ".");
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
end Video;
