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

/*==============================================================================
 Some functions signatures
--------------------------------------------------------------------------------
 This part was created because some functions in this file use other functions
 in this same file.
 We declare them so the functions order does not matter.
==============================================================================*/

rt_public void c_gtk_widget_set_bg_color (GtkWidget * widget, int r, int g, int b);
rt_public EIF_POINTER c_gtk_widget_top_window (GtkWidget *);

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
 * Function `c_gtk_events_process_events_queue'
 *
 * Note :  Process all the events in the events queue.
 * 
 * Author: Alex.
 *
 *********************************/

void c_gtk_events_process_events_queue ()
{
  while (gtk_events_pending())
	gtk_main_iteration();	
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

/* To be placed in another file such as gtk_eiffel_event.c */
/* The following functions have been created because the callback functions associated
 * to them need to have a specific signature.
 * We shall put them in another file (such as gtk_eiffel_event.c).
 */

/* For Multi column List */
void mclist_click_column_callback(GtkWidget *clist,
                               gint column,
                               gpointer data)
{
    callback_data_t *pcbd;
	
    pcbd = (callback_data_t *)data;

	/* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
    /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
    /*printf("c_signal_callback (%d, %d)\n", w, data); */
    (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
}

gboolean mouse_enter_set_cursor (GtkWidget *widget, GdkEventCrossing *event, gpointer cursor)
{
	gdk_window_set_cursor (widget->window, cursor);
	return TRUE;
}

gint c_gtk_widget_set_cursor (GtkWidget *widget, gpointer cursor)
{
	if (c_gtk_widget_displayed (widget)) {gdk_window_set_cursor (widget->window, cursor);}

	return gtk_signal_connect (GTK_OBJECT (widget), "enter-notify-event",
	GTK_SIGNAL_FUNC (mouse_enter_set_cursor), cursor);
}



gint timeout_callback (gpointer data){
	//Callback called when a GtkTimeout is set
	callback_data_t *pcbd;

	//Retrieve locally the callback data
	pcbd = (callback_data_t *)data;

	//Call Eiffel callback
	(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument),
		    eif_access(pcbd->ev_data));

	//Return non-zero value to Gtk to recall timeout callback in `n' milliseconds
	return 1;
}

