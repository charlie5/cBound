-- This file is generated by SWIG. Please do not modify by hand.
--
with xcb.xcb_glx_generic_error_t;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_glx_bad_pixmap_error_t is

   -- Item
   --
   subtype Item is xcb.xcb_glx_generic_error_t.Item;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_glx_bad_pixmap_error_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_glx_bad_pixmap_error_t.Item,
      Element_Array      => xcb.xcb_glx_bad_pixmap_error_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C.size_t range <>) of aliased xcb.xcb_glx_bad_pixmap_error_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_glx_bad_pixmap_error_t.Pointer,
      Element_Array      => xcb.xcb_glx_bad_pixmap_error_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_glx_bad_pixmap_error_t;
