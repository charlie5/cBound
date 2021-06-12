-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with swig;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_grab_keyboard_request_t is

   -- Item
   --

   type Item is record
      major_opcode  : aliased Interfaces.Unsigned_8;
      owner_events  : aliased Interfaces.Unsigned_8;
      length        : aliased Interfaces.Unsigned_16;
      grab_window   : aliased xcb.xcb_window_t;
      time          : aliased xcb.xcb_timestamp_t;
      pointer_mode  : aliased Interfaces.Unsigned_8;
      keyboard_mode : aliased Interfaces.Unsigned_8;
      pad0          : aliased swig.int8_t_Array (0 .. 1);
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_grab_keyboard_request_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_grab_keyboard_request_t.Item,
      Element_Array      => xcb.xcb_grab_keyboard_request_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_grab_keyboard_request_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_grab_keyboard_request_t.Pointer,
      Element_Array      => xcb.xcb_grab_keyboard_request_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_grab_keyboard_request_t;
