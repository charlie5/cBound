with
     openCV_c.Binding,
     interfaces.C.Strings;


package body openCV
is

   function Version return String
   is
   begin
      return interfaces.C.Strings.Value (openCV_c.Binding.cv_version);
   end Version;



   procedure use_OpenCL (Now : in Boolean)
   is
   begin
      openCV_c.Binding.cv_use_opencl (if Now then 1 else 0);
   end use_OpenCL;

end openCV;
