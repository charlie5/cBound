//
//   SWIG interface definition for clib (the standard C library).
//

%module clib


// These wil be added to the geberated C binding file.
//
%{
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <locale.h>
#include <math.h>
#include <setjmp.h>
#include <time.h>

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

#include <string.h>
%}


/// Declarations from <sys/cdefs.h>
//
%include <sys/cdefs.h>



/// 'time_t'
//

// 'time_t' is platform dependent: choose the correct setting below.
//
// (tbd: Find a way to make this portable.)

//#define USE_32bit_time_t
#define USE_64bit_time_t



/// Declarations from <limits.h>
//
%include <limits.h>



/// Declarations from <locale.h>
//
%include <locale.h>

%inline
%{
int   lc_CTYPE ()           { return LC_CTYPE;          };
int   lc_NUMERIC ()         { return LC_NUMERIC;        };
int   lc_TIME ()            { return LC_TIME;           };
int   lc_COLLATE ()         { return LC_COLLATE;        };
int   lc_MONETARY ()        { return LC_MONETARY;       };
int   lc_MESSAGES ()        { return LC_MESSAGES;       };
int   lc_ALL ()             { return LC_ALL;            };
int   lc_PAPER ()           { return LC_PAPER;          };
int   lc_NAME ()            { return LC_NAME;           };
int   lc_ADDRESS ()         { return LC_ADDRESS;        };
int   lc_TELEPHONE ()       { return LC_TELEPHONE;      };
int   lc_MEASUREMENT ()     { return LC_MEASUREMENT;    };
int   lc_IDENTIFICATION ()  { return LC_IDENTIFICATION; };
%}



/// Declarations from <math.h>
//
%ignore __huge_val_t;
%include <math.h>



/// Type declarations from <time.h>
//
%inline
%{
  #if defined (USE_32bit_time_t)
    typedef int  time_t;
  #endif

  #if defined (USE_64bit_time_t)
    typedef long time_t;
  #endif
%}


struct timeval 
{
  long int tv_sec;
  long int tv_usec;
};



/// Declarations from <signal.h>   (currently unused)
//

// %ignore _sys_siglist;
// %ignore sys_siglist;
// %include <signal.h>



/// Declarations from <stddef.h>
//
%include <stddef.h>



/// Declarations from <stdio.h>
//
typedef void   FILE;

