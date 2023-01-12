-- This file is generated by SWIG. Please do not modify by hand.
--

with Interfaces.C.Pointers;


package TensorFlow_C.Pointers
is

   -- TF_Buffer_Pointer
   --
   package C_TF_Buffer_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Buffer,
      Element_Array      => TensorFlow_C.TF_Buffer_Array,
      default_Terminator => 0);

   subtype TF_Buffer_Pointer is C_TF_Buffer_Pointers.Pointer;

   -- TF_Buffer_Pointer_Array
   --
   type TF_Buffer_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Buffer_Pointer;

   -- TF_Bool_Pointer
   --
   package C_TF_Bool_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Bool,
      Element_Array      => TensorFlow_C.TF_Bool_Array,
      default_Terminator => 0);

   subtype TF_Bool_Pointer is C_TF_Bool_Pointers.Pointer;

   -- TF_Bool_Pointer_Array
   --
   type TF_Bool_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Bool_Pointer;

   -- TF_AttrType_Pointer
   --
   package C_TF_AttrType_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_AttrType,
      Element_Array      => TensorFlow_C.TF_AttrType_array,
      Default_Terminator => TensorFlow_C.TF_AttrType'Val (0));

   subtype TF_AttrType_Pointer is C_TF_AttrType_Pointers.Pointer;

   -- TF_AttrType_Pointer_Array
   --
   type TF_AttrType_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_AttrType_Pointer;

   -- TF_DataType_Pointer
   --
   package C_TF_DataType_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_DataType,
      Element_Array      => TensorFlow_C.TF_DataType_array,
      Default_Terminator => TensorFlow_C.TF_DataType'Val (0));

   subtype TF_DataType_Pointer is C_TF_DataType_Pointers.Pointer;

   -- TF_DataType_Pointer_Array
   --
   type TF_DataType_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_DataType_Pointer;

   -- TF_Status_Pointer
   --
   package C_TF_Status_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Status,
      Element_Array      => TensorFlow_C.TF_Status_Array,
      default_Terminator => 0);

   subtype TF_Status_Pointer is C_TF_Status_Pointers.Pointer;

   -- TF_Status_Pointer_Array
   --
   type TF_Status_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Status_Pointer;

   -- TF_Code_Pointer
   --
   package C_TF_Code_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.TF_Code,
      Element_Array      => TensorFlow_C.TF_Code_array,
      Default_Terminator => TensorFlow_C.TF_Code'Val (0));

   subtype TF_Code_Pointer is C_TF_Code_Pointers.Pointer;

   -- TF_Code_Pointer_Array
   --
   type TF_Code_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Code_Pointer;

   -- TF_Tensor_Pointer
   --
   package C_TF_Tensor_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Tensor,
      Element_Array      => TensorFlow_C.TF_Tensor_Array,
      default_Terminator => 0);

   subtype TF_Tensor_Pointer is C_TF_Tensor_Pointers.Pointer;

   -- TF_Tensor_Pointer_Array
   --
   type TF_Tensor_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Tensor_Pointer;

   -- TF_TString_Pointer
   --
   package C_TF_TString_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_TString,
      Element_Array      => TensorFlow_C.TF_TString_Array,
      default_Terminator => 0);

   subtype TF_TString_Pointer is C_TF_TString_Pointers.Pointer;

   -- TF_TString_Pointer_Array
   --
   type TF_TString_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_TString_Pointer;

   -- TF_TString_Type_Pointer
   --
   package C_TF_TString_Type_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_TString_Type,
      Element_Array      => TensorFlow_C.TF_TString_Type_Array,
      default_Terminator => 0);

   subtype TF_TString_Type_Pointer is C_TF_TString_Type_Pointers.Pointer;

   -- TF_TString_Type_Pointer_Array
   --
   type TF_TString_Type_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_TString_Type_Pointer;

   -- TF_Operation_ptr_ptr_ptr_Pointer
   --
   package C_TF_Operation_ptr_ptr_ptr_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Operation_ptr_ptr_ptr,
      Element_Array      => TensorFlow_C.TF_Operation_ptr_ptr_ptr_Array,
      default_Terminator => 0);

   subtype TF_Operation_ptr_ptr_ptr_Pointer is C_TF_Operation_ptr_ptr_ptr_Pointers.Pointer;

   -- TF_Operation_ptr_ptr_ptr_Pointer_Array
   --
   type TF_Operation_ptr_ptr_ptr_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Operation_ptr_ptr_ptr_Pointer;

   -- TF_SessionOptions_Pointer
   --
   package C_TF_SessionOptions_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_SessionOptions,
      Element_Array      => TensorFlow_C.TF_SessionOptions_Array,
      default_Terminator => 0);

   subtype TF_SessionOptions_Pointer is C_TF_SessionOptions_Pointers.Pointer;

   -- TF_SessionOptions_Pointer_Array
   --
   type TF_SessionOptions_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_SessionOptions_Pointer;

   -- TF_Graph_Pointer
   --
   package C_TF_Graph_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Graph,
      Element_Array      => TensorFlow_C.TF_Graph_Array,
      default_Terminator => 0);

   subtype TF_Graph_Pointer is C_TF_Graph_Pointers.Pointer;

   -- TF_Graph_Pointer_Array
   --
   type TF_Graph_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Graph_Pointer;

   -- TF_OperationDescription_Pointer
   --
   package C_TF_OperationDescription_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_OperationDescription,
      Element_Array      => TensorFlow_C.TF_OperationDescription_Array,
      default_Terminator => 0);

   subtype TF_OperationDescription_Pointer is C_TF_OperationDescription_Pointers.Pointer;

   -- TF_OperationDescription_Pointer_Array
   --
   type TF_OperationDescription_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_OperationDescription_Pointer;

   -- TF_Operation_Pointer
   --
   package C_TF_Operation_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Operation,
      Element_Array      => TensorFlow_C.TF_Operation_Array,
      default_Terminator => 0);

   subtype TF_Operation_Pointer is C_TF_Operation_Pointers.Pointer;

   -- TF_Operation_Pointer_Array
   --
   type TF_Operation_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Operation_Pointer;

   -- TF_Function_Pointer
   --
   package C_TF_Function_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Function,
      Element_Array      => TensorFlow_C.TF_Function_Array,
      default_Terminator => 0);

   subtype TF_Function_Pointer is C_TF_Function_Pointers.Pointer;

   -- TF_Function_Pointer_Array
   --
   type TF_Function_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Function_Pointer;

   -- TF_FunctionOptions_Pointer
   --
   package C_TF_FunctionOptions_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_FunctionOptions,
      Element_Array      => TensorFlow_C.TF_FunctionOptions_Array,
      default_Terminator => 0);

   subtype TF_FunctionOptions_Pointer is C_TF_FunctionOptions_Pointers.Pointer;

   -- TF_FunctionOptions_Pointer_Array
   --
   type TF_FunctionOptions_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_FunctionOptions_Pointer;

   -- TF_ImportGraphDefOptions_Pointer
   --
   package C_TF_ImportGraphDefOptions_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_ImportGraphDefOptions,
      Element_Array      => TensorFlow_C.TF_ImportGraphDefOptions_Array,
      default_Terminator => 0);

   subtype TF_ImportGraphDefOptions_Pointer is C_TF_ImportGraphDefOptions_Pointers.Pointer;

   -- TF_ImportGraphDefOptions_Pointer_Array
   --
   type TF_ImportGraphDefOptions_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_ImportGraphDefOptions_Pointer;

   -- TF_ImportGraphDefResults_Pointer
   --
   package C_TF_ImportGraphDefResults_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_ImportGraphDefResults,
      Element_Array      => TensorFlow_C.TF_ImportGraphDefResults_Array,
      default_Terminator => 0);

   subtype TF_ImportGraphDefResults_Pointer is C_TF_ImportGraphDefResults_Pointers.Pointer;

   -- TF_ImportGraphDefResults_Pointer_Array
   --
   type TF_ImportGraphDefResults_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_ImportGraphDefResults_Pointer;

   -- TF_Session_Pointer
   --
   package C_TF_Session_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Session,
      Element_Array      => TensorFlow_C.TF_Session_Array,
      default_Terminator => 0);

   subtype TF_Session_Pointer is C_TF_Session_Pointers.Pointer;

   -- TF_Session_Pointer_Array
   --
   type TF_Session_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Session_Pointer;

   -- TF_DeprecatedSession_Pointer
   --
   package C_TF_DeprecatedSession_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_DeprecatedSession,
      Element_Array      => TensorFlow_C.TF_DeprecatedSession_Array,
      default_Terminator => 0);

   subtype TF_DeprecatedSession_Pointer is C_TF_DeprecatedSession_Pointers.Pointer;

   -- TF_DeprecatedSession_Pointer_Array
   --
   type TF_DeprecatedSession_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_DeprecatedSession_Pointer;

   -- TF_DeviceList_Pointer
   --
   package C_TF_DeviceList_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_DeviceList,
      Element_Array      => TensorFlow_C.TF_DeviceList_Array,
      default_Terminator => 0);

   subtype TF_DeviceList_Pointer is C_TF_DeviceList_Pointers.Pointer;

   -- TF_DeviceList_Pointer_Array
   --
   type TF_DeviceList_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_DeviceList_Pointer;

   -- TF_Library_Pointer
   --
   package C_TF_Library_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Library,
      Element_Array      => TensorFlow_C.TF_Library_Array,
      default_Terminator => 0);

   subtype TF_Library_Pointer is C_TF_Library_Pointers.Pointer;

   -- TF_Library_Pointer_Array
   --
   type TF_Library_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Library_Pointer;

   -- TF_ApiDefMap_Pointer
   --
   package C_TF_ApiDefMap_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_ApiDefMap,
      Element_Array      => TensorFlow_C.TF_ApiDefMap_Array,
      default_Terminator => 0);

   subtype TF_ApiDefMap_Pointer is C_TF_ApiDefMap_Pointers.Pointer;

   -- TF_ApiDefMap_Pointer_Array
   --
   type TF_ApiDefMap_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_ApiDefMap_Pointer;

   -- TF_Server_Pointer
   --
   package C_TF_Server_Pointers is new Interfaces.c.Pointers
     (Index              => Interfaces.c.size_t,
      Element            => TensorFlow_C.TF_Server,
      Element_Array      => TensorFlow_C.TF_Server_Array,
      default_Terminator => 0);

   subtype TF_Server_Pointer is C_TF_Server_Pointers.Pointer;

   -- TF_Server_Pointer_Array
   --
   type TF_Server_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.TF_Server_Pointer;

   -- Deallocator_T_Pointer
   --
   package C_Deallocator_T_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => TensorFlow_C.Deallocator_T,
      Element_Array      => TensorFlow_C.Deallocator_T_Array,
      Default_Terminator => null);

   subtype Deallocator_T_Pointer is C_Deallocator_T_Pointers.Pointer;

   -- Deallocator_T_Pointer_Array
   --
   type Deallocator_T_Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased TensorFlow_C.Pointers.Deallocator_T_Pointer;


end TensorFlow_C.Pointers;
