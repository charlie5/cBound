-- This file is generated by SWIG. Please do not modify by hand.
--

with Interfaces.C.Pointers;


package TensorFlow_C.TF_Output
is

   -- Item
   --

   type Item is record
      oper  : access  TensorFlow_C.TF_Operation;
      index : aliased Interfaces.C.int;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.TF_Output.Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_Output.Item,
      Element_Array      => TensorFlow_C.TF_Output.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.TF_Output.Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_Output.Pointer,
      Element_Array      => TensorFlow_C.TF_Output.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;


end TensorFlow_C.TF_Output;
