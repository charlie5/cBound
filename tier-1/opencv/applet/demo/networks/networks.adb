with
     openCV.Images,
     openCV.Networks,

     ada.Text_IO,
     ada.Command_Line,
     ada.Directories,
     ada.Streams.Stream_IO;


procedure Networks
--
--  Runs a neural network upon a picture, and picks the best of some boxes, checking each result.
--
--  A real network is a large file, so the demo writes a very small one of its own: a model, in the ONNX form,
--  of a single layer which gives zero for a negative number and leaves any other as it is.
--
is
   use openCV,
       openCV.Images,
       ada.Text_IO;

   use type openCV.Networks.Sizes;

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


   the_File  : constant String := "build/tiny.onnx";

   --  The model: one 'Relu' node, from an input 'in' to an output 'out', each of 1 by 3 by 4 by 4 real numbers.
   --
   the_Model : constant ada.Streams.Stream_Element_Array
     := [8, 8, 66, 4, 10, 0, 16, 13, 58, 90, 10, 21, 10, 2, 105, 110, 18, 3, 111, 117, 116, 26, 4, 114, 101, 108, 117, 34, 4, 82, 101,
         108, 117, 18, 4, 116, 105, 110, 121, 90, 28, 10, 2, 105, 110, 18, 22, 10, 20, 8, 1, 18, 16, 10, 2, 8, 1, 10, 2, 8, 3, 10, 2,
         8, 4, 10, 2, 8, 4, 98, 29, 10, 3, 111, 117, 116, 18, 22, 10, 20, 8, 1, 18, 16, 10, 2, 8, 1, 10, 2, 8, 3, 10, 2, 8, 4, 10, 2,
         8, 4];


   procedure write_the_Model
   is
      use ada.Streams.Stream_IO;
      the_Stream : ada.Streams.Stream_IO.File_type;
   begin
      create (the_Stream, out_File, the_File);
      write  (the_Stream, the_Model);
      close  (the_Stream);
   end write_the_Model;

begin
   openCV.use_OpenCL (False);     -- So that the demo runs where there is no usable graphics card.

   write_the_Model;

   --  A picture of 4 by 4, each of whose elements is more than 100 in green, 100 in red, and less than 100 in blue.
   --  The mean which is taken from it, of 100 for each, leaves green above zero, red at zero and blue below zero.
   --
   declare
      Picture     : constant Image := to_Image (Width => 4,  Height => 4,  Ground => (Red => 100,  Green => 150,  Blue => 20));
      the_Network : openCV.Networks.Network := openCV.Networks.load (the_File);
      the_Result  : constant openCV.Networks.Result := the_Network.run (Picture,
                                                                        Width  => 4,
                                                                        Height => 4,
                                                                        Mean   => to_Colour (100));
   begin
      check (the_Result.Dimensions = [1, 3, 4, 4],                    "a network is read, and run upon a picture");
      check (the_Result.Count = 48,                                   "its result has a number for each channel of each element");

      check (the_Result.Value ( 1) =  0.0,                            "blue, which was below the mean, is made zero by the network");
      check (the_Result.Value (17) = 50.0,                            "green, which was above it, is left");
      check (the_Result.Value (33) =  0.0,                            "red, which was at it, is zero");

      declare
         the_Copy : constant openCV.Networks.Result := the_Result;
      begin
         check (the_Copy.Value (32) = 50.0,                           "a result is copied");
      end;

      begin
         check (the_Result.Value (49) < 0.0,                          "a number which does not exist cannot be read");
      exception
         when Constraint_Error =>
            check (True,                                              "a number which does not exist cannot be read");
      end;
   end;

   ada.Directories.delete_File (the_File);

   begin
      declare
         the_Network : openCV.Networks.Network := openCV.Networks.load ("no/such/model.onnx") with Unreferenced;
      begin
         check (False,                                                "a model which does not exist cannot be read");
      end;
   exception
      when openCV.Error =>
         check (True,                                                 "a model which does not exist cannot be read");
   end;

   --  Boxes: two which overlap, one apart, and one with a poor score.
   --
   declare
      the_Boxes : constant openCV.Networks.Boxes
        := [(Row => 10.0,  Column =>  10.0,  Width => 50.0,  Height => 50.0,  Score => 0.8),
            (Row => 12.0,  Column =>  14.0,  Width => 50.0,  Height => 50.0,  Score => 0.9),
            (Row => 10.0,  Column => 200.0,  Width => 40.0,  Height => 40.0,  Score => 0.7),
            (Row => 90.0,  Column =>  90.0,  Width => 30.0,  Height => 30.0,  Score => 0.2)];

      the_Best  : constant openCV.Networks.Boxes := openCV.Networks.best_of (the_Boxes);
   begin
      check (the_Best'Length = 2,                                     "of four boxes, two are kept");
      check (the_Best (1).Score = 0.9 and the_Best (2).Score = 0.7,   "the better of the two which overlap, and the one apart");
      check (openCV.Networks.best_of (the_Boxes,  least_Score => 0.1)'Length = 3,   "and a third, when a poorer score is let through");
   end;

   new_Line;

   if Failures = 0
   then
      put_Line ("All of the checks passed.");
   else
      put_Line (Failures'Image & " checks failed.");
      ada.Command_Line.set_exit_Status (ada.Command_Line.Failure);
   end if;
end Networks;
