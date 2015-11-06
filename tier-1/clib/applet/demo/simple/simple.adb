with cLib.Binding;
with cLib.lconv;

with interfaces.C.Strings;

with ada.Strings.unbounded;
with ada.Text_IO;


procedure Simple
is
   use ada.text_IO, ada.Strings.Unbounded, Interfaces.C.Strings;

   the_set_Locale : Interfaces.C.Strings.chars_ptr := clib.Binding.setlocale (cLib.binding.LC_ALL, 
                                                                              new_String (""));
   the_Locale     : clib.lconv.Pointer             := clib.Binding.localeconv.all'access;

   function grouping_Image return String
   is
      the_Grouping : String          := Value (the_Locale.grouping);
      the_Image    : unbounded_String;
   begin
      for Each in the_Grouping'range loop
         append (the_Image,  Integer'Image (Character'Pos (the_Grouping (Each))));
      end loop;

      return to_String (the_Image);
   end grouping_Image;

begin
   put_Line ("Locale is: '" & Value (the_set_Locale) & "'");
   put_Line ("   decimal_point:   " & Value (the_Locale.decimal_Point  ));
   put_Line ("   thousands_sep:   " & Value (the_Locale.thousands_sep  ));
   put_Line ("   grouping:        " & grouping_Image                    );
   put_Line ("   int_curr_symbol: " & Value (the_Locale.int_curr_symbol));
end Simple;
