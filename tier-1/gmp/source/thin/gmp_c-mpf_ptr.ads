-- This file is generated by SWIG. Please do *not* modify by hand.
--
with gmp_c.a_a_mpf_struct;
with Interfaces.C;

package gmp_c.mpf_ptr is

   -- Item
   --
   subtype Item is gmp_c.a_a_mpf_struct.Pointer;

   -- Items
   --
   type Items is
     array (Interfaces.C.size_t range <>) of aliased gmp_c.mpf_ptr.Item;

   -- Pointer
   --
   type Pointer is access all gmp_c.mpf_ptr.Item;

   -- Pointers
   --
   type Pointers is
     array (Interfaces.C.size_t range <>) of aliased gmp_c.mpf_ptr.Pointer;

   -- Pointer_Pointer
   --
   type Pointer_Pointer is access all gmp_c.mpf_ptr.Pointer;

end gmp_c.mpf_ptr;
