-- This file is generated by SWIG. Please do *not* modify by hand.
--
with interfaces.C;



package fann_c.Pointers is



   -- FILE_Pointer
   -- 
   type FILE_Pointer is access all fann_c.FILE;

   -- FILE_Pointers
   -- 
   type FILE_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.FILE_Pointer;



   -- fann_type_Pointer
   -- 
   type fann_type_Pointer is access all fann_c.fann_type;

   -- fann_type_Pointers
   -- 
   type fann_type_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_type_Pointer;



   -- fann_errno_enum_Pointer
   -- 
   type fann_errno_enum_Pointer is access all fann_c.fann_errno_enum;

   -- fann_errno_enum_Pointers
   -- 
   type fann_errno_enum_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_errno_enum_Pointer;



   -- fann_train_enum_Pointer
   -- 
   type fann_train_enum_Pointer is access all fann_c.fann_train_enum;

   -- fann_train_enum_Pointers
   -- 
   type fann_train_enum_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_train_enum_Pointer;



   -- fann_activationfunc_enum_Pointer
   -- 
   type fann_activationfunc_enum_Pointer is access all fann_c.fann_activationfunc_enum;

   -- fann_activationfunc_enum_Pointers
   -- 
   type fann_activationfunc_enum_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_activationfunc_enum_Pointer;



   -- fann_errorfunc_enum_Pointer
   -- 
   type fann_errorfunc_enum_Pointer is access all fann_c.fann_errorfunc_enum;

   -- fann_errorfunc_enum_Pointers
   -- 
   type fann_errorfunc_enum_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_errorfunc_enum_Pointer;



   -- fann_stopfunc_enum_Pointer
   -- 
   type fann_stopfunc_enum_Pointer is access all fann_c.fann_stopfunc_enum;

   -- fann_stopfunc_enum_Pointers
   -- 
   type fann_stopfunc_enum_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_stopfunc_enum_Pointer;



   -- fann_nettype_enum_Pointer
   -- 
   type fann_nettype_enum_Pointer is access all fann_c.fann_nettype_enum;

   -- fann_nettype_enum_Pointers
   -- 
   type fann_nettype_enum_Pointers is array (interfaces.C.Size_t range <>) of aliased fann_c.Pointers.fann_nettype_enum_Pointer;










end fann_c.Pointers;
