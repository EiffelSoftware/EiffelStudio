/**********************************************

EiffelVision/GTK 

external C library
					       
  Date: 8/24/1998

  gdk event macros

**************************************** */

#include <gdk/gdktypes.h>	/* Events are declared here */

/* GDK events */

				/* Any */
#define c_gdk_event_type(p) (((GdkEvent*)p)->type)

				/* Motion, button */
#define c_gdk_event_x(p) (((GdkEventButton*)p)->x)/* double */
#define c_gdk_event_y(p) (((GdkEventButton*)p)->y) /* double */
#define c_gdk_event_state(p) (((GdkEventKey*)p)->state) /* integer */

				/* Button */
#define c_gdk_event_button(p) (((GdkEventButton*)p)->button)/* integer */

				/* Key */
#define c_gdk_event_keyval(p) (((GdkEventKey*)p)->keyval)/* integer */
#define c_gdk_event_length(p) (((GdkEventKey*)p)->length)/* integer */
#define c_gdk_event_string(p) (((GdkEventKey*)p)->string)/* char* */

				/* Expose */
#define c_gdk_event_rectangle_x(p) (((GdkEventExpose*)p)->area.x)/* integer */
#define c_gdk_event_rectangle_y(p) (((GdkEventExpose*)p)->area.y)/* integer */
#define c_gdk_event_rectangle_width(p) (((GdkEventExpose*)p)->area.width)/* integer */
#define c_gdk_event_rectangle_height(p) (((GdkEventExpose*)p)->area.height)/* integer */

				/* Configure */
#define c_gdk_event_configure_x(p) (((GdkEventConfigure*)p)->x)/* integer */
#define c_gdk_event_configure_y(p) (((GdkEventConfigure*)p)->y)/* integer */
#define c_gdk_event_configure_width(p) (((GdkEventConfigure*)p)->width)/* integer */
#define c_gdk_event_configure_height(p) (((GdkEventConfigure*)p)->height)/* integer */
