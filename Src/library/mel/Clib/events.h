/*
 *
 * These are macros for retrieving values of the event structures.
 *
 */ 

#include "mel.h"

	/* XmAnyEvent */

#define c_event_type(_ptr_) (_ptr_)->type
#define c_event_serial(_ptr_) (_ptr_)->serial
#define c_event_send_event(_ptr_) (_ptr_)->send_event
#define c_event_display(_ptr_) (_ptr_)->display

	/* XmAnyEvent */
	/* XmButtonEvent */
	/* XKeyEvent */
	/* XConfigureEvent */
	/* XConfigureRequestEvent */
	/* XCreateWindowEvent */
	/* XCrossingEvent */
	/* XExposeEvent */
	/* XCirculateEvent */
	/* XCirculateRequestEvent */
	/* XDestroyWindowEvent */
	/* XClientMessageEvent */
	/* XColormapEvent */
	/* XFocusChangeEvent */
	/* XGravityEvent */
	/* XKeymapEvent */
	/* XMapEvent */
	/* XUnmapEvent */
	/* XMappingEvent */
	/* XMapRequestEvent */
	/* XMotionEvent */
	/* XPropertyEvent */
	/* XReparentEvent */
	/* XResizeRequestEvent */
	/* XSelectionClearEvent */
	/* XVisibilityEvent */

#define c_event_window(_ptr_) (_ptr_)->window

	/* XmButtonEvent */
	/* XKeyEvent */
	/* XColormapEvent */
	/* XCrossingEvent */
	/* XMotionEvent */
	/* XPropertyEvent */
	/* XVisibilityEvent */

#define c_event_state(_ptr_) (_ptr_)->state

	/* XmButtonEvent */
	/* XKeyEvent */
	/* XConfigureEvent */
	/* XConfigureRequestEvent */
	/* XCreateWindowEvent */
	/* XCrossingEvent */
	/* XExposeEvent */
	/* XGraphicsExposeEvent */
	/* XGravityEvent */
	/* XMotionEvent */
	/* XReparentEvent */

#define c_event_x(_ptr_) (_ptr_)->x
#define c_event_y(_ptr_) (_ptr_)->y

	/* XmButtonEvent */
	/* XKeyEvent */
	/* XCrossingEvent */
	/* XMotionEvent */

#define c_event_root(_ptr_) (_ptr_)->root
#define c_event_subwindow(_ptr_) (_ptr_)->subwindow
#define c_event_x_root(_ptr_) (_ptr_)->x_root
#define c_event_y_root(_ptr_) (_ptr_)->y_root
#define c_event_same_screen(_ptr_) (_ptr_)->same_screen

	/* XmButtonEvent */
	/* XKeyEvent */
	/* XCrossingEvent */
	/* XMotionEvent */
	/* XPropertyEvent */
	/* XSelectionClearEvent */
	/* XSelectionEvent */
	/* XSelectionRequestEvent */

#define c_event_time(_ptr_) (_ptr_)->time

	/* XmButtonEvent */

#define c_event_button(_ptr_) (_ptr_)->button

	/* XKeyEvent */

#define c_event_keycode(_ptr_) (_ptr_)->keycode

	/* XCirculateEvent */
	/* XCirculateRequestEvent */
	/* XCreateWindowEvent */

#define c_event_place(_ptr_) (_ptr_)->place

	/* XCirculateEvent */
	/* XConfigureEvent */
	/* XDestroyWindowEvent */
	/* XGravityEvent */
	/* XMapEvent */
	/* XUnmapEvent */
	/* XReparentEvent */

#define c_event_event(_ptr_) (_ptr_)->event

	/* XCirculateRequestEvent */
	/* XConfigureRequestEvent */
	/* XCreateWindowEvent */
	/* XMapRequestEvent */
	/* XReparentEvent */

#define c_event_parent(_ptr_) (_ptr_)->parent

	/* XClientMessageEvent */

#define c_event_message_type(_ptr_) (_ptr_)->message_type
#define c_event_format(_ptr_) (_ptr_)->format
#define c_event_data(_ptr_) (_ptr_)->data.b

	/* XColormapEvent */

#define c_event_colormap(_ptr_) (_ptr_)->colormap
#if defined(__cplusplus) || defined(c_plusplus)
#define c_event_new(_ptr_) (_ptr_)->c_new
#else
#define c_event_new(_ptr_) (_ptr_)->new
#endif

	/* XConfigureEvent */
	/* XConfigureRequestEvent */
	/* XCreateWindowEvent */
	/* XExposeEvent */
	/* XGraphicsExposeEvent */
	/* XResizeRequestEvent */

#define c_event_width(_ptr_) (_ptr_)->width
#define c_event_height(_ptr_) (_ptr_)->height

	/* XConfigureEvent */
	/* XConfigureRequestEvent */
	/* XCreateWindowEvent */

#define c_event_border_width(_ptr_) (_ptr_)->border_width

	/* XConfigureEvent */
	/* XConfigureRequestEvent */

#define c_event_above(_ptr_) (_ptr_)->above

	/* XConfigureEvent */
	/* XCreateWindowEvent */
	/* XMapEvent */
	/* XReparentEvent */

#define c_event_override_redirect(_ptr_) (_ptr_)->override_redirect

	/* XConfigureRequestEvent */
	/* XCrossingEvent */
	/* XFocusChangeEvent */

#define c_event_detail(_ptr_) (_ptr_)->detail

	/* XConfigureRequestEvent */

#define c_event_value_mask(_ptr_) (_ptr_)->value_mask

	/* XCrossingEvent */
	/* XFocusChangeEvent */

#define c_event_mode(_ptr_) (_ptr_)->mode

	/* XCrossingEvent */

#define c_event_focus(_ptr_) (_ptr_)->focus

	/* XExposeEvent */
	/* XMappingEvent */

#define c_event_count(_ptr_) (_ptr_)->count

	/* XGraphicsExposeEvent */
	/* XNoExposeEvent */

#define c_event_drawable(_ptr_) (_ptr_)->drawable
#define c_event_major_code(_ptr_) (_ptr_)->major_code
#define c_event_minor_code(_ptr_) (_ptr_)->minor_code

	/* XKeymapEvent */

#define c_event_key_vector(_ptr_) (_ptr_)->key_vector

	/* XUnmapEvent */

#define c_event_from_configure(_ptr_) (_ptr_)->from_configure

	/* XMappingEvent */

#define c_event_request(_ptr_) (_ptr_)->request
#define c_event_first_keycode(_ptr_) (_ptr_)->first_keycode

	/* XMotionEvent */

#define c_event_is_hint(_ptr_) (_ptr_)->is_hint

	/* XPropertyEvent */

#define c_event_atom(_ptr_) (_ptr_)->atom

	/* XSelectionClearEvent */
	/* XSelectionEvent */
	/* XSelectionRequestEvent */

#define c_event_selection(_ptr_) (_ptr_)->selection

	/* XSelectionEvent */
	/* XSelectionRequestEvent */

#define c_event_requestor(_ptr_) (_ptr_)->requestor
#define c_event_target(_ptr_) (_ptr_)->target
#define c_event_property(_ptr_) (_ptr_)->property

	/* XSelectionRequestEvent */

#define c_event_owner(_ptr_) (_ptr_)->owner
