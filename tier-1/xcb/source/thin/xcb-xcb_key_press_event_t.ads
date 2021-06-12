-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_key_press_event_t is

   -- Item
   --

   type Item is record
      response_type : aliased Interfaces.Unsigned_8;
      detail        : aliased xcb.xcb_keycode_t;
      sequence      : aliased Interfaces.Unsigned_16;
      time          : aliased xcb.xcb_timestamp_t;
      root          : aliased xcb.xcb_window_t;
      event         : aliased xcb.xcb_window_t;
      child         : aliased xcb.xcb_window_t;
      root_x        : aliased Interfaces.Integer_16;
      root_y        : aliased Interfaces.Integer_16;
      event_x       : aliased Interfaces.Integer_16;
      event_y       : aliased Interfaces.Integer_16;
      state         : aliased Interfaces.Unsigned_16;
      same_screen   : aliased Interfaces.Unsigned_8;
      pad0          : aliased Interfaces.Unsigned_8;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_key_press_event_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_key_press_event_t.Item,
      Element_Array      => xcb.xcb_key_press_event_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_key_press_event_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_key_press_event_t.Pointer,
      Element_Array      => xcb.xcb_key_press_event_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_key_press_event_t;
