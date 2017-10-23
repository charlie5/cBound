/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 1.3.36
 * 
 * This file is not intended to be easily readable and contains a number of 
 * coding conventions designed to improve portability and efficiency. Do not make
 * changes to this file unless you know what you are doing--modify the SWIG 
 * interface file instead. 
 * ----------------------------------------------------------------------------- */


#ifdef __cplusplus
template<typename T> class SwigValueWrapper {
    T *tt;
public:
    SwigValueWrapper() : tt(0) { }
    SwigValueWrapper(const SwigValueWrapper<T>& rhs) : tt(new T(*rhs.tt)) { }
    SwigValueWrapper(const T& t) : tt(new T(t)) { }
    ~SwigValueWrapper() { delete tt; } 
    SwigValueWrapper& operator=(const T& t) { delete tt; tt = new T(t); return *this; }
    operator T&() const { return *tt; }
    T *operator&() { return tt; }
private:
    SwigValueWrapper& operator=(const SwigValueWrapper<T>& rhs);
};

template <typename T> T SwigValueInit() {
  return T();
}
#endif

/* -----------------------------------------------------------------------------
 *  This section contains generic SWIG labels for method/variable
 *  declarations/attributes, and other compiler dependent labels.
 * ----------------------------------------------------------------------------- */

/* template workaround for compilers that cannot correctly implement the C++ standard */
#ifndef SWIGTEMPLATEDISAMBIGUATOR
# if defined(__SUNPRO_CC) && (__SUNPRO_CC <= 0x560)
#  define SWIGTEMPLATEDISAMBIGUATOR template
# elif defined(__HP_aCC)
/* Needed even with `aCC -AA' when `aCC -V' reports HP ANSI C++ B3910B A.03.55 */
/* If we find a maximum version that requires this, the test would be __HP_aCC <= 35500 for A.03.55 */
#  define SWIGTEMPLATEDISAMBIGUATOR template
# else
#  define SWIGTEMPLATEDISAMBIGUATOR
# endif
#endif

/* inline attribute */
#ifndef SWIGINLINE
# if defined(__cplusplus) || (defined(__GNUC__) && !defined(__STRICT_ANSI__))
#   define SWIGINLINE inline
# else
#   define SWIGINLINE
# endif
#endif

/* attribute recognised by some compilers to avoid 'unused' warnings */
#ifndef SWIGUNUSED
# if defined(__GNUC__)
#   if !(defined(__cplusplus)) || (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4))
#     define SWIGUNUSED __attribute__ ((__unused__)) 
#   else
#     define SWIGUNUSED
#   endif
# elif defined(__ICC)
#   define SWIGUNUSED __attribute__ ((__unused__)) 
# else
#   define SWIGUNUSED 
# endif
#endif

#ifndef SWIGUNUSEDPARM
# ifdef __cplusplus
#   define SWIGUNUSEDPARM(p)
# else
#   define SWIGUNUSEDPARM(p) p SWIGUNUSED 
# endif
#endif

/* internal SWIG method */
#ifndef SWIGINTERN
# define SWIGINTERN static SWIGUNUSED
#endif

/* internal inline SWIG method */
#ifndef SWIGINTERNINLINE
# define SWIGINTERNINLINE SWIGINTERN SWIGINLINE
#endif

/* exporting methods */
#if (__GNUC__ >= 4) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
#  ifndef GCC_HASCLASSVISIBILITY
#    define GCC_HASCLASSVISIBILITY
#  endif
#endif

#ifndef SWIGEXPORT
# if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#   if defined(STATIC_LINKED)
#     define SWIGEXPORT
#   else
#     define SWIGEXPORT __declspec(dllexport)
#   endif
# else
#   if defined(__GNUC__) && defined(GCC_HASCLASSVISIBILITY)
#     define SWIGEXPORT __attribute__ ((visibility("default")))
#   else
#     define SWIGEXPORT
#   endif
# endif
#endif

/* calling conventions for Windows */
#ifndef SWIGSTDCALL
# if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#   define SWIGSTDCALL __stdcall
# else
#   define SWIGSTDCALL
# endif 
#endif

