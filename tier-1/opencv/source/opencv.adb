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

end openCV;
