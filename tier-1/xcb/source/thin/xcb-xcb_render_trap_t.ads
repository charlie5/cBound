-- This file is generated by SWIG. Please do not modify by hand.
--
with xcb.xcb_render_spanfix_t;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_render_trap_t is

   -- Item
   --

   type Item is record
      top : aliased xcb.xcb_render_spanfix_t.Item;
      bot : aliased xcb.xcb_render_spanfix_t.Item;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_render_trap_t.Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_render_trap_t.Item,
      Element_Array      => xcb.xcb_render_trap_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_render_trap_t.Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_render_trap_t.Pointer,
      Element_Array      => xcb.xcb_render_trap_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_render_trap_t;