void toggle_button_state_selection_callback(GtkToggleButton *togglebutton, gpointer data){
	callback_data_t *pcbd;
	int signal_type;
	//Signal type is either 1, 2 or 3
	//states :   Toggled = 1
	//	    Selected (toggle on) = 2
	//	    Unselected (toggle off) = 3
	//	    Radio toggle button callback = 4
	gboolean toggled;
	
	pcbd = (callback_data_t *)data;
	signal_type = (int)(pcbd->extra_data);
	toggled = togglebutton->active;

	if (signal_type == 4)
	{
		//if (toggled == 1)
		{
		//Radio Toggle button callback	
		(pcbd->rtn)(eif_access(pcbd->obj),
		eif_access(pcbd->argument),
	    	eif_access(pcbd->ev_data));
		}
	}

	if (signal_type == 1)
	{
	//Call toggled routine
		(pcbd->rtn)(eif_access(pcbd->obj),
		eif_access(pcbd->argument),
	    	eif_access(pcbd->ev_data));

	}
	else if (signal_type == 2)
	{
	//Call selected routine if button is selected (toggle on)
		if (toggled == 1)
		{
			//If button is selected then call callback
			(pcbd->rtn)(eif_access(pcbd->obj),
 			eif_access(pcbd->argument),
    			eif_access(pcbd->ev_data));
	
		}
	}
	else if (signal_type == 3)
	{
	//Call unselected routine if button is unselected (toggle off)
		if (toggled == 0)
		{
			//If button is unselected then call callback
			(pcbd->rtn)(eif_access(pcbd->obj),
			eif_access(pcbd->argument),
			eif_access(pcbd->ev_data));
		}
	}
}
	
		
void mclist_row_selection_callback(GtkWidget *clist,
                               gint row,
                               gint column,
                               GdkEventButton *event,
                               gpointer data)
{
    callback_data_t *pcbd;
	int row_index;
	
    pcbd = (callback_data_t *)data;

	/* The index of the row */
	row_index = (int)(pcbd->extra_data) - 1;

	if (row == row_index || row_index == -1)
	{    
	  /* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
      /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
	  /*printf("c_signal_callback (%d, %d)\n", w, data); */
	  (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
	}
}

/* For CTree .*/

void ctree_row_selection_callback(GtkCTree *ctree,
                               GtkCTreeNode *row,
                               gint column,
                               gpointer data)
{
    callback_data_t *pcbd;
	GtkCTreeNode *node;
	
    pcbd = (callback_data_t *)data;

	/* The index of the row */
	node = (GtkCTreeNode *) pcbd->extra_data;
		
	if ((node == row) || (node == NULL))
	{    
	  /* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
      /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
	  /*printf("c_signal_callback (%d, %d)\n", w, data); */
	  (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
	}
	
}

void ctree_row_subtree_callback(GtkCTree *ctree,
                               GtkCTreeNode *row,
                               gpointer data)
{
    callback_data_t *pcbd;
	GtkCTreeNode *node;
	
    pcbd = (callback_data_t *)data;

	/* The index of the row */
	node = (GtkCTreeNode *) pcbd->extra_data;
		
	if ((node == row) || (node == NULL))
	{    
	  /* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
      /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
	  /*printf("c_signal_callback (%d, %d)\n", w, data); */
	  (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
	}
	
}

/* For Text*/
void text_insert_text_callback(GtkEditable *editable,
								const gchar *text,
								gint length,
								gint *position,
								gpointer data)
{
    callback_data_t *pcbd;
	
    pcbd = (callback_data_t *)data;

	if (pcbd->ev_data != NULL)
    {
	  /* Call Eiffel routine 'set_event_data' to transfer the event data
	   to Eiffel */
	  (pcbd->set_event_data)(eif_access(pcbd->ev_data_imp), position); 
    }

	/* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
    /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
    /*printf("c_signal_callback (%d, %d)\n", w, data); */
    (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
}

void text_delete_text_callback(GtkEditable *editable,
								gint start,
								gint end,
								gpointer data)
{
    callback_data_t *pcbd;
	
    pcbd = (callback_data_t *)data;

	/* Call Eiffel routine 'rtn' of object 'obj' with argument 'argument' */
    /*(pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument));*/
    /*printf("c_signal_callback (%d, %d)\n", w, data); */
    (pcbd->rtn)(eif_access(pcbd->obj), eif_access(pcbd->argument), eif_access(pcbd->ev_data));
}


/* For List */
void list_selection_child_callback(GtkList *list,
								GtkWidget *child,
								gpointer data)
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
 * Function `c_gtk_signal_connect_general'
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
 * > extra_data = extra information needed.
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
			   EIF_REFERENCE object,
			   EIF_REFERENCE argument,
			   EIF_REFERENCE ev_data,
			   EIF_REFERENCE ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click,
			   int after,
			   gpointer extra_data)
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

	pcbd->extra_data = extra_data;

   
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
			

			/* TEST: the callback signature depends on the events */
			if ((strcmp(name, "select_row") == 0) ||
					(strcmp(name, "unselect_row") == 0))
			{
				/* We need to store the index of the row
				 * so we put it in the mouse_button */
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(mclist_row_selection_callback), 
					(gpointer)pcbd));	
			}
			else
			if (strcmp(name, "click_column") == 0)
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(mclist_click_column_callback), 
					(gpointer)pcbd));
			}
			else
			if ((strcmp(name, "tree_select_row") == 0) || (strcmp(name, "tree_unselect_row") == 0))
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(ctree_row_selection_callback), 
					(gpointer)pcbd));
			}
			else
			if ((strcmp(name, "tree_expand") == 0) || (strcmp(name, "tree_collapse") == 0))
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(ctree_row_subtree_callback),
					(gpointer)pcbd));
			}
			else
			if (strcmp(name, "insert_text") == 0)
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(text_insert_text_callback), 
					(gpointer)pcbd));
			}
			else
			if (strcmp(name, "delete_text") == 0)
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(text_delete_text_callback), 
					(gpointer)pcbd));
			}
			else
			if ((strcmp(name, "select_child") == 0) || (strcmp(name, "unselect_child")) == 0)
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(list_selection_child_callback), 
					(gpointer)pcbd));
			}
			if (strcmp(name, "radio_toggle") == 0)
			{
				return (gtk_signal_connect (widget, "toggled", 
					GTK_SIGNAL_FUNC(toggle_button_state_selection_callback), 
					(gpointer)pcbd));

			}	
			if (strcmp(name, "toggled_on_off") == 0)
			{
				return (gtk_signal_connect (widget, "toggled", 
					GTK_SIGNAL_FUNC(toggle_button_state_selection_callback), 
					(gpointer)pcbd));

			}		
			if (strcmp(name, "toggled_on") == 0)
			{
				return (gtk_signal_connect (widget, "toggled", 
					GTK_SIGNAL_FUNC(toggle_button_state_selection_callback), 
					(gpointer)pcbd));			
			}
			if (strcmp(name, "toggled_off") == 0)
			{
				return (gtk_signal_connect (widget, "toggled", 
					GTK_SIGNAL_FUNC(toggle_button_state_selection_callback), 
					(gpointer)pcbd));			
			}
			if (strcmp(name, "timeout") == 0)
			{
				// Create timeout with interval(extra_data) , callback funct and pcbd data
				return (gtk_timeout_add ((guint32) extra_data,
					(GtkFunction) timeout_callback,
					(gpointer)pcbd));
			}
			else
			{
				return (gtk_signal_connect (widget, name, 
					GTK_SIGNAL_FUNC(c_signal_callback), 
					(gpointer)pcbd));
			}
		}
	}
}

gint c_gtk_signal_connect (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_REFERENCE object,
			   EIF_REFERENCE argument,
			   EIF_REFERENCE ev_data,
			   EIF_REFERENCE ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click,
			   gpointer extra_data)
{
	gchar tmp_name[40]; /* The name of the signals must be smaller than 40 characters otherwise
						   we need to allocate bigger space. */
	
	strcpy (tmp_name, name);
	
	return c_gtk_signal_connect_general (widget, tmp_name, execute_func, object, argument, ev_data, ev_data_imp, event_data_rtn, mouse_button, double_click, 0, extra_data);
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
	//return c_gtk_signal_connect_general (widget, name, execute_func, object, argument, ev_data, ev_data_imp, event_data_rtn, mouse_button, double_click, 1, extra_data);
	return c_gtk_signal_connect_general (widget, name, execute_func, object, argument, ev_data, ev_data_imp, event_data_rtn, mouse_button, double_click, 1, NULL);
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
 * Function `c_gtk_object_class_user_signal_new'
 *
 * Note :  Register a new signal for the given widget.
 * 
 * Author: Alex.
 *
 *********************************/

EIF_INTEGER c_gtk_object_class_user_signal_new (GtkObject *object, const gchar *signal_name)
{
  guint i;
  GQuark quark;
  gchar *name;
  
  /* Create a new signal for the given GtkObject
   * 
   * argument 	3: specify that the signal can be emitted by the user.
   * 			4: specify the marshaler, in this case the callback has no parameter.
   * 			5: no return value for the callback.
   * 			6: no more following argument for function 'gtk_object_class_user_signal_new'.
   */
  name = g_strdup (signal_name);
  quark = gtk_signal_lookup (name, object->klass->type);
  /* We test if there is already a signal with this name. If so, we do not do anything.*/
  
  if (!quark)
  {
    i = gtk_object_class_user_signal_new  (object->klass,
					   signal_name,
					   GTK_RUN_ACTION,
					   gtk_marshal_NONE__NONE,
					   GTK_TYPE_NONE, 0);
  }
  else
		i = 1;
		/* We just give a positive value to ensure that everything went ok 
		 * (even if we did not add the signal as it already exists.
		 */
  
  return i;
}		

 /*********************************
 *
 * Function `c_gtk_widget_add_accelerator'
 *
 * Note :  Add an accelerator to the widget with the given name.
 * 
 * Author: Alex.
 *
 *********************************/

void c_gtk_widget_add_accelerator (GtkWidget *widget, const gchar *signal_name,guint keycode, gboolean shift_mask, gboolean control_mask, gboolean alt_mask)
{
  GtkAccelGroup *accel_group;
  GtkWindow *window;
  guint mask;

  window = GTK_WINDOW (c_gtk_widget_top_window (widget));
  if (window)
  {
    accel_group = gtk_accel_group_new ();
    gtk_window_add_accel_group(GTK_WINDOW (window), accel_group);
  }
  else	
  {
	  printf ("Error in creating the accelerator group.");
  }
  
  /* Determine the mask. */
  mask = 0;
  if (shift_mask)
  {
	  mask = mask | GDK_SHIFT_MASK;
  }
  if (control_mask)
  {
	  mask = mask | GDK_CONTROL_MASK;
  }
  if (alt_mask)
  {
	  /* No mask for alt yet.
	   * mask = mask | GDK_;
	   */
  }

  gtk_widget_add_accelerator(GTK_WIDGET (widget), signal_name, accel_group, keycode, mask, 0);
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
 * Function `c_gtk_widget_grab_focus'	(1)
 *
 * Note : 	(1) Grab the focus
 *
 *********************************/

void c_gtk_widget_grab_focus (GtkWidget *widget)
{
//	GTK_WIDGET_SET_FLAGS(widget, GTK_CAN_FOCUS);

	gtk_widget_grab_focus (widget);	
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
 * Function `c_gtk_widget_displayed'
 *
 * Note : Is widget visible visible on the screen?
 *
 * Author : Alex
 *
 *********************************/

EIF_BOOLEAN c_gtk_widget_displayed (GtkWidget *wid) 
{
  gint bool;
	
  if (GTK_WIDGET_VISIBLE (wid))
  {
	  if (GTK_IS_WINDOW (wid->parent))
	  {
		if (GTK_WINDOW (wid->parent)->type == GTK_WINDOW_TOPLEVEL)
		{
		  if GTK_WIDGET_VISIBLE (wid->parent)
			  bool = 1;
		  else
			  bool = 0;
		}
		else
		  bool = c_gtk_widget_displayed (wid->parent);
	  }
	  else
		bool = c_gtk_widget_displayed (wid->parent);
  }
  else
	bool = 0;	
  
  return (EIF_BOOLEAN) bool;
}

/*********************************
 *
 * Function `c_gtk_widget_top_window'
 *
 * Note : GtkWindow of the given widget.
 *
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_widget_top_window (GtkWidget *wid) 
{
  GtkWindow *top_window = (GtkWindow *) 0;
	
  while (top_window == NULL)
  {
	if (GTK_IS_WINDOW (wid->parent))
	{
	  if ((GTK_WINDOW (wid->parent)->type == GTK_WINDOW_TOPLEVEL))
	  {
	    top_window = GTK_WINDOW (wid->parent);
  	  }
	}
	else
	  wid = wid->parent; 
  }
  return (EIF_POINTER) wid->parent;
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

EIF_INTEGER c_gtk_absolute_x (GtkWidget *w)
{
	gint x;
	GtkWidget *window;

	window = (GtkWidget *) c_gtk_widget_top_window (w);


	if GTK_WIDGET_VISIBLE(w)
	{
	gdk_window_get_position (window->window, &x, NULL);
		
		return x;
	}
	else
		return (-1);
}

EIF_INTEGER c_gtk_absolute_y (GtkWidget *w)
{
	gint y;
	GtkWidget *window;

	window = (GtkWidget *) c_gtk_widget_top_window (w);


	if GTK_WIDGET_VISIBLE(w)
	{
	gdk_window_get_position (window->window, NULL, &y);
		
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
  
  if (width < 0)
	allocation.width = 0;
  else
	allocation.width = width;

  if (height < 0)
	allocation.height = 0;
  else
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
 * Function : `c_gtk_container_nb_children' 		(1)
 *  		  `c_gtk_container_ith_child'   		(2)
 *  		  `c_gtk_container_has_child'			(3)
 *  		  `c_gtk_container_set_bg_pixmap'		(4)
 *  		  `c_gtk_container_remove_all_children'	(5)
 *  		            
 * Note (1) : Return the number of children of a container.
 * 		(2)	: Return the i-th child of the container.
 * 		(3) : Tell if the given widget is a child of the container.
 * 		(4) : Set the container background pixmap to the given one.
 * 		(5) : Remove all the children contained in the container.
 * 
 * Author : Leila, Alex
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

void c_gtk_container_set_bg_pixmap (GtkWidget *container, GtkWidget *pixmap)
{
  GtkStyle *widgetStyle;
  int i;
  
  widgetStyle = gtk_style_copy (GTK_WIDGET (container)->style);
  
  for (i = 0; i < 5; i++)
  {
	widgetStyle->bg_pixmap[i] = GTK_PIXMAP (pixmap)->pixmap;
  }
 
  /* --- Set the style of the widget --- */
  gtk_widget_set_style (GTK_WIDGET (container), widgetStyle);
}

void c_gtk_container_remove_all_children (GtkContainer *container)
{
	GList *children;
	GtkWidget *item;
	
	children = gtk_container_children (container);

	while (children)
    {
      item = GTK_WIDGET (children->data);
 	  gtk_container_remove (container, item);
      children = children->next;
    }
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
 * Function : `c_gtk_option_button_selected_menu_item'	(1)
 *			  `c_gtk_option_button_index_of_menu_item'	(2)
 *			  `c_gtk_option_button_set_fg_color'		(3)
 *			  `c_gtk_option_button_set_bg_color'		(4)
 *			  
 * Note : (1) Current selected menu item
 *		  (2) Give the position of the menu_item in the menu
 *		  		inside the option button. The position is needed by 
 *		  		`gtk_option_menu_set_history'.
 *		  (3) Set the foreground colors of the option menu. We need a specific
 *		  		function because we have to set the color for the GtkOptionMenu's child too.
 *		  (4) Set the background colors of the option menu. We need a specific
 *		  		function because we have to set the color for the GtkOptionMenu's child too.
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

void c_gtk_option_button_set_fg_color (GtkOptionMenu *option, gint r, gint g, gint b)
{
	c_gtk_widget_set_fg_color ((GtkWidget *) option, r, g, b);
	if (((GtkBin *) option)->child != NULL)
		c_gtk_widget_set_fg_color ((GtkWidget *) ((GtkBin *) option)->child, r, g, b);	
}

void c_gtk_option_button_set_bg_color (GtkOptionMenu *option, gint r, gint g, gint b)
{
	c_gtk_widget_set_bg_color ((GtkWidget *) option, r, g, b);
	if (((GtkBin *) option)->child != NULL)
		c_gtk_widget_set_bg_color ((GtkWidget *) ((GtkBin *) option)->child, r, g, b);	
}

/*********************************
 *
 * Function : `c_gtk_menu_remove_all_items' (1)
 * 			  `c_gtk_menu_get_child'		(2)
 * 			  `c_gtk_menu_nb_children'		(3)
 *			  
 * Note : (1) remove all the menu items of the given menu. 
 * 		  (2) Pointer of to the child of the menu at the given position.
 * 		  (3) Number of children of the menu.
 * 
 *********************************/


	
void c_gtk_menu_remove_all_items (GtkMenu *menu)
{
	GtkMenuShell *menu_shell;
	GList *children;
	GtkWidget *item;
	
	menu_shell = GTK_MENU_SHELL (menu);
	children = menu_shell->children;
	
	while (children)
    {
      item = GTK_WIDGET (children->data);
      children = children->next;
 	  gtk_container_remove (GTK_CONTAINER (menu), item);
    }
}

EIF_POINTER c_gtk_menu_get_child (GtkMenu *menu, gint i)
{
  GtkMenuShell *menu_shell;

  menu_shell = GTK_MENU_SHELL (menu);
  return g_list_nth_data (menu_shell->children, i);   
}

EIF_INTEGER c_gtk_menu_nb_children (GtkMenu *menu)
{
  GtkMenuShell *menu_shell;

  menu_shell = GTK_MENU_SHELL (menu);
  return g_list_length (menu_shell->children);   
 
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

GdkCursor *c_gtk_create_cursor_with_pixmap (char *fname, gint X, gint Y)
{

	GtkWidget *create_window;
	GdkCursor *cursor;
	GdkBitmap *pixmap;
	GdkBitmap *mask;
	//GdkColor fg = { 0, 0, 0, 0 }; /* Red. */
	//GdkColor bg = { 0, 65535, 65535, 65535 }; /* Blue. */
	int  this_function_needs_implementing;

	create_window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
	gtk_widget_realize (create_window);

  	pixmap = gdk_pixmap_create_from_xpm (create_window->window,
					&mask,
					&create_window->style->bg[GTK_STATE_NORMAL],
					fname);

	//cursor = gdk_cursor_new_from_pixmap (pixmap, mask, &fg, &bg, X, Y);
	//This line of code is incorrect

	cursor = gdk_cursor_new (54);
	

	//gdk_pixmap_unref (pixmap);
	//gdk_pixmap_unref (mask);

	return cursor;
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
	/* create GtkPixmap from GdkPixmap of def. size
	   and put Mask (with all 1's) on. */
	GdkPixmap *pixmap;
        GdkBitmap *mask;
	GdkColor mask_pattern;
	GdkGC *gc;

	if (!GTK_WIDGET_REALIZED(window_parent)) {
		gtk_widget_realize (window_parent);
	}	
	
      	mask = gdk_pixmap_new (window_parent->window, width, height, 1);
      	gc = gdk_gc_new (mask);
      	mask_pattern.pixel = 0;
      	gdk_gc_set_foreground (gc, &mask_pattern);
      	gdk_draw_rectangle (mask, gc, TRUE, 0, 0, -1, -1);
 
	pixmap = (GdkPixmap *) gdk_pixmap_new(window_parent->window, width, height, -1);
	gc = gdk_gc_new(pixmap);
	mask_pattern.pixel = 1;
	gdk_gc_set_foreground(gc, &mask_pattern);
	gdk_draw_rectangle(pixmap, gc, TRUE, 0, 0, -1, -1);
	
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
 *  		  `c_gtk_clist_unset_pixmap	(6)
 *  		  `c_gtk_clist_title_shown	(7)
 *  		  `c_gtk_clist_column_width	(8)
 *  		            
 * Note (1) : Sets the foreground color of the given row.
 * 		(2) : Sets the background color of the given row.
 * 		(3) : Gets the foreground color of the given row.
 * 		(4) : Gets the background color of the given row.
 * 		(5) : Sets the pixmap and the text of the given row and column.
 * 		(6) : Unsets the pixmap of the given row and column.
 * 		(7) : Are the titles of the columns shown?
 * 		(8) : width of the given column.
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

EIF_BOOLEAN c_gtk_clist_title_shown (GtkCList *clist)
{
	return (EIF_BOOLEAN) GTK_CLIST_SHOW_TITLES (clist);
}

EIF_INTEGER c_gtk_clist_column_width (GtkCList *clist, gint column)
{
  GtkCListColumn *columns;
	
  columns = GTK_CLIST (clist)->column;

  /* Point to the 'column'th column */
  columns = columns + column;

  return (EIF_INTEGER) columns->width;
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
 * Function : `c_gtk_ctree_item_insert_node'			(1)
 *			  `c_gtk_ctree_item_is_expanded' 			(2)
 * 			  `c_gtk_ctree_set_single_selection_mode'	(3)
 * 			  `c_gtk_ctree_selected_item'				(4)
 * 			  `c_gtk_ctree_item_set_pixtext'			(5)
 * 			  `c_gtk_ctree_item_get_position_in_tree'	(6)
 *
 * Note : (1) Inserts a node in the ctree. 
 *		  (2) Is the tree Item expanded?
 *		  (3) Sets the ctree to single selection mode.
 *		  (4) Gives the selected item. 
 *		  (5) Sets the pixmap and text of the node.
 *		  (6) Gives the index in the given ctree of the given node.
 * 	
 * Author : Leila, Alex
 *
 *********************************/

EIF_POINTER c_gtk_ctree_insert_node (GtkCTree *ctree, GtkCTreeNode*parent, GtkCTreeNode*sibling, gchar *name, guint8 spacing, GdkPixmap* pix, GdkBitmap* mask, gboolean is_leaf, gboolean expanded)
{
  gchar *text[1];
  GtkCTreeNode *node;
  
  text[1] = name;

  node = gtk_ctree_insert_node (ctree, parent, sibling, text, spacing, pix, mask, pix, mask, is_leaf, expanded);

  return (EIF_POINTER) node; 
}

EIF_BOOLEAN c_gtk_ctree_item_is_expanded (GtkCTreeNode *node)
{
  return (EIF_BOOLEAN) ((GTK_CTREE_ROW (node))->expanded) ? 1: 0;
}

/*EIF_BOOLEAN c_gtk_tree_item_is_selected (GtkWidget *tree, GtkWidget *treeItem)
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
*/

void c_gtk_ctree_set_single_selection_mode (GtkCTree *ctree)
{
  gtk_clist_set_selection_mode (GTK_CLIST (ctree), GTK_SELECTION_SINGLE);
}

EIF_POINTER c_gtk_ctree_selected_item (GtkCTree *ctree)
{
  GList *list;

  list = (GTK_CLIST (ctree))->selection;
	
  if (list != NULL)
  {	
    if (list->data != NULL)
	{
	  return (EIF_POINTER) (list->data);
	}
	else return (EIF_POINTER) NULL; 	
  }
  else return (EIF_POINTER) NULL;

}

void c_gtk_ctree_item_set_pixtext (GtkCTree *ctree, GtkCTreeNode *node, gint column, GtkPixmap *p, gchar *txt, guint8 spacing)
{
  GdkPixmap *pix;
  GdkBitmap *mask;

  if (p != NULL)
  {
	mask = p->mask;
	pix = p->pixmap;
    gtk_ctree_node_set_pixtext (ctree, node, column, txt, spacing, pix, mask);
  } else
  gtk_ctree_node_set_pixtext (ctree, node, column, txt, spacing, NULL, NULL);
  
}

EIF_INTEGER c_gtk_ctree_item_get_position_in_tree (GtkCTree *ctree, GtkCTreeNode *node)
{
    return (EIF_INTEGER) g_list_index (GTK_CLIST (ctree)->row_list, (gpointer) (GTK_CTREE_ROW (node)));
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
 * Function :	`c_gtk_box_set_child_options'	(1)
 * 				`c_gtk_box_is_child_expandable'	(2)
 *
 * Note : (1) Change the options of a child in a box.
 * 		  (2) Is the child expandable?
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

EIF_BOOLEAN c_gtk_box_is_child_expandable (GtkWidget *box, GtkWidget *child)
{
  gint fill;
  gint expand;
  gint padding;
  GtkPackType pack_type;

  gtk_box_query_child_packing (GTK_BOX(box), child, &expand, &fill,
			       &padding, &pack_type);
  
  return (EIF_BOOLEAN) expand;
}

void c_gtk_box_set_child_expandable (GtkWidget *box, GtkWidget *child, gint flag)
{
  gint fill;
  gint old_expand;
  gint padding;
  GtkPackType pack_type;

  gtk_box_query_child_packing (GTK_BOX(box), child, &old_expand, &fill,
			       &padding, &pack_type);
  gtk_box_set_child_packing (GTK_BOX(box), child, flag, fill, padding, pack_type);
}

/*********************************
 *
 * Function : `c_gtk_statusbar_item_create_pixmap_place'	(1)
 *			  `c_gtk_statusbar_item_unset_pixmap'			(2)
 *			  `c_gtk_statusbar_item_set_bg_color'			(3)
 *			  	
 * Note : (1) The equivalent of `create_pixmap_place' in EV_PIXMAPABLE
 * 				to create the place in the box, where the pixmap will be placed.
 * 				Return the value of the pixmap pointer.
 *		  (2) Unsets the pixmap of the status bar item.	Remove the GtkPixmap
 *		  		the status bar, which will be destroyed (no more ref).
 *		  (3) Sets the background of the status bar item to the given color.
 *		  		Redefine because
 *		  		EV_STATUS_BAR_ITEM = gtk_statusbar (box) < gtk_frame < (gtk_pixmap + gtk_label)
 *		  		'<' = containing.
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

void c_gtk_statusbar_item_set_bg_color (GtkWidget *statusbar, int r, int g, int b)
{
  GtkWidget *hbox;
  GtkWidget *statusbar_frame;
  GtkWidget *statusbar_label;
	
  r *= 257; g *= 257; b *= 257;
  
  statusbar_label = GTK_STATUSBAR (statusbar)->label;
  hbox = GTK_WIDGET (statusbar_label)->parent;
  statusbar_frame = GTK_STATUSBAR (statusbar)->frame;
  
  /* set the background or the three widgets. */
  c_gtk_widget_set_bg_color (statusbar, r, g, b);
  c_gtk_widget_set_bg_color (hbox, r, g, b);
  c_gtk_widget_set_bg_color (statusbar_label, r, g, b);
  c_gtk_widget_set_bg_color (statusbar_frame, r, g, b);
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

/*==============================================================================
 gtk_toolbar functions
==============================================================================*/

/*********************************
 *
 * Function : `c_gtk_toolbar_new'			(1)
 *
 * Note : (1) Default creation of the toolbar.
 *
 * Author : King
 *
 *********************************/

EIF_POINTER c_gtk_toolbar_new_horizontal (void)
{
  return (EIF_POINTER) gtk_toolbar_new ( GTK_ORIENTATION_HORIZONTAL, GTK_TOOLBAR_BOTH);
}

/*==============================================================================
 gtk_progressbar functions
==============================================================================*/

/*********************************
 *
 * Function : `c_gtk_progress_bar_style'			(1)
 *            `c_gtk_progress_bar_new_with_adjustment		(2)
 *            `c_gtk_progress_bar_set_adjustment		(3)
 *            `c_gtk_progress_bar_set_step'			(4)
 *            `c_gtk_progress_bar_set_minimum			(5)
 *            `c_gtk_progress_bar_set_maximum			(6)
 *	      `c_gtk_progress_bar_get_step			(7)
 *	      `c_gtk_progress_bar_get_minimum			(8)
 *	      `c_gtk_progress_bar_get_maximum			(9)
 *
 * Note : (1) Style of the progress bar.
 *
 * Author : Alex (1,2,4)
 * 	  : King (4,5,6,7,8,9)
 *
 *********************************/

EIF_POINTER c_gtk_progress_bar_new_with_adjustment (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap)
{
  GtkAdjustment *adj;
  
  /* The page size is only relevant for scrollbars. */
  adj = (GtkAdjustment *) gtk_adjustment_new (value, min, max, step, leap, 0.0);

  return (EIF_POINTER) gtk_progress_bar_new_with_adjustment (adj);
}

EIF_INTEGER c_gtk_progress_bar_style (GtkWidget *progressbar)
{
	GtkProgressBarStyle style;
	
	style = (GTK_PROGRESS_BAR (progressbar))->bar_style;

	if (style != GTK_PROGRESS_CONTINUOUS)
	{
		return 1;
	}
	else
	return 0;	
}

void c_gtk_progress_bar_set_adjustment (GtkProgressBar *progressbar, gfloat value, gfloat min, gfloat max, gfloat step)
{ 
  GtkAdjustment *adj;
  
  adj = GTK_PROGRESS (progressbar)->adjustment;

  adj->value = value;
  adj->upper = max;
  adj->lower = min;
  adj->step_increment = step;

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}


void c_gtk_progressbar_set_step ( GtkProgressBar * bar, gfloat value)
{
  GtkAdjustment *adj;

  adj = bar->progress.adjustment;
  adj->step_increment = value;
  
  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */

  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

gfloat c_gtk_progressbar_get_step ( GtkProgressBar * bar)
{
  GtkAdjustment *adj;
  gfloat value;
  adj = bar->progress.adjustment;
  value = adj->step_increment;
  return value;
}
  

void c_gtk_progressbar_set_minimum ( GtkProgressBar * bar, gfloat value)
{
  GtkAdjustment *adj;

  adj = bar->progress.adjustment;
  adj->lower = value;

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */

  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

gfloat c_gtk_progressbar_get_minimum ( GtkProgressBar * bar)
{
   GtkAdjustment *adj;
   gfloat value;
   adj = bar->progress.adjustment;
   value = adj->lower;
   return value;
}

void c_gtk_progressbar_set_maximum ( GtkProgressBar * bar, gfloat value)
{
  GtkAdjustment *adj;

  adj = bar->progress.adjustment;
  adj->upper = value;
  
  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */

  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

gfloat c_gtk_progressbar_get_maximum ( GtkProgressBar * bar)
{
   GtkAdjustment *adj;
   gfloat value;
   adj = bar->progress.adjustment;
   value = adj->upper;
   return value;
}


/*==============================================================================
 File and directory selection functions
==============================================================================*/

/*********************************
 *
 * Function : `c_gtk_file_selection_get_file_name'	(1)
 * 			  `c_gtk_file_selection_get_dir'		(2)
 * 			  `c_gtk_file_selection_get_dir_name'	(3)
 * 			  `c_gtk_directory_selection_new'		(4)
 *
 * Note : (1) Value in the gtk_entry of the gtk_file_selection.
 * 		  (2) Dir name of the gtk_file_selection.
 * 		  (3) Dir name of the current selected directory (for directory selection dialog).
 * 		  (3) Create a directory selection (based on the GtkFileSelection).
 *
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_selection_get_selection_entry (GtkWidget *dialog)
{
  GtkEntry *entry;
	
  entry = (GtkEntry *)((GtkFileSelection *) dialog)->selection_entry;
  
  return (EIF_POINTER) gtk_entry_get_text (entry);
}

EIF_POINTER c_gtk_file_selection_get_dir (GtkWidget *file_dialog)
{
  GtkLabel *label;
  char *value;
  
  label = (GtkLabel*) ((GtkFileSelection *) file_dialog)->selection_text;
  
  gtk_label_get (label, &value);
  
  value = value + 11;
  
  return (EIF_POINTER) value; 
}

EIF_POINTER c_gtk_directory_selection_new (const gchar *name)
{
  GtkWidget *directory_selection;
  GtkWidget *file_list;
  GtkWidget *scroll;

  directory_selection = gtk_file_selection_new (name);
  
  /* Remove the file list */
  file_list = GTK_FILE_SELECTION (directory_selection)->file_list;
  scroll = file_list->parent;
  gtk_widget_hide (file_list);
  gtk_widget_hide (scroll);
  
  /* Remove the "delete file" and "rename file" buttons */
  gtk_widget_hide (GTK_FILE_SELECTION (directory_selection)->fileop_del_file);
  gtk_widget_hide (GTK_FILE_SELECTION (directory_selection)->fileop_ren_file);

  return (EIF_POINTER) directory_selection;	
}

/*==============================================================================
 Spin button functions
==============================================================================*/

/*********************************
 *
 * Function : 'c_gtk_spin_button_new'			(1)
 * 			  'c_gtk_spin_button_set_step'		(2)
 * 			  'c_gtk_spin_button_set_minimum'	(3)
 * 			  'c_gtk_spin_button_set_maximum'	(4)
 *
 * Note : (1) Create a new spin button with some options.
 * 		  (2) Set the step for the spin button.
 * 		  (3) Set the minimum for the spin button.
 * 		  (4) Set the maximum for the spin button.
 *
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_spin_button_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap)
{
  GtkAdjustment *adj;
  
  /* The page size is only relevant for scrollbars. */
  adj = (GtkAdjustment *) gtk_adjustment_new (value, min, max, step, leap, 0.0);

  return (EIF_POINTER) gtk_spin_button_new (adj, 0, 0);
}

void c_gtk_spin_button_set_step (GtkSpinButton *spinButton, gfloat step)
{
  GtkAdjustment *adj;
  
  adj = gtk_spin_button_get_adjustment ((GtkSpinButton *) spinButton);

  adj->step_increment = step;

//  gtk_spin_button_set_adjustment ((GtkSpinButton *) spinButton, adj);

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

void c_gtk_spin_button_set_minimum (GtkSpinButton *spinButton, gfloat min)
{
  GtkAdjustment *adj;
  
  adj = gtk_spin_button_get_adjustment ((GtkSpinButton *) spinButton);

  adj->lower = min;
//  gtk_spin_button_set_adjustment ((GtkSpinButton *) spinButton, adj);

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

void c_gtk_spin_button_set_maximum (GtkSpinButton *spinButton, gfloat max)
{
  GtkAdjustment *adj;
  
  adj = gtk_spin_button_get_adjustment ((GtkSpinButton *) spinButton);

  adj->upper = max;
//  gtk_spin_button_set_adjustment ((GtkSpinButton *) spinButton, adj);

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

/*==============================================================================
 gtk_range (vertical and horizontal) functions for EV_RANGE and EV_SCROLL_BAR
==============================================================================*/

/*********************************
 *
 * Function : 'c_gtk_range_set_step'	(1)
 * 			  'c_gtk_range_set_minimum'	(2)
 * 			  'c_gtk_range_set_maximum'	(3)
 * 			  'c_gtk_range_set_leap'	(4)
 *
 * Note : (1) Set the step for the range.
 * 		  (2) Set the minimum for the range.
 * 		  (3) Set the maximum for the range.
 * 		  (4) Set the leap for the range.
 *
 * Author : Alex
 *
 *********************************/

void c_gtk_range_set_step (GtkRange *range, gfloat step)
{
  GtkAdjustment *adj;
  
  adj = gtk_range_get_adjustment (range);

  adj->step_increment = step;
//  gtk_range_set_adjustment (range, adj); 

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

void c_gtk_range_set_minimum (GtkRange *range, gfloat min)
{
  GtkAdjustment *adj;
  
  adj = gtk_range_get_adjustment (range);

  adj->lower = min;
//  gtk_range_set_adjustment (range, adj); 

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

void c_gtk_range_set_maximum (GtkRange *range, gfloat max)
{
  GtkAdjustment *adj;
  
  adj = gtk_range_get_adjustment (range);

  adj->upper = max;
//  gtk_range_set_adjustment (range, adj); 

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

void c_gtk_range_set_leap (GtkRange *range, gfloat leap)
{
  GtkAdjustment *adj;
  
  adj = gtk_range_get_adjustment (range);

  adj->page_increment = leap;

//  gtk_range_set_adjustment (range, adj);

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

/*==============================================================================
 gtk_scale (vertical and horizontal) functions for EV_RANGE
==============================================================================*/

/*********************************
 *
 * Function : 'c_gtk_vscale_new'		(1)
 * 			  'c_gtk_hscale_new'		(1)
 *
 * Note : (1) Create a new vertical (horizontal) GtkScale.
 *
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_vscale_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap)
{
  GtkAdjustment *adj;
  
  /* The page size is only relevant for scrollbars. */
  adj = (GtkAdjustment *) gtk_adjustment_new (value, min, max, step, leap, 0.0);

  return (EIF_POINTER) gtk_vscale_new (adj);
}

EIF_POINTER c_gtk_hscale_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap)
{
  GtkAdjustment *adj;
  
  /* The page size is only relevant for scrollbars. */
  adj = (GtkAdjustment *) gtk_adjustment_new (value, min, max, step, leap, 0.0);

  return (EIF_POINTER) gtk_hscale_new (adj);
}

/*==============================================================================
 gtk_scroll (vertical and horizontal) functions for EV_SCROLL_BAR
==============================================================================*/

/*********************************
 *
 * Function : 'c_gtk_vsrollbar_new'		(1)
 * 			  'c_gtk_hscrollbar_new'	(1)
 *
 * Note : (1) Create a new vertical (horizontal) GtkScroll.
 *
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_vscrollbar_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap, gfloat page)
{
    GtkAdjustment *adj;
  
  /* The page size is only relevant for scrollbars. */
  adj = (GtkAdjustment *) gtk_adjustment_new (value, min, max, step, leap, page);

  return (EIF_POINTER) gtk_vscrollbar_new (adj);
}

EIF_POINTER c_gtk_hscrollbar_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap, gfloat page)
{
  GtkAdjustment *adj;
  
  adj = (GtkAdjustment *) gtk_adjustment_new (value, min, max, step, leap, page);

  return (EIF_POINTER) gtk_hscrollbar_new (adj);	
}

void c_gtk_scrollbar_set_value ( GtkScrollbar * scroll, gfloat value)
{
  GtkAdjustment *adj;
  
  adj = gtk_range_get_adjustment (GTK_RANGE (scroll));
  adj->value = value;
  
//  gtk_range_set_adjustment (GTK_RANGE (scroll), adj);

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}


void c_gtk_scrollbar_set_page_size ( GtkScrollbar * scroll, gfloat value)
{
  GtkAdjustment *adj;
  
  adj = gtk_range_get_adjustment (GTK_RANGE (scroll));
  adj->page_size = value;
  adj->page_increment = value;
  
//  gtk_range_set_adjustment (GTK_RANGE (scroll), adj);

  /* Now emit the "changed" signal to reconfigure all the widgets that
   * are attached to this adjustment */
  gtk_signal_emit_by_name (GTK_OBJECT (adj), "changed");
}

/*==============================================================================
 gtk_tooltips functions
==============================================================================*/

void c_gtk_tooltips_get_bg_color (GtkTooltips *tooltips, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b)
{
  GdkColor *bg_color;

  bg_color = GTK_TOOLTIPS (tooltips)->background;

  if (bg_color != NULL)
  {
    *r = bg_color->red;
    *g = bg_color->green;
    *b = bg_color->blue;
 
   	*r /= 257; *g /= 257; *b /= 257;
  }
  else
  {
    *r = -1; *g = -1; *b = -1;
  }
}

void c_gtk_tooltips_get_fg_color (GtkTooltips *tooltips, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b)
{
  GdkColor *fg_color;
	
  fg_color = GTK_TOOLTIPS (tooltips)->foreground;

  if (fg_color != NULL)
  {
    *r = fg_color->red;
    *g = fg_color->green;
    *b = fg_color->blue;
 
   	*r /= 257; *g /= 257; *b /= 257;
  }
  else
  {
    *r = -1; *g = -1; *b = -1;
  }
}

void c_gtk_tooltips_set_bg_color (GtkTooltips* tooltips, int r, int g, int b)
{
  GdkColor *bg_color;
  bg_color = (GdkColor *) malloc (sizeof (GdkColor));
  
  r *= 257; g *= 257; b *= 257;
  
  if (tooltips->background != NULL) 
    bg_color->pixel = tooltips->foreground->pixel;
  else
    bg_color->pixel = 0;

  bg_color->red = (gushort) r;
  bg_color->green = (gushort) g;
  bg_color->blue = (gushort) b;
  
  gtk_tooltips_set_colors (tooltips, bg_color, tooltips->foreground);
}

void c_gtk_tooltips_set_fg_color (GtkTooltips* tooltips, int r, int g, int b)
{
  GdkColor *fg_color;
  
  fg_color = (GdkColor *) malloc (sizeof (GdkColor));
 
  r *= 257; g *= 257; b *= 257;

  /*
  if (tooltips->foreground != NULL) 
    fg_color->pixel = tooltips->foreground->pixel;
  else
    fg_color->pixel = 0;
  
  fg_color->red = (gushort) r;
  fg_color->green = (gushort) g;
  fg_color->blue = (gushort) b;
  
  gtk_tooltips_set_colors (tooltips, tooltips->background, fg_color);

  */
  if (tooltips->foreground != NULL) 
  {
	tooltips->foreground->red = r;
	tooltips->foreground->green = g;
	tooltips->foreground->blue = b;
  }
  else
  {
	fg_color->pixel = 0;
	fg_color->red = r;
	fg_color->green = g;
	fg_color->blue = b;
	tooltips->foreground = fg_color;
  }
}

/*==============================================================================
 Color selection functions
==============================================================================*/

/*********************************
 *
 * Function : 'c_gtk_color_selection_dialog_new'	(1)
 * 			  `c_gtk_color_selection_get_color'		(2)
 * 			  `c_gtk_color_selection_set_color'		(3)
 *
 * Note : (1) Create a new color dialog with some options.
 * 		  (2) Value of the chosen color.
 * 		  (3) Set the color to the given value.
 *
 * Author : Alex
 *
 *********************************/

EIF_POINTER c_gtk_color_selection_dialog_new (gchar* name)
{
  GtkWidget *color_dialog;
	
  color_dialog = gtk_color_selection_dialog_new(name);
  gtk_color_selection_set_opacity (
        GTK_COLOR_SELECTION (GTK_COLOR_SELECTION_DIALOG (color_dialog)->colorsel),
		TRUE);

  gtk_color_selection_set_update_policy(
        GTK_COLOR_SELECTION (GTK_COLOR_SELECTION_DIALOG (color_dialog)->colorsel),
		GTK_UPDATE_CONTINUOUS);

 return (EIF_POINTER) color_dialog; 
}

void c_gtk_color_selection_get_color (GtkWidget *color_dialog, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b)
{
  GtkColorSelection *colorsel;
  gdouble colors[4];
	
  colorsel = GTK_COLOR_SELECTION (((GtkColorSelectionDialog *) color_dialog)->colorsel);
  gtk_color_selection_get_color (colorsel, colors);

  *r = 255 * colors[0];
  *g = 255 * colors[1];
  *b = 255 * colors[2];
}

void c_gtk_color_selection_set_color (GtkWidget *color_dialog, EIF_INTEGER r, EIF_INTEGER g, EIF_INTEGER b)
{
  GtkColorSelection *colorsel;
  gdouble colors[4];
 
  colorsel = GTK_COLOR_SELECTION (((GtkColorSelectionDialog *) color_dialog)->colorsel);
  gtk_color_selection_get_color(colorsel, colors);
	
/*  colors[0] = r / 255;
  colors[1] = g / 255;
  colors[2] = b / 255;
  colors[3] = colorsel->use_opacity;
  */
  gtk_color_selection_set_color (colorsel, colors);
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

void SetForegroundStyleRecursively (GtkWidget *widget, gpointer data)
{
  GtkStyle* widgetStyle;
  GtkStyle* style;
  int nr, ng, nb; // new colors
  int or, og, ob; // old colors
  int i;

  style = (GtkStyle *) data;
//  widgetStyle = gtk_widget_get_style(GTK_WIDGET(widget));
  widgetStyle = gtk_style_copy(GTK_WIDGET(widget)->style);

  /* The colors we want the foreground to be. */
  nr = style->fg[GTK_STATE_NORMAL].red;
  ng = style->fg[GTK_STATE_NORMAL].green;
  nb = style->fg[GTK_STATE_NORMAL].blue;

  /* The colors the foreground was. */
  or = widgetStyle->fg[GTK_STATE_NORMAL].red;
  og = widgetStyle->fg[GTK_STATE_NORMAL].green;
  ob = widgetStyle->fg[GTK_STATE_NORMAL].blue;
		
  if(or != nr || og != ng || ob != nb)
  {
	/* If we are here, this means the former foreground
	 * color is not he same as the requested one, so we set it to the new one.
	 */
  	  
  	for (i = 0; i < 5; i++)
	{
	  /* We do not change the color when GTK_STATE_SELECTED
	   * because of EV_TEXT_AREA */
	  if (i != 3)
	  {
	    widgetStyle->fg[i].red = nr;
	    widgetStyle->fg[i].green = ng;
	    widgetStyle->fg[i].blue = nb;
//	    widgetStyle->text[i].red = r;
//	    widgetStyle->text[i].green = g;
//	    widgetStyle->text[i].blue = b;
	  }  
	}

    /* --- Set the style of the widget --- */
    gtk_widget_set_style (widget, widgetStyle);
  }

  /* --- If it may have children widgets --- */
//  if (GTK_IS_CONTAINER (widget))
//  {
//	  /* --- Set all the children's styles too. --- */
//	  gtk_container_foreach (GTK_CONTAINER (widget), 
//	  SetForegroundStyleRecursively, style);
// }
}
	
void SetBackgroundStyleRecursively (GtkWidget *widget, gpointer data)
{
  GtkStyle *widgetStyle;
  GtkStyle *style;
  int nr, ng, nb; // new colors
  int or, og, ob; // old colors
  int i;

  style = (GtkStyle *) data;
//  widgetStyle = gtk_widget_get_style(GTK_WIDGET(widget));
  widgetStyle = gtk_style_copy(GTK_WIDGET(widget)->style);

  /* The colors we want the background to be. */
  nr = style->bg[GTK_STATE_NORMAL].red;
  ng = style->bg[GTK_STATE_NORMAL].green;
  nb = style->bg[GTK_STATE_NORMAL].blue;

  /* The colors the background was. */
  or = widgetStyle->bg[GTK_STATE_NORMAL].red;
  og = widgetStyle->bg[GTK_STATE_NORMAL].green;
  ob = widgetStyle->bg[GTK_STATE_NORMAL].blue;
		
  if(or != nr || og != ng || ob != nb)
  {
    for (i = 0; i < 5; i++)
	{
	  /* We do not change the color when GTK_STATE_SELECTED
	   * because of EV_TEXT_AREA */
	  if (i != 3)
	  {
		widgetStyle->bg[i].red = nr;
	  	widgetStyle->bg[i].green = ng;
		widgetStyle->bg[i].blue = nb;
	  }
	}

    /* --- Set the style of the widget --- */
    gtk_widget_set_style (widget, widgetStyle);
  }

    /* --- If it may have children widgets --- */
//    if (GTK_IS_CONTAINER (widget))
//	{
//      /* --- Set all the children's styles too. --- */
//      gtk_container_foreach (GTK_CONTAINER (widget), 
//                     SetBackgroundStyleRecursively, style);
//    }
}

void c_gtk_widget_set_bg_color (GtkWidget* widget, int nr, int ng, int nb)
{
  GtkStyle* widgetStyle;
  int or, og, ob; // old colors
  int i;

  nr *= 257; ng *= 257; nb *= 257;
  
  //  style = gtk_widget_get_style(GTK_WIDGET(widget));
  widgetStyle = gtk_style_copy(GTK_WIDGET(widget)->style);

  /* The old color the background was. */
  or = widgetStyle->bg[GTK_STATE_NORMAL].red;
  og = widgetStyle->bg[GTK_STATE_NORMAL].green;
  ob = widgetStyle->bg[GTK_STATE_NORMAL].blue;
		
  if(or != nr || og != ng || ob != nb)
  {
    for (i = 0; i < 5; i++)
	{
	  /* We do not change the color when GTK_STATE_SELECTED
	   * because of EV_TEXT_AREA */
	  if (i != 3)
	  {
		widgetStyle->bg[i].red = nr;
	  	widgetStyle->bg[i].green = ng;
		widgetStyle->bg[i].blue = nb;
	  }
	}

    /* --- Set the style of the widget --- */
    gtk_widget_set_style (widget, widgetStyle);
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


void c_gtk_widget_set_fg_color (GtkWidget* widget, int nr, int ng, int nb)
{
  GtkStyle* widgetStyle;
  int or, og, ob; // old colors
  int i;

  nr *= 257; ng *= 257; nb *= 257;
  
  //  style = gtk_widget_get_style(GTK_WIDGET(widget));
  widgetStyle = gtk_style_copy(GTK_WIDGET(widget)->style);

  /* The old color the foreground was. */
  or = widgetStyle->fg[GTK_STATE_NORMAL].red;
  og = widgetStyle->fg[GTK_STATE_NORMAL].green;
  ob = widgetStyle->fg[GTK_STATE_NORMAL].blue;
		
  if(or != nr || og != ng || ob != nb)
  {
    for (i = 0; i < 5; i++)
	{
	  /* We do not change the color when GTK_STATE_SELECTED
	   * because of EV_TEXT_AREA */
	  if (i != 3)
	  {
		widgetStyle->fg[i].red = nr;
	  	widgetStyle->fg[i].green = ng;
		widgetStyle->fg[i].blue = nb;
	  }
	}

    /* --- Set the style of the widget --- */
    gtk_widget_set_style (widget, widgetStyle);
  }
}


void c_gtk_widget_get_fg_color (GtkWidget* widget, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b)
{
		GtkStyle* style;
		style = GTK_WIDGET(widget)->style;
		
		*r = style->fg[GTK_STATE_NORMAL].red;
		*g = style->fg[GTK_STATE_NORMAL].green;
		*b = style->fg[GTK_STATE_NORMAL].blue;

		*r /= 257; *g /= 257; *b /= 257;
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
