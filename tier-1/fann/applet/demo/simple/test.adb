
with fann_c.Binding;
with fann_c.Fann;
with fann_c.Pointers;

with Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Ada.Text_IO; use Ada.Text_IO;


procedure Test
is
   use Interfaces, interfaces.C,
       fann_c, fann_c.Binding, fann_c.Pointers;

   calc_out : fann_type_Pointer;
   input    : array (1 .. 1) of aliased fann_Type;

   ann : fann_c.fann.pointer := fann_create_from_file (new_String ("xor_float.net"));
begin
   input (1) := 0.0;

   for Each in 1 .. 20 loop
      calc_out  := fann_run (ann, input (1)'unchecked_access);
      put_Line ("linear neural test (" & fann_Type'Image (input (1)) & ") -> "  & fann_Type'Image (calc_out.all));

      input (1) := input (1) + 0.05;
   end loop;


   fann_destroy (ann);
end Test;

