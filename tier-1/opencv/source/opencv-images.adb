with
     openCV_c.Binding,

     interfaces.C.Strings;


package body openCV.Images
is
   use openCV_c,
       openCV_c.Binding,
       openCV_c.Pointers,

       interfaces.C,
       interfaces.C.Strings;

   use type openCV_c.Pointers.Mat_Pointer;


   -----------
   --- Utility
   --

   --  An error which OpenCV reports is left pending by the thin binding, in its wrapper file, from where it is taken here.
   --
   function  pending_Error      return int         with Import, Convention => C, External_Name => "swig_ada_pending_exception";
   function  pending_Message    return chars_ptr   with Import, Convention => C, External_Name => "swig_ada_pending_exception_text";
   procedure clear_the_Error                       with Import, Convention => C, External_Name => "swig_ada_clear_pending_exception";


   procedure check
   --
   --  Raises 'Error' if the last call of the library reported one.
   --
   is
   begin
      if pending_Error /= 0
      then
         declare
            the_Message : constant String := Value (pending_Message);
         begin
            clear_the_Error;
            raise Error with the_Message;
         end;
      end if;
   end check;



   procedure require (Self : in Image)
   --
   --  Raises 'Error' for an image which has not been given a value.
   --
   is
   begin
      if Self.Thin = null
      then
         raise Error with "The image is empty.";
      end if;
   end require;



   procedure require (Self : in Image;   Row, Column : in Natural)
   is
   begin
      require (Self);

      if        Row    >= Self.Height
        or else Column >= Self.Width
      then
         raise Constraint_Error with   "Row"       & Row   'Image & ", column" & Column    'Image
                                     & " is not in an image of" & Self.Height'Image & " rows and" & Self.Width'Image & " columns.";
      end if;
   end require;



   function new_Image return Image
   is
   begin
      return Result : Image
      do
         Result.Thin := cv_new_image;
      end return;
   end new_Image;



   -----------
   --- Colours
   --

   function to_Colour (Grey : in Shade) return Colour
   is
   begin
      return (Red   => Grey,
              Green => Grey,
              Blue  => Grey);
   end to_Colour;



   ---------
   --- Forge
   --

   function to_Image (Width, Height : in Positive;
                      in_Colour     : in Boolean := True;
                      Ground        : in Colour  := Black) return Image
   is
   begin
      return Result : Image
      do
         Result.Thin := cv_new_image_of (int (Height),
                                         int (Width),
                                         (if in_Colour then CV_8UC3_type else CV_8UC1_type));
         check;
         Result.fill (Ground);
      end return;
   end to_Image;



   function read (Filename  : in String;
                  in_Colour : in Boolean := True) return Image
   is
      the_Name : chars_ptr := new_String (Filename);
      Okay     : int;
   begin
      return Result : Image := new_Image
      do
         Okay := cv_read (the_Name,
                          (if in_Colour then READ_COLOUR else READ_GREYSCALE),
                          Result.Thin);
         free (the_Name);
         check;

         if Okay = 0
         then
            raise Error with "Unable to read an image from '" & Filename & "'.";
         end if;
      end return;
   end read;



   procedure write (Self : in Image;   Filename : in String)
   is
      the_Name : chars_ptr := new_String (Filename);
      Okay     : int;
   begin
      require (Self);

      Okay := cv_write (the_Name, Self.Thin);
      free (the_Name);
      check;

      if Okay = 0
      then
         raise Error with "Unable to write the image to '" & Filename & "'.";
      end if;
   end write;



   --------------
   --- Attributes
   --

   function Width (Self : in Image) return Natural
   is
   begin
      return (if Self.Thin = null then 0
                                  else Natural (cv_columns (Self.Thin)));
   end Width;



   function Height (Self : in Image) return Natural
   is
   begin
      return (if Self.Thin = null then 0
                                  else Natural (cv_rows (Self.Thin)));
   end Height;



   function is_Empty (Self : in Image) return Boolean
   is
   begin
      return        Self.Thin = null
            or else cv_is_empty (Self.Thin) /= 0;
   end is_Empty;



   function in_Colour (Self : in Image) return Boolean
   is
   begin
      return          Self.Thin /= null
             and then cv_channels (Self.Thin) = 3;
   end in_Colour;



   function Element (Self : in Image;   Row, Column : in Natural) return Colour
   is
   begin
      require (Self, Row, Column);

      if Self.in_Colour
      then
         return (Blue  => Shade (cv_get (Self.Thin, int (Row), int (Column), 0)),
                 Green => Shade (cv_get (Self.Thin, int (Row), int (Column), 1)),
                 Red   => Shade (cv_get (Self.Thin, int (Row), int (Column), 2)));
      else
         return to_Colour (Shade (cv_get (Self.Thin, int (Row), int (Column), 0)));
      end if;
   end Element;



   function Grey (Self : in Image;   Row, Column : in Natural) return Shade
   is
   begin
      require (Self, Row, Column);
      return Shade (cv_get (Self.Thin, int (Row), int (Column), 0));
   end Grey;



   procedure set (Self : in out Image;   Row, Column : in Natural;
                                         To          : in Colour)
   is
   begin
      require (Self, Row, Column);

      if Self.in_Colour
      then
         cv_set (Self.Thin, int (Row), int (Column), 0, int (To.Blue));
         cv_set (Self.Thin, int (Row), int (Column), 1, int (To.Green));
         cv_set (Self.Thin, int (Row), int (Column), 2, int (To.Red));
      else
         cv_set (Self.Thin, int (Row), int (Column), 0, int (To.Blue));     -- A grey has the same shade of each.
      end if;
   end set;



   procedure fill (Self : in out Image;   To : in Colour)
   is
   begin
      require (Self);
      cv_fill (Self.Thin, double (To.Blue), double (To.Green), double (To.Red));
      check;
   end fill;



   function Mean (Self : in Image) return Colour
   is
   begin
      require (Self);

      if Self.in_Colour
      then
         return Result : constant Colour := (Blue  => Shade (double'Rounding (cv_mean (Self.Thin, 0))),
                                             Green => Shade (double'Rounding (cv_mean (Self.Thin, 1))),
                                             Red   => Shade (double'Rounding (cv_mean (Self.Thin, 2))))
         do
            check;
         end return;
      else
         return to_Colour (Shade (Long_Float'Rounding (Self.mean_Grey)));
      end if;
   end Mean;



   function mean_Grey (Self : in Image) return Long_Float
   is
   begin
      require (Self);

      return Result : constant Long_Float := Long_Float (cv_mean (Self.Thin, 0))
      do
         check;
      end return;
   end mean_Grey;



   procedure find_the_Limits (Self : in Image;   Least, Greatest : out Shade)
   is
      the_Least,
      the_Greatest : aliased double := 0.0;
   begin
      require (Self);
      cv_least_and_greatest (Self.Thin, the_Least'unchecked_Access, the_Greatest'unchecked_Access);
      check;

      Least    := Shade (the_Least);
      Greatest := Shade (the_Greatest);
   end find_the_Limits;



   function Darkest (Self : in Image) return Shade
   is
      Least, Greatest : Shade;
   begin
      find_the_Limits (Self, Least, Greatest);
      return Least;
   end Darkest;



   function Brightest (Self : in Image) return Shade
   is
      Least, Greatest : Shade;
   begin
      find_the_Limits (Self, Least, Greatest);
      return Greatest;
   end Brightest;



   function non_zero_Count (Self : in Image) return Natural
   is
   begin
      require (Self);

      return Result : constant Natural := Natural (cv_count_non_zero (Self.Thin))
      do
         check;
      end return;
   end non_zero_Count;



   --------------
   --- Operations
   --

   function to_Grey (Self : in Image) return Image
   is
   begin
      require (Self);

      if not Self.in_Colour
      then
         return Self;
      end if;

      return Result : Image := new_Image
      do
         cv_convert_colour (Self.Thin, Result.Thin, BGR_TO_GREY);
         check;
      end return;
   end to_Grey;



   function to_Colour (Self : in Image) return Image
   is
   begin
      require (Self);

      if Self.in_Colour
      then
         return Self;
      end if;

      return Result : Image := new_Image
      do
         cv_convert_colour (Self.Thin, Result.Thin, GREY_TO_BGR);
         check;
      end return;
   end to_Colour;



   function resized (Self : in Image;   Width, Height : in Positive;
                                        By            : in Interpolation := Linear) return Image
   is
   begin
      require (Self);

      return Result : Image := new_Image
      do
         cv_resize (Self.Thin, Result.Thin,
                    int (Width),
                    int (Height),
                    (case By is
                        when Nearest => INTERPOLATE_NEAREST,
                        when Linear  => INTERPOLATE_LINEAR,
                        when Cubic   => INTERPOLATE_CUBIC,
                        when Area    => INTERPOLATE_AREA));
         check;
      end return;
   end resized;



   function flipped (Self : in Image;   How : in Flip) return Image
   is
   begin
      require (Self);

      return Result : Image := new_Image
      do
         cv_flip (Self.Thin, Result.Thin,
                  (case How is
                      when Vertically   => FLIP_VERTICALLY,
                      when Horizontally => FLIP_HORIZONTALLY,
                      when Both         => FLIP_BOTH));
         check;
      end return;
   end flipped;



   function blurred (Self : in Image;   Size  : in Positive   := 5;
                                        Sigma : in Long_Float := 0.0) return Image
   is
   begin
      require (Self);

      return Result : Image := new_Image
      do
         cv_gaussian_blur (Self.Thin, Result.Thin, int (Size), double (Sigma));
         check;
      end return;
   end blurred;



   function marked (Self : in Image;   Threshold : in Shade;
                                       Kind      : in int) return Image
   is
      the_Grey : constant Image := Self.to_Grey;
      Unused   :          double;
   begin
      return Result : Image := new_Image
      do
         Unused := cv_threshold (the_Grey.Thin, Result.Thin, double (Threshold), 255.0, Kind);
         check;
      end return;
   end marked;



   function above (Self : in Image;   Threshold : in Shade) return Image
   is
   begin
      return marked (Self, Threshold, THRESHOLD_BINARY);
   end above;



   function below (Self : in Image;   Threshold : in Shade) return Image
   is
   begin
      return marked (Self, Threshold, THRESHOLD_BINARY_INVERSE);
   end below;



   function Edges (Self : in Image;   Lower, Upper : in Long_Float) return Image
   is
      the_Grey : constant Image := Self.to_Grey;
   begin
      return Result : Image := new_Image
      do
         cv_find_edges (the_Grey.Thin, Result.Thin, double (Lower), double (Upper));
         check;
      end return;
   end Edges;



   function "+" (Left, Right : in Image) return Image
   is
   begin
      require (Left);
      require (Right);

      return Result : Image := new_Image
      do
         cv_add (Left.Thin, Right.Thin, Result.Thin);
         check;
      end return;
   end "+";



   function "-" (Left, Right : in Image) return Image
   is
   begin
      require (Left);
      require (Right);

      return Result : Image := new_Image
      do
         cv_subtract (Left.Thin, Right.Thin, Result.Thin);
         check;
      end return;
   end "-";



   function Difference (Left, Right : in Image) return Image
   is
   begin
      require (Left);
      require (Right);

      return Result : Image := new_Image
      do
         cv_absolute_difference (Left.Thin, Right.Thin, Result.Thin);
         check;
      end return;
   end Difference;



   function blended (Left  : in Image;   left_Weight  : in Long_Float;
                     Right : in Image;   right_Weight : in Long_Float) return Image
   is
   begin
      require (Left);
      require (Right);

      return Result : Image := new_Image
      do
         cv_blend (Left .Thin, double (left_Weight),
                   Right.Thin, double (right_Weight),
                   Result.Thin);
         check;
      end return;
   end blended;



   -----------
   --- Drawing
   --

   procedure draw_Line (Self : in out Image;   from_Row, from_Column : in Integer;
                                               to_Row,   to_Column   : in Integer;
                                               Ink                   : in Colour;
                                               Thickness             : in Positive := 1)
   is
   begin
      require (Self);
      cv_draw_line (Self.Thin,
                    int (from_Column), int (from_Row),
                    int (to_Column),   int (to_Row),
                    double (Ink.Blue), double (Ink.Green), double (Ink.Red),
                    int (Thickness));
      check;
   end draw_Line;



   procedure draw_Rectangle (Self : in out Image;   Row, Column   : in Integer;
                                                    Width, Height : in Positive;
                                                    Ink           : in Colour;
                                                    Thickness     : in Integer := 1)
   is
   begin
      require (Self);
      cv_draw_rectangle (Self.Thin,
                         int (Column), int (Row),
                         int (Width),  int (Height),
                         double (Ink.Blue), double (Ink.Green), double (Ink.Red),
                         int (Thickness));
      check;
   end draw_Rectangle;



   procedure draw_Circle (Self : in out Image;   Row, Column : in Integer;
                                                 Radius      : in Positive;
                                                 Ink         : in Colour;
                                                 Thickness   : in Integer := 1)
   is
   begin
      require (Self);
      cv_draw_circle (Self.Thin,
                      int (Column), int (Row),
                      int (Radius),
                      double (Ink.Blue), double (Ink.Green), double (Ink.Red),
                      int (Thickness));
      check;
   end draw_Circle;



   procedure draw_Text (Self : in out Image;   Text        : in String;
                                               Row, Column : in Integer;
                                               Ink         : in Colour;
                                               Scale       : in Long_Float := 1.0;
                                               Thickness   : in Positive   := 1)
   is
      the_Text : chars_ptr := new_String (Text);
   begin
      require (Self);
      cv_draw_text (Self.Thin,
                    the_Text,
                    int (Column), int (Row),
                    double (Scale),
                    double (Ink.Blue), double (Ink.Green), double (Ink.Red),
                    int (Thickness));
      free (the_Text);
      check;
   end draw_Text;



   -----------
   --- Windows
   --

   procedure show (Self : in Image;   Window : in String := "image")
   is
      the_Window : chars_ptr := new_String (Window);
   begin
      require (Self);
      cv_show (the_Window, Self.Thin);
      free (the_Window);
      check;
   end show;



   function wait_for_Key (Milliseconds : in Natural := 0) return Integer
   is
   begin
      return Result : constant Integer := Integer (cv_wait_for_key (int (Milliseconds)))
      do
         check;
      end return;
   end wait_for_Key;



   procedure close (Window : in String)
   is
      the_Window : chars_ptr := new_String (Window);
   begin
      cv_close (the_Window);
      free (the_Window);
      check;
   end close;



   procedure close_all
   is
   begin
      cv_close_all;
      check;
   end close_all;



   -------------
   --- Thin view
   --

   function thin (Self : in Image) return openCV_c.Pointers.Mat_Pointer
   is
   begin
      return Self.Thin;
   end thin;



   ------------------
   --- Controlled ops
   --

   overriding
   procedure adjust (Self : in out Image)
   is
   begin
      if Self.Thin /= null
      then
         Self.Thin := cv_copy_of (Self.Thin);
      end if;
   end adjust;



   overriding
   procedure finalize (Self : in out Image)
   is
   begin
      if Self.Thin /= null
      then
         cv_delete (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;

end openCV.Images;
