/**********************************************

EiffelVision/GTK 

external C library
					       
  Date: 5/22/98

**************************************** */

#include <gtk/gtk.h>
#include "eif_eiffel.h"
#include "eif_argv.h"



typedef  struct callback_data {
    EIF_PROC rtn;
    EIF_OBJ obj;
    EIF_OBJ argument;
    EIF_OBJ ev_data;
    EIF_PROC set_event_data;
    char mouse_button;
    char double_click;
} callback_data_t;


void c_free_call_back_block (callback_data_t *p);


/* Pass command line arguments to the GTK initialization code */
/* In ISE's runtime there are references to these in "argv.h" */
void c_gtk_init_toolkit (); 

/* This function is actually called when the event occurs */
/* an it in turn calls Eiffel.                            */
void c_signal_callback (GtkObject *w, gpointer data);


/* This function is actually called when the event occurs */
/* an it in turn calls Eiffel.                            */
/* This function is called for signals named "*_event".  XXXX */
void c_event_callback (GtkObject *w, GdkEvent *ev,  gpointer data);


/* Function to call when signal is disconnected */
void c_gtk_signal_destroy_data (gpointer data);


/* Connect a call back to a widget/event pair */
gint c_gtk_signal_connect (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click);


/* Disconnect a call back of a widget/event pair */
void c_gtk_signal_disconnect (GtkObject *widget, 
			      EIF_PROC func,
			      EIF_OBJ object,
			      EIF_OBJ argument);

/* True, if widget is destroyed */
int c_gtk_widget_destroyed (GtkWidget *widget);

/* Set widget flags */
void c_gtk_widget_set_flags (GtkWidget *widget, int flags);


EIF_BOOLEAN c_gtk_widget_visible (GtkWidget *w);

/*  c_gtk_widget_realized  (GtkWidget *w) : Is widget realised */
EIF_BOOLEAN c_gtk_widget_realized (GtkWidget *w); 

/*  
    c_gtk_widget_sensitive  (GtkWidget *w) 

   Is widget sensitive
*/
EIF_BOOLEAN c_gtk_widget_sensitive (GtkWidget *w); 

/*  
    the x coordinate of widget
*/
EIF_INTEGER c_gtk_widget_x (GtkWidget *w);

/*  
    the y coordinate of widget
*/
EIF_INTEGER c_gtk_widget_y (GtkWidget *w);

/*  
    the width of widget
*/
EIF_INTEGER c_gtk_widget_width (GtkWidget *w);

/*  
    the height of widget
*/
EIF_INTEGER c_gtk_widget_height (GtkWidget *w);

/*  
    the minimum width of widget
*/
EIF_INTEGER c_gtk_widget_minimum_width (GtkWidget *w); 

/*  
    the mimimum height of widget
*/
EIF_INTEGER c_gtk_widget_minimum_height (GtkWidget *w); 

/* Widget:
   set size */
void c_gtk_widget_set_size (GtkWidget *widget, int width, int height);


/* Call back for toolbar buttons */
void c_toolbar_callback (GtkObject *w, gpointer data);



/* Call back for buttons on a tool bar */
void c_gtk_toolbar_append_item (GtkToolbar *toolbar, 
				const char *text, 
				const char *tip,
				const char *private_tip,
				GtkWidget *icon,
				EIF_PROC func, EIF_OBJ object,
				callback_data_t **p);

				/* return widget name */
EIF_REFERENCE c_gtk_widget_get_name (GtkWidget *widget);
				/* set widget name */
void c_gtk_widget_set_name (GtkWidget *widget, const gchar *name);


				/* message dialog */


				/* Create message dialog buttons */
void c_gtk_create_message_d_buttons (GtkWidget *dialog, GtkWidget *ok,
				     GtkWidget *cancel, GtkWidget *help);


				/* Message dialog text */
void c_gtk_create_message_d_label (GtkWidget *dialog, GtkWidget *label);


/* 
   out: label_widget pointer to buttons label widget
   in: label_text  text of label
 */
/*GtkWidget* c_gtk_create_button_with_label (GtkWidget *label_widget,
					  const gchar *label_text)

*/

/*
  Returns the label widget of button. 
  There has to be only a label inside the widget.
*/
GtkWidget* c_gtk_get_label_widget (GtkWidget *widget);


				/* Text */

/* The length of the string in text widget */
int c_gtk_get_text_length (GtkWidget* text);

/* The maximum length of string in text widget */
int c_gtk_get_text_max_length (GtkWidget* text);


				/* Container widgets (all widgets) */

/* Show the children of widget recursively */
void c_gtk_widget_show_children (GtkWidget *widget);


/* Return a state of a toggle button */
EIF_BOOLEAN c_gtk_toggle_button_active (GtkWidget *button);


/* Create an empty pixmap */
GtkWidget* c_gtk_pixmap_create_empty  (GtkWidget *widget);

/* Create a pixmap widget from an xpm file */
GtkWidget *c_gtk_pixmap_create_from_xpm (GtkWidget *widget, char *fname);

/* Read the pixmap for xpm file */
void c_gtk_pixmap_read_from_xpm ( GtkPixmap *pixmap,
				  GtkWidget *pixmap_parent,
				  char *file_name );

/* List : add a listItem to a list */
void c_gtk_add_list_item (GtkWidget *list, GtkWidget *item);


/* Routines to get and set the number of rows and columns of a table. */
EIF_INTEGER c_gtk_table_rows        (GtkWidget *widget            );
EIF_INTEGER c_gtk_table_columns     (GtkWidget *widget            );
