with
     openCV.Images,
     openCV_c.Pointers;

private
with
     ada.Finalization;


package openCV.Networks
--
-- Neural networks: a network which is read from the file of a model, and run upon an image.
--
is
   use openCV.Images;


   ------------
   --- Networks
   --

   type Network is tagged limited private;

   function load (Model         : in String;
                  Configuration : in String := "") return Network;
   --
   -- Reads a network from the file of a model (ONNX, and others, each told by the end of its name).
   -- Some kinds of model have a second file, of their configuration.


   -----------
   --- Results
   --

   type Result is tagged private;
   --
   -- What a network gives: real numbers, arranged in several dimensions. What they mean depends on the network.

   type Sizes is array (Positive range <>) of Positive;

   function Dimensions (Self : in Result)                         return Sizes;
   function Count      (Self : in Result)                         return Natural;
   function Value      (Self : in Result;   Index : in Positive)  return Long_Float;
   --
   -- The numbers are counted from 1, with the last dimension changing first.


   -----------
   --- Running
   --

   function run (Self              : in out Network'Class;
                 Input             : in     Image;
                 Width, Height     : in     Positive;
                 Scale             : in     Long_Float := 1.0;
                 Mean              : in     Colour     := Black;
                 swap_Red_and_Blue : in     Boolean    := False) return Result;
   --
   -- Runs the network upon an image, which is first made the size which the network takes, has the mean taken from
   -- each of its elements, and is then scaled. The network is given blue, green and red, in that order, unless they
   -- are swapped.


   ---------
   --- Boxes
   --

   type Box is
      record
         Row,
         Column : Long_Float := 0.0;     -- Of its top left corner.
         Width,
         Height : Long_Float := 0.0;
         Score  : Long_Float := 0.0;
      end record;

   type Boxes is array (Positive range <>) of Box;

   function best_of (the_Boxes    : in Boxes;
                     least_Score  : in Long_Float := 0.5;
                     most_Overlap : in Long_Float := 0.4) return Boxes;
   --
   -- A network which finds things commonly gives many boxes for each. This keeps, of the boxes which overlap by more
   -- than the given part of their area, the one with the best score, and none with less than the least score.



private

   type Network is new ada.Finalization.limited_Controlled with
      record
         Thin : openCV_c.Pointers.Net_Pointer;
      end record;

   overriding
   procedure finalize (Self : in out Network);


   type Result is new ada.Finalization.Controlled with
      record
         Thin : openCV_c.Pointers.Mat_Pointer;
      end record;

   overriding
   procedure adjust   (Self : in out Result);

   overriding
   procedure finalize (Self : in out Result);

end openCV.Networks;
