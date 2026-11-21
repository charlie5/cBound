with
     openCV_c.Pointers;

private
with
     ada.Finalization;


package openCV.Images
--
-- An image, and the operations upon one.
--
-- An image is a value: assigning one copies its elements, and an image frees its storage when it is done with.
-- An element is found by its row and its column, each counted from 0, with row 0 at the top.
--
is
   type Image is tagged private;


   -----------
   --- Colours
   --

   type Shade is range 0 .. 255;

   type Colour is
      record
         Red,
         Green,
         Blue : Shade := 0;
      end record;

   Black : constant Colour := (Red =>   0,  Green =>   0,  Blue =>   0);
   White : constant Colour := (Red => 255,  Green => 255,  Blue => 255);
   Red   : constant Colour := (Red => 255,  Green =>   0,  Blue =>   0);
   Green : constant Colour := (Red =>   0,  Green => 255,  Blue =>   0);
   Blue  : constant Colour := (Red =>   0,  Green =>   0,  Blue => 255);

   function to_Colour (Grey : in Shade) return Colour;     -- The grey of the given shade.


   ---------
   --- Forge
   --

   function to_Image (Width, Height : in Positive;
                      in_Colour     : in Boolean := True;
                      Ground        : in Colour  := Black) return Image;
   --
   -- An image of the given size and ground. One which is not in colour has an element of a single shade of grey.

   function  read  (Filename  : in String;
                    in_Colour : in Boolean := True) return Image;

   procedure write (Self : in Image;   Filename : in String);
   --
   -- The kind of file is taken from the end of its name ('.png', '.jpg', ...).


   --------------
   --- Attributes
   --

   function Width     (Self : in Image) return Natural;
   function Height    (Self : in Image) return Natural;

   function is_Empty  (Self : in Image) return Boolean;     -- True for an image which has not been given a value.
   function in_Colour (Self : in Image) return Boolean;

   function Element   (Self : in Image;   Row, Column : in Natural) return Colour;
   function Grey      (Self : in Image;   Row, Column : in Natural) return Shade;
   --
   -- 'Element' gives the grey of the shade, for an image which is not in colour. 'Grey' is for such an image.

   procedure set      (Self : in out Image;   Row, Column : in Natural;
                                              To          : in Colour);
   procedure fill     (Self : in out Image;   To          : in Colour);

   function Mean           (Self : in Image) return Colour;
   function mean_Grey      (Self : in Image) return Long_Float;
   function Darkest        (Self : in Image) return Shade;
   function Brightest      (Self : in Image) return Shade;
   function non_zero_Count (Self : in Image) return Natural;
   --
   -- The last four are for an image which is not in colour.


   --------------
   --- Operations
   --

   function to_Grey   (Self : in Image) return Image;
   function to_Colour (Self : in Image) return Image;

   type Interpolation is (Nearest, Linear, Cubic, Area);

   function resized   (Self : in Image;   Width, Height : in Positive;
                                          By            : in Interpolation := Linear) return Image;

   type Flip is (Vertically, Horizontally, Both);

   function flipped   (Self : in Image;   How : in Flip) return Image;

   function blurred   (Self : in Image;   Size  : in Positive   := 5;
                                          Sigma : in Long_Float := 0.0) return Image;
   --
   -- 'Size' is the width of the square which each element is blurred over, and must be odd.
   -- A 'Sigma' of 0.0 has it worked out from the size.

   function above     (Self : in Image;   Threshold : in Shade) return Image;
   function below     (Self : in Image;   Threshold : in Shade) return Image;
   --
   -- An image which is white where the image is above (or is not above) the threshold, and black elsewhere.

   function Edges     (Self : in Image;   Lower, Upper : in Long_Float) return Image;

   function "+"       (Left, Right : in Image) return Image;
   function "-"       (Left, Right : in Image) return Image;
   function Difference (Left, Right : in Image) return Image;     -- The absolute difference of each element.

   function blended   (Left  : in Image;   left_Weight  : in Long_Float;
                       Right : in Image;   right_Weight : in Long_Float) return Image;


   ------------
   --- Geometry
   --

   type Point is
      record
         Row,
         Column : Integer := 0;
      end record;

   type Points  is array (Positive range <>) of Point;
   type Corners is array (1 .. 4)            of Point;

   function cropped (Self : in Image;   Row, Column   : in Natural;
                                        Width, Height : in Positive) return Image;
   --
   -- The part of the image within a rectangle, whose top left corner is given.

   procedure paste  (Self : in out Image;   the_Image   : in Image;
                                            Row, Column : in Natural);
   --
   -- Copies an image onto this one, with its top left corner at the given place. It must lie within this one.

   type Turn is (Clockwise, Half, Anticlockwise);

   function turned  (Self : in Image;   By : in Turn) return Image;
   --
   -- A quarter turn either way exchanges the width and the height.

   function rotated (Self : in Image;   Degrees : in Long_Float;
                                        Scale   : in Long_Float := 1.0) return Image;
   --
   -- Rotated anticlockwise about its centre. The image keeps its size, so its corners are lost.

   function warped  (Self : in Image;   From, To      : in Corners;
                                        Width, Height : in Positive) return Image;
   --
   -- An image of the given size, in which each of four places of this image is moved to one of four others,
   -- and the rest is stretched to suit: the view of a flat thing from another angle.


   -----------
   --- Drawing
   --

   Filled : constant := -1;     -- A thickness which fills a closed shape.

   procedure draw_Line      (Self : in out Image;   from_Row, from_Column : in Integer;
                                                    to_Row,   to_Column   : in Integer;
                                                    Ink                   : in Colour;
                                                    Thickness             : in Positive := 1);

   procedure draw_Rectangle (Self : in out Image;   Row, Column   : in Integer;
                                                    Width, Height : in Positive;
                                                    Ink           : in Colour;
                                                    Thickness     : in Integer := 1);

   procedure draw_Circle    (Self : in out Image;   Row, Column : in Integer;
                                                    Radius      : in Positive;
                                                    Ink         : in Colour;
                                                    Thickness   : in Integer := 1);

   procedure draw_Text      (Self : in out Image;   Text        : in String;
                                                    Row, Column : in Integer;
                                                    Ink         : in Colour;
                                                    Scale       : in Long_Float := 1.0;
                                                    Thickness   : in Positive   := 1);
   --
   -- The row and column are those of the bottom left of the text.


   -----------
   --- Windows
   --

   procedure show (Self : in Image;   Window : in String := "image");

   function  wait_for_Key (Milliseconds : in Natural := 0) return Integer;
   --
   -- Waits for a key to be pressed in a window, for ever if no time is given. Returns the key, or -1.
   -- A window is drawn only while this waits.

   procedure close (Window : in String);
   procedure close_all;


   -------------
   --- Thin view
   --

   function thin (Self : in Image) return openCV_c.Pointers.Mat_Pointer;
   --
   -- The image of the thin binding, for an operation which this package lacks. It belongs to 'Self'.



private

   type Image is new ada.Finalization.Controlled with
      record
         Thin : openCV_c.Pointers.Mat_Pointer;
      end record;

   overriding
   procedure adjust   (Self : in out Image);

   overriding
   procedure finalize (Self : in out Image);

end openCV.Images;
