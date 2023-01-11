
with
     TensorFlow_C.Binding,
     interfaces.C.Strings,
     ada.Text_IO; 


procedure hello_TF
is
   use Ada.Text_IO,
       Interfaces,
       interfaces.C,
       Interfaces.C.Strings,
       Tensorflow_C.Binding;

   Version : String := Value (TF_Version);

begin
   put_Line ("Hello Tensorflow.");
   put_Line ("Version: " & Version);
end hello_TF;