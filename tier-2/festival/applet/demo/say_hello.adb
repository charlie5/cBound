with
     speech_tools_c.Binding,
     festival.Binding,
     Interfaces.C.Strings,
     speech_tools_c.Pointers,
     Swig.Pointers;

with Ada.Text_IO; use Ada.Text_IO;


procedure say_Hello
is
   use Festival,
       Festival.Binding,
       speech_tools_c.Binding,
       speech_tools_c.Pointers,
       Interfaces,
       Interfaces.C,
       Interfaces.C.Strings;

   Status : interfaces.c.int;
begin
   set_festival_libdir (to => new_String ("/usr/share/festival"));

   festival_initialize (1, 1024 * 1024);

   Status := festival_say_file (EST_String_Pointer (new_EST_String (new_String ("./hello.txt"))));
   Status := festival_say_file (EST_String_Pointer (new_EST_String (new_String ("./hello.txt"))));

   Status := festival_say_text (EST_String_Pointer (new_EST_String (new_String ("Goodbye from Ada."))));

   declare
      use speech_tools_c.Pointers;

      the_Wave : EST_Wave_Pointer           := EST_Wave_Pointer (new_EST_Wave);
      the_Data : swig.Pointers.short_Pointer;
   begin
      Status := festival_text_to_wave (EST_String_Pointer (new_EST_String (new_String ("Goodbye from Ada."))),
                                       the_Wave);

      the_Data := EST_Wave_Data (the_Wave).all'access;

      put_Line ("Sample count:  " & c.int'Image     (EST_Wave_num_Samples  (the_Wave)));
      put_Line ("Channel count: " & c.int'Image     (EST_Wave_num_Channels (the_Wave)));
      put_Line ("Sample Rate:   " & c.int'Image     (EST_Wave_sample_Rate  (the_Wave)));
      put_Line ("Length:        " & c.int'Image     (EST_Wave_Length       (the_Wave)));
      put_Line ("End:           " & c.c_float'Image (EST_Wave_End          (the_Wave)));
   end;

--     festival_wait_for_spooler;
   delay 5.0;

end say_Hello;
