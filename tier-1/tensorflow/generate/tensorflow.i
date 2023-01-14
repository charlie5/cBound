//--------------------------------------------------------------
// SWIG interface definition for the TensorFlow library binding.
//

%module TensorFlow_C

%{
#include <tensorflow/c/c_api.h>
%}

struct TF_Buffer;

%ignore TF_NewWhile;

typedef bool      TF_Bool;
%rename TF_BOOL   TF_BOOLEAN;

%include <tensorflow/tensorflow/c/tf_attrtype.h>
%include <tensorflow/tensorflow/c/tf_datatype.h>
%include <tensorflow/tensorflow/c/tf_status.h>

%ignore TF_NewTensor;
%include <tensorflow/tensorflow/c/tf_tensor.h>

struct  TF_TString;
struct  TF_TString_Type;
%include <tensorflow/tensorflow/c/tf_tstring.h>

typedef TF_Operation***  TF_Operation_ptr_ptr_ptr;
%ignore TF_RegisterLogListener;
%include <tensorflow/tensorflow/c/c_api.h>



//------------------
// Custom functions.
//
%inline
%{

   typedef void (*Deallocator_T) (void* data, size_t len, void* arg);

   TF_CAPI_EXPORT extern TF_Tensor* 
   TF_CreateNewTensor (TF_DataType      data_type, 
                       const int64_t*   dims,
                       int              num_dims, 
                       void*            data,
                       size_t           len,
                       Deallocator_T    deallocator,
                       void*            deallocator_arg)
   {
      return TF_NewTensor (data_type, dims, num_dims, data, len, deallocator, deallocator_arg);
   }

%}