#include "mel.h"

XEvent global_xevent; /* Global variable for Event processing */

/*
 *
 * C functions to retrieve informations on widgets according 
 * to the type of the information wished. Functions for setting
 * the same informations are also available.
 *
 */

EIF_REFERENCE c_get_argv (EIF_POINTER w)
{
	String *temp;

	XtVaGetValues ((Widget) w, XtNargv, &temp, NULL);

	if (temp != NULL)
		return (EIF_REFERENCE) RTMS (*temp);
	else
		return NULL;
}

EIF_INTEGER c_get_int (EIF_POINTER w, char *res)
{
	int temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_int (EIF_POINTER w, char *res, EIF_INTEGER an_int)
{
	XtVaSetValues ((Widget) w, (String) res, (int) an_int, NULL);
}

EIF_INTEGER c_get_cardinal (EIF_POINTER w, char *res)
{
	Cardinal temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_cardinal (EIF_POINTER w, char *res, EIF_INTEGER a_card)
{
	XtVaSetValues ((Widget) w, (String) res, (Cardinal) a_card, NULL);
}

EIF_BOOLEAN c_get_boolean (EIF_POINTER w, char *res)
{
	Boolean temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_BOOLEAN) (temp != 0);
}

void c_set_boolean (EIF_POINTER w, char *res, EIF_BOOLEAN a_boolean)
{
	XtVaSetValues ((Widget) w, (String) res, (Boolean) (a_boolean != 0), NULL);
}

EIF_INTEGER c_get_unsigned_char (EIF_POINTER w, char *res)
{
	unsigned char temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_unsigned_char (EIF_POINTER w, char *res, EIF_INTEGER an_unsigned_char)
{
	XtVaSetValues ((Widget) w, (String) res, (unsigned char) an_unsigned_char, NULL);
}

EIF_POINTER c_get_pixmap (EIF_POINTER w, char *res)
{
	Pixmap temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_POINTER) temp;
}

void c_set_pixmap (EIF_POINTER w, char *res, EIF_POINTER a_pixmap)
{
	XtVaSetValues ((Widget) w, (String) res, (Pixmap) a_pixmap, NULL);
}

EIF_CHARACTER c_get_keysym (EIF_POINTER w, char *res)
{
	KeySym temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	if (temp<0 || temp>255)
		return (EIF_CHARACTER) 0;
	else
		return (EIF_CHARACTER) temp;
}

void c_set_keysym (EIF_POINTER w, char *res, EIF_CHARACTER a_widget)
{
	XtVaSetValues ((Widget) w, (String) res, (KeySym) a_widget, NULL);
}

EIF_POINTER c_get_widget (EIF_POINTER w, char *res)
{
	Widget temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_POINTER) temp;
}

void c_set_widget (EIF_POINTER w, char *res, EIF_POINTER a_widget)
{
	XtVaSetValues ((Widget) w, (String) res, (Widget) a_widget, NULL);
}

EIF_POINTER c_get_i_th_widget_child (EIF_POINTER w, EIF_INTEGER index)
{
	return (EIF_POINTER) ((WidgetList) w)[(int) index - 1];
}

EIF_POINTER c_get_children (EIF_POINTER w, char *res)
{
	WidgetList temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_POINTER) temp;
}

EIF_INTEGER c_get_dimension (EIF_POINTER w, char *res)
{
	Dimension temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_dimension (EIF_POINTER w, char *res, EIF_INTEGER a_dimension)
{
	XtVaSetValues ((Widget) w, (String) res, (Dimension) a_dimension, NULL);
}

EIF_POINTER c_get_pixel (EIF_POINTER w, char *res)
{
	Pixel temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_POINTER) temp;
}

void c_set_pixel (EIF_POINTER w, char *res, EIF_POINTER a_pixel)
{
	XtVaSetValues ((Widget) w, (String) res, (Pixel) a_pixel, NULL);
}

