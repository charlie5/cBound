-- This file is generated by SWIG. Please do *not* modify by hand.
--
with Interfaces.C;

package gmp_c.Pointers is

   -- mp_limb_t_Pointer
   --
   type mp_limb_t_Pointer is access all gmp_c.mp_limb_t;

   -- mp_limb_t_Pointers
   --
   type mp_limb_t_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.mp_limb_t_Pointer;

   -- mp_limb_signed_t_Pointer
   --
   type mp_limb_signed_t_Pointer is access all gmp_c.mp_limb_signed_t;

   -- mp_limb_signed_t_Pointers
   --
   type mp_limb_signed_t_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.mp_limb_signed_t_Pointer;

   -- mp_bitcnt_t_Pointer
   --
   type mp_bitcnt_t_Pointer is access all gmp_c.mp_bitcnt_t;

   -- mp_bitcnt_t_Pointers
   --
   type mp_bitcnt_t_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.mp_bitcnt_t_Pointer;

   -- mp_size_t_Pointer
   --
   type mp_size_t_Pointer is access all gmp_c.mp_size_t;

   -- mp_size_t_Pointers
   --
   type mp_size_t_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.mp_size_t_Pointer;

   -- mp_exp_t_Pointer
   --
   type mp_exp_t_Pointer is access all gmp_c.mp_exp_t;

   -- mp_exp_t_Pointers
   --
   type mp_exp_t_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.mp_exp_t_Pointer;

   -- gmp_randalg_t_Pointer
   --
   type gmp_randalg_t_Pointer is access all gmp_c.gmp_randalg_t;

   -- gmp_randalg_t_Pointers
   --
   type gmp_randalg_t_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.gmp_randalg_t_Pointer;

   -- anonymous_enum_1_Pointer
   --
   type anonymous_enum_1_Pointer is access all gmp_c.anonymous_enum_1;

   -- anonymous_enum_1_Pointers
   --
   type anonymous_enum_1_Pointers is
     array
       (Interfaces.C
          .size_t range <>) of aliased gmp_c.Pointers.anonymous_enum_1_Pointer;

end gmp_c.Pointers;
