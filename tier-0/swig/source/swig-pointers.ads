with
     interfaces.C.Pointers,
     interfaces.C.Strings,
     system.Address_to_Access_conversions;

package swig.Pointers
--
-- Contains pointers to Swig related C type definitions not available in the 'interfaces.C' family.
--
is
   use Interfaces;

   ------------
   --  void_ptr
   --
   package C_void_ptr_Pointers is new C.Pointers (Index              => C.size_t,
                                                  Element            => swig.void_ptr,
                                                  element_Array      => void_ptr_Array,
                                                  default_Terminator => system.null_Address);
   subtype void_ptr_Pointer is C_void_ptr_Pointers.Pointer;


   ---------------------
   --  opaque struct_ptr
   --
   type opaque_structure_ptr       is access swig.opaque_structure;
   type opaque_structure_ptr_array is array (C.Size_t range <>) of aliased opaque_structure_ptr;

   package C_opaque_structure_ptr_Pointers is new C.Pointers (Index              => C.size_t,
                                                              Element            => opaque_structure_ptr,
                                                              element_Array      => opaque_structure_ptr_array,
                                                              default_Terminator => null);
   subtype opaque_structure_ptr_Pointer is C_opaque_structure_ptr_Pointers.Pointer;


   --------------------
   --  incomplete class
   --
   type incomplete_class_ptr       is access swig.incomplete_class;
   type incomplete_class_ptr_array is array (C.Size_t range <>) of aliased incomplete_class_ptr;

   package C_incomplete_class_ptr_Pointers is new C.Pointers (Index              => C.size_t,
                                                              Element            => incomplete_class_ptr,
                                                              element_Array      => incomplete_class_ptr_array,
                                                              default_Terminator => null);
   subtype incomplete_class_ptr_Pointer is C_incomplete_class_ptr_Pointers.Pointer;


   ---------
   --  bool*
   --
   package c_bool_Pointers is new C.Pointers (Index              => C.size_t,
                                              Element            => swig.bool,
                                              element_Array      => bool_Array,
                                              default_Terminator => 0);
   subtype bool_Pointer       is c_bool_Pointers.Pointer;
   type    bool_Pointer_array is array (C.Size_t range <>) of aliased bool_Pointer;


   --  bool**
   --
   package C_bool_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                      Element            => bool_Pointer,
                                                      element_Array      => bool_Pointer_array,
                                                      default_Terminator => null);
   subtype bool_pointer_Pointer is C_bool_pointer_Pointers.Pointer;


   ------------
   --  char* []
   --
   type chars_ptr_array         is array (C.Size_t range <>) of aliased C.strings.chars_Ptr;   -- Standard Ada does not have 'aliased'.

   package C_chars_ptr_Pointers is new C.Pointers (Index              => C.size_t,
                                                   Element            => C.strings.chars_ptr,
                                                   element_Array      => chars_ptr_array,
                                                   default_Terminator => C.strings.Null_Ptr);
   subtype chars_ptr_Pointer is C_chars_ptr_Pointers.Pointer;


   --  char** []
   --
   type chars_ptr_Pointer_array         is array (C.Size_t range <>) of aliased chars_ptr_Pointer;

   package C_chars_ptr_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                           Element            => chars_ptr_Pointer,
                                                           element_Array      => chars_ptr_Pointer_array,
                                                           default_Terminator => null);
   subtype chars_ptr_pointer_Pointer is C_chars_ptr_pointer_Pointers.Pointer;


   -----------
   -- wchar_t*
   --
   package c_wchar_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                 Element            => C.wchar_t,
                                                 element_Array      => C.wchar_array,
                                                 default_Terminator => C.wchar_t'First);
   subtype wchar_t_Pointer    is c_wchar_t_Pointers.Pointer;


   ----------------
   --  signed char*
   --
   package c_signed_char_Pointers is new C.Pointers (Index              => C.size_t,
                                                     Element            => C.signed_Char,
                                                     element_Array      => swig.signed_char_Array,
                                                     default_Terminator => 0);
   subtype signed_char_Pointer    is c_signed_char_Pointers.Pointer;


   ------------------
   --  unsigned char*
   --
   package c_unsigned_char_Pointers is new C.Pointers (Index              => C.size_t,
                                                       Element            => C.unsigned_Char,
                                                       element_Array      => unsigned_char_Array,
                                                       default_Terminator => 0);
   subtype unsigned_char_Pointer    is c_unsigned_char_Pointers.Pointer;


   ----------
   --  short*
   --
   package c_short_Pointers is new C.Pointers (Index              => C.size_t,
                                               Element            => C.Short,
                                               element_Array      => short_Array,
                                               default_Terminator => 0);
   subtype short_Pointer    is c_short_Pointers.Pointer;


   -------------------
   --  unsigned short*
   --
   package c_unsigned_short_Pointers is new C.Pointers (Index              => C.size_t,
                                                        Element            => C.unsigned_Short,
                                                        element_Array      => unsigned_short_Array,
                                                        default_Terminator => 0);
   subtype unsigned_short_Pointer    is c_unsigned_short_Pointers.Pointer;


   --------
   --  int*
   --
   package c_int_Pointers is new C.Pointers (Index              => C.size_t,
                                             Element            => C.Int,
                                             element_Array      => int_Array,
                                             default_Terminator => 0);
   subtype int_Pointer    is c_int_Pointers.Pointer;


   --  int**
   --
   type int_pointer_Array is array (C.size_t range <>) of aliased int_Pointer;

   package c_int_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                     Element            => int_Pointer,
                                                     element_Array      => int_pointer_Array,
                                                     default_Terminator => null);
   subtype int_pointer_Pointer    is c_int_pointer_Pointers.Pointer;


   -----------
   --  size_t*
   --
   package c_size_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                Element            => C.Size_t,
                                                element_Array      => size_t_Array,
                                                default_Terminator => 0);
   subtype size_t_Pointer    is c_size_t_Pointers.Pointer;



   -------------
   --  unsigned*
   --
   package c_unsigned_Pointers is new C.Pointers (Index              => C.size_t,
                                                  Element            => C.Unsigned,
                                                  element_Array      => unsigned_Array,
                                                  default_Terminator => 0);
   subtype unsigned_Pointer    is c_unsigned_Pointers.Pointer;


   ---------
   --  long*
   --
   package c_long_Pointers is new C.Pointers (Index              => C.size_t,
                                              Element            => C.Long,
                                              element_Array      => long_Array,
                                              default_Terminator => 0);
   subtype long_Pointer    is c_long_Pointers.Pointer;


   ------------------
   --  unsigned long*
   --
   package c_unsigned_long_Pointers is new C.Pointers (Index              => C.size_t,
                                                       Element            => C.unsigned_Long,
                                                       element_Array      => unsigned_long_Array,
                                                       default_Terminator => 0);
   subtype unsigned_long_Pointer    is c_unsigned_long_Pointers.Pointer;


   --------------
   --  long long*
   --
   package c_long_long_Pointers is new C.Pointers (Index              => C.size_t,
                                                   Element            => swig.long_Long,
                                                   element_Array      => long_long_Array,
                                                   default_Terminator => 0);
   subtype long_long_Pointer    is c_long_long_Pointers.Pointer;


   -----------------------
   --  unsigned long long*
   --
   package c_unsigned_long_long_Pointers is new C.Pointers (Index              => C.size_t,
                                                            Element            => swig.unsigned_long_Long,
                                                            element_Array      => unsigned_long_long_Array,
                                                            default_Terminator => 0);
   subtype unsigned_long_long_Pointer    is c_unsigned_long_long_Pointers.Pointer;



   -----------
   --  int8_t*
   --
   package c_int8_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                Element            => swig.int8_t,
                                                element_Array      => swig.int8_t_Array,
                                                default_Terminator => 0);
   subtype int8_t_Pointer    is c_int8_t_Pointers.Pointer;


   ------------
   --  int16_t*
   --
   package c_int16_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                 Element            => swig.int16_t,
                                                 element_Array      => swig.int16_t_Array,
                                                 default_Terminator => 0);
   subtype int16_t_Pointer    is c_int16_t_Pointers.Pointer;


   ------------
   --  int32_t*
   --
   package c_int32_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                 Element            => swig.int32_t,
                                                 element_Array      => swig.int32_t_Array,
                                                 default_Terminator => 0);
   subtype int32_t_Pointer    is c_int32_t_Pointers.Pointer;


   ------------
   --  int64_t*
   --
   package c_int64_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                 Element            => swig.int64_t,
                                                 element_Array      => swig.int64_t_Array,
                                                 default_Terminator => 0);
   subtype int64_t_Pointer    is c_int64_t_Pointers.Pointer;


   --  int64_t**
   --
   type int64_t_pointer_Array is array (C.size_t range <>) of aliased int64_t_Pointer;

   package c_int64_t_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                         Element            => int64_t_Pointer,
                                                         element_Array      => int64_t_pointer_Array,
                                                         default_Terminator => null);
   subtype int64_t_pointer_Pointer    is c_int64_t_pointer_Pointers.Pointer;


   ------------
   --  uint8_t*
   --
   package c_uint8_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                 Element            => swig.uint8_t,
                                                 element_Array      => swig.uint8_t_Array,
                                                 default_Terminator => 0);
   subtype uint8_t_Pointer    is c_uint8_t_Pointers.Pointer;


   -------------
   --  uint16_t*
   --
   package c_uint16_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                  Element            => swig.uint16_t,
                                                  element_Array      => swig.uint16_t_Array,
                                                  default_Terminator => 0);
   subtype uint16_t_Pointer    is c_uint16_t_Pointers.Pointer;


   -------------
   --  uint32_t*
   --
   package c_uint32_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                  Element            => swig.uint32_t,
                                                  element_Array      => swig.uint32_t_Array,
                                                  default_Terminator => 0);
   subtype uint32_t_Pointer    is c_uint32_t_Pointers.Pointer;


   -------------
   --  uint64_t*
   --
   package c_uint64_t_Pointers is new C.Pointers (Index              => C.size_t,
                                                  Element            => swig.uint64_t,
                                                  element_Array      => swig.uint64_t_Array,
                                                  default_Terminator => 0);
   subtype uint64_t_Pointer    is c_uint64_t_Pointers.Pointer;



   ----------
   --  float*
   package c_float_Pointers is new C.Pointers (Index              => C.size_t,
                                               Element            => C.c_Float,
                                               element_Array      => float_Array,
                                               default_Terminator => 0.0);
   subtype float_Pointer    is c_float_Pointers.Pointer;


   --  float**
   --
   type float_pointer_Array is array (C.size_t range <>) of aliased float_Pointer;

   package c_float_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                       Element            => float_Pointer,
                                                       element_Array      => float_pointer_Array,
                                                       default_Terminator => null);
   subtype float_pointer_Pointer    is c_float_pointer_Pointers.Pointer;


   -----------
   --  double*
   --
   package c_double_Pointers is new C.Pointers (Index              => C.size_t,
                                                Element            => C.Double,
                                                element_Array      => double_Array,
                                                default_Terminator => 0.0);
   subtype double_Pointer    is c_double_Pointers.Pointer;


   --  double**
   --
   type double_pointer_Array is array (C.size_t range <>) of aliased double_Pointer;

   package c_double_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                        Element            => double_Pointer,
                                                        element_Array      => double_pointer_Array,
                                                        default_Terminator => null);
   subtype double_pointer_Pointer    is c_double_pointer_Pointers.Pointer;


   ----------------
   --  long double*
   --
   package c_long_double_Pointers is new C.Pointers (Index              => C.size_t,
                                                     Element            => C.long_Double,
                                                     element_Array      => long_double_Array,
                                                     default_Terminator => 0.0);
   subtype long_double_Pointer    is c_long_double_Pointers.Pointer;


   --  long double**
   --
   type long_double_pointer_Array is array (C.size_t range <>) of aliased long_double_Pointer;

   package c_long_double_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                             Element            => long_double_Pointer,
                                                             element_Array      => long_double_pointer_Array,
                                                             default_Terminator => null);
   subtype long_double_pointer_Pointer    is c_long_double_pointer_Pointers.Pointer;


   ---------------
   -- std::string*
   --
   null_std_string : constant std_string := (M_dataplus => system.null_Address);

   package c_std_string_Pointers is new C.Pointers (Index              => C.size_t,
                                                    Element            => std_string,
                                                    element_Array      => std_string_Array,
                                                    default_Terminator => null_std_string);
   subtype std_string_Pointer    is c_std_string_Pointers.Pointer;


   --  std::string**
   --
   type std_string_pointer_Array is array (C.size_t range <>) of aliased std_string_Pointer;

   package c_std_string_pointer_Pointers is new C.Pointers (Index              => C.size_t,
                                                            Element            => std_string_Pointer,
                                                            element_Array      => std_string_pointer_Array,
                                                            default_Terminator => null);
   subtype std_string_pointer_Pointer    is c_std_string_pointer_Pointers.Pointer;


   -----------
   --  Utility
   --
   package void_Conversions is new system.Address_to_Access_conversions (swig.Void);


end Swig.Pointers;
