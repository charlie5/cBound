-- This file is generated by SWIG. Please do not modify by hand.
--

with Interfaces.C.Pointers;


package TensorFlow_C.TF_AllocatorAttributes
is

   -- Item
   --

   type Item is record
      struct_size : aliased Interfaces.C.size_t;
      on_host     : aliased TensorFlow_C.TF_Bool;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.TF_AllocatorAttributes.Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_AllocatorAttributes.Item,
      Element_Array      => TensorFlow_C.TF_AllocatorAttributes.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.TF_AllocatorAttributes.Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_AllocatorAttributes.Pointer,
      Element_Array      => TensorFlow_C.TF_AllocatorAttributes.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;


end TensorFlow_C.TF_AllocatorAttributes;