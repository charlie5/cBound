-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_create_cursor_request_t is

   -- Item
   --

   type Item is record
      major_opcode : aliased Interfaces.Unsigned_8;
      pad0         : aliased Interfaces.Unsigned_8;
      length       : aliased Interfaces.Unsigned_16;
      cid          : aliased xcb.xcb_cursor_t;
      source       : aliased xcb.xcb_pixmap_t;
      mask         : aliased xcb.xcb_pixmap_t;
      fore_red     : aliased Interfaces.Unsigned_16;
      fore_green   : aliased Interfaces.Unsigned_16;
      fore_blue    : aliased Interfaces.Unsigned_16;
      back_red     : aliased Interfaces.Unsigned_16;
      back_green   : aliased Interfaces.Unsigned_16;
      back_blue    : aliased Interfaces.Unsigned_16;
      x            : aliased Interfaces.Unsigned_16;
      y            : aliased Interfaces.Unsigned_16;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_create_cursor_request_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_create_cursor_request_t.Item,
      Element_Array      => xcb.xcb_create_cursor_request_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_create_cursor_request_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_create_cursor_request_t.Pointer,
      Element_Array      => xcb.xcb_create_cursor_request_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_create_cursor_request_t;
