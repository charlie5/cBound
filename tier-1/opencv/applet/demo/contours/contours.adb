with
     openCV.Images,
     openCV.Contours,

     ada.Text_IO,
     ada.Command_Line;


procedure Contours
--
--  Draws three shapes, finds their outlines and measures them, checking each result.
--
is
   use openCV,
       openCV.Images,
       ada.Text_IO;

   use type openCV.Contours.Box;

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


   Picture : Image := to_Image (Width => 200,  Height => 150,  in_Colour => False);

begin
   --  A square of 40, a rectangle of 60 by 20 with a hole in it, and a disc of radius 20, on black.
   --
   Picture.draw_Rectangle (Row => 20,   Column => 20,   Width => 40,  Height => 40,  Ink => White,  Thickness => Filled);
   Picture.draw_Rectangle (Row => 100,  Column => 30,   Width => 60,  Height => 20,  Ink => White,  Thickness => Filled);
   Picture.draw_Rectangle (Row => 105,  Column => 50,   Width => 10,  Height => 10,  Ink => Black,  Thickness => Filled);
   Picture.draw_Circle    (Row => 60,   Column => 150,  Radius => 20,                Ink => White,  Thickness => Filled);

   declare
      the_Shapes : constant openCV.Contours.Set := openCV.Contours.find (Picture);
      Everything : constant openCV.Contours.Set := openCV.Contours.find (Picture,  outer_Only => False);

      the_Square : Natural := 0;
      the_Disc   : Natural := 0;
      the_Bar    : Natural := 0;
   begin
      check (the_Shapes.Count = 3,                            "three shapes are found");
      check (Everything.Count = 4,                            "and four outlines, with that of the hole");

      --  Tell the shapes apart by where they are.
      --
      for i in 1 .. the_Shapes.Count
      loop
         declare
            the_Box : constant openCV.Contours.Box := the_Shapes.Bounds (i);
         begin
            if    the_Box.Column > 100 then the_Disc   := i;
            elsif the_Box.Row    >  80 then the_Bar    := i;
            else                            the_Square := i;
            end if;
         end;
      end loop;

      check (the_Square /= 0 and the_Disc /= 0 and the_Bar /= 0,     "each in its place");

      declare
         the_Box : constant openCV.Contours.Box := the_Shapes.Bounds (the_Square);
      begin
         check (the_Box = (Row => 20,  Column => 20,  Width => 40,  Height => 40),   "the bounds of the square");
      end;

      check (the_Shapes.the_Points (the_Square)'Length = 4,                  "the square has four corners");
      check (near (the_Shapes.Area      (the_Square), 39.0 * 39.0, 1.0),     "its area, between the centres of its edge elements");
      check (near (the_Shapes.Perimeter (the_Square), 4.0 * 39.0,  1.0),     "and its perimeter");

      check (near (the_Shapes.Area      (the_Disc), 3.14159 * 20.0 ** 2,  60.0),   "the area of the disc");
      check (near (the_Shapes.Perimeter (the_Disc), 2.0 * 3.14159 * 20.0, 12.0),   "and its perimeter");

      check (the_Shapes.Bounds (the_Bar).Width = 60 and the_Shapes.Bounds (the_Bar).Height = 20,   "the bounds of the rectangle");
      check (the_Shapes.Largest = the_Square,                                "the square is the largest shape");

      --  Draw the outlines on a picture in colour.
      --
      declare
         Drawn : Image := Picture.to_Colour;
      begin
         the_Shapes.draw (Onto => Drawn,  Ink => Red,  Thickness => 3);
         check (Drawn.Element (20, 40) = Red,                                "the outlines are drawn");
         check (Drawn.Element (40, 40) = White,                              "which leaves the middle of a shape as it was");

         the_Shapes.draw (Onto => Drawn,  Ink => Green,  Index => the_Disc,  Thickness => Filled);
         check (Drawn.Element (60, 150) = Green and Drawn.Element (40, 40) = White,   "one shape is filled");
      end;

      begin
         check (the_Shapes.Area (9) < 0.0,                                   "an outline which does not exist cannot be measured");
      exception
         when Constraint_Error =>
            check (True,                                                     "an outline which does not exist cannot be measured");
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
end Contours;
