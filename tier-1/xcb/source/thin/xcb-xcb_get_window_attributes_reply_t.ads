-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with swig;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_get_window_attributes_reply_t is

   -- Item
   --

   type Item is record
      response_type         : aliased Interfaces.Unsigned_8;
      backing_store         : aliased Interfaces.Unsigned_8;
      sequence              : aliased Interfaces.Unsigned_16;
      length                : aliased Interfaces.Unsigned_32;
      visual                : aliased xcb.xcb_visualid_t;
      a_class               : aliased Interfaces.Unsigned_16;
      bit_gravity           : aliased Interfaces.Unsigned_8;
      win_gravity           : aliased Interfaces.Unsigned_8;
      backing_planes        : aliased Interfaces.Unsigned_32;
      backing_pixel         : aliased Interfaces.Unsigned_32;
      save_under            : aliased Interfaces.Unsigned_8;
      map_is_installed      : aliased Interfaces.Unsigned_8;
      map_state             : aliased Interfaces.Unsigned_8;
      override_redirect     : aliased Interfaces.Unsigned_8;
      colormap              : aliased xcb.xcb_colormap_t;
      all_event_masks       : aliased Interfaces.Unsigned_32;
      your_event_mask       : aliased Interfaces.Unsigned_32;
      do_not_propagate_mask : aliased Interfaces.Unsigned_16;
      pad0                  : aliased swig.int8_t_Array (0 .. 1);
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_get_window_attributes_reply_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_get_window_attributes_reply_t.Item,
      Element_Array      => xcb.xcb_get_window_attributes_reply_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb.xcb_get_window_attributes_reply_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index              => Interfaces.C.size_t,
      Element            => xcb.xcb_get_window_attributes_reply_t.Pointer,
      Element_Array => xcb.xcb_get_window_attributes_reply_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_get_window_attributes_reply_t;