-- This file is generated by SWIG. Please do *not* modify by hand.
--
with gmp_c.a_a_mpz_struct;
with Interfaces.C;

package gmp_c.mpz_srcptr is

   -- Item
   --
   subtype Item is gmp_c.a_a_mpz_struct.Pointer;

   -- Items
   --
   type Items is
     array (Interfaces.C.size_t range <>) of aliased gmp_c.mpz_srcptr.Item;

   -- Pointer
   --
   type Pointer is access all gmp_c.mpz_srcptr.Item;

   -- Pointers
   --
   type Pointers is
     array (Interfaces.C.size_t range <>) of aliased gmp_c.mpz_srcptr.Pointer;

   -- Pointer_Pointer
   --
   type Pointer_Pointer is access all gmp_c.mpz_srcptr.Pointer;

end gmp_c.mpz_srcptr;
