package openCV
--
-- A thick binding to the OpenCV ('Open Computer Vision') library.
--
is
   Error : exception;
   --
   -- Raised, with the message of the library, when OpenCV reports an error.

   function Version return String;

   procedure use_OpenCL (Now : in Boolean);
   --
   -- Says whether the library may use OpenCL, where it has it, to do its work on a graphics card.
   -- Some operations start OpenCL when they are first used (the finding of features is one), which can hang
   -- where its drivers are not usable: within a container, say. Turning it off beforehand avoids that.

end openCV;
