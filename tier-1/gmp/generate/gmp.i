//   SWIG 'interface definition' for the 'GMP' (Gnu Multi-Precision) large number C library.
//

%module gmp_c

%{
#include "gmp.h"
%}

%ignore GMP_NUMB_BITS;
%ignore __GMP_CC;
%ignore __GMP_CFLAGS;

%ignore __gmp_set_memory_functions;
%ignore __gmp_get_memory_functions;
%ignore __gmpn_sec_tabselect;
%ignore __gmpz_limbs_read;
%ignore __gmpz_limbs_write;
%ignore __gmpz_limbs_modify;
%ignore __gmpz_limbs_finish;
%ignore __gmpz_roinit_n;
%ignore __gmpn_div_qr_1;
%ignore __gmpn_sizeinbase;
%ignore __gmpn_cnd_add_n;
%ignore __gmpn_cnd_sub_n;
%ignore __gmpn_sec_add_1;
%ignore __gmpn_sec_add_1_itch;
%ignore __gmpn_sec_sub_1;
%ignore __gmpn_sec_sub_1_itch;
%ignore __gmpn_sec_mul;
%ignore __gmpn_sec_mul_itch;
%ignore __gmpn_sec_sqr;
%ignore __gmpn_sec_sqr_itch;
%ignore __gmpn_sec_powm;
%ignore __gmpn_sec_powm_itch;
%ignore __gmpn_sec_div_qr;
%ignore __gmpn_sec_div_qr_itch;
%ignore __gmpn_sec_div_r;
%ignore __gmpn_sec_div_r_itch;
%ignore __gmpn_sec_invert;
%ignore __gmpn_sec_invert_itch;

%rename  (bits_per_limb)        __gmp_bits_per_limb;
%rename  (errno)                __gmp_errno;
%rename  (version)              __gmp_version;


// **************** Random number routines.  ****************

%rename  (randinit)          __gmp_randinit;
%rename  (randinit_default) __gmp_randinit_default;
%rename  (randinit_lc_2exp) __gmp_randinit_lc_2exp;
%rename  (randinit_lc_2exp_size) __gmp_randinit_lc_2exp_size;
%rename  (randinit_mt) __gmp_randinit_mt;
%rename  (randinit_set) __gmp_randinit_set;
%rename  (randseed) __gmp_randseed;
%rename  (randseed_ui) __gmp_randseed_ui;
%rename  (randclear) __gmp_randclear;
%rename  (urandomb_ui) __gmp_urandomb_ui;
%rename  (urandomm_ui) __gmp_urandomm_ui;


// **************** Formatted output routines.  ****************

%rename  (asprintf) __gmp_asprintf;
%rename  (fprintf) __gmp_fprintf;
%rename  (obstack_printf) __gmp_obstack_printf;
%rename  (obstack_vprintf) __gmp_obstack_vprintf;
%rename  (printf) __gmp_printf;
%rename  (snprintf) __gmp_snprintf;
%rename  (sprintf) __gmp_sprintf;
%rename  (vasprintf) __gmp_vasprintf;
%rename  (vfprintf) __gmp_vfprintf;
%rename  (vprintf) __gmp_vprintf;
%rename  (vsnprintf) __gmp_vsnprintf;
%rename  (vsprintf) __gmp_vsprintf;


// **************** Formatted input routines.  ****************

%rename  (fscanf) __gmp_fscanf;
%rename  (scanf) __gmp_scanf;
%rename  (sscanf) __gmp_sscanf;
%rename  (vfscanf) __gmp_vfscanf;
%rename  (vscanf) __gmp_vscanf;
%rename  (vsscanf) __gmp_vsscanf;


// **************** Integer (i.e. Z) routines.  ****************

