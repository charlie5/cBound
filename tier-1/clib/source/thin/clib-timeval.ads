-- This file is generated by SWIG. Please do *not* modify by hand.
--
with Interfaces.C;
with Interfaces.C.Pointers;
with Interfaces.C.Strings;
with System;
package clib.timeval is

   -- Item
   --

   type Item is record
      tv_sec  : aliased Interfaces.C.long;
      tv_usec : aliased Interfaces.C.long;
   end record;

   -- Items
   --
   type Items is
     array (Interfaces.C.size_t range <>) of aliased clib.timeval.Item;

   -- Pointer
   --
   type Pointer is access all clib.timeval.Item;

   -- Pointers
   --
   type Pointers is
     array (Interfaces.C.size_t range <>) of aliased clib.timeval.Pointer;

   -- Pointer_Pointer
   --
   type Pointer_Pointer is access all clib.timeval.Pointer;

end clib.timeval;
