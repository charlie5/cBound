-- This file is generated by SWIG. Please do not modify by hand.
--
with Interfaces;
with xcb.xcb_render_pointfix_t;
with Interfaces.C;
with Interfaces.C.Pointers;

package xcb.xcb_render_create_radial_gradient_request_t is

   -- Item
   --

   type Item is record
      major_opcode : aliased Interfaces.Unsigned_8;
      minor_opcode : aliased Interfaces.Unsigned_8;
      length       : aliased Interfaces.Unsigned_16;
      picture      : aliased xcb.xcb_render_picture_t;
      inner        : aliased xcb.xcb_render_pointfix_t.Item;
      outer        : aliased xcb.xcb_render_pointfix_t.Item;
      inner_radius : aliased xcb.xcb_render_fixed_t;
      outer_radius : aliased xcb.xcb_render_fixed_t;
      num_stops    : aliased Interfaces.Unsigned_32;
   end record;

   -- Item_Array
   --
   type Item_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb
       .xcb_render_create_radial_gradient_request_t
       .Item;

   -- Pointer
   --
   package C_Pointers is new Interfaces.C.Pointers
     (Index         => Interfaces.C.size_t,
      Element       => xcb.xcb_render_create_radial_gradient_request_t.Item,
      Element_Array =>
        xcb.xcb_render_create_radial_gradient_request_t.Item_Array,
      Default_Terminator => (others => <>));

   subtype Pointer is C_Pointers.Pointer;

   -- Pointer_Array
   --
   type Pointer_Array is
     array
       (Interfaces.C
          .size_t range <>) of aliased xcb
       .xcb_render_create_radial_gradient_request_t
       .Pointer;

   -- Pointer_Pointer
   --
   package C_Pointer_Pointers is new Interfaces.C.Pointers
     (Index         => Interfaces.C.size_t,
      Element       => xcb.xcb_render_create_radial_gradient_request_t.Pointer,
      Element_Array =>
        xcb.xcb_render_create_radial_gradient_request_t.Pointer_Array,
      Default_Terminator => null);

   subtype Pointer_Pointer is C_Pointer_Pointers.Pointer;

end xcb.xcb_render_create_radial_gradient_request_t;
