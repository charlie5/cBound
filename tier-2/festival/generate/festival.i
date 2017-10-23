//
// SWIG interface defintion for the Festival speech synthesis library binding.
//

%module festival

%{
    #include <festival/festival.h>
%}



%ignore utt_iform_string;
%ignore utt_type;


/// Core Declarations
//

struct FILE;
class ostream;

%import "../../../tier-1/speech_tools/generate/speech_tools.i"

%ignore stddebug;
%ignore cdebug;
%ignore festival_libdir;
%ignore get_c_unitdatabase;

%include "./festival-tailored.h"


/// Tailoring
//

%inline
%{

   void
   set_festival_libdir (const char*   To)
   {
      festival_libdir = To;
   }

%}
