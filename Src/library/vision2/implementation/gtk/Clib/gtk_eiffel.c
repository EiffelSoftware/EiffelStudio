/***************************
 *			   *		     
 *   EiffelVision/GTK      *
 *                         *
 *   external C library    *
 *			   *	       
 *   Date: 5/22/98         *
 *                         *
 ***************************/

#include "gtk_eiffel.h"
#include "gdk_eiffel.h"

/*********************************
 *
 * Function `c_free_call_back_block'
 *
 *********************************/

void c_free_call_back_block (callback_data_t *p) 
{
    if (p != NULL)
	free (p);
}

/*********************************
 *
 * Function `c_gtk_init_toolkit'
 *
 * Note : Pass command line arguments to the GTK initialization code
 *       In ISE's runtime there are references to these in "argv.h"
 *
 *********************************/

void c_gtk_init_toolkit () 
{
    gtk_init (&eif_argc, &eif_argv);
	gtk_rc_parse("gtkrc");
}

/*********************************
 *
 * Function `c_signal_callback'
 *
 * Note : This function is actually called when the event occurs
 *        and it in turn calls Eiffel.       
 *
 *********************************/

void c_signal_callback (GtkObject *w, gpointer data) 
{
    callback_data_t *pcbd;
    pcbd = (callback_data_t *)data;
    
    /* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
    /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
	/*printf("c_signal_callback (%d, %d)\n", w, data); */
	(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
}

/*********************************
 *
 * Function `c_event_callback'
 *
 * Note : This function is actually called when the event occurs
 *        and it in turn calls Eiffel.
 *        This function is called for signals named "*_event".     
 *
 *********************************/

void c_event_callback (GtkObject *w, GdkEvent *ev,  gpointer data) 
{
    callback_data_t *pcbd;
    pcbd = (callback_data_t *)data;

	/*printf("c_event_callback (%d, %d, %d)\n", w, ev, data); */

    if (pcbd->ev_data != NULL)
    {
	/* Call Eiffel routine 'set_event_data' to transfer the event data
	   to Eiffel */
	(pcbd->set_event_data)(eif_access(pcbd->ev_data_imp), ev); 
    }

    /* In case of button event we have to check that the right button
       was pressed. If it was a wrong button, no callback will be
       executed */

    if (pcbd->mouse_button == 0 ||
	(pcbd->mouse_button == c_gdk_event_button (ev) &&
	 (pcbd->double_click == (c_gdk_event_type (ev) == GDK_2BUTTON_PRESS))))
    {
	
	/* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument'

	   (routine execute of EV_COMMAND object with EV_ARGUMENTS */
	/*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
	(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
    }

    /* Another test to make a difference between a move event and a size
       event for a window. For a move-event : pcbd->mouse_button = 1, for
       a size_event : pcbd->mouse_button = 2.
    */
    
    if (
		c_gdk_event_type (ev) == GDK_CONFIGURE
		&&
        (
			(
				pcbd->mouse_button == 1
				&&
				c_gdk_event_configure_width(ev) == c_gtk_widget_width (GTK_WIDGET(w))
				&&
				c_gdk_event_configure_height(ev) == c_gtk_widget_height (GTK_WIDGET(w))
			)
			||
			(
			   	pcbd->mouse_button == 2
				&&
				(
					c_gdk_event_configure_width(ev) != c_gtk_widget_width (GTK_WIDGET(w))
					||
					c_gdk_event_configure_height(ev) != c_gtk_widget_height (GTK_WIDGET(w))
				)
			)
		) 
	) {
	/*	(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
		(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
    }
}


/*********************************
 *
 * Function `c_gtk_signal_destroy_data'
 *
 * Note : Function to call when signal is disconnected
 *
 *********************************/

void c_gtk_signal_destroy_data (gpointer data)
{
    callback_data_t *pcbd;
    pcbd = (callback_data_t *)data;  

    printf ("c_gtk_signal_destroy_data= %d object= %d pcbd= %d\n", (int)pcbd->rtn, (int)(pcbd->obj), (int)pcbd); 
    eif_wean(pcbd->obj);
    eif_wean(pcbd->argument);
	eif_wean(pcbd->ev_data);
	eif_wean(pcbd->ev_data_imp);
				/* free the memory for callback data */
    c_free_call_back_block (data);
}

/*********************************
 *
 * Function `c_gtk_signal_connect'
 *
 * Note : Connect a callback to a widget/event pair 
 *  
 * > widget = gtk widget
 * > name = name of the signal
 * > execute_func = address of eiffel routine execute in class EV_COMMAND
 * > object = eiffel object of type EV_COMMAND
 * > argument = object of type EV_ARGUMENTS which will be passed to 
 *   object.execute when it is executed
 * > ev_data = object of type EV_EVENT_DATA. The fields of this object are
 *   filled in 'event_data_rtn' which is called in 'c_event_callback' 
 *   according to the C(gdk) event struct
 *
 * > mouse_button = number of mouse button. Only applicable in button events.
 * > double_click = tells whether we are interested in double click events.
 *   Only applicable in button events.
 *
 * > argument can be NULL which means that there is no arguments for
 *   execute (the corresponding ev_data can be NULL which means that event
 *   data is not needed for this event
 *
 * Note2: This function handles both gtk events and gtk signals. It
 * should be separated
 *
 *********************************/

gint c_gtk_signal_connect_general (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_POINTER ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click,
			   int after)
{
    callback_data_t *pcbd;
    int name_len;
	int event = 0;
	gint event_flags;

    /* Deallocation of this block is done when the */
    /* the signal is destroyed (see c_gtk_signal_destroy_data) */
    pcbd = (callback_data_t*) malloc (sizeof (callback_data_t));
    /* Return the pointer of the allocated block to Eiffel, so it
       can be deallocated later
    */
    /* do not allow the garbage collection of  object and argument */
    pcbd->rtn = execute_func;
    pcbd->obj = henter (object);
    pcbd->argument = henter (argument);
    pcbd->ev_data = henter (ev_data);
    pcbd->ev_data_imp = henter (ev_data_imp);
    pcbd->set_event_data = event_data_rtn;
    pcbd->mouse_button = mouse_button;
    pcbd->double_click = double_click;  
    /*  printf ("connect rtn= %d object= %d pcbd= %d\n", pcbd->rtn, (pcbd->obj), pcbd); */

    /* allow the garbage collection of object and argument, when the signal is destroyed */ 
	gtk_signal_set_funcs (NULL, (GtkSignalDestroy)c_gtk_signal_destroy_data);

    /* Look at the signal name to check whether it ends with "*_event" */
    name_len = strlen (name);
    if (name_len > 6 && strcmp (&name [name_len - 6], "_event") == 0) {
        event = 1;
	}

    /* Make sure the widget has motion event enabled */
	if (strcmp(name, "motion_notify_event") == 0) {
		event_flags = gtk_widget_get_events(GTK_WIDGET(widget));
		printf("event_flags = %d\n", event_flags);
		event_flags |= GDK_POINTER_MOTION_MASK;
		printf("event_flags = %d\n", event_flags);
		gtk_widget_set_events(GTK_WIDGET(widget), event_flags);
		event_flags = gtk_widget_get_events(GTK_WIDGET(widget));
		printf("event_flags = %d\n", event_flags);
	}
	

	
		
	if(after) {
		if (event) {
			return (gtk_signal_connect_after (widget, name, 
				GTK_SIGNAL_FUNC(c_event_callback), 
				(gpointer)pcbd));		
		} else {
			return (gtk_signal_connect_after (widget, name, 
				GTK_SIGNAL_FUNC(c_signal_callback), 
				(gpointer)pcbd));
		}
	} else {
		if (event) {
			return (gtk_signal_connect (widget, name, 
				GTK_SIGNAL_FUNC(c_event_callback), 
				(gpointer)pcbd));		
		} else {
			return (gtk_signal_connect (widget, name, 
				GTK_SIGNAL_FUNC(c_signal_callback), 
				(gpointer)pcbd));
		}
	}
}

gint c_gtk_signal_connect (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_POINTER ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click)
{
	return c_gtk_signal_connect_general (widget, name, execute_func, object, argument, ev_data, ev_data_imp, event_data_rtn, mouse_button, double_click, 0);
}
			
gint c_gtk_signal_connect_after (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_POINTER ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click)
{
	return c_gtk_signal_connect_general (widget, name, execute_func, object, argument, ev_data, ev_data_imp, event_data_rtn, mouse_button, double_click, 1);
}


 /*********************************
 *
 * Function `c_gtk_signal_disconnect'
 *
 * Note :  Disconnect a call back of a widget/event pair
 *
 *********************************/

void c_gtk_signal_disconnect (GtkObject *widget, 
			      EIF_PROC func,
			      EIF_OBJ object,
			      EIF_OBJ argument)
{
    callback_data_t cbd;

    cbd.rtn = func;
    cbd.obj = object;
    cbd.argument = argument;
    /*  printf ("connect rtn= %d object= %d cbd= %d\n", cbd->rtn, (cbd->obj), cbd); */

    gtk_signal_disconnect_by_data (widget, (gpointer)&cbd);
}

/*********************************
 *
 * Function `c_gtk_event_keys_state'
 *
 * Note : state, information about
 * 		  pressed Keys (Shift, Control...)
 *
 *********************************/

int c_gtk_event_keys_state (GtkObject *p)
{
	int x,y;
	GdkModifierType state;
	
	gdk_window_get_pointer (((GdkEventMotion*)p)->window, &x, &y, &state);

	return (int)state;
}
	
/*********************************
 * 
 * Function `gtk_widget_set_all_events'
 *
 * Note : set the events which have to be
 *		  caught by the window
 * 
 *********************************/

void c_gtk_widget_set_all_events (GtkObject * win)
{
	gint event_flags;

 	event_flags = gtk_widget_get_events(GTK_WIDGET(win));
 	event_flags = event_flags | GDK_BUTTON_PRESS_MASK | GDK_BUTTON_RELEASE_MASK | GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK | GDK_ENTER_NOTIFY_MASK | GDK_LEAVE_NOTIFY_MASK | GDK_FOCUS_CHANGE_MASK;
	gtk_widget_set_events (GTK_WIDGET(win), event_flags);
}

/*********************************
 *
 * Function `c_gtk_widget_destroyed'
 *
 * Note : True, if widget is destroyed
 *
 *********************************/

int c_gtk_widget_destroyed (GtkWidget *widget)
{
    return (GTK_OBJECT_DESTROYED (GTK_OBJECT (widget)));
}

/*********************************
 *
 * Function `c_gtk_widget_set_flags'
 *
 * Note : Set widget flags
 *
 *********************************/

void c_gtk_widget_set_flags (GtkWidget *widget, int flags) 
{
    GTK_WIDGET_SET_FLAGS (widget, flags);
}

/*********************************
 *
 * Function `c_gtk_widget_visible'
 *
 * Note :
 *
 *********************************/

EIF_BOOLEAN c_gtk_widget_visible (GtkWidget *w) 
{
    return (GTK_WIDGET_VISIBLE(w));

/*  if (GTK_WIDGET_VISIBLE(w))
    return (1);
    else
    return (0);*/
}

/*********************************
 *
 * Function `c_gtk_widget_realized'
 *
 * Note : Is widget realised
 *
 * Author : Samik
 *
 *********************************/

EIF_BOOLEAN c_gtk_widget_realized (GtkWidget *w) 
{
    return (GTK_WIDGET_REALIZED(w));
}

/*********************************
 *
 * Function `c_gtk_widget_sensitive'
 *
 * Note : Is widget sensitive
 *
 * Author : Samik
 *
 *********************************/

EIF_BOOLEAN c_gtk_widget_sensitive (GtkWidget *w) 
{
    return (GTK_WIDGET_SENSITIVE(w));
}

/*********************************
 *
 * Function `c_gtk_widget_foreground'
 *
 * Note : 
 *
 * Author : 
 *
 *********************************/
/*
EIF_BOOLEAN c_gtk_widget_forground (GtkWidget *w) 
{
	GdkColor* color;
	color = GTK_WIDGET(w)->style->fg;
}
*/

/*********************************
 *
 * Function `c_gtk_window_x'
 *          `c_gtk_window_y'
 *			`c_gtk_window_maximum_height'
 *			`c_gtk_window_maximum_width'
 *			`c_gtk_window_title'
 *
 * Note : Return the x and y coordinates of a window
 * 		  And the postcondition function for x. 
 * 		  Return the maximum height and width.
 * 		  Return the title of a window 
 *      
 * Author : Leila, Alex
 *
 *********************************/

EIF_INTEGER c_gtk_window_x (GtkWidget *w)
{
	gint x;

	if GTK_WIDGET_VISIBLE(w)
	{
		gdk_window_get_position (w->window, &x, NULL);
		return x;
	}
	else
		return (-1);
}

EIF_INTEGER c_gtk_window_y (GtkWidget *w)
{
	gint y;
	
	if GTK_WIDGET_VISIBLE(w)
	{
		gdk_window_get_position (w->window, NULL, &y);
		return y;
	}
	else
		return (-1);
}

void c_gtk_window_set_modal (GtkWindow* window, gboolean modal)
{
	gtk_signal_connect_object(GTK_OBJECT(window),"show",GTK_SIGNAL_FUNC(gtk_grab_add),GTK_OBJECT(window));
	gtk_signal_connect_object(GTK_OBJECT(window),"hide",GTK_SIGNAL_FUNC(gtk_grab_remove),GTK_OBJECT(window));
}

EIF_INTEGER c_gtk_window_maximum_height (GtkWidget *w)
{
	GtkWindowGeometryInfo *info;
	
	if GTK_WIDGET_VISIBLE(w)
	{		
		info = (GtkWindowGeometryInfo *) gtk_object_get_data (GTK_OBJECT(w), "gtk-window-geometry");
		return info->geometry.max_height;
	}
	else
		return (-1);
}

EIF_INTEGER c_gtk_window_maximum_width (GtkWidget *w)
{
	GtkWindowGeometryInfo *info;
			
	if GTK_WIDGET_VISIBLE(w)
	{		
		info = (GtkWindowGeometryInfo *) gtk_object_get_data (GTK_OBJECT(w), "gtk-window-geometry");
		return info->geometry.max_width;
	}
	else
		return (-1);
}

gchar* c_gtk_window_title (GtkWindow *w)
{
	return w->title;
}

/*********************************
 *
 * Function `c_gtk_widget_position_set'
 * 			`c_gtk_widget_minimum_size_set'
 *
 * Note : Return a boolean that say if gtk have
 * 		  memorize a changement of size or position
 * 		  asked by the user. 
 *      
 * Author : Leila
 *
 **********************************/

EIF_BOOLEAN c_gtk_widget_position_set (GtkWidget *w, gint x, gint y) 
{
	GtkWidgetAuxInfo *aux_info;
	
	aux_info = gtk_object_get_data (GTK_OBJECT(w), "gtk-aux-info");
	if (x != -1)
	{
		if (y != -1)
		{
			return ((x == aux_info->x) && (y == aux_info->y));
		}
		else
			return (x == aux_info->x);
	}
	else
		return (y == aux_info-> y);
}

EIF_BOOLEAN c_gtk_widget_minimum_size_set (GtkWidget *w, guint width, guint height) 
{
	GtkWidgetAuxInfo *aux_info;

	aux_info = gtk_object_get_data (GTK_OBJECT(w), "gtk-aux-info");

	if (width != -1)
	{
		if (height != -1)
		{
			return ((width == aux_info->width) && (height == aux_info->height));
		}
		else
			return (width == aux_info->width);
	}
	else
		return (height == aux_info->height);
}

/*********************************
 *
 * Function `c_gtk_widget_set_size' (1)
 * 			`c_gtk_widget_minimum_width' (2)
 * 			`c_gtk_widget_minimum_height' (3)
 *
 * Note : (1) Allocates the widget size
 * 		  (2) Gets the minimum width
 * 		  (3) Gets the minimum height
 *
 * Author : Leila (1), Alex (2), (3)
 *
 *********************************/

void c_gtk_widget_set_size (GtkWidget *widget, int width, int height) 
{
  GtkAllocation allocation;
  
  allocation.x = widget->allocation.x;
  allocation.y = widget->allocation.y;
  allocation.width = width;
  allocation.height = height;
  
  gtk_widget_size_allocate (widget, &allocation);
}

EIF_INTEGER c_gtk_widget_minimum_width (GtkObject *widget) 
{
	  GtkRequisition requisition;
	    
	  gtk_widget_size_request ((GtkWidget *) widget, &requisition);
	  return requisition.width;
}

EIF_INTEGER c_gtk_widget_minimum_height (GtkObject *widget) 
{
	  GtkRequisition requisition;

	  gtk_widget_size_request ((GtkWidget *) widget, &requisition);
	  return requisition.height;
}

/*********************************
 *
 * Function : `c_gtk_container_nb_children' (1)
 *  		  `c_gtk_container_ith_child'   (2)
 *  		  `c_gtk_container_has_child'	(3)
 *  		            
 * Note (1) : Return the number of children of a container.
 * 		(2)	: Return the i-th child of the container.
 * 		(3) : Tell if the given widget is a child of the container.
 * 
 * Author : Leila
 *
 **********************************/

gint c_gtk_container_nb_children (GtkWidget *widget)
{
	GList* children;

	children = gtk_container_children (GTK_CONTAINER(widget));
	return (g_list_length (children));
}

EIF_POINTER c_gtk_container_ith_child (GtkWidget *widget, guint i)
{
	GList* children;
	
	children = gtk_container_children (GTK_CONTAINER(widget));
	return (EIF_POINTER)(g_list_nth_data ((children), i));
}

int c_gtk_container_has_child (GtkWidget *widget, GtkWidget *child)
{
	GList* children;
	
	children = gtk_container_children (GTK_CONTAINER(widget));
	children = g_list_find (children, (gpointer) child);
	if (!children)
	{
		return 0;
	}
	else
	{
		return 1;
	};
}

/*********************************
 *
 * Function `c_gtk_scrollable_area_add' (1)
 * 			'c_gtk_scrollable_area_has_child' (2)
 *
 * Note : (1) We have to distinguish 2 cases to add the widget 
 * 		  to the scroll area:
 * 		  	- if the widget is not a scrollable widget,
 * 		  			use 'gtk_scrolled_window_add_with_viewport',
 * 		  	- otherwise, use 'gtk_container_add'.
 * 		  (2) Has the scrollable area the given child?
 *
 *********************************/

void c_gtk_scrollable_area_add (GtkWidget *scroll_area, GtkWidget *widget)
{
  GtkScrolledWindow *scrolled_window;
  
  scrolled_window = GTK_SCROLLED_WINDOW (scroll_area);
  
    if (!gtk_widget_set_scroll_adjustments (widget,
			gtk_range_get_adjustment (GTK_RANGE (scrolled_window->hscrollbar)),
			gtk_range_get_adjustment (GTK_RANGE (scrolled_window->vscrollbar))))
	{
		gtk_scrolled_window_add_with_viewport (scrolled_window, widget);
	}
	else
		gtk_container_add (GTK_CONTAINER (scroll_area), widget);
}

int c_gtk_scrollable_area_has_child (GtkWidget *widget, GtkWidget *child)
{
	GtkBin *bin;
	GtkWidget *viewport;

	GList* children;

	bin = GTK_BIN (widget);
	if ( (bin->child !=NULL) && (GTK_IS_VIEWPORT (bin->child)) )
	/* If we are here, this means we use the
	 * 'gtk_scrolled_window_add_with_viewport' to add the child.
	 * So we have to test if the child has been added to the viewport
	 */
	{
		viewport = bin->child;
		children = gtk_container_children (GTK_CONTAINER(viewport));
		children = g_list_find (children, (gpointer) child);
		if (!children)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}
	else
	/* Otherwise, we have used 'gtk_container_add' to add the
	 * child in the scrollable area.
	 * So we just use 'c_gtk_container_has_child'.
	 */
	{
		return c_gtk_container_has_child (widget, child);
	}
}

/*********************************
 *
 * Function `c_toolbar_callback'
 *
 * Note : Call back for toolbar buttons
 *
 *********************************/

void c_toolbar_callback (GtkObject *w, gpointer data) 
{
    callback_data_t *cbd;
    cbd = (callback_data_t *)data;
    /* Call Eiffel */
    /*  printf ("callback= %d object= %d cbd= %d\n", cbd->rtn, (cbd->obj), cbd); */
    (cbd->rtn)(cbd->obj);
}

/*********************************
 *
 * Function `c_gtk_toolbar_append_item'
 *
 * Note : Call back for buttons on a tool bar
 *
 *********************************/

void c_gtk_toolbar_append_item (GtkToolbar *toolbar, 
				const char *text, 
				const char *tip,
				const char *private_tip,
				GtkWidget *icon,
				EIF_PROC func, EIF_OBJ object,
				callback_data_t **p)
{
    callback_data_t *cbd;

    cbd = (callback_data_t*) malloc (sizeof (callback_data_t));
    *p = cbd;
    eif_freeze (object);
    cbd->rtn = func;
    cbd->obj = eif_access (object);
    gtk_toolbar_append_item (toolbar, text, tip, private_tip, icon, 
			     (GtkSignalFunc)c_toolbar_callback, cbd);
}
						   
/*********************************
 *
 * Function : `c_gtk_widget_get_name'
 *            `c_gtk_widget_set_name'
 *
 * Note : respectively returns and set  widget name 
 *
 *********************************/

EIF_REFERENCE c_gtk_widget_get_name (GtkWidget *widget)
{
    return RTMS (gtk_widget_get_name (widget));
}

void c_gtk_widget_set_name (GtkWidget *widget, const gchar *name)
{
    gtk_widget_set_name (widget, name);
}


/*********************************
 *
 * Function : `c_gtk_get_label_widget'
 *
 * Note : Returns the label widget of button. 
 *        There has to be only a label inside the widget.
 *
 *********************************/

GtkWidget* c_gtk_get_label_widget (GtkWidget *widget)
{
    GList            *glist;
    
    glist = gtk_container_children( GTK_CONTAINER(widget) );
    return GTK_WIDGET( glist->data );
}

/*********************************
 *
 * Function : `c_gtk_get_text_length'
 *            `c_gtk_get_text_max_lenght'
 *
 * Note : The length of the string in text widget.
 *        The maximum length of string in text widget.
 *
 *********************************/

int c_gtk_get_text_length (GtkWidget* text)
{
    return GTK_ENTRY (text)->text_length;
}

int c_gtk_get_text_max_length (GtkWidget* text)
{
    return GTK_ENTRY (text)->text_max_length;
}

/*********************************
 *
 * Function : `c_gtk_toggle_button_active'
 *
 * Note : Return a state of a toggle button
 *
 *********************************/

EIF_BOOLEAN c_gtk_toggle_button_active (GtkWidget *button) 
{
    return (GTK_TOGGLE_BUTTON(button)->active);
}

/*********************************
 *
 * Function : `c_gtk_option_button_selected_menu_item' (1)
 *			  `c_gtk_option_button_index_of_menu_item' (2)
 *			  
 * Note : (1) Current selected menu item
 *		  (2) Give the position of the menu_item in the menu
 *		  		inside the option button. The position is needed by 
 *		  		`gtk_option_menu_set_history'.
 * 
 *********************************/

EIF_POINTER c_gtk_option_button_selected_menu_item (GtkWidget *option_button) 
{
    return ((EIF_POINTER) GTK_OPTION_MENU (option_button)->menu_item);
}

EIF_INTEGER c_gtk_option_button_index_of_menu_item (GtkWidget *option_menu, GtkWidget *menu_item)
{
	GtkOptionMenu * opt_menu;
	GtkMenu *menu;

	gint pos;
	
	opt_menu = GTK_OPTION_MENU (option_menu);
	menu = GTK_MENU (opt_menu->menu);
	
	pos = g_list_index (GTK_MENU_SHELL (menu)->children, (gpointer) menu_item);

   	return pos;
}

/*********************************
 *
 * Data : `xpm_data'
 *
 * Note : Data for empty pixmap of size 1x1
 *
 *********************************/

static char * xpm_data[] = {
	"16 16 3 1",
       "       c None",
       ".      c #000000000000",
       "X      c #FFFFFFFFFFFF",
       "                ",
       "   ......       ",
       "   .XXX.X.      ",
       "   .XXX.XX.     ",
       "   .XXX.XXX.    ",
       "   .XXX.....    ",
       "   .XXXXXXX.    ",
       "   .XXXXXXX.    ",
       "   .XXXXXXX.    ",
       "   .XXXXXXX.    ",
       "   .XXXXXXX.    ",
       "   .XXXXXXX.    ",
       "   .XXXXXXX.    ",
       "   .........    ",
       "                ",
       "                "};



	/*
      "1 1 1 1",
      "       c None",
      " "};
	  */

/*********************************
 *
 * Function : `c_gtk_pixmap_create_empty'
 *
 * Note : Create an empty pixmap
 *
 *********************************/

GtkWidget* c_gtk_pixmap_create_empty  (GtkWidget *widget)
{
    GdkBitmap *mask;
    GdkPixmap *pixmap;
  
    /* Widget must be realized before we can attach a pixmap to it */
	if (!GTK_WIDGET_REALIZED(widget)) {
		gtk_widget_realize (widget);
	}
    pixmap = gdk_pixmap_create_from_xpm_d (widget->window,
					 &mask, 
					 &widget->style->bg[GTK_STATE_NORMAL],
					 (gchar **)xpm_data);
    return (gtk_pixmap_new (pixmap, mask));
}

/*********************************
 *
 * Function : `c_gtk_pixmap_create_from_xpm'
 *
 * Note : Create a pixmap widget from an xpm file
 *        file must exist an be in xpm format
 *
 *********************************/

GtkWidget *c_gtk_pixmap_create_from_xpm (GtkWidget *widget, char *fname) 
{
    GdkBitmap *mask;
    GdkPixmap *pixmap;
  
    /* Widget must be realized before we can attach a pixmap to it */
	if (!GTK_WIDGET_REALIZED(widget)) {
		gtk_widget_realize (widget);
	}
    pixmap = gdk_pixmap_create_from_xpm (widget->window,
					 &mask, 
					 &widget->style->bg[GTK_STATE_NORMAL],
					 fname);
    return (gtk_pixmap_new (pixmap, mask));
}

/*********************************
 *
 * Function : `c_gtk_pixmap_make_with_size'
 *
 * Note : Create the pixmap with
 *        the given size.
 *
 *********************************/

GtkWidget* c_gtk_pixmap_create_with_size ( GtkWidget *window_parent,
				  gint width, gint height)
{
//    GdkPixmap *pixmap;
//    GdkBitmap *mask;
	
	if (!GTK_WIDGET_REALIZED(window_parent)) {
		gtk_widget_realize (window_parent);
	}
return ((GtkWidget *) gdk_pixmap_new (window_parent->window, width, height, -1));
//    pixmap =  gdk_pixmap_new (window_parent, width, height, -1);
//	return (gtk_pixmap_new (pixmap, ));
}

/*********************************
 *
 * Function : `c_gtk_pixmap_read_from_xpm'
 *
 * Note : Read the pixmap for xpm file
 *        file must exist an be in xpm format
 *
 *********************************/

void c_gtk_pixmap_read_from_xpm ( GtkPixmap *pixmap,
				  GtkWidget *pixmap_parent,
				  char *file_name )
{
    GdkPixmap* gdk_pixmap;
    GdkBitmap *mask;
    GtkStyle *style;

	if (!GTK_WIDGET_REALIZED(pixmap_parent)) {
		gtk_widget_realize (pixmap_parent);
	}
    style = gtk_widget_get_style (pixmap_parent);
    gdk_pixmap = gdk_pixmap_create_from_xpm (pixmap_parent->window,
					     &mask,
					     &style->bg[GTK_STATE_NORMAL],
					     file_name);
    
    gtk_pixmap_set (pixmap, gdk_pixmap, mask);
}

/*********************************
 *
 * Function : `c_gtk_pixmap_set_from_pixmap'
 *            
 * Note     : Change the pixmap's gdkPixmap to new gdkPixmap
 * 
 * Author : Alex
 *
 *********************************/

void c_gtk_pixmap_set_from_pixmap	 (GtkWidget  *pixmapDest, GtkWidget *pixmapSource)
{
  GdkPixmap *image;
  GdkBitmap *mask;

  /* Prepare the bitmap and the mask */
  mask = ((GtkPixmap *) pixmapSource)->mask;
  image = ((GtkPixmap *) pixmapSource)->pixmap;
 
  /* Set the bitmap */
  gtk_pixmap_set ((GtkPixmap *) pixmapDest, image, mask);
}

/*********************************
 *
 * Function : `c_gtk_list_item_select'   	(1)
 *            `c_gtk_list_item_unselect' 	(2)
 *            `c_gtk_list_item_is_selected' (3)
 *            `c_gtk_list_rows'           	(4)
 *            `c_gtk_list_selection_mode' 	(5)
 *            `c_gtk_list_selected_item'  	(6)
 *            `c_gtk_list_insert_item'	 	(7)
 *            
 * Note (2,3) : Two routines to select or unselect an item, because the gtk
 *              functions seems to have a bug.
 * Note (4)   : Give the number of rows of a list.
 * Note (6)   : Index of the most recently selected item. (-1 if none selected)
 * Note (7)   : Insert the item at the given index.
 * 
 * Author : Leila, Alex
 *
 *********************************/

void c_gtk_list_item_select (GtkWidget *item)
{  
  if (GTK_WIDGET (item)->parent && GTK_IS_LIST (GTK_WIDGET (item)->parent))
    gtk_list_select_child (GTK_LIST (GTK_WIDGET (item)->parent),
                           GTK_WIDGET (item));
}

void c_gtk_list_item_unselect (GtkWidget *item)
{  
  /* if (GTK_WIDGET (item)->parent && GTK_IS_LIST (GTK_WIDGET (item)->parent)) */
  if (GTK_IS_LIST (GTK_WIDGET (item)->parent))
    gtk_list_unselect_child (GTK_LIST (GTK_WIDGET (item)->parent),
                           GTK_WIDGET (item));
}

EIF_BOOLEAN c_gtk_list_item_is_selected (GtkWidget *list, GtkWidget *item)
{
	GList *selected_items;

	selected_items = GTK_LIST (list)->selection;
	
	while (selected_items) 
	{
	  if (item == GTK_WIDGET (selected_items->data))
		return TRUE;
	  selected_items = selected_items->next;
	}
	return FALSE;
}

guint c_gtk_list_rows (GtkWidget *list)
{
	return (g_list_length (GTK_LIST(list)->children));	
}

gint c_gtk_list_selection_mode (GtkWidget *list)
{
	return GTK_LIST(list)->selection_mode;
}

guint c_gtk_list_selected (GtkWidget *list)
{
	return (g_list_length (GTK_LIST(list)->selection));	
}

gint c_gtk_list_selected_item (GtkWidget *list)
{
	if ((GTK_LIST (list)->selection) != NULL) 
	{
	  return gtk_list_child_position (GTK_LIST(list), GTK_LIST(list)->selection->data);

	}
	return -1;
}

void c_gtk_list_insert_item (GtkWidget *list, GtkWidget *item, gint position)
{
  GList *item_list;
 
  item_list = (GList *) malloc (sizeof (GList *));
  
  item_list->data = item;
  gtk_list_insert_items ((GtkList *)list, item_list, position);
}

void c_gtk_list_remove_item (GtkWidget *list, GtkWidget *item)
{
  GList *item_list;
 
  item_list = (GList *) malloc (sizeof (GList *));
  
  item_list->data = item;
  gtk_list_remove_items ((GtkList *)list, item_list);
}

/*********************************
 *
 * Function : `c_gtk_notebook_count'
 *  		            
 * Note (1) : Number of pages in a notebook.
 * 
 * Author : Leila
 *
 **********************************/

gint c_gtk_notebook_count (GtkWidget *notebook)
{
	return (g_list_length (GTK_NOTEBOOK(notebook)->children));
}

/*********************************
 *
 * Function : `c_gtk_clist_append_row'			(1)
 *  		  `c_gtk_clist_selected'   			(2)
 *  		  `c_gtk_clist_ith_selected_item 	(3)
 *  		            
 * Note (1) : Add an empty row in the given multi-column list.
 * 		(2)	: Return an integer telling if an element is selected or not. 
 * 			  This integer can be interpreted as a boolean.
 * 		(3) : Return the i-th element of the selected-items list.
 * 
 * Author : Leila
 *
 **********************************/

gint c_gtk_clist_append_row (GtkWidget* list)
{
	char *text[GTK_CLIST(list)->columns];
	gint i;

	for (i = 0; i < GTK_CLIST(list)->columns; i++)
		text[i] = "";
	return (gtk_clist_append (GTK_CLIST(list), text));
}

guint c_gtk_clist_selected (GtkWidget* list)
{
	return (g_list_length (GTK_CLIST(list)->selection));
}

gint c_gtk_clist_ith_selected_item (GtkWidget* list, guint i)
{
	return (GPOINTER_TO_INT (g_list_nth_data (GTK_CLIST(list)->selection, i)));
}

guint c_gtk_clist_selection_length (GtkWidget* list)
{
	return (g_list_length (GTK_CLIST(list)->selection));
}

/*********************************
 *
 * Function : `c_gtk_clist_set_fg_color	(1)
 *  		  `c_gtk_clist_set_bg_color	(2)
 *  		  `c_gtk_clist_get_fg_color	(3)
 *  		  `c_gtk_clist_get_bg_color	(4)
 *  		  `c_gtk_clist_set_pixtext	(5)
 *  		  `c_gtk_clist_unset_pixmap	(5)
 *  		            
 * Note (1) : Sets the foreground color of the given row.
 * 		(2) : Sets the background color of the given row.
 * 		(3) : Gets the foreground color of the given row.
 * 		(4) : Gets the background color of the given row.
 * 		(5) : Sets the pixmap and the text of the given row and column.
 * 		(6) : Unsets the pixmap of the given row and column.
 * 
 * Author : Alex
 *
 **********************************/

void c_gtk_clist_set_fg_color (GtkWidget* clist, int row, int r, int g, int b)
{
	GdkColor fg_color;
	
	/* Prepare the GdkColor */
	r *= 257; g *= 257; b *= 257;
	fg_color.red = r;
	fg_color.green = g;
	fg_color.blue = b;
	
	/* Sets the foreground color of the given row */
	gtk_clist_set_foreground (GTK_CLIST (clist), row, &fg_color);
}

void c_gtk_clist_set_bg_color (GtkWidget* clist, int row, int r, int g, int b)
{
	GdkColor bg_color;
	
	/* Prepare the GdkColor */
	r *= 257; g *= 257; b *= 257;
	bg_color.red = r;
	bg_color.green = g;
	bg_color.blue = b;
 	
	/* Sets the background color of the given row */
	gtk_clist_set_background (GTK_CLIST (clist), row, &bg_color);
}

void c_gtk_clist_get_fg_color (GtkWidget* clist, int row, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b)
{
  GtkCListRow *clist_row;
  GdkColor row_color;
  
  if (row < 0 || row >= ((GtkCList *) clist)->rows)
    return;

  clist_row = (g_list_nth (((GtkCList *) clist)->row_list, row))->data;
  row_color = ((GtkCListRow *) clist_row)->foreground;
  
  *r = (EIF_INTEGER) row_color.red;
  *g = (EIF_INTEGER) row_color.green;
  *b = (EIF_INTEGER) row_color.blue;

  *r /= 257; *g /= 257; *b /= 257;
}

void c_gtk_clist_get_bg_color (GtkWidget* clist, int row, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b)
{
  GtkCListRow *clist_row;
  GdkColor row_color;
  
  if (row < 0 || row >= ((GtkCList *) clist)->rows)
    return;

  clist_row = (g_list_nth (((GtkCList *) clist)->row_list, row))->data;
  row_color = ((GtkCListRow *) clist_row)->background;
  
  *r = (EIF_INTEGER) row_color.red;
  *g = (EIF_INTEGER) row_color.green;
  *b = (EIF_INTEGER) row_color.blue;

  *r /= 257; *g /= 257; *b /= 257;
}

void c_gtk_clist_set_pixtext (GtkWidget* clist, int row, int column, GtkWidget *pixmap, gchar *text)
{
  GdkBitmap *mask;
  GtkCListRow *clist_row;
  
  /* prepare the mask */
  clist_row = (g_list_nth (((GtkCList *)clist)->row_list, row))->data;
  /* mask can be NULL */
  mask = GTK_CELL_PIXMAP (clist_row->cell[column])->mask;

  /* Set the pixmap and the text */
  if (pixmap != NULL)
  {	  
    gtk_clist_set_pixtext ((GtkCList *) clist, row, column, text, 0, ((GtkPixmap *) pixmap)->pixmap, mask);
  }
  else
  {
    gtk_clist_set_text ((GtkCList *) clist, row, column, text);
  }
}

void c_gtk_clist_unset_pixmap (GtkWidget* clist, int row, int column)
{
  GtkCListRow *clist_row;
  
  clist_row = (g_list_nth (((GtkCList *) clist)->row_list, row))->data;

  /* Remove the old pixmap */
  gdk_pixmap_unref (GTK_CELL_PIXTEXT (clist_row->cell[column])->pixmap);
  if (GTK_CELL_PIXTEXT (clist_row->cell[column])->mask)
	gdk_bitmap_unref (GTK_CELL_PIXTEXT (clist_row->cell[column])->mask);
   
  clist_row->cell[column].type = GTK_CELL_TEXT;
}

/*********************************
 *
 * Function : `c_gtk_table_rows' (1)
 *            `c_gtk_table_columns' (2)
 *            `c_gtk_table_set_spacing_if_needed' (3)
 *
 * Note : (1) (2) Give the number of rows and columns of
 *        a table.
 *        (3) Sets the spacings if needed. This function has been created
 *        because of a GTK bug: when adding new child in the table,
 *        the spacings are not set for it. As soon as the bug is fixed,
 *        we can erase this function.
 *
 * Author : Leila
 *
 *********************************/

EIF_INTEGER c_gtk_table_rows (GtkWidget *widget)
{
  return (GTK_TABLE(widget)->nrows);
}

EIF_INTEGER c_gtk_table_columns (GtkWidget *widget)
{
  return (GTK_TABLE(widget)->ncols);
}

void c_gtk_table_set_spacing_if_needed (GtkWidget *widget)
{
	if (GTK_TABLE (widget)->column_spacing > 0)
	{
	  gtk_table_set_col_spacings (GTK_TABLE (widget), GTK_TABLE (widget)->column_spacing);
	}
	if (GTK_TABLE (widget)->row_spacing > 0)
	{
	  gtk_table_set_row_spacings (GTK_TABLE (widget), GTK_TABLE (widget)->row_spacing);
	}
	
}

/*********************************
 *
 * Function : `c_gtk_tree_item_expanded' (1)
 * 			  `c_gtk_tree_item_is_selected'	(2)
 * 			  `c_gtk_tree_set_single_selection_mode' (3)
 * 			  `c_gtk_tree_selected_item' (4)
 *
 * Note : (1) Tell if an item is expanded or not.
 *		  (2) is the item selected?
 *		  (3) set the selection mode to SINGLE.
 *		  (4) give the selected item of the tree.
 * 	
 * Author : Leila, Alex
 *
 *********************************/

EIF_BOOLEAN c_gtk_tree_item_expanded (GtkWidget *widget)
{
  return (GTK_TREE_ITEM(widget)->expanded) ? 1: 0;
}

EIF_BOOLEAN c_gtk_tree_item_is_selected (GtkWidget *tree, GtkWidget *treeItem)
{
	GList *list;
	GtkWidget *item;
	
	list = GTK_TREE_SELECTION(tree);
	
	while (list)
	{
	  if (list->data != NULL)
	  {
		item = GTK_WIDGET (list->data);
 	    if (item == treeItem)
	    {
		  return 1;
	    }
	  }
  	  list = list->next;
	}
	return 0; 
}

void c_gtk_tree_set_single_selection_mode (GtkWidget *tree)
{
  gtk_tree_set_selection_mode (GTK_TREE (tree), GTK_SELECTION_SINGLE);
}

EIF_POINTER c_gtk_tree_selected_item (GtkWidget *tree)
{
	GList *list;
	GtkTree * wid;

	wid = GTK_TREE_ROOT_TREE (GTK_TREE (tree));
list = wid->selection;
	
	list = GTK_TREE_SELECTION(tree);

  while (list){
    GtkWidget *item;

    item = GTK_WIDGET (list->data);
    list = list->next;
  }
  if (list->data != NULL)
  {
   	return (EIF_POINTER) (list->data);
  }	  
  else return (EIF_POINTER) NULL; 

/*

	if (list != NULL)
	{	
	  if (list->data != NULL)
	  {
	   	return (EIF_POINTER) (list->data);
	  }
	  else return (EIF_POINTER) NULL; 
	}
	else return (EIF_POINTER) NULL; 
*/
	}

/*********************************
 *
 * Function : `c_gtk_text_insert' (1)
 * 			  `c_gtk_text_full_insert' (2)
 *
 * Note (1): Insert a text at the current position of a text widget.
 *        	 We can't use directly the function because the widget
 *        	 must be realized.
 *      (2): Insert a text at the current position of a rich-text widget.
 *      	 The text is added with the given color and font. The background
 *      	 color used is the one of the widget.
 *
 * Author : Leila
 *
 *********************************/

void c_gtk_text_insert (GtkWidget *widget, const char *txt)
{
  gtk_text_insert (GTK_TEXT(widget), NULL, NULL, NULL, txt, -1);
}

void c_gtk_text_full_insert (GtkWidget *widget, GdkFont *font, int r, int g, int b, const char *txt, gint length)
{
	GdkColor fore;
	GdkColor back;
	GtkStyle *style;
	
	/* We create the foreground color */
	r *= 257; g *= 257; b *= 257;
	fore.pixel = 0;
	fore.red = r;
	fore.green = g;
	fore.blue = b;
	
	/* We create the background color */
	style = GTK_WIDGET(widget)->style;
	back.pixel = 0;
	back.red = style->base[GTK_STATE_NORMAL].red;
	back.green = style->base[GTK_STATE_NORMAL].green;
	back.blue = style->base[GTK_STATE_NORMAL].blue;

	gtk_text_insert (GTK_TEXT (widget), font, &fore, &back, txt, length);
}

/*********************************
 *
 * Function : `c_gtk_box_set_child_options'
 *
 * Note : Change the options of a child in a box.
 *
 * Author : Leila
 *
 *********************************/

void c_gtk_box_set_child_options (GtkWidget *box, GtkWidget *child,
				  gint expand, gint fill)
{
  gint old_fill;
  gint old_expand;
  gint old_padding;
  GtkPackType old_pack_type;

  gtk_box_query_child_packing (GTK_BOX(box), child, & old_expand, & old_fill,
			       & old_padding, & old_pack_type);
  gtk_box_set_child_packing (GTK_BOX(box), child, expand, fill, 
			     old_padding, old_pack_type);

}

/*********************************
 *
 * Function : `c_gtk_statusbar_item_create_pixmap_place'	(1)
 *			  `c_gtk_statusbar_item_unset_pixmap'			(3)
 *			  	
 * Note : (1) The equivalent of `create_pixmap_place' in EV_PIXMAPABLE
 * 				to create the place in the box, where the pixmap will be placed.
 * 				Return the value of the pixmap pointer.
 *		  (3) Unsets the pixmap of the status bar item.	Remove the GtkPixmap
 *		  		the status bar, which will be destroyed (no more ref).
 * 
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_statusbar_item_create_pixmap_place (GtkWidget *statusbar)
{
  GtkWidget *pixmap;

  GtkWidget *statusbar_frame;
  GtkWidget *statusbar_label;
  GtkWidget *hbox;
  
  statusbar_frame = GTK_STATUSBAR (statusbar)->frame;
  statusbar_label = GTK_STATUSBAR (statusbar)->label;
  /* the status bar label is never NULL, by gtk-construction. */
	
  /* Test if the box to put the pixmap and the label has
   * already been created by us, previously.
   * If the parent of the label is the original frame, then no,
   * otherwise it is the box.
   */
  hbox = GTK_WIDGET (statusbar_label)->parent;
	
  if ( !GTK_IS_BOX (hbox))
  {
    /** If we are in here, this means the box has not been created yet. **/
		
	/* First remove the label from the frame.
	 * We reference the label otherwise
	 * it will be destroyed when removed.
	 */
	gtk_object_ref (GTK_OBJECT (statusbar_label));
 	gtk_container_remove (GTK_CONTAINER (statusbar_frame), statusbar_label);

	/* 
	 * Create a gtk_hbox where we will put the pixmap and the label
	 * and add to the frame.
	 */	
	hbox = gtk_hbox_new (FALSE, 0);
	gtk_container_add (GTK_CONTAINER (statusbar_frame), hbox);

	/* show the box */
	gtk_widget_show (hbox);
  }
  else
  {
	/** If we are here, this means we have already created the box **/

	/* Put the pixmap in the box.
	 * First we take the label off to have the pixmap on the left
	 * and the  label on the right.
	 */
	gtk_object_ref (GTK_OBJECT (statusbar_label));
	gtk_container_remove (GTK_CONTAINER (hbox), statusbar_label);	
  }

  /* create the pixmap that we will put in the box */
  pixmap = c_gtk_pixmap_create_empty (hbox);
			
  /* Put the pixmap and the label in the box */
  gtk_box_pack_start (GTK_BOX (hbox), pixmap, FALSE, FALSE, 0);
  gtk_box_pack_start (GTK_BOX (hbox), statusbar_label, FALSE, FALSE, 0);

  /* show the pixmap */
  gtk_widget_show (pixmap);

  /* Unreference the label which has one reference more now
   * That we have added it to the box.
   */
  gtk_object_unref (GTK_OBJECT (statusbar_label));
  
  /* Return the value of the pixmap pointer */
  return (EIF_POINTER) pixmap;
}

void c_gtk_statusbar_item_unset_pixmap (GtkWidget *statusbar, GtkWidget *pixmap)
{
	GtkWidget *hbox;
	GtkWidget *statusbar_label;
	
	statusbar_label = GTK_STATUSBAR (statusbar)->label;
	
	/* Pointer to the hbox where the pixmap and the label are */
	hbox = GTK_WIDGET (GTK_STATUSBAR (statusbar)->label)->parent;

	/* Remove the pixmap from the box */
	gtk_container_remove (GTK_CONTAINER (hbox), pixmap);
}

/*********************************
 *
 * Function : `c_gtk_pixmap_width'		(1)
 * 			  `c_gtk_pixmap_height'		(2)
 * 			  `c_gtk_pixmap_gdk_unref'	(3)
 *
 * Note : (1) Pixmap width.
 * 		  (2) Pixmap height.
 * 		  (3) Unref the gdk pixmap and the gdk bitmap (mask) to destroy them.
 *
 * Author : Alex
 *
 *********************************/

EIF_INTEGER c_gtk_pixmap_width (GtkWidget *pixmap)
{
	  gint width;
	  gint height;
	  
	  gdk_window_get_size (GTK_PIXMAP (pixmap)->pixmap, &width, &height);
	  
	  return (EIF_INTEGER) width;
}

EIF_INTEGER c_gtk_pixmap_height (GtkWidget *pixmap)
{
	  gint width;
	  gint height;
	  
	  gdk_window_get_size (GTK_PIXMAP (pixmap)->pixmap, &width, &height);
	  
	  return (EIF_INTEGER) height;
}

void c_gtk_pixmap_gdk_unref (GtkWidget *pixmap)
{
  GdkPixmap *gdkPixmap;
  GdkBitmap *mask;

  gdkPixmap = ((GtkPixmap *) pixmap)->pixmap;
  mask = ((GtkPixmap *) pixmap)->mask;

  /* Unref */
  gdk_pixmap_unref (gdkPixmap);
  if (mask != NULL)
	gdk_bitmap_unref (mask); 
}

/*********************************
 *
 * Function : `'
 *
 * Note : Several externals for the colors
 *
 * Author : Leila
 *
 *********************************/


/*
EIF_REFERENCE ev_color_make_rgb (int r, int g, int b)
{
		EIF_REFERENCE ev_color;
		EIF_TYPE_ID ev_color_type;
		EIF_PROC set_rgb;
		EIF_INTEGER er = r;
		EIF_INTEGER eg = g;
		EIF_INTEGER eb = b;

		ev_color_type = eif_type_id("EV_COLOR");
		ev_color = eif_access(eif_create(ev_color_type));
		set_rgb = eif_proc("make_rgb", ev_color_type);
		(set_rgb)(ev_color, er, eg, eb);
		return ev_color;
}
*/

void c_gtk_style_default_bg_color (EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b)
{
		GtkStyle* style;

		style = gtk_widget_get_default_style();
		*r = style->bg[GTK_STATE_NORMAL].red;
		*g = style->bg[GTK_STATE_NORMAL].green;
		*b = style->bg[GTK_STATE_NORMAL].blue;
		
		*r /= 257; *g /= 257; *b /= 257;
}

void c_gtk_style_default_fg_color (EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b)
{
		GtkStyle* style;

		style = gtk_widget_get_default_style();
		*r = style->fg[GTK_STATE_NORMAL].red;
		*g = style->fg[GTK_STATE_NORMAL].green;
		*b = style->fg[GTK_STATE_NORMAL].blue;
		
		*r /= 257; *g /= 257; *b /= 257;
}

/*********************************
 *
 * Function : `SetStyleRecursively'			(1)
 * 			  `c_gtk_widget_set_fg_color'	(2)
 * 			  `c_gtk_widget_set_bg_color'	(3)
 *
 * Note : (1) This function is a function needed by
 * 				- `c_gtk_widget_set_bg_color'
 * 				- `c_gtk_widget_set_fg_color' only.
 * 		  		It enable to set the requested style to all children
 * 		  	 	when the widget is a container
 *		  (2) Sets the foreground color of the widgets and its children.
 *		  (3) Sets the background color of the widgets and its children.
 *
 * Author : Alex
 *
 *********************************/

void SetStyleRecursively (GtkWidget *widget, gpointer data)
{
    GtkStyle *style;

    /* --- Get the style --- */
    style = (GtkStyle *) data;

    /* --- Set the style of the widget --- */
    gtk_widget_set_style (widget, style);

    /* --- If it may have children widgets --- */
    if (GTK_IS_CONTAINER (widget)) {

        /* --- Set all the children's styles too. --- */
        gtk_container_foreach (GTK_CONTAINER (widget), 
                           SetStyleRecursively, style);
    }
}

void c_gtk_widget_set_bg_color (GtkWidget* widget, int r, int g, int b)
{
  GtkStyle* style;
  int or, og, ob;
  int i;

  style = gtk_widget_get_style(GTK_WIDGET(widget));
  r *= 257; g *= 257; b *= 257;

  or = style->bg[GTK_STATE_NORMAL].red;
  og = style->bg[GTK_STATE_NORMAL].green;
  ob = style->bg[GTK_STATE_NORMAL].blue;
		
  if(or != r || og != g || ob != b)
  {
  	style = gtk_style_copy (style);
	for (i = 0; i < 5; i++)
	{
	  /* We do not change the color when GTK_STATE_SELECTED
	   * because of EV_TEXT_AREA */
	  if (i != 3)
	  {
	    style->bg[i].red = r;
	    style->bg[i].green = g;
	    style->bg[i].blue = b;	
	  }
	}
//	gtk_widget_set_style(GTK_WIDGET(widget), style);	
	SetStyleRecursively(widget, (gpointer) style);
	
  }
		
}

void c_gtk_widget_get_bg_color (GtkWidget *widget, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b)
{
		GtkStyle* style;
		style = GTK_WIDGET(widget)->style;
		
		*r = style->bg[GTK_STATE_NORMAL].red;
		*g = style->bg[GTK_STATE_NORMAL].green;
		*b = style->bg[GTK_STATE_NORMAL].blue;

		*r /= 257; *g /= 257; *b /= 257;
}


void c_gtk_widget_set_fg_color (GtkWidget* widget, int r, int g, int b)
{
  GtkStyle* style;
  int or, og, ob;
  int i;

  style = gtk_widget_get_style(GTK_WIDGET(widget));

  r *= 257; g *= 257; b *= 257;
		
  or = style->fg[GTK_STATE_NORMAL].red;
  og = style->fg[GTK_STATE_NORMAL].green;
  ob = style->fg[GTK_STATE_NORMAL].blue;
		
  if(or != r || og != g || ob != b) {
    for (i = 0; i < 5; i++)
	{
	  style->fg[i].red = r;
	  style->fg[i].green = g;
	  style->fg[i].blue = b;
	  style->text[i].red = r;
	  style->text[i].green = g;
	  style->text[i].blue = b;  
	}
	
	//gtk_widget_set_style(GTK_WIDGET(widget), style);
	SetStyleRecursively(widget, (gpointer) style);
  }
}


void c_gtk_widget_get_color_info (GtkWidget* widget,
	EIF_INTEGER *fgr,
	EIF_INTEGER *fgg,
	EIF_INTEGER *fgb,
	EIF_INTEGER *fgpix,
	EIF_INTEGER *textr,
	EIF_INTEGER *textg,
	EIF_INTEGER *textb,
	EIF_INTEGER *textpix,
	EIF_INTEGER *bgr,
	EIF_INTEGER *bgg,
	EIF_INTEGER *bgb,
	EIF_INTEGER *bgpix,
	EIF_INTEGER *baser,
	EIF_INTEGER *baseg,
	EIF_INTEGER *baseb,
	EIF_INTEGER *basepix,
	EIF_INTEGER *blackr,
	EIF_INTEGER *blackg,
	EIF_INTEGER *blackb,
	EIF_INTEGER *blackpix,
	EIF_INTEGER *whiter,
	EIF_INTEGER *whiteg,
	EIF_INTEGER *whiteb,
	EIF_INTEGER *whitepix
	)
{
		GtkStyle* style;
		style = GTK_WIDGET(widget)->style;

		*fgr = style->fg[GTK_STATE_NORMAL].red;
		*fgg = style->fg[GTK_STATE_NORMAL].green;
		*fgb = style->fg[GTK_STATE_NORMAL].blue;
		*fgpix = style->fg[GTK_STATE_NORMAL].pixel;

		*fgr /= 257; *fgg /= 257; *fgb /= 257; *fgpix /= 257;

		*textr = style->text[GTK_STATE_NORMAL].red;
		*textg = style->text[GTK_STATE_NORMAL].green;
		*textb = style->text[GTK_STATE_NORMAL].blue;
		*fgpix = style->text[GTK_STATE_NORMAL].pixel;

		*textr /= 257; *textg /= 257; *textb /= 257; *textpix /= 257;

		*bgr = style->bg[GTK_STATE_NORMAL].red;
		*bgg = style->bg[GTK_STATE_NORMAL].green;
		*bgb = style->bg[GTK_STATE_NORMAL].blue;
		*bgpix = style->bg[GTK_STATE_NORMAL].pixel;

		*bgr /= 257; *bgg /= 257; *bgb /= 257; *bgpix /= 257;

		*baser = style->base[GTK_STATE_NORMAL].red;
		*baseg = style->base[GTK_STATE_NORMAL].green;
		*baseb = style->base[GTK_STATE_NORMAL].blue;
		*basepix = style->base[GTK_STATE_NORMAL].pixel;

		*baser /= 257; *baseg /= 257; *baseb /= 257; *basepix /= 257;

		*blackr = style->black.red;
		*blackg = style->black.green;
		*blackb = style->black.blue;
		*blackpix = style->black.pixel;

		*blackr /= 257; *blackg /= 257; *blackb /= 257; *blackpix /= 257;

		*whiter = style->white.red;
		*whiteg = style->white.green;
		*whiteb = style->white.blue;
		*whitepix = style->white.pixel;

		*whiter /= 257; *whiteg /= 257; *whiteb /= 257; *whitepix /= 257;

}

void c_gtk_widget_get_fg_color (GtkWidget* widget, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b)
{
		GtkStyle* style;
		style = GTK_WIDGET(widget)->style;
/*
		*r = style->text[GTK_STATE_NORMAL].red;
		*g = style->text[GTK_STATE_NORMAL].green;
		*b = style->text[GTK_STATE_NORMAL].blue;

		*r /= 257; *g /= 257; *b /= 257;
*/
*r = style->fg[GTK_STATE_NORMAL].red;
*g = style->fg[GTK_STATE_NORMAL].green;
*b = style->fg[GTK_STATE_NORMAL].blue;

		*r /= 257; *g /= 257; *b /= 257;
}