/* Deal with Microsoft's attempt at deprecating C standard runtime functions */
#if !defined(SWIG_NO_CRT_SECURE_NO_DEPRECATE) && defined(_MSC_VER) && !defined(_CRT_SECURE_NO_DEPRECATE)
# define _CRT_SECURE_NO_DEPRECATE
#endif

/* Deal with Microsoft's attempt at deprecating methods in the standard C++ library */
#if !defined(SWIG_NO_SCL_SECURE_NO_DEPRECATE) && defined(_MSC_VER) && !defined(_SCL_SECURE_NO_DEPRECATE)
# define _SCL_SECURE_NO_DEPRECATE
#endif



#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#if defined(_WIN32) || defined(__CYGWIN32__)
#  define DllExport   __declspec( dllexport )
#  define SWIGSTDCALL __stdcall
#else
#  define DllExport  
#  define SWIGSTDCALL
#endif 


#ifdef __cplusplus
#  include <new>
#endif



/* Callback for returning strings to Ada without leaking memory */

typedef char * (SWIGSTDCALL* SWIG_AdaStringHelperCallback)(const char *);
static SWIG_AdaStringHelperCallback SWIG_ada_string_callback = NULL;



/* probably obsolete ...
#ifdef __cplusplus
extern "C" 
#endif
DllExport void SWIGSTDCALL SWIGRegisterStringCallback_CORE_MODULE(SWIG_AdaStringHelperCallback callback) {
  SWIG_ada_string_callback = callback;
}
*/



/* Contract support */
/*
#define SWIG_contract_assert(nullreturn, expr, msg) if (!(expr)) {SWIG_AdaThrowException(SWIG_AdaArgumentOutOfRangeException, msg); return nullreturn; } else
*/

#define protected public
#define private   public

    #include <festival/festival.h>



   void
   set_festival_libdir (const char*   To)
   {
      festival_libdir = To;
   }


