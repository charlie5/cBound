-- This file is generated by SWIG. Please do *not* modify by hand.
--
with gmp_c.Pointers;
with Interfaces.C;

package gmp_c.mp_ptr is

   -- Item
   --
   subtype Item is gmp_c.Pointers.mp_limb_t_Pointer;

   -- Items
   --
   type Items is
     array (Interfaces.C.size_t range <>) of aliased gmp_c.mp_ptr.Item;

   -- Pointer
   --
   type Pointer is access all gmp_c.mp_ptr.Item;

   -- Pointers
   --
   type Pointers is
     array (Interfaces.C.size_t range <>) of aliased gmp_c.mp_ptr.Pointer;

   -- Pointer_Pointer
   --
   type Pointer_Pointer is access all gmp_c.mp_ptr.Pointer;

end gmp_c.mp_ptr;