//#define _mpz_realloc) __gmpz_realloc
%rename (realloc) __gmpz_realloc;
%rename (abs) __gmpz_abs;
%rename (add) __gmpz_add;
%rename (add_ui) __gmpz_add_ui;
%rename (addmul) __gmpz_addmul;
%rename (addmul_ui) __gmpz_addmul_ui;
%rename (z_and) __gmpz_and;
%rename (array_init) __gmpz_array_init;
%rename (bin_ui) __gmpz_bin_ui;
%rename (bin_uiui) __gmpz_bin_uiui;
%rename (cdiv_q) __gmpz_cdiv_q;
%rename (cdiv_q_2exp) __gmpz_cdiv_q_2exp;
%rename (cdiv_q_ui) __gmpz_cdiv_q_ui;
%rename (cdiv_qr) __gmpz_cdiv_qr;
%rename (cdiv_qr_ui) __gmpz_cdiv_qr_ui;
%rename (cdiv_r) __gmpz_cdiv_r;
%rename (cdiv_r_2exp) __gmpz_cdiv_r_2exp;
%rename (cdiv_r_ui) __gmpz_cdiv_r_ui;
%rename (cdiv_ui) __gmpz_cdiv_ui;
%rename (clear) __gmpz_clear;
%rename (clrbit) __gmpz_clrbit;
%rename (cmp) __gmpz_cmp;
%rename (cmp_d) __gmpz_cmp_d;
//#define _mpz_cmp_si) __gmpz_cmp_si
//#define _mpz_cmp_ui) __gmpz_cmp_ui
%rename (cmpabs) __gmpz_cmpabs;
%rename (cmpabs_d) __gmpz_cmpabs_d;
%rename (cmpabs_ui) __gmpz_cmpabs_ui;
%rename (com) __gmpz_com;
%rename (combit) __gmpz_combit;
%rename (congruent_p) __gmpz_congruent_p;
%rename (congruent_2exp_p) __gmpz_congruent_2exp_p;
%rename (congruent_ui_p) __gmpz_congruent_ui_p;
%rename (divexact) __gmpz_divexact;
%rename (divexact_ui) __gmpz_divexact_ui;
%rename (divisible_p) __gmpz_divisible_p;
%rename (divisible_ui_p) __gmpz_divisible_ui_p;
%rename (divisible_2exp_p) __gmpz_divisible_2exp_p;
%rename (dump) __gmpz_dump;
%rename (z_export) __gmpz_export;
%rename (fac_ui) __gmpz_fac_ui;
%rename (fdiv_q) __gmpz_fdiv_q;
%rename (fdiv_q_2exp) __gmpz_fdiv_q_2exp;
%rename (fdiv_q_ui) __gmpz_fdiv_q_ui;
%rename (fdiv_qr) __gmpz_fdiv_qr;
%rename (fdiv_qr_ui) __gmpz_fdiv_qr_ui;
%rename (fdiv_r) __gmpz_fdiv_r;
%rename (fdiv_r_2exp) __gmpz_fdiv_r_2exp;
%rename (fdiv_r_ui) __gmpz_fdiv_r_ui;
%rename (fdiv_ui) __gmpz_fdiv_ui;
%rename (fib_ui) __gmpz_fib_ui;
%rename (fib2_ui) __gmpz_fib2_ui;
%rename (fits_sint_p) __gmpz_fits_sint_p;
%rename (fits_slong_p) __gmpz_fits_slong_p;
%rename (fits_sshort_p) __gmpz_fits_sshort_p;
%rename (fits_uint_p) __gmpz_fits_uint_p;
%rename (fits_ulong_p) __gmpz_fits_ulong_p;
%rename (fits_ushort_p) __gmpz_fits_ushort_p;
%rename (gcd) __gmpz_gcd;
%rename (gcd_ui) __gmpz_gcd_ui;
%rename (gcdext) __gmpz_gcdext;
%rename (get_d) __gmpz_get_d;
%rename (get_d_2exp) __gmpz_get_d_2exp;
%rename (get_si) __gmpz_get_si;
%rename (get_str) __gmpz_get_str;
%rename (get_ui) __gmpz_get_ui;
%rename (getlimbn) __gmpz_getlimbn;
%rename (hamdist) __gmpz_hamdist;
%rename (import) __gmpz_import;
%rename (init) __gmpz_init;
%rename (init2) __gmpz_init2;
%rename (init_set) __gmpz_init_set;
%rename (init_set_d) __gmpz_init_set_d;
%rename (init_set_si) __gmpz_init_set_si;
%rename (init_set_str) __gmpz_init_set_str;
%rename (init_set_ui) __gmpz_init_set_ui;
%rename (inp_raw) __gmpz_inp_raw;
%rename (inp_str) __gmpz_inp_str;
%rename (invert) __gmpz_invert;
%rename (ior) __gmpz_ior;
%rename (jacobi) __gmpz_jacobi;
%rename (kronecker) mpz_jacobi;
%rename (kronecker_si) __gmpz_kronecker_si;
%rename (kronecker_ui) __gmpz_kronecker_ui;
%rename (si_kronecker) __gmpz_si_kronecker;
%rename (ui_kronecker) __gmpz_ui_kronecker;
%rename (lcm) __gmpz_lcm;
%rename (lcm_ui) __gmpz_lcm_ui;
%rename (legendre) mpz_jacobi;
%rename (lucnum_ui) __gmpz_lucnum_ui;
%rename (lucnum2_ui) __gmpz_lucnum2_ui;
%rename (millerrabin) __gmpz_millerrabin;
%rename (mod) __gmpz_mod;
%rename (mod_ui) mpz_fdiv_r_ui;
%rename (mul) __gmpz_mul;
%rename (mul_2exp) __gmpz_mul_2exp;
%rename (mul_si) __gmpz_mul_si;
%rename (mul_ui) __gmpz_mul_ui;
%rename (neg) __gmpz_neg;
%rename (nextprime) __gmpz_nextprime;
%rename (out_raw) __gmpz_out_raw;
%rename (out_str) __gmpz_out_str;
%rename (perfect_power_p) __gmpz_perfect_power_p;
%rename (perfect_square_p) __gmpz_perfect_square_p;
%rename (popcount) __gmpz_popcount;
%rename (pow_ui) __gmpz_pow_ui;
%rename (powm) __gmpz_powm;
%rename (powm_ui) __gmpz_powm_ui;
%rename (probab_prime_p) __gmpz_probab_prime_p;
%rename (random) __gmpz_random;
%rename (random2) __gmpz_random2;
%rename (realloc2) __gmpz_realloc2;
%rename (remove) __gmpz_remove;
%rename (root) __gmpz_root;
%rename (rootrem) __gmpz_rootrem;
%rename (rrandomb) __gmpz_rrandomb;
%rename (scan0) __gmpz_scan0;
%rename (scan1) __gmpz_scan1;
%rename (set) __gmpz_set;
%rename (set_d) __gmpz_set_d;
%rename (set_f) __gmpz_set_f;
%rename (set_q) __gmpz_set_q;
%rename (set_si) __gmpz_set_si;
%rename (set_str) __gmpz_set_str;
%rename (set_ui) __gmpz_set_ui;
%rename (setbit) __gmpz_setbit;
%rename (size) __gmpz_size;
%rename (sizeinbase) __gmpz_sizeinbase;
%rename (sqrt) __gmpz_sqrt;
%rename (sqrtrem) __gmpz_sqrtrem;
%rename (sub) __gmpz_sub;
%rename (sub_ui) __gmpz_sub_ui;
%rename (ui_sub) __gmpz_ui_sub;
%rename (submul) __gmpz_submul;
%rename (submul_ui) __gmpz_submul_ui;
%rename (swap) __gmpz_swap;
%rename (tdiv_ui) __gmpz_tdiv_ui;
%rename (tdiv_q) __gmpz_tdiv_q;
%rename (tdiv_q_2exp) __gmpz_tdiv_q_2exp;
%rename (tdiv_q_ui) __gmpz_tdiv_q_ui;
%rename (tdiv_qr) __gmpz_tdiv_qr;
%rename (tdiv_qr_ui) __gmpz_tdiv_qr_ui;
%rename (tdiv_r) __gmpz_tdiv_r;
%rename (tdiv_r_2exp) __gmpz_tdiv_r_2exp;
%rename (tdiv_r_ui) __gmpz_tdiv_r_ui;
%rename (tstbit) __gmpz_tstbit;
%rename (ui_pow_ui) __gmpz_ui_pow_ui;
%rename (urandomb) __gmpz_urandomb;
%rename (urandomm) __gmpz_urandomm;
%rename (z_xor) __gmpz_xor;
//%rename (eor) __gmpz_xor;


