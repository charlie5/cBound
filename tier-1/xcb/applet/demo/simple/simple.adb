
with xcb.Binding;                use xcb.Binding;
with xcb.Pointers;               use xcb.Pointers;

with xcb.xcb_Screen_t;
with xcb.xcb_screen_Iterator_t;
with xcb.xcb_void_cookie_t;
with xcb.xcb_generic_event_t;

with Swig;                       use Swig;
with Swig.Pointers;

with interfaces.C.Strings;       use Interfaces, interfaces.C, interfaces.C.Strings;
with ada.Text_IO;                use ada.Text_IO;
with ada.unchecked_Deallocation;
with Ada.unchecked_Conversion;


procedure Simple
is
   the_Connection : xcb_connection_t_Pointer;

   the_Screen     : xcb.xcb_screen_t.Pointer;
   the_screen_Id  : swig.Pointers.int_Pointer := new c.int;

   the_Window     : xcb.xcb_window_t;
   void_Cookie    : xcb.xcb_void_cookie_t.item;
   Status         : C.int;

   Mask           : swig.uint32_t;
   Values         : swig.uint32_t_array (1 .. 2);

   E              : xcb.xcb_generic_event_t.Pointer;

   use type xcb.xcb_generic_event_t.Pointer;

   procedure free    is new ada.Unchecked_Deallocation (xcb.xcb_generic_event_t.item,  xcb.xcb_generic_event_t.Pointer);
   function  to_Flag is new ada.Unchecked_Conversion   (xcb.xcb_event_mask_t,          swig.uint32_t);
   function  to_Flag is new ada.Unchecked_Conversion   (xcb.xcb_cw_t,                  swig.uint32_t);

begin
   -- Open the connection to the X server.
   --
   the_Connection := xcb_connect (c.strings.null_Ptr,                -- Use the DISPLAY environment variable as the default display name.
                                  the_screen_Id);

   -- Get the screen id.
   --
   the_Screen := xcb_setup_roots_iterator (xcb_get_setup (the_Connection)).data.all'access;


   -- Display some screen details.
   --
   new_Line;
   put_Line ("Informations of screen:" & Unsigned_32'image (the_Screen.root));
   new_Line;
   put_Line ("   width      :" & Unsigned_16'image (the_Screen.width_in_pixels ));
   put_Line ("   height     :" & Unsigned_16'image (the_Screen.height_in_pixels));
   put_Line ("   white pixel:" & Unsigned_32'image (the_Screen.white_pixel     ));
   put_Line ("   black pixel:" & Unsigned_32'image (the_Screen.black_pixel     ));
   new_Line;

   -- Create the window.
   --

   -- Ask for our window's Id.
   --
   the_Window  := xcb_generate_id (the_Connection);

   Mask        := to_Flag (xcb.XCB_CW_BACK_PIXEL) or to_Flag (xcb.XCB_CW_EVENT_MASK);
   put_Line ("FLAG: " & swig.uint32_t'Image (Mask));

   Values      := (1 => the_Screen.white_pixel,  2 => to_Flag (xcb.XCB_EVENT_MASK_EXPOSURE));

   void_Cookie := xcb_create_window (the_Connection,
                                     Unsigned_8 (xcb.XCB_COPY_FROM_PARENT),
                                     the_Window,
                                     the_screen.Root,
                                     0,     0,
                                     150, 150,
                                     10,
                                     xcb.xcb_window_class_t'Pos (xcb.XCB_WINDOW_CLASS_INPUT_OUTPUT),
                                     the_Screen.root_Visual,
                                     Mask,
                                     Values (1)'Address);

   -- Map the window on the screen.
   --
   void_Cookie := xcb_map_window (the_Connection, the_Window);


   -- Make sure commands are sent before we pause, so window is shown.
   --
   Status := xcb_flush (the_Connection);

   loop
      put_Line ("fetch event:");
      E := xcb_wait_for_event (the_Connection);

      exit when E = null;

      put_Line ("Got event:" & integer'image (Integer (E.response_type)));
      free (E);
    end loop;


   -- Close the X server connection.
   --
   xcb_disconnect (the_Connection);

   new_Line;
   put_Line ("End.");
end Simple;
