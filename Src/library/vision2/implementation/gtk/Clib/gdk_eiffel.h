/*==============================================================================
 EiffelVision/GDK External C library
 gdk_eiffel.h
--------------------------------------------------------------------------------
 description: "Functions for using gdk from Eiffel"
 date:        "$Date$"
 revision:    "$Revision$"
 status:      "See notice at end of file"
==============================================================================*/
#ifndef _GDK_EIFFEL_H_INCLUDED_
#define _GDK_EIFFEL_H_INCLUDED_

/*==============================================================================
 Included files
==============================================================================*/
#include <gdk/gdktypes.h>	/* Events are declared here */

/*==============================================================================
 Event handling
==============================================================================*/

/*------------------------------------------------------------------------------
 Any
------------------------------------------------------------------------------*/

#define c_gdk_event_type(p) (((GdkEvent*)p)->type)

/*------------------------------------------------------------------------------
 Motion, button
------------------------------------------------------------------------------*/

#define c_gdk_event_x(p) (((GdkEventButton*)p)->x)/* double */
#define c_gdk_event_y(p) (((GdkEventButton*)p)->y) /* double */
#define c_gdk_event_state(p) (((GdkEventKey*)p)->state) /* integer */
#define c_gdk_event_button(p) (((GdkEventButton*)p)->button)/* integer */

/*------------------------------------------------------------------------------
 Key
------------------------------------------------------------------------------*/

#define c_gdk_event_keyval(p) (((GdkEventKey*)p)->keyval)/* integer */
#define c_gdk_event_length(p) (((GdkEventKey*)p)->length)/* integer */
#define c_gdk_event_string(p) (((GdkEventKey*)p)->string)/* char* */

/*------------------------------------------------------------------------------
 Expose
------------------------------------------------------------------------------*/

#define c_gdk_event_rectangle_x(p) (((GdkEventExpose*)p)->area.x)/* integer */
#define c_gdk_event_rectangle_y(p) (((GdkEventExpose*)p)->area.y)/* integer */
#define c_gdk_event_rectangle_width(p) (((GdkEventExpose*)p)->area.width)/* integer */
#define c_gdk_event_rectangle_height(p) (((GdkEventExpose*)p)->area.height)/* integer */

/*------------------------------------------------------------------------------
 Configure
------------------------------------------------------------------------------*/

#define c_gdk_event_configure_x(p) (((GdkEventConfigure*)p)->x)/* integer */
#define c_gdk_event_configure_y(p) (((GdkEventConfigure*)p)->y)/* integer */
#define c_gdk_event_configure_width(p) (((GdkEventConfigure*)p)->width)/* integer */
#define c_gdk_event_configure_height(p) (((GdkEventConfigure*)p)->height)/* integer */

/*==============================================================================
 Font
--------------------------------------------------------------------------------
 GdkFont attributes
==============================================================================*/
#define c_gdk_font_ascent(p) (((GdkFont*)p)->ascent) /*gint*/
#define c_gdk_font_descent(p) (((GdkFont*)p)->descent) /*gint*/

/*==============================================================================
 End of file
==============================================================================*/

#endif /* _GDK_EIFFEL_H_INCLUDED_ */

/*|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|--------------------------------------------------------------*/

