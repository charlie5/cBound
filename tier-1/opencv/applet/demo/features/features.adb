with
     openCV.Images,
     openCV.Features,

     ada.Text_IO,
     ada.Command_Line;


procedure Features
--
--  Finds the features of a picture, and finds them again in a copy of the picture
--  which has been moved, checking each result.
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


   procedure draw_Scene (Onto : in out Image;   Down, Across : in Integer)
   --
   --  Several shapes and some words, moved down and across by the given amounts.
   --
   is
   begin
      Onto.draw_Rectangle (Row =>  60 + Down,  Column =>  70 + Across,  Width => 60,  Height => 40,  Ink => White,          Thickness => Filled);
      Onto.draw_Rectangle (Row => 150 + Down,  Column => 180 + Across,  Width => 35,  Height => 70,  Ink => to_Colour (180),  Thickness => Filled);
      Onto.draw_Circle    (Row => 100 + Down,  Column => 230 + Across,  Radius => 28,                Ink => to_Colour (220),  Thickness => Filled);
      Onto.draw_Line      (from_Row => 200 + Down,  from_Column => 60 + Across,
                           to_Row   => 150 + Down,  to_Column   => 130 + Across,  Ink => White,  Thickness => 4);
      Onto.draw_Text      ("Ada",     Row => 215 + Down,  Column => 190 + Across,  Ink => White,  Scale => 1.5,  Thickness => 3);
      Onto.draw_Text      ("openCV",  Row =>  50 + Down,  Column => 170 + Across,  Ink => White,  Scale => 1.0,  Thickness => 2);
   end draw_Scene;


   Down   : constant := 12;
   Across : constant := 25;

   First  : Image := to_Image (Width => 360,  Height => 280,  in_Colour => False);
   Second : Image := to_Image (Width => 360,  Height => 280,  in_Colour => False);

begin
   openCV.use_OpenCL (False);     -- So that the demo runs where there is no usable graphics card.

   draw_Scene (First,   Down => 0,     Across => 0);
   draw_Scene (Second,  Down => Down,  Across => Across);

   declare
      the_First  : constant openCV.Features.Set := openCV.Features.find (First);
      the_Second : constant openCV.Features.Set := openCV.Features.find (Second);
   begin
      check (the_First.Count > 20 and the_Second.Count > 20,          "features are found in each picture");

      declare
         the_Feature : constant openCV.Features.Feature := the_First.Element (1);
      begin
         check (    the_Feature.Row    > 0.0 and the_Feature.Row    < 280.0
                and the_Feature.Column > 0.0 and the_Feature.Column < 360.0,   "a feature is within its picture");
         check (the_Feature.Size > 0.0 and the_Feature.Strength > 0.0,          "and has a size and a strength");
      end;

      --  Pair the features of the two pictures, and see how far each has moved.
      --
      declare
         the_Matches : constant openCV.Features.Matches := openCV.Features.matched (the_First, the_Second);
         Moved_right :          Natural := 0;
      begin
         check (the_Matches'Length > 10,                              "features of the first are paired with those of the second");

         for Each of the_Matches
         loop
            declare
               From : constant openCV.Features.Feature := the_First .Element (Each.Left);
               To   : constant openCV.Features.Feature := the_Second.Element (Each.Right);
            begin
               if         abs (To.Row    - From.Row    - Long_Float (Down))   < 2.0
                 and then abs (To.Column - From.Column - Long_Float (Across)) < 2.0
               then
                  Moved_right := Moved_right + 1;
               end if;
            end;
         end loop;

         put_Line ("   " & Moved_right'Image & " of" & the_Matches'Length'Image & " pairs show the move.");
         check (Moved_right * 10 >= the_Matches'Length * 8,           "four in five of the pairs, at least, show how the picture was moved");
      end;

      declare
         Ringed : constant Image := the_First.drawn (Onto => First);
      begin
         check (Ringed.in_Colour and Ringed.Width = 360,              "the features are drawn on a copy of the picture");
      end;

      begin
         check (the_First.Element (100_000).Size < 0.0,               "a feature which does not exist cannot be read");
      exception
         when Constraint_Error =>
            check (True,                                              "a feature which does not exist cannot be read");
      end;
   end;

   --  Corners.
   --
   declare
      the_Square  : Image := to_Image (Width => 200,  Height => 200,  in_Colour => False);
   begin
      the_Square.draw_Rectangle (Row => 50,  Column => 60,  Width => 80,  Height => 90,  Ink => White,  Thickness => Filled);

      declare
         the_Corners : constant openCV.Features.Set := openCV.Features.find_Corners (the_Square,  Most => 10);
         Near_one    :          Natural := 0;
      begin
         check (the_Corners.Count = 4,                                "the four corners of a rectangle are found");

         for i in 1 .. the_Corners.Count
         loop
            declare
               the_Corner : constant openCV.Features.Feature := the_Corners.Element (i);
            begin
               if         (abs (the_Corner.Row    - 50.0) < 3.0 or else abs (the_Corner.Row    - 139.0) < 3.0)
                 and then (abs (the_Corner.Column - 60.0) < 3.0 or else abs (the_Corner.Column - 139.0) < 3.0)
               then
                  Near_one := Near_one + 1;
               end if;
            end;
         end loop;

         check (Near_one = the_Corners.Count,                         "each where a corner is");
      end;
   end;

   new_Line;

   if Failures = 0
   then
      put_Line ("All of the checks passed.");
   else
      put_Line (Failures'Image & " checks failed.");
      ada.Command_Line.set_exit_Status (ada.Command_Line.Failure);
   end if;
end Features;