// **************** Rational (i.e. Q) routines.  ****************

%rename (abs) __gmpq_abs;
%rename (add) __gmpq_add;
%rename (canonicalize) __gmpq_canonicalize;
%rename (clear) __gmpq_clear;
%rename (cmp) __gmpq_cmp;
//#define _mpq_cmp_si) __gmpq_cmp_si
//#define _mpq_cmp_ui) __gmpq_cmp_ui
%rename (div) __gmpq_div;
%rename (div_2exp) __gmpq_div_2exp;
%rename (equal) __gmpq_equal;
%rename (get_num) __gmpq_get_num;
%rename (get_den) __gmpq_get_den;
%rename (get_d) __gmpq_get_d;
%rename (get_str) __gmpq_get_str;
%rename (init) __gmpq_init;
%rename (inp_str) __gmpq_inp_str;
%rename (inv) __gmpq_inv;
%rename (mul) __gmpq_mul;
%rename (mul_2exp) __gmpq_mul_2exp;
%rename (neg) __gmpq_neg;
%rename (out_str) __gmpq_out_str;
%rename (set) __gmpq_set;
%rename (set_d) __gmpq_set_d;
%rename (set_den) __gmpq_set_den;
%rename (set_f) __gmpq_set_f;
%rename (set_num) __gmpq_set_num;
%rename (set_si) __gmpq_set_si;
%rename (set_str) __gmpq_set_str;
%rename (set_ui) __gmpq_set_ui;
%rename (set_z) __gmpq_set_z;
%rename (sub) __gmpq_sub;
%rename (swap) __gmpq_swap;


