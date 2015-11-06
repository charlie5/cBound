-- This file is generated by SWIG. Please do *not* modify by hand.
--
with Swig;
with Interfaces.C;
with Interfaces.C.Pointers;
with Interfaces.C.Strings;
with System;
package clib is

   -- time_t
   --
   subtype time_t is Interfaces.C.long;

   type time_t_array is
     array (Interfaces.C.size_t range <>) of aliased clib.time_t;

   -- FILE
   --
   subtype FILE is Swig.void;

   type FILE_array is
     array (Interfaces.C.size_t range <>) of aliased clib.FILE;

   use type Interfaces.C.long;

   a_SYS_CDEFS_H     : constant                                    := 1;
   a_LIBC_LIMITS_H_a : constant                                    := 1;
   MB_LEN_MAX        : constant                                    := 16;
   a_LIMITS_H        : constant                                    := 1;
   CHAR_BIT          : constant                                    := 8;
   SCHAR_MIN         : constant                                    := -128;
   SCHAR_MAX         : constant                                    := 127;
   UCHAR_MAX         : constant                                    := 255;
   CHAR_MIN          : constant                                    := -128;
   CHAR_MAX          : constant                                    := 127;
   SHRT_MIN          : constant                                    := -32768;
   SHRT_MAX          : constant                                    := 32767;
   USHRT_MAX         : constant                                    := 65535;
   INT_MAX           : constant := 2147483647;
   UINT_MAX          : aliased constant Interfaces.C.unsigned := 4294967295;
   LONG_MAX          : aliased constant Interfaces.C.long := 2147483647;
   LONG_MIN          : aliased constant Interfaces.C.long := -2147483648;
   ULONG_MAX : aliased constant Interfaces.C.unsigned_long := 4294967295;
   a_LOCALE_H        : constant                                    := 1;
   a_MATH_H          : constant                                    := 1;

end clib;
