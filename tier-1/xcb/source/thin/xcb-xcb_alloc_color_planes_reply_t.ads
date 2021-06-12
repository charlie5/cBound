-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with swig;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_alloc_color_planes_reply_t is

   -- Item
   --

   type Item is record
      response_type : aliased Interfaces.Unsigned_8;
      pad0          : aliased Interfaces.Unsigned_8;
      sequence      : aliased Interfaces.Unsigned_16;
      length        : aliased Interfaces.Unsigned_32;
      pixels_len    : aliased Interfaces.Unsigned_16;
      pad1          : aliased swig.int8_t_Array (0 .. 1);
      red_mask      : aliased Interfaces.Unsigned_32;
      green_mask    : aliased Interfaces.Unsigned_32;
      blue_mask     : aliased Interfaces.Unsigned_32;
      pad2          : aliased swig.int8_t_Array (0 .. 7);
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_alloc_color_planes_reply_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_alloc_color_planes_reply_t.Item,
      Element_Array      => xcb.xcb_alloc_color_planes_reply_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_alloc_color_planes_reply_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_alloc_color_planes_reply_t.Pointer,
      Element_Array      => xcb.xcb_alloc_color_planes_reply_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_alloc_color_planes_reply_t;