// **************** Float (i.e. F) routines.  ****************

%rename (abs) __gmpf_abs;
%rename (add) __gmpf_add;
%rename (add_ui) __gmpf_add_ui;
%rename (ceil) __gmpf_ceil;
%rename (clear) __gmpf_clear;
%rename (cmp) __gmpf_cmp;
%rename (cmp_d) __gmpf_cmp_d;
%rename (cmp_si) __gmpf_cmp_si;
%rename (cmp_ui) __gmpf_cmp_ui;
%rename (div) __gmpf_div;
%rename (div_2exp) __gmpf_div_2exp;
%rename (div_ui) __gmpf_div_ui;
%rename (dump) __gmpf_dump;
%rename (eq) __gmpf_eq;
%rename (fits_sint_p) __gmpf_fits_sint_p;
%rename (fits_slong_p) __gmpf_fits_slong_p;
%rename (fits_sshort_p) __gmpf_fits_sshort_p;
%rename (fits_uint_p) __gmpf_fits_uint_p;
%rename (fits_ulong_p) __gmpf_fits_ulong_p;
%rename (fits_ushort_p) __gmpf_fits_ushort_p;
%rename (floor) __gmpf_floor;
%rename (get_d) __gmpf_get_d;
%rename (get_d_2exp) __gmpf_get_d_2exp;
%rename (get_default_prec) __gmpf_get_default_prec;
%rename (get_prec) __gmpf_get_prec;
%rename (get_si) __gmpf_get_si;
%rename (get_str) __gmpf_get_str;
%rename (get_ui) __gmpf_get_ui;
%rename (init) __gmpf_init;
%rename (init2) __gmpf_init2;
%rename (init_set) __gmpf_init_set;
%rename (init_set_d) __gmpf_init_set_d;
%rename (init_set_si) __gmpf_init_set_si;
%rename (init_set_str) __gmpf_init_set_str;
%rename (init_set_ui) __gmpf_init_set_ui;
%rename (inp_str) __gmpf_inp_str;
%rename (integer_p) __gmpf_integer_p;
%rename (mul) __gmpf_mul;
%rename (mul_2exp) __gmpf_mul_2exp;
%rename (mul_ui) __gmpf_mul_ui;
%rename (neg) __gmpf_neg;
%rename (out_str) __gmpf_out_str;
%rename (pow_ui) __gmpf_pow_ui;
%rename (random2) __gmpf_random2;
%rename (reldiff) __gmpf_reldiff;
%rename (set) __gmpf_set;
%rename (set_d) __gmpf_set_d;
%rename (set_default_prec) __gmpf_set_default_prec;
%rename (set_prec) __gmpf_set_prec;
%rename (set_prec_raw) __gmpf_set_prec_raw;
%rename (set_q) __gmpf_set_q;
%rename (set_si) __gmpf_set_si;
%rename (set_str) __gmpf_set_str;
%rename (set_ui) __gmpf_set_ui;
%rename (set_z) __gmpf_set_z;
%rename (size) __gmpf_size;
%rename (sqrt) __gmpf_sqrt;
%rename (sqrt_ui) __gmpf_sqrt_ui;
%rename (sub) __gmpf_sub;
%rename (sub_ui) __gmpf_sub_ui;
%rename (swap) __gmpf_swap;
%rename (trunc) __gmpf_trunc;
%rename (ui_div) __gmpf_ui_div;
%rename (ui_sub) __gmpf_ui_sub;
%rename (urandomb) __gmpf_urandomb;


