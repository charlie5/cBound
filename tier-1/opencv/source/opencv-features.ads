with
     openCV.Images,
     openCV_c.Pointers;

private
with
     ada.Finalization;


package openCV.Features
--
-- The features of an image: places which can be told from those around them, and found again in another image.
--
is
   use openCV.Images;

   type Set is tagged limited private;
   --
   -- The features which were found in an image. A feature is known by its number, from 1 to 'Count'.

   type Feature is
      record
         Row,
         Column   : Long_Float := 0.0;
         Size     : Long_Float := 0.0;     -- The width of the part of the image which it describes.
         Angle    : Long_Float := 0.0;     -- Its direction, in degrees, or -1.0 if it has none.
         Strength : Long_Float := 0.0;
      end record;


   ---------
   --- Forge
   --

   function find (in_Image : in Image;
                  Most     : in Positive := 500) return Set;
   --
   -- The strongest features of an image, each with a description by which it can be matched (by the ORB method).

   function find_Corners (in_Image       : in Image;
                          Most           : in Positive   := 100;
                          Quality        : in Long_Float := 0.01;
                          least_Distance : in Long_Float := 10.0) return Set;
   --
   -- The strongest corners of an image. They have no descriptions, so cannot be matched.
   -- 'Quality' is the least strength of a corner, as a part of that of the strongest.


   --------------
   --- Attributes
   --

   function Count   (Self : in Set)                         return Natural;
   function Element (Self : in Set;   Index : in Positive)  return Feature;

   function drawn   (Self : in Set;   Onto : in Image;
                                      Ink  : in Colour := Green) return Image;
   --
   -- A copy of the image, in colour, with a ring at each feature.


   ------------
   --- Matching
   --

   type Match is
      record
         Left,
         Right    : Positive   := 1;       -- The numbers of the two features.
         Distance : Long_Float := 0.0;     -- How far apart their descriptions are: the less, the more alike.
      end record;

   type Matches is array (Positive range <>) of Match;

   function matched (Left, Right : in Set) return Matches;
   --
   -- Pairs each feature of the left with the feature of the right which is most like it, where each is the other's best.



private

   type Set is new ada.Finalization.limited_Controlled with
      record
         Thin : openCV_c.Pointers.cv_Features_Pointer;
      end record;

   overriding
   procedure finalize (Self : in out Set);

end openCV.Features;