#undef protected
#undef private
#ifdef __cplusplus 
extern "C" {
#endif
DllExport int SWIGSTDCALL Ada_festival_socket_client (
  char * jarg1
  ,
  
  int jarg2
  )
{
  int jresult ;
  char *arg1 = (char *) 0 ;
  int arg2 ;
  int result;
  
  arg1 = jarg1; 
  
  
  arg2 = (int) jarg2; 
  
  
  result = (int)festival_socket_client((char const *)arg1,arg2);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport int SWIGSTDCALL Ada_festival_start_server (
  int jarg1
  )
{
  int jresult ;
  int arg1 ;
  int result;
  
  
  arg1 = (int) jarg1; 
  
  
  result = (int)festival_start_server(arg1);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport void SWIGSTDCALL Ada_festival_initialize (
  int jarg1
  ,
  
  int jarg2
  )
{
  int arg1 ;
  int arg2 ;
  
  
  arg1 = (int) jarg1; 
  
  
  
  arg2 = (int) jarg2; 
  
  
  festival_initialize(arg1,arg2);
  
  
}



DllExport void SWIGSTDCALL Ada_festival_init_lang (
  void * jarg1
  )
{
  EST_String *arg1 = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  festival_init_lang((EST_String const &)*arg1);
  
  
}



DllExport int SWIGSTDCALL Ada_festival_eval_command (
  void * jarg1
  )
{
  int jresult ;
  EST_String *arg1 = 0 ;
  int result;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = (int)festival_eval_command((EST_String const &)*arg1);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport int SWIGSTDCALL Ada_festival_load_file (
  void * jarg1
  )
{
  int jresult ;
  EST_String *arg1 = 0 ;
  int result;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = (int)festival_load_file((EST_String const &)*arg1);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport int SWIGSTDCALL Ada_festival_say_file (
  void * jarg1
  )
{
  int jresult ;
  EST_String *arg1 = 0 ;
  int result;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = (int)festival_say_file((EST_String const &)*arg1);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport int SWIGSTDCALL Ada_festival_say_text (
  void * jarg1
  )
{
  int jresult ;
  EST_String *arg1 = 0 ;
  int result;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = (int)festival_say_text((EST_String const &)*arg1);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport int SWIGSTDCALL Ada_festival_text_to_wave (
  void * jarg1
  ,
  
  void * jarg2
  )
{
  int jresult ;
  EST_String *arg1 = 0 ;
  EST_Wave *arg2 = 0 ;
  int result;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_Wave *)jarg2;
  
  
  result = (int)festival_text_to_wave((EST_String const &)*arg1,*arg2);
  jresult = result; 
  
  
  
  return jresult;
  
}



DllExport void SWIGSTDCALL Ada_festival_repl (
  int jarg1
  )
{
  int arg1 ;
  
  
  arg1 = (int) jarg1; 
  
  
  festival_repl(arg1);
  
  
}



DllExport void SWIGSTDCALL Ada_festival_server_mode (
  )
{
  festival_server_mode();
  
  
}



DllExport void SWIGSTDCALL Ada_festival_wait_for_spooler (
  )
{
  festival_wait_for_spooler();
  
  
}



DllExport void SWIGSTDCALL Ada_festival_tidy_up (
  )
{
  festival_tidy_up();
  
  
}



DllExport void SWIGSTDCALL Ada_festival_def_nff (
  void * jarg1
  ,
  
  void * jarg2
  ,
  
  EST_Item_featfunc jarg3
  ,
  
  char * jarg4
  )
{
  EST_String *arg1 = 0 ;
  EST_String *arg2 = 0 ;
  EST_Item_featfunc arg3 ;
  char *arg4 = (char *) 0 ;
  EST_Item_featfunc *argp3 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  
  argp3 = (EST_Item_featfunc *) &jarg3; 
  
  arg3 = *argp3; 
  
  
  arg4 = jarg4; 
  
  festival_def_nff((EST_String const &)*arg1,(EST_String const &)*arg2,arg3,(char const *)arg4);
  
  
}



DllExport void SWIGSTDCALL Ada_festival_def_ff_pref (
  void * jarg1
  ,
  
  void * jarg2
  ,
  
  void * jarg3
  ,
  
  char * jarg4
  )
{
  EST_String *arg1 = 0 ;
  EST_String *arg2 = 0 ;
  FT_ff_pref_func arg3 = (FT_ff_pref_func) 0 ;
  char *arg4 = (char *) 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  arg3 = (FT_ff_pref_func)jarg3; 
  
  arg4 = jarg4; 
  
  festival_def_ff_pref((EST_String const &)*arg1,(EST_String const &)*arg2,arg3,(char const *)arg4);
  
  
}



DllExport EST_Val SWIGSTDCALL Ada_ffeature (
  void * jarg1
  ,
  
  void * jarg2
  )
{
  EST_Val jresult ;
  EST_Item *arg1 = (EST_Item *) 0 ;
  EST_String *arg2 = 0 ;
  EST_Val result;
  
  arg1 = (EST_Item *)jarg1; 
  
  
  arg2 = (EST_String *)jarg2;
  
  
  result = ffeature(arg1,(EST_String const &)*arg2);
  
  jresult = result; 
  //jresult = new EST_Val ((EST_Val &) result); 
  
  
  
  
  return jresult;
  
}



DllExport void SWIGSTDCALL Ada_proclaim_module__SWIG_0 (
  void * jarg1
  ,
  
  void * jarg2
  ,
  
  void * jarg3
  )
{
  EST_String *arg1 = 0 ;
  EST_String *arg2 = 0 ;
  ModuleDescription *arg3 = (ModuleDescription *) 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  arg3 = (ModuleDescription *)jarg3; 
  
  proclaim_module((EST_String const &)*arg1,(EST_String const &)*arg2,(ModuleDescription const *)arg3);
  
  
}



DllExport void SWIGSTDCALL Ada_proclaim_module__SWIG_1 (
  void * jarg1
  ,
  
  void * jarg2
  )
{
  EST_String *arg1 = 0 ;
  EST_String *arg2 = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  proclaim_module((EST_String const &)*arg1,(EST_String const &)*arg2);
  
  
}



DllExport void SWIGSTDCALL Ada_proclaim_module__SWIG_2 (
  void * jarg1
  ,
  
  void * jarg2
  )
{
  EST_String *arg1 = 0 ;
  ModuleDescription *arg2 = (ModuleDescription *) 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  arg2 = (ModuleDescription *)jarg2; 
  
  proclaim_module((EST_String const &)*arg1,(ModuleDescription const *)arg2);
  
  
}



DllExport void SWIGSTDCALL Ada_proclaim_module__SWIG_3 (
  void * jarg1
  )
{
  EST_String *arg1 = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  proclaim_module((EST_String const &)*arg1);
  
  
}



DllExport EST_Val SWIGSTDCALL Ada_wagon_predict (
  void * jarg1
  ,
  
  LISP jarg2
  )
{
  EST_Val jresult ;
  EST_Item *arg1 = (EST_Item *) 0 ;
  LISP arg2 ;
  EST_Val result;
  LISP *argp2 ;
  
  arg1 = (EST_Item *)jarg1; 
  
  
  argp2 = (LISP *) &jarg2; 
  
  arg2 = *argp2; 
  
  
  result = wagon_predict(arg1,arg2);
  
  jresult = result; 
  //jresult = new EST_Val ((EST_Val &) result); 
  
  
  
  
  return jresult;
  
}



DllExport LISP SWIGSTDCALL Ada_wagon_pd (
  void * jarg1
  ,
  
  LISP jarg2
  )
{
  LISP jresult ;
  EST_Item *arg1 = (EST_Item *) 0 ;
  LISP arg2 ;
  LISP result;
  LISP *argp2 ;
  
  arg1 = (EST_Item *)jarg1; 
  
  
  argp2 = (LISP *) &jarg2; 
  
  arg2 = *argp2; 
  
  
  result = wagon_pd(arg1,arg2);
  
  jresult = result; 
  //jresult = new LISP ((LISP &) result); 
  
  
  
  
  return jresult;
  
}



DllExport EST_Val SWIGSTDCALL Ada_lr_predict (
  void * jarg1
  ,
  
  LISP jarg2
  )
{
  EST_Val jresult ;
  EST_Item *arg1 = (EST_Item *) 0 ;
  LISP arg2 ;
  EST_Val result;
  LISP *argp2 ;
  
  arg1 = (EST_Item *)jarg1; 
  
  
  argp2 = (LISP *) &jarg2; 
  
  arg2 = *argp2; 
  
  
  result = lr_predict(arg1,arg2);
  
  jresult = result; 
  //jresult = new EST_Val ((EST_Val &) result); 
  
  
  
  
  return jresult;
  
}



DllExport void * SWIGSTDCALL Ada_get_ngram__SWIG_0 (
  void * jarg1
  ,
  
  void * jarg2
  )
{
  void * jresult ;
  EST_String *arg1 = 0 ;
  EST_String *arg2 = 0 ;
  EST_Ngrammar *result = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  result = (EST_Ngrammar *)get_ngram((EST_String const &)*arg1,(EST_String const &)*arg2);
  jresult = (void *) result;      
  
  
  
  return jresult;
  
}



DllExport void * SWIGSTDCALL Ada_get_ngram__SWIG_1 (
  void * jarg1
  )
{
  void * jresult ;
  EST_String *arg1 = 0 ;
  EST_Ngrammar *result = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = (EST_Ngrammar *)get_ngram((EST_String const &)*arg1);
  jresult = (void *) result;      
  
  
  
  return jresult;
  
}



DllExport void * SWIGSTDCALL Ada_get_wfst__SWIG_0 (
  void * jarg1
  ,
  
  void * jarg2
  )
{
  void * jresult ;
  EST_String *arg1 = 0 ;
  EST_String *arg2 = 0 ;
  EST_WFST *result = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  result = (EST_WFST *)get_wfst((EST_String const &)*arg1,(EST_String const &)*arg2);
  jresult = (void *) result;      
  
  
  
  return jresult;
  
}



DllExport void * SWIGSTDCALL Ada_get_wfst__SWIG_1 (
  void * jarg1
  )
{
  void * jresult ;
  EST_String *arg1 = 0 ;
  EST_WFST *result = 0 ;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = (EST_WFST *)get_wfst((EST_String const &)*arg1);
  jresult = (void *) result;      
  
  
  
  return jresult;
  
}



DllExport LISP SWIGSTDCALL Ada_lisp_wfst_transduce (
  LISP jarg1
  ,
  
  LISP jarg2
  )
{
  LISP jresult ;
  LISP arg1 ;
  LISP arg2 ;
  LISP result;
  LISP *argp1 ;
  LISP *argp2 ;
  
  
  argp1 = (LISP *) &jarg1; 
  
  arg1 = *argp1; 
  
  
  
  argp2 = (LISP *) &jarg2; 
  
  arg2 = *argp2; 
  
  
  result = lisp_wfst_transduce(arg1,arg2);
  
  jresult = result; 
  //jresult = new LISP ((LISP &) result); 
  
  
  
  
  return jresult;
  
}



DllExport EST_String SWIGSTDCALL Ada_map_pos__SWIG_0 (
  LISP jarg1
  ,
  
  void * jarg2
  )
{
  EST_String jresult ;
  LISP arg1 ;
  EST_String *arg2 = 0 ;
  EST_String result;
  LISP *argp1 ;
  
  
  argp1 = (LISP *) &jarg1; 
  
  arg1 = *argp1; 
  
  
  
  arg2 = (EST_String *)jarg2;
  
  
  result = map_pos(arg1,(EST_String const &)*arg2);
  
  jresult = result; 
  //jresult = new EST_String ((EST_String &) result); 
  
  
  
  
  return jresult;
  
}



DllExport LISP SWIGSTDCALL Ada_map_pos__SWIG_1 (
  LISP jarg1
  ,
  
  LISP jarg2
  )
{
  LISP jresult ;
  LISP arg1 ;
  LISP arg2 ;
  LISP result;
  LISP *argp1 ;
  LISP *argp2 ;
  
  
  argp1 = (LISP *) &jarg1; 
  
  arg1 = *argp1; 
  
  
  
  argp2 = (LISP *) &jarg2; 
  
  arg2 = *argp2; 
  
  
  result = map_pos(arg1,arg2);
  
  jresult = result; 
  //jresult = new LISP ((LISP &) result); 
  
  
  
  
  return jresult;
  
}



DllExport void SWIGSTDCALL Ada_utt_cleanup (
  void * jarg1
  )
{
  EST_Utterance *arg1 = 0 ;
  
  
  arg1 = (EST_Utterance *)jarg1;
  
  
  utt_cleanup(*arg1);
  
  
}



DllExport LISP SWIGSTDCALL Ada_utt_iform (
  void * jarg1
  )
{
  LISP jresult ;
  EST_Utterance *arg1 = 0 ;
  LISP result;
  
  
  arg1 = (EST_Utterance *)jarg1;
  
  
  result = utt_iform(*arg1);
  
  jresult = result; 
  //jresult = new LISP ((LISP &) result); 
  
  
  
  
  return jresult;
  
}



DllExport void SWIGSTDCALL Ada_add_item_features (
  void * jarg1
  ,
  
  LISP jarg2
  )
{
  EST_Item *arg1 = (EST_Item *) 0 ;
  LISP arg2 ;
  LISP *argp2 ;
  
  arg1 = (EST_Item *)jarg1; 
  
  
  argp2 = (LISP *) &jarg2; 
  
  arg2 = *argp2; 
  
  
  add_item_features(arg1,arg2);
  
  
}



DllExport void SWIGSTDCALL Ada_festival_init_modules (
  )
{
  festival_init_modules();
  
  
}



DllExport LISP SWIGSTDCALL Ada_ft_get_param (
  void * jarg1
  )
{
  LISP jresult ;
  EST_String *arg1 = 0 ;
  LISP result;
  
  
  arg1 = (EST_String *)jarg1;
  
  
  result = ft_get_param((EST_String const &)*arg1);
  
  jresult = result; 
  //jresult = new LISP ((LISP &) result); 
  
  
  
  
  return jresult;
  
}



DllExport void SWIGSTDCALL Ada_set_festival_libdir (
  char * jarg1
  )
{
  char *arg1 = (char *) 0 ;
  
  arg1 = jarg1; 
  
  set_festival_libdir((char const *)arg1);
  
  
}



#ifdef __cplusplus
}
#endif
#ifdef __cplusplus
extern "C" {
#endif
#ifdef __cplusplus
}
#endif