// ************ Low level positive-integer (i.e. N) routines.  ************

//%rename (add __MPN(add)
//%rename (add_1 __MPN(add_1)
//%rename (add_n __MPN(add_n)
//%rename (addmul_1 __MPN(addmul_1)
//%rename (bdivmod __MPN(bdivmod)
//%rename (cmp __MPN(cmp)


//%rename (divexact_by3c __MPN(divexact_by3c)

/*
%rename (divrem __MPN(divrem)
%rename (divrem_1 __MPN(divrem_1)
%rename (divrem_2 __MPN(divrem_2)
%rename (gcd __MPN(gcd)
%rename (gcd_1 __MPN(gcd_1)
%rename (gcdext_1 __MPN(gcdext_1)
%rename (gcdext __MPN(gcdext)
%rename (get_str __MPN(get_str)
%rename (hamdist __MPN(hamdist)
%rename (lshift __MPN(lshift)
%rename (mod_1 __MPN(mod_1)
%rename (mul __MPN(mul)
%rename (mul_1 __MPN(mul_1)
%rename (mul_n __MPN(mul_n)
%rename (neg_n __MPN(neg_n)
%rename (perfect_square_p __MPN(perfect_square_p)
%rename (popcount __MPN(popcount)
%rename (pow_1 __MPN(pow_1)
%rename (preinv_mod_1 __MPN(preinv_mod_1)
%rename (random __MPN(random)
%rename (random2 __MPN(random2)
%rename (rshift __MPN(rshift)
%rename (scan0 __MPN(scan0)
%rename (scan1 __MPN(scan1)
%rename (set_str __MPN(set_str)
%rename (sqrtrem __MPN(sqrtrem)
%rename (sub __MPN(sub)
%rename (sub_1 __MPN(sub_1)
%rename (sub_n __MPN(sub_n)
%rename (submul_1 __MPN(submul_1)
%rename (tdiv_qr __MPN(tdiv_qr)
*/


%include "gmp.h"