EIF_INTEGER c_get_position (EIF_POINTER w, char *res)
{
	Position temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_position (EIF_POINTER w, char *res, EIF_INTEGER a_position)
{
	XtVaSetValues ((Widget) w, (String) res, (Position) a_position, NULL);
}

EIF_POINTER c_get_font_list (EIF_POINTER w, char *res)
{
	XmFontList font_list;
	XtVaGetValues ((Widget) w, (String) res, &font_list, NULL);
	return (EIF_POINTER) font_list;
}

void c_set_font_list (EIF_POINTER w, char *res, EIF_POINTER a_font_list)
{
	XtVaSetValues ((Widget) w, (String) res, (XmFontList) a_font_list, NULL);
}

EIF_REFERENCE c_get_string_no_free (EIF_POINTER w, char *res)
{
	String  temp;
	EIF_REFERENCE an_object;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	an_object = (EIF_REFERENCE) RTMS (temp);
	return an_object;
}

EIF_REFERENCE c_get_string (EIF_POINTER w, char *res)
{
	String  temp;
	EIF_REFERENCE an_object;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	an_object = (EIF_REFERENCE) RTMS (temp);
	XtFree (temp);
	return an_object;
}


void c_set_allocated_string (EIF_POINTER w, char *res, char *a_string)
{
	char *c_string;
	
	c_string = strdup (a_string);
	XtVaSetValues ((Widget) w, (String) res, (String) c_string, NULL);
}

void c_set_string (EIF_POINTER w, char *res, char *a_string)
{
	XtVaSetValues ((Widget) w, (String) res, (String) a_string, NULL);
}

EIF_INTEGER c_get_short (EIF_POINTER w, char *res)
{
	short temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_short (EIF_POINTER w, char *res, EIF_INTEGER a_short)
{
	XtVaSetValues ((Widget) w, (String) res, (short) a_short, NULL);
}

EIF_POINTER c_get_string_table (EIF_POINTER w, char *res)
{
	XmStringTable temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_POINTER) temp;
}

void c_set_string_table (EIF_POINTER w, char *res, EIF_POINTER table)
{
	XtVaSetValues ((Widget) w, (String) res, (XmStringTable) table, NULL);
}

EIF_INTEGER c_get_string_direction (EIF_POINTER w, char *res)
{
	XmStringDirection temp;

	XtVaGetValues ((Widget) w, (String) res, &temp, NULL);
	return (EIF_INTEGER) temp;
}

void c_set_string_direction (EIF_POINTER w, char *res, EIF_INTEGER dir)
{
	XtVaSetValues ((Widget) w, (String) res, (XmStringDirection) dir, NULL);
}

EIF_POINTER c_get_xmstring (EIF_POINTER w, char *res)
{
	XmString a_string;

	XtVaGetValues ((Widget) w,(String) res, &a_string, NULL);
	return (EIF_POINTER) a_string;
}

void c_set_xmstring (EIF_POINTER w, char *res, EIF_POINTER cmpnd_str)
{
	XtVaSetValues ((Widget) w,(String) res, (XmString) cmpnd_str, NULL);
}

EIF_POINTER get_i_widget_child (EIF_POINTER w, EIF_INTEGER index)
{
	return (EIF_POINTER) ((WidgetList) w)[(int) index];
}

/*
 *
 * Miscellaneous Xt functions.
 *
 */

/* Globals */

String * fallback_list = (String *) 0;

/* Xt utility functions */

EIF_INTEGER xt_real_x (EIF_POINTER a_widget)
{
	/*  X screen-relative coordinates of a widget */
	Position root_x, root_y;

	XtTranslateCoords ((Widget) a_widget, 0, 0, &root_x, &root_y);
	return (EIF_INTEGER) root_x;
}

EIF_INTEGER xt_real_y (EIF_POINTER a_widget)
{
	/* Y screen-relative coordinates of a widget */
	Position root_x, root_y;

	XtTranslateCoords ((Widget) a_widget, 0, 0, &root_x, &root_y);
	return (EIF_INTEGER) root_y;
}

EIF_BOOLEAN xt_is_visible (EIF_POINTER a_widget)
{
	/* Map state */
	XWindowAttributes window_attributes;
	Widget temp;

	temp = (Widget) a_widget;
	XGetWindowAttributes (XtDisplay (temp), XtWindow (temp), &window_attributes);
	return (EIF_BOOLEAN) (window_attributes.map_state == IsViewable);
}

void x_propagate_event (EIF_POINTER a_widget, EIF_BOOLEAN choice)
{
	/* Specify if `a_widget' propagates event
	 * to its ancestor or not
	 */
	XSetWindowAttributes set_window_attributes;
	Widget temp;
	unsigned long valuemask;

	temp = (Widget) a_widget;
	valuemask = CWDontPropagate | CWEventMask;
	if (choice) {
		set_window_attributes.do_not_propagate_mask = NoEventMask;
		}
	else
	{
		set_window_attributes.event_mask = 2261055;
		set_window_attributes.do_not_propagate_mask = 79;
	}
	XChangeWindowAttributes (XtDisplay (temp), XtWindow (temp),
						valuemask, &set_window_attributes);
}

void set_fallback_res (EIF_POINTER w, EIF_OBJ res, EIF_INTEGER count)
{
	int counter = 0;

	if (fallback_list != (String *) 0) {
		String * temp = fallback_list;
		while (temp) eif_rt_xfree (*(temp++));
		eif_rt_xfree (fallback_list);
		fallback_list = (String *) 0;
	}
	if (res != (EIF_OBJ) 0) {
		fallback_list = (String *) cmalloc (count * sizeof (String) + 1);
		while (count > counter) {
			*(fallback_list + counter) = (String) cmalloc (strlen (*((char **)eif_access(res) + counter)) + 1);
			strcpy (*(fallback_list + counter), *((char **)(eif_access (res)) + counter));
			counter++;
		}
		*(fallback_list + counter) = (String) 0;
	}
		
	XtAppSetFallbackResources ((XtAppContext) w, fallback_list);
}

extern void handle_translation(); 
			/* `c_trans_routine' must corresponding to the
			 * name of above routine.
			 */

EIF_POINTER xt_init ()
{
	/* Initialize Xt toolkit and application context
	 * add action c_callback_on_trans to the list of
	 * application actions, it will be called by any
	 * new translations or accelerators.
	 * Prepare the Xt toolkit and create a global
	 * application context.
	 */
	XtAppContext gAppContext;

	static XtActionsRec	actionTable [] = {
			{c_trans_routine, handle_translation},
			}; 

	XtToolkitInitialize ();
	gAppContext = XtCreateApplicationContext ();
	XtAppAddActions (gAppContext, actionTable, XtNumber (actionTable));
	return (EIF_POINTER) gAppContext;
}

EIF_BOOLEAN compare_masks (EIF_INTEGER mask1, EIF_INTEGER mask2)
{
		/* 
		 * Compare masks `mask1' and `mask2'
		 */
	return (EIF_BOOLEAN) (((unsigned int) mask1 & (unsigned int) mask2) != 0);
}

EIF_REFERENCE c_event_string (EIF_POINTER event_pointer)
{
	/* Ignore modifiers and simply return the string value */
	/* E.g. ctrlg returns g.*/
	char result [100];
	XComposeStatus status;
	KeySym keysym;
	int length;
   
	length = XLookupString ((XKeyEvent *) event_pointer, result, 99, &keysym, &status);
	if (!length) return (EIF_REFERENCE) 0;
	result [length] = '\0';
	return (EIF_REFERENCE) makestr (result, strlen (result));
}

EIF_INTEGER c_event_keysym (EIF_INTEGER event_pointer)
{
	/* Return the keysym value */
	char result [100];
	XComposeStatus status;
	KeySym keysym;

	(void) XLookupString ((XKeyEvent *) event_pointer, result, 99, &keysym, &status);
	return (EIF_INTEGER) keysym;
}

void xt_grab_pointer (EIF_POINTER widget, EIF_POINTER cursor)
{
	/* Grab the pointer and the
	 * keyboard
	 */

	if (cursor)
		XtGrabPointer ((Widget) widget, False,
			PointerMotionMask | ButtonPressMask | ButtonReleaseMask,
			GrabModeAsync, GrabModeSync, None, (Cursor) cursor, CurrentTime);
	else
		XtGrabPointer ((Widget) widget, False,
			PointerMotionMask | ButtonPressMask | ButtonReleaseMask,
			GrabModeAsync, GrabModeSync, None, None, CurrentTime);
}

EIF_POINTER c_create_xpoints (EIF_INTEGER number)
{
	return ((EIF_POINTER) cmalloc (number*sizeof (XPoint)));
}

void c_put_xpoint (EIF_POINTER array, EIF_INTEGER position, EIF_INTEGER x, EIF_INTEGER y)
{
	((XPoint *) array) [(int) position].x = (short) x;
	((XPoint *) array) [(int) position].y = (short) y;
}

void c_free_xpoints (EIF_POINTER array)
{
	eif_rt_xfree ((XPoint *) array);
}

