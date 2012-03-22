/*
 * Functions used to get information on mouse pointer
 */

#include "mel.h"

EIF_INTEGER x_query_x_pointer (EIF_POINTER display_pointer, EIF_POINTER screen_pointer)
{
	/* Get x coordonnate of pointer	 
	 * relative to root window		 
	 */	
	Window root, child;
	int	root_x, root_y;
	int	win_x, win_y;
	unsigned int keys_buttons;
	
	XQueryPointer ((Display *) display_pointer, 
					RootWindowOfScreen ((Screen *) screen_pointer),
					&root, &child, &root_x, &root_y, 
					&win_x, &win_y, &keys_buttons);
	return (EIF_INTEGER) root_x;
}

EIF_INTEGER x_query_y_pointer (EIF_POINTER display_pointer, EIF_POINTER screen_pointer)
{

	/* Get y coordonnate of pointer	 
	 * relative to root window		 
	 */	
	Window root, child;
	int root_x, root_y;
	int	win_x, win_y;
	unsigned int keys_buttons;
	
	XQueryPointer ((Display *) display_pointer, 
			RootWindowOfScreen ((Screen *) screen_pointer),
			&root, &child, &root_x, &root_y, 
			&win_x, &win_y, &keys_buttons);
	return root_y;
}

EIF_POINTER x_query_window_pointer (EIF_POINTER display_pointer, EIF_POINTER window)
{
	/* Get the window currently pointed  
	 */	
	Window root, child;
	int	root_x, root_y;
	int	win_x, win_y;
	unsigned int keys_buttons;

	XQueryPointer ((Display *) display_pointer, (Window) window, 
					&root, &child, &root_x, &root_y, 
					&win_x, &win_y, &keys_buttons);
	return (EIF_POINTER) child;
}

EIF_BOOLEAN x_query_button_pointer (EIF_POINTER display_pointer, EIF_INTEGER button)
{
	/*  Get button state of pointer	  
	 *  relative to root window		 
	 */
	Window root, child;
	int	 root_x, root_y;
	int	 win_x, win_y;
	unsigned int keys_buttons;
	Display *temp;

	temp = (Display *) display_pointer;
	XQueryPointer (temp, 
				RootWindow (temp, DefaultScreen (temp)), 
				&root, &child, &root_x, &root_y, &win_x, &win_y, &keys_buttons);
	switch ((int) button) {
		case 1: return (EIF_BOOLEAN) ((keys_buttons & Button1Mask) != 0);
		case 2: return (EIF_BOOLEAN) ((keys_buttons & Button2Mask) != 0);
		case 3: return (EIF_BOOLEAN) ((keys_buttons & Button3Mask) != 0);
		case 4: return (EIF_BOOLEAN) ((keys_buttons & Button4Mask) != 0);
		case 5: return (EIF_BOOLEAN) ((keys_buttons & Button5Mask) != 0);
		default: return (EIF_BOOLEAN) 0;
	}
}
