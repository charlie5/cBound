package openCV
--
-- A thick binding to the OpenCV ('Open Computer Vision') library.
--
is
   Error : exception;
   --
   -- Raised, with the message of the library, when OpenCV reports an error.

   function Version return String;

end openCV;
