with
     openCV.Images,
     openCV_c.Pointers;

private
with
     ada.Finalization;


package openCV.Videos
--
-- Moving pictures: a source which frames are taken from, and a sink which they are written to.
--
is
   use openCV.Images;


   -----------
   --- Sources
   --

   type Source is tagged limited private;
   --
   -- A camera, or a file. It is closed when it is done with.

   function open_Camera (Number   : in Natural := 0) return Source;
   function open_File   (Filename : in String)       return Source;
   --
   -- Each raises 'Error' if the source cannot be opened.

   function Width       (Self : in Source) return Natural;
   function Height      (Self : in Source) return Natural;
   function frame_Rate  (Self : in Source) return Long_Float;
   function frame_Count (Self : in Source) return Natural;     -- Of a file. A camera has no count.

   procedure take (Self : in out Source;   Frame : in out Image;
                                           Found :    out Boolean);
   --
   -- Takes the next frame, if there is one. Where there is none, the frame is left as it was.


   ---------
   --- Sinks
   --

   type Sink is tagged limited private;
   --
   -- A file which frames are written to, as Motion JPEG. It is ended when it is done with.

   function create (Filename      : in String;
                    Width, Height : in Positive;
                    frame_Rate    : in Long_Float := 25.0;
                    in_Colour     : in Boolean    := True) return Sink;
   --
   -- Raises 'Error' if the file cannot be made. The kind of file is taken from the end of its name ('.avi').

   procedure put   (Self : in out Sink;   Frame : in Image);
   --
   -- The frame must be of the size, and the kind, which the sink was made for.

   procedure close (Self : in out Sink);
   --
   -- Ends the file now, so that it may be read.



private

   type Source is new ada.Finalization.limited_Controlled with
      record
         Thin : openCV_c.Pointers.VideoCapture_Pointer;
      end record;

   overriding
   procedure finalize (Self : in out Source);


   type Sink is new ada.Finalization.limited_Controlled with
      record
         Thin : openCV_c.Pointers.VideoWriter_Pointer;
      end record;

   overriding
   procedure finalize (Self : in out Sink);

end openCV.Videos;
