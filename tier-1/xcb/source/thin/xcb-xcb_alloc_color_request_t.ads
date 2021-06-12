-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with swig;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_alloc_color_request_t is

   -- Item
   --

   type Item is record
      major_opcode : aliased Interfaces.Unsigned_8;
      pad0         : aliased Interfaces.Unsigned_8;
      length       : aliased Interfaces.Unsigned_16;
      cmap         : aliased xcb.xcb_colormap_t;
      red          : aliased Interfaces.Unsigned_16;
      green        : aliased Interfaces.Unsigned_16;
      blue         : aliased Interfaces.Unsigned_16;
      pad1         : aliased swig.int8_t_Array (0 .. 1);
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_alloc_color_request_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_alloc_color_request_t.Item,
      Element_Array      => xcb.xcb_alloc_color_request_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_alloc_color_request_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_alloc_color_request_t.Pointer,
      Element_Array      => xcb.xcb_alloc_color_request_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_alloc_color_request_t;
