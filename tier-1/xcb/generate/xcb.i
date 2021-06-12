//
//   SWIG interface defintion for XCB (X11 C Binding) library
//

%module xcb

%{
#include <xcb/xcb.h>
#include <xcb/xproto.h>
#include <xcb/bigreq.h>
#include <xcb/render.h>
#include <xcb/xcbext.h>
#include <xcb/xcb_renderutil.h>
#include <xcb/xc_misc.h>
#include <xcb/glx.h>

#include <X11/Xlib.h>
#include <X11/Xlib-xcb.h>
%}



// XCB

struct xcb_query_extension_reply_t;
struct xcb_setup_t;

%include <xcb/xcb.h>
%include <xcb/xproto.h>
%include <xcb/bigreq.h>
%include <xcb/render.h>

struct iovec;
%ignore xcb_take_socket;
%include <xcb/xcbext.h>

%include <xcb/xcb_renderutil.h>
%include <xcb/xc_misc.h>

%include <xcb/glx.h>



// X11 Support

struct Display;

enum XEventQueueOwner { XlibOwnsEventQueue = 0, XCBOwnsEventQueue };


%inline
%{
  Display*   
  x11_XOpenDisplay (char*   display_name)
  {
    return XOpenDisplay (display_name);
  }


  int
  x11_DefaultScreen (Display*   display)
  {
    return XDefaultScreen (display);
  }


  xcb_connection_t*
  x11_XGetXCBConnection (Display *dpy)
  {
    return XGetXCBConnection (dpy);
  }


  void
  x11_XSetEventQueueOwner (Display*                dpy, 
                           enum XEventQueueOwner   owner)
  {
    XSetEventQueueOwner (dpy, owner);
  }
%}
