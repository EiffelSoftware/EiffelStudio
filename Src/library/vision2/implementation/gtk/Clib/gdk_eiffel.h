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
#define c_gdk_event_state(p) (((GdkEventButton*)p)->state) /* integer */

				/* Button */
#define c_gdk_event_button(p) (((GdkEventButton*)p)->button)/* integer */

				/* Key */
#define c_gdk_event_keyval(p) (((GdkEventKey*)p)->keyval)/* integer */
