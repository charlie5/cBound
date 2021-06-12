-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with swig;
with xcb.xcb_render_directformat_t;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_render_pictforminfo_t is

   -- Item
   --

   type Item is record
      id       : aliased xcb.xcb_render_pictformat_t;
      the_type : aliased Interfaces.Unsigned_8;
      depth    : aliased Interfaces.Unsigned_8;
      pad0     : aliased swig.int8_t_Array (0 .. 1);
      direct   : aliased xcb.xcb_render_directformat_t.Item;
      colormap : aliased xcb.xcb_colormap_t;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_render_pictforminfo_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_render_pictforminfo_t.Item,
      Element_Array      => xcb.xcb_render_pictforminfo_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_render_pictforminfo_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_render_pictforminfo_t.Pointer,
      Element_Array      => xcb.xcb_render_pictforminfo_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_render_pictforminfo_t;