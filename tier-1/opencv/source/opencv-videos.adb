with
     openCV.Errors,
     openCV_c.Binding,

     interfaces.C.Strings;


package body openCV.Videos
is
   use openCV_c.Binding,
       openCV_c.Pointers,
       interfaces.C,
       interfaces.C.Strings;

   use type openCV_c.Pointers.VideoCapture_Pointer,
            openCV_c.Pointers.VideoWriter_Pointer;


   -----------
   --- Sources
   --

   function open_Camera (Number : in Natural := 0) return Source
   is
   begin
      return Result : Source
      do
         Result.Thin := cv_open_camera (int (Number));
         Errors.check;

         if cv_source_is_open (Result.Thin) = 0
         then
            raise Error with "Unable to open camera" & Number'Image & ".";
         end if;
      end return;
   end open_Camera;



   function open_File (Filename : in String) return Source
   is
      the_Name : chars_ptr := new_String (Filename);
   begin
      return Result : Source
      do
         Result.Thin := cv_open_video (the_Name);
         free (the_Name);
         Errors.check;

         if cv_source_is_open (Result.Thin) = 0
         then
            raise Error with "Unable to open the video '" & Filename & "'.";
         end if;
      end return;
   end open_File;



   function Width (Self : in Source) return Natural
   is
   begin
      return Natural (cv_frame_width (Self.Thin));
   end Width;



   function Height (Self : in Source) return Natural
   is
   begin
      return Natural (cv_frame_height (Self.Thin));
   end Height;



   function frame_Rate (Self : in Source) return Long_Float
   is
   begin
      return Long_Float (cv_frame_rate (Self.Thin));
   end frame_Rate;



   function frame_Count (Self : in Source) return Natural
   is
      the_Count : constant int := cv_frame_count (Self.Thin);
   begin
      return (if the_Count > 0 then Natural (the_Count)
                               else 0);
   end frame_Count;



   procedure take (Self : in out Source;   Frame : in out Image;
                                           Found :    out Boolean)
   is
   begin
      if Frame.is_Empty
      then
         Frame := to_Image (Width => 1,  Height => 1);     -- So that there is an image for the library to fill.
      end if;

      Found := cv_next_frame (Self.Thin, Frame.thin) /= 0;
      Errors.check;
   end take;



   overriding
   procedure finalize (Self : in out Source)
   is
   begin
      if Self.Thin /= null
      then
         cv_close_source (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;



   ---------
   --- Sinks
   --

   function create (Filename      : in String;
                    Width, Height : in Positive;
                    frame_Rate    : in Long_Float := 25.0;
                    in_Colour     : in Boolean    := True) return Sink
   is
      the_Name : chars_ptr := new_String (Filename);
   begin
      return Result : Sink
      do
         Result.Thin := cv_create_video (the_Name,
                                         double (frame_Rate),
                                         int (Width),
                                         int (Height),
                                         (if in_Colour then 1 else 0));
         free (the_Name);
         Errors.check;

         if cv_sink_is_open (Result.Thin) = 0
         then
            raise Error with "Unable to make the video '" & Filename & "'.";
         end if;
      end return;
   end create;



   procedure put (Self : in out Sink;   Frame : in Image)
   is
   begin
      if Self.Thin = null
      then
         raise Error with "The video has been closed.";
      end if;

      cv_write_frame (Self.Thin, Frame.thin);
      Errors.check;
   end put;



   procedure close (Self : in out Sink)
   is
   begin
      Self.finalize;
   end close;



   overriding
   procedure finalize (Self : in out Sink)
   is
   begin
      if Self.Thin /= null
      then
         cv_close_sink (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;

end openCV.Videos;
