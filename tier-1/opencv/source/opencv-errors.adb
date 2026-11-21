with
     interfaces.C.Strings;


package body openCV.Errors
is
   use interfaces.C,
       interfaces.C.Strings;

   --  An error which OpenCV reports is left pending by the thin binding, in its wrapper file, from where it is taken here.
   --
   function  pending_Error      return int         with Import, Convention => C, External_Name => "swig_ada_pending_exception";
   function  pending_Message    return chars_ptr   with Import, Convention => C, External_Name => "swig_ada_pending_exception_text";
   procedure clear_the_Error                       with Import, Convention => C, External_Name => "swig_ada_clear_pending_exception";


   procedure check
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

end openCV.Errors;
