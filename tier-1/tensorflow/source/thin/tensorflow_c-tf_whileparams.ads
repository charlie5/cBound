-- This file is generated by SWIG. Please do not modify by hand.
--

with TensorFlow_C.TF_Output;
with Interfaces.C.Strings;
with Interfaces.C.Pointers;


package TensorFlow_C.TF_WhileParams
is

   -- Item
   --

   type Item is record
      ninputs      : aliased Interfaces.C.int;
      cond_graph   : access  TensorFlow_C.TF_Graph;
      cond_inputs  : access  TensorFlow_C.TF_Output.Item;
      cond_output  : aliased TensorFlow_C.TF_Output.Item;
      body_graph   : access  TensorFlow_C.TF_Graph;
      body_inputs  : access  TensorFlow_C.TF_Output.Item;
      body_outputs : access  TensorFlow_C.TF_Output.Item;
      name         : aliased Interfaces.C.Strings.chars_ptr;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.TF_WhileParams.Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_WhileParams.Item,
      Element_Array      => TensorFlow_C.TF_WhileParams.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.TF_WhileParams.Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_WhileParams.Pointer,
      Element_Array      => TensorFlow_C.TF_WhileParams.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;


end TensorFlow_C.TF_WhileParams;
