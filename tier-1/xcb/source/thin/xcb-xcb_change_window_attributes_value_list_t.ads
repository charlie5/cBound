-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_change_window_attributes_value_list_t is

   -- Item
   --

   type Item is record
      background_pixmap     : aliased xcb.xcb_pixmap_t;
      background_pixel      : aliased Interfaces.Unsigned_32;
      border_pixmap         : aliased xcb.xcb_pixmap_t;
      border_pixel          : aliased Interfaces.Unsigned_32;
      bit_gravity           : aliased Interfaces.Unsigned_32;
      win_gravity           : aliased Interfaces.Unsigned_32;
      backing_store         : aliased Interfaces.Unsigned_32;
      backing_planes        : aliased Interfaces.Unsigned_32;
      backing_pixel         : aliased Interfaces.Unsigned_32;
      override_redirect     : aliased xcb.xcb_bool32_t;
      save_under            : aliased xcb.xcb_bool32_t;
      event_mask            : aliased Interfaces.Unsigned_32;
      do_not_propogate_mask : aliased Interfaces.Unsigned_32;
      colormap              : aliased xcb.xcb_colormap_t;
      cursor                : aliased xcb.xcb_cursor_t;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb
       .xcb_change_window_attributes_value_list_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index         => Interfaces.C.size_t,
      Element       => xcb.xcb_change_window_attributes_value_list_t.Item,
      Element_Array =>
        xcb.xcb_change_window_attributes_value_list_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb
       .xcb_change_window_attributes_value_list_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index         => Interfaces.C.size_t,
      Element       => xcb.xcb_change_window_attributes_value_list_t.Pointer,
      Element_Array =>
        xcb.xcb_change_window_attributes_value_list_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_change_window_attributes_value_list_t;