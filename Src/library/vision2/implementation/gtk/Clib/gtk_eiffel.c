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


static void c_gtk_widget_show_children_recurse (GtkWidget *widget,
					      gpointer   client_data);

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
    (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));
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

    if (pcbd->ev_data != NULL)
    {
	/* Call Eiffel routine 'set_event_data' to transfer the event data
	   to Eiffel */
	(pcbd->set_event_data)(eif_access(pcbd->ev_data), ev); 
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
	(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));
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
    hfree(pcbd->obj);
    hfree(pcbd->argument);
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

gint c_gtk_signal_connect (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click)
{
    callback_data_t *pcbd;
    int name_len;

    /* Deallocation of this block is done when the */
    /* the signal is destroyed (see c_gtk_signal_destroy_data) */
    pcbd = malloc (sizeof (callback_data_t));
    /* Return the pointer of the allocated block to Eiffel, so it
       can be deallocated later
    */
    /* do not allow the garbage collection of  object and argument */
    pcbd->rtn = execute_func;
    pcbd->obj = henter (object);
    pcbd->argument = henter (argument);
    pcbd->ev_data = henter (ev_data);
    pcbd->set_event_data = event_data_rtn;
    pcbd->mouse_button = mouse_button;
    pcbd->double_click = double_click;  
    /*  printf ("connect rtn= %d object= %d pcbd= %d\n", pcbd->rtn, (pcbd->obj), pcbd); */

    /* allow the garbage collection of object and argument, when the signal is destroyed */ 
    gtk_signal_set_funcs (NULL, (GtkSignalDestroy)c_gtk_signal_destroy_data);

    /* Look at the signal name to check whether it ends with "*_event" */
    name_len = strlen (name);
    if (name_len > 6)
    {
	if (strcmp (&name [name_len - 6], "_event") == 0)
	    return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(c_event_callback), 
					(gpointer)pcbd));		
    }
    return (gtk_signal_connect (widget, name, 
				GTK_SIGNAL_FUNC(c_signal_callback), 
				(gpointer)pcbd));
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
 * Function `c_gtk_widget_x'
 *          `c_gtk_widget_y'
 *
 * Note : Return the x and y coordinates of a widget
 * Note2 : The gtk function sent an `signed short' (gint16), but it 
 *         seems compatible with the EIF_INTEGER.
 *
 * Author : Leila
 *
 *********************************/

EIF_INTEGER c_gtk_widget_x (GtkWidget *w) 
{
  if (!GTK_WIDGET_VISIBLE (w))
    gtk_widget_size_allocate (w, &w->allocation);
  return (GTK_WIDGET(w)->allocation.x);
}

EIF_INTEGER c_gtk_widget_y (GtkWidget *w) 
{
  if (!GTK_WIDGET_VISIBLE (w))
    gtk_widget_size_allocate (w, &w->allocation);
  return (GTK_WIDGET(w)->allocation.y);
}

/*********************************
 *
 * Function `c_gtk_widget_width'
 *          `c_gtk_widget_height'
 *
 * Note : Return the width and the height of a widget
 *
 * Author : Samik
 *
 *********************************/

EIF_INTEGER c_gtk_widget_width (GtkWidget *w) 
{
  //  GtkRequisition r;
   //  gtk_widget_size_request (w, &r);
   //  return r.width;
   //    return (GTK_WIDGET(w)->requisition.width);
  if (!GTK_WIDGET_VISIBLE (w))
    gtk_widget_queue_resize (w);
  return (GTK_WIDGET(w)->allocation.width);
}

EIF_INTEGER c_gtk_widget_height (GtkWidget *w) 
{
  //   GtkRequisition r;
   //gtk_widget_size_request (w, &r);
  // return r.height;
  //return (GTK_WIDGET(w)->requisition.height);
  if (!GTK_WIDGET_VISIBLE (w))
    gtk_widget_queue_resize (w);
   return (GTK_WIDGET(w)->allocation.height);
}

/*********************************
 *
 * Function `c_gtk_widget_minimum_width'
 *          `c_gtk_widget_minimum_height'
 *
 * Note : Return the minimum width and height of a widget
 *
 * Author : Samik
 *
 *********************************/

EIF_INTEGER c_gtk_widget_minimum_width (GtkWidget *w) 
{
    GtkRequisition r;
    gtk_widget_size_request (w, &r);
    return r.width;
}

EIF_INTEGER c_gtk_widget_minimum_height (GtkWidget *w) 
{
    GtkRequisition r;
    gtk_widget_size_request (w, &r);
    return r.height;
}

/*********************************
 *
 * Function `c_gtk_widget_set_size'
 *
 * Note : Allocates the widget size
 *
 * Author : Samik
 *
 *********************************/

