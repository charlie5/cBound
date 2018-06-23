//
//   SWIG interface defintion for FANN ('Fast Artificial Neural Net') library binding.
//

%module fann_c

%{
#include <floatfann.h>
#include <parallel_fann.h>
#include <fann.h>
%}



#define FANN_EXTERNAL
#define FANN_API

struct FILE;


// core declarations
//

%ignore FANNPRINTF;
%ignore FANNSCANF;
%include <floatfann.h>

%ignore fann_default_error_log;
%include <fann_error.h>

%include <fann_activation.h>

%ignore FANN_TRAIN_NAMES;
%ignore FANN_ACTIVATIONFUNC_NAMES;
%ignore FANN_ERRORFUNC_NAMES;
%ignore FANN_STOPFUNC_NAMES;
%ignore FANN_NETTYPE_NAMES;
%include <fann_data.h>


%ignore fann_create_train_from_callback;

%inline
%{
  typedef void (*user_function)(unsigned int,
                                unsigned int,
                                unsigned int,
                                fann_type * ,
                                fann_type * );


  struct fann_train_data * 
  create_train_from_callback (unsigned int    num_data,
                              unsigned int    num_input,
                              unsigned int    num_output,
                              user_function   the_user_function)
  {
    return fann_create_train_from_callback (num_data, num_input, num_output,  the_user_function);
  }
%}


%include <fann_train.h>
#%include <parallel_fann.h>

%include <fann_cascade.h>
%include <fann_io.h>
%include <fann.h>


