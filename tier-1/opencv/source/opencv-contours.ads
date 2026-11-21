with
     openCV.Images,
     openCV_c.Pointers;

private
with
     ada.Finalization;


package openCV.Contours
--
-- The outlines of the shapes in an image.
--
is
   use openCV.Images;

   type Set is tagged limited private;
   --
   -- The outlines which were found in an image. An outline is known by its number, from 1 to 'Count'.

   type Box is
      record
         Row,
         Column : Integer := 0;     -- Of its top left corner.
         Width,
         Height : Natural := 0;
      end record;


   ---------
   --- Forge
   --

   function find (in_Image   : in Image;
                  outer_Only : in Boolean := True) return Set;
   --
   -- Finds the shapes of an image of shades of grey, in which whatever is not black is part of a shape.
   -- With 'outer_Only', the outline of a hole within a shape is left out.


   --------------
   --- Attributes
   --

   function Count      (Self : in Set)                         return Natural;

   function Area       (Self : in Set;   Index : in Positive)  return Long_Float;
   function Perimeter  (Self : in Set;   Index : in Positive)  return Long_Float;
   function Bounds     (Self : in Set;   Index : in Positive)  return Box;
   function the_Points (Self : in Set;   Index : in Positive)  return Points;
   --
   -- The points are the corners of the outline: the straight parts between them are left out.

   function Largest    (Self : in Set)                         return Natural;
   --
   -- The number of the outline of the greatest area, or 0 if there are none.


   --------------
   --- Operations
   --

   procedure draw (Self : in Set;   Onto      : in out Image;
                                    Ink       : in     Colour;
                                    Index     : in     Natural := 0;
                                    Thickness : in     Integer := 1);
   --
   -- Draws one outline, or all of them if no number is given. A thickness of 'Filled' fills each.



private

   type Set is new ada.Finalization.limited_Controlled with
      record
         Thin : openCV_c.Pointers.cv_Contours_Pointer;
      end record;

   overriding
   procedure finalize (Self : in out Set);

end openCV.Contours;
