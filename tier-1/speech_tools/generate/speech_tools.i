//
//   SWIG interface defintion for the Edinburgh Speech Tools library binding.
//

%module speech_tools_c

%{
  #include <speech_tools/EST.h>
%}


/// Core Declarations
//

%ignore init_module_subr;
%ignore festival_def_utt_module;

class EST_Wave;
class EST_String;
class EST_Item_featfunc;
class EST_Item;
class EST_Val;
class EST_Ngrammar;
class EST_WFST;
class EST_Utterance;
class LISP;
class UnitDatabase;


/// Tailoring
//

%inline
%{
   /// EST_Wave
   //
   
   EST_Wave*
   new_EST_Wave ()
   {
      return new EST_Wave();
   }


   int
   EST_Wave_num_samples (EST_Wave*    Self)
   {
      return Self->num_samples();
   }
   
   
   int
   EST_Wave_num_channels (EST_Wave*    Self)
   {
      return Self->num_channels();
   }
   
   
   int
   EST_Wave_sample_rate (EST_Wave*    Self)
   {
      return Self->sample_rate();
   }
   

   int
   EST_Wave_length (EST_Wave*    Self)
   {
      return Self->length();
   }
   
   
   float
   EST_Wave_end (EST_Wave*    Self)
   {
      return Self->end();
   }
   

   short int*
   EST_Wave_Data (EST_Wave*    Self)
   {
      return Self->values().memory();
   }
   

   void
   EST_Wave_resample (EST_Wave*    Self,   int    new_Rate)
   {
      return Self->resample (new_Rate);
   }
   
   
   /// EST_String
   //

   EST_String*
   new_EST_String()
   {
      return new EST_String();
   }


   EST_String*
   new_EST_String (const char*   From)
   {
      return new EST_String (From);
   }

%}
