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
    EIF_OBJ ev_data_imp;
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
			   EIF_POINTER ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click);

/* Connect a call back to a widget/event pair */
/* To be run after other callbacks */
gint c_gtk_signal_connect_after (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_POINTER ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click);

/* Disconnect a call back of a widget/event pair */
void c_gtk_signal_disconnect (GtkObject *widget, 
			      EIF_PROC func,
			      EIF_OBJ object,
			      EIF_OBJ argument);

/********************************
 *
 * Some routines for widgets
 *
 ********************************/

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

/* Two routines for post-consitions */
EIF_BOOLEAN c_gtk_widget_position_set (GtkWidget *w, gint x, gint y);
EIF_BOOLEAN c_gtk_widget_minimum_size_set (GtkWidget *w, guint width, guint height);


/*********************************
 *
 * Macro `c_gtk_widget_x'
 *       `c_gtk_widget_y'
 *       `c_gtk_widget_width'
 *       `c_gtk_widget_height'
 *       `c_gtk_widget_minimum_width'
 *       `c_gtk_widget_minimum_height'
 *
 * Note : When the widget is not shown :
 *           x and y return -1,
 *           width and height return 1 and
 *           minimum_width and minimum_height return 0.
 *
 * Author : Samik
 *
 *********************************//*  
    the coordinates, size and minimum size of a widget
*/
#define c_gtk_widget_x(p)      (((GtkWidget*)p)->allocation.x)      /*integer*/
#define c_gtk_widget_y(p)      (((GtkWidget*)p)->allocation.y)      /*integer*/
#define c_gtk_widget_width(p)  (((GtkWidget*)p)->allocation.width)  /*integer*/
#define c_gtk_widget_height(p) (((GtkWidget*)p)->allocation.height) /*integer*/

#define c_gtk_widget_minimum_width(p)  (((GtkWidget*)p)->requisition.width)  /*integer*/
#define c_gtk_widget_minimum_height(p) (((GtkWidget*)p)->requisition.height) /*integer*/

/* set size */
void c_gtk_widget_set_size (GtkWidget *widget, int width, int height);

/* return widget name */
EIF_REFERENCE c_gtk_widget_get_name (GtkWidget *widget);

/* set widget name */
void c_gtk_widget_set_name (GtkWidget *widget, const gchar *name);

/********************************
 *
 * Some routines for toolbar
 *
 ********************************/

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

/********************************
 *
 * Some routines for message dialog
 *
 ********************************/

				/* Create message dialog buttons */
void c_gtk_create_message_d_buttons (GtkWidget *dialog, GtkWidget *ok,
				     GtkWidget *cancel, GtkWidget *help);


				/* Message dialog text */
void c_gtk_create_message_d_label (GtkWidget *dialog, GtkWidget *label);

/********************************
 *
 * Some routines for buttons
 *
 ********************************/

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

/* Return a state of a toggle button */
EIF_BOOLEAN c_gtk_toggle_button_active (GtkWidget *button);

/********************************
 *
 * Some routines for text
 *
 ********************************/

/* The length of the string in text widget */
int c_gtk_get_text_length (GtkWidget* text);

/* The maximum length of string in text widget */
int c_gtk_get_text_max_length (GtkWidget* text);

/********************************
 *
 * Some routines for combos
 *
 ********************************/

#define c_gtk_combo_entry(p)      (((GtkCombo*)p)->entry)  /*GtkWidget**/
#define c_gtk_combo_list(p)      (((GtkCombo*)p)->list)  /*GtkWidget**/

/********************************
 *
 * Some routines for containers
 *
 ********************************/

/* Show the children of widget recursively */
void c_gtk_widget_show_children (GtkWidget *widget);

/********************************
 *
 * Some routines for pixmaps
 *
 ********************************/

/* Create an empty pixmap */
GtkWidget* c_gtk_pixmap_create_empty  (GtkWidget *widget);

/* Create a pixmap widget from an xpm file */
GtkWidget *c_gtk_pixmap_create_from_xpm (GtkWidget *widget, char *fname);

/* Read the pixmap for xpm file */
void c_gtk_pixmap_read_from_xpm ( GtkPixmap *pixmap,
				  GtkWidget *pixmap_parent,
				  char *file_name );

/********************************
 *
 * Some routines for lists and clist (multi-column list)
 *
 ********************************/

/* List : add a listItem to a list */
void c_gtk_add_list_item (GtkWidget *list, GtkWidget *item);
void c_gtk_list_item_select (GtkWidget *item);
void c_gtk_list_item_unselect (GtkWidget *item);
gint c_gtk_list_selection_mode (GtkWidget *item);
guint c_gtk_list_selected (GtkWidget* list);
gint c_gtk_list_selected_item (GtkWidget *item);

/* List : number of rows */
guint c_gtk_list_rows (GtkWidget *list);

/* CList */
#define c_gtk_clist_rows(p)     (((GtkCList*)p)->rows)     /*integer*/
#define c_gtk_clist_columns(p)  (((GtkCList*)p)->columns)  /*integer*/
#define c_gtk_clist_selection_mode(p) (((GtkCList*)p)->selection_mode)  /*integer*/
gint c_gtk_clist_append_row (GtkWidget* list);
guint c_gtk_clist_selected (GtkWidget* list);
gint c_gtk_clist_ith_selected_item (GtkWidget* list, guint i);
guint c_gtk_clist_selection_length (GtkWidget* list);


/********************************
 *
 * Some routines for tables
 *
 ********************************/

/* Routines to get and set the number of rows and columns of a table. */
EIF_INTEGER c_gtk_table_rows        (GtkWidget *widget            );
EIF_INTEGER c_gtk_table_columns     (GtkWidget *widget            );

/********************************
 *
 * Some routines for trees
 *
 ********************************/

/* Routine to know if a tree item is expanded */
EIF_BOOLEAN c_gtk_tree_item_expanded (GtkWidget *widget);

/********************************
 *
 * Some routines for text area
 *
 ********************************/

/* Insert a text in a text-area widget. */
void c_gtk_text_insert (GtkWidget *widget, const char *txt);

/********************************
 *
 * Some routines for boxes
 *
 ********************************/

/* Set the options of a child in a box */
void c_gtk_box_set_child_options (GtkWidget *box, GtkWidget *child,
				  gint expand, gint fill);


/********************************
 *
 * Some routines for windows
 *
 ********************************/

/* Give the position of a window. */
EIF_INTEGER c_gtk_window_x (GtkWidget *w);
EIF_INTEGER c_gtk_window_y (GtkWidget *w);

/********************************
 *
 * A macro for menu
 *
 ********************************/

#define c_gtk_menu_item_submenu(p) (((GtkMenuItem*)p)->submenu) /* GtkWidget* */

#define c_gtk_check_menu_item_active(p) (((GtkCheckMenuItem*)p)->active) /* guint */
