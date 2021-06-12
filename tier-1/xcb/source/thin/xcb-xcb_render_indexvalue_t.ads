-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_render_indexvalue_t is

   -- Item
   --

   type Item is record
      pixel : aliased Interfaces.Unsigned_32;
      red   : aliased Interfaces.Unsigned_16;
      green : aliased Interfaces.Unsigned_16;
      blue  : aliased Interfaces.Unsigned_16;
      alpha : aliased Interfaces.Unsigned_16;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_render_indexvalue_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_render_indexvalue_t.Item,
      Element_Array      => xcb.xcb_render_indexvalue_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_render_indexvalue_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_render_indexvalue_t.Pointer,
      Element_Array      => xcb.xcb_render_indexvalue_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_render_indexvalue_t;
