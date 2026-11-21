with
     openCV.Images,
     openCV_c.Pointers;

private
with
     ada.Finalization;


package openCV.Cameras
--
-- The measuring of a camera: its focal length, its centre and the distortion of its lens, found from several views
-- of points whose places are known (the corners of a chessboard, commonly).
--
is
   use openCV.Images;

   type Camera is tagged limited private;

   type Place is
      record
         X, Y, Z : Long_Float := 0.0;
      end record;
   --
   -- Where a thing is: X to the right, Y down and Z away from the camera, in any unit.

   type Spot is
      record
         Row,
         Column : Long_Float := 0.0;
      end record;
   --
   -- Where a thing is seen, in an image.

   type Places is array (Positive range <>) of Place;
   type Spots  is array (Positive range <>) of Spot;


   -------------
   --- Measuring
   --

   procedure add_View (Self : in out Camera;   the_Places : in Places;
                                               seen_at    : in Spots);
   --
   -- Adds a view of points: their places, in a frame of their own (that of the chessboard), and where they were seen.

   function  view_Count (Self : in Camera) return Natural;

   procedure measure  (Self : in out Camera;   Width, Height : in     Positive;
                                               Error         :    out Long_Float);
   --
   -- Measures the camera from its views, of which there must be several, from different angles, for images of the
   -- given size. 'Error' is how far, in elements, the measures leave the points from where they were seen.

   function focal_Length_across (Self : in Camera) return Long_Float;
   function focal_Length_down   (Self : in Camera) return Long_Float;
   function Centre              (Self : in Camera) return Spot;
   --
   -- All in elements. A camera which has not been measured has a focal length of 1.0 and its centre at the origin.

   subtype distortion_Index is Positive range 1 .. 5;

   function Distortion  (Self : in Camera;   Index : in distortion_Index) return Long_Float;
   --
   -- The measures of the distortion of the lens: two radial, two tangential and a third radial.

   function undistorted (Self : in Camera;   the_Image : in Image) return Image;
   --
   -- The image as it would be with no distortion of the lens.


   ------------
   --- Utility
   --

   function Chessboard (in_Image      : in Image;
                        Columns, Rows : in Positive) return Spots;
   --
   -- The inner corners of a chessboard, of which there are 'Columns' along each row and 'Rows' down each column
   -- (one fewer, each way, than it has squares). Gives none unless all are found.

   function seen_at (the_Places   : in Places;
                     focal_Length : in Long_Float;
                     Centre       : in Spot;
                     Rotation     : in Place := (0.0, 0.0, 0.0);
                     Translation  : in Place := (0.0, 0.0, 0.0)) return Spots;
   --
   -- Where a camera with no distortion sees points which are turned, and then moved. The rotation is about the
   -- axis which it gives, by its length in radians.



private

   type Camera is new ada.Finalization.limited_Controlled with
      record
         Thin : openCV_c.Pointers.cv_Camera_Pointer;
      end record;

   overriding
   procedure initialize (Self : in out Camera);

   overriding
   procedure finalize   (Self : in out Camera);

end openCV.Cameras;