void c_gtk_widget_set_size (GtkWidget *w, int width, int height) 
{
    GtkAllocation a;
    a.width = width;
    a.height = height;

    gtk_widget_size_allocate (w, &a);
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

    cbd = malloc (sizeof (callback_data_t));
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
 * Function : `c_gtk_create_message_d_buttons'
 *
 * Note : Create message dialog buttons
 *
 *********************************/

void c_gtk_create_message_d_buttons (GtkWidget *dialog, GtkWidget *ok,
				     GtkWidget *cancel, GtkWidget *help)
{
    gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dialog)->action_area), ok,
			TRUE, TRUE, 0);
    gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dialog)->action_area), cancel,
			TRUE, TRUE, 0);
    gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dialog)->action_area), help,
			TRUE, TRUE, 0);
}

/*********************************
 *
 * Function : `c_gtk_create_message_d_label'
 *
 * Note : Message dialog text
 *
 *********************************/

void c_gtk_create_message_d_label (GtkWidget *dialog, GtkWidget *label)
{
    gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dialog)->vbox), label, TRUE,
			TRUE, 0);
}

/*********************************
 *
 * Function : `c_gtk_create_button_with_label'
 *
 * out : label_widget pointer to buttons label widget
 * in  : label_text  text of label
 *
 *********************************/

/*GtkWidget* c_gtk_create_button_with_label (GtkWidget *label_widget,
					  const gchar *label_text)
{
    GtkWidget *button;

    button = gtk_button_new ();
    label_widget = gtk_label_new (label_text);
    gtk_misc_set_alignment (GTK_MISC (label_widget), 0.5, 0.5);
    
    gtk_container_add (GTK_CONTAINER (button), label_widget);
    gtk_widget_show (label_widget);
    
    return button;
}
*/

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
 * Function : `c_gtk_widget_show_children'
 *
 * Note : Show the children of widget recursively
 *
 *********************************/

void c_gtk_widget_show_children (GtkWidget *widget)
{
    g_return_if_fail (widget != NULL);
    
    if (GTK_IS_CONTAINER (widget))
	gtk_container_foreach (GTK_CONTAINER (widget),
			       c_gtk_widget_show_children_recurse,
			       NULL);
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
 * Data : `xpm_data'
 *
 * Note : Data for empty pixmap of size 1x1
 *
 *********************************/

static char * xpm_data[] = {
      "1 1 1 1",
      "       c None",
      " "};

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
    if (widget->window == NULL)
	gtk_widget_realize (widget);
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
    if (widget->window == NULL)
	gtk_widget_realize (widget);
    pixmap = gdk_pixmap_create_from_xpm (widget->window,
					 &mask, 
					 &widget->style->bg[GTK_STATE_NORMAL],
					 fname);
    return (gtk_pixmap_new (pixmap, mask));
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

    style = gtk_widget_get_style (pixmap_parent);
    gdk_pixmap = gdk_pixmap_create_from_xpm (pixmap_parent->window,
					     &mask,
					     &style->bg[GTK_STATE_NORMAL],
					     file_name);
    
    gtk_pixmap_set (pixmap, gdk_pixmap, mask);
}

/*********************************
 *
 * Function : `c_gtk_add_list_item'
 *
 * Note : Add a listItem in a list. The item is first added in a Glist,
 *        then the Glist is added to the list.
 *
 * Author : Leila
 *
 *********************************/

void c_gtk_add_list_item (GtkWidget *list, GtkWidget *item)
{
	GList *glist;
	
	glist=NULL;
	glist=g_list_append(glist, item);
	gtk_list_append_items (GTK_LIST(list), glist);
	gtk_widget_show(item);
}

/*********************************
 *
 * Function : `c_gtk_widget_show_children_recurse'
 *
 * Note : static functions
 *
 *********************************/

static void c_gtk_widget_show_children_recurse (GtkWidget *widget,
                                  gpointer   client_data)
{
    gtk_widget_show (widget);
    c_gtk_widget_show_children (widget);
}

/*********************************
 *
 * Function : `c_gtk_table_rows'
 *            `c_gtk_table_columns'
 *
 * Note : Give the number of rows and columns of
 *        a table.
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

