/*==============================================================================
 EiffelVision/GTK External C library
 gtk_eiffel.h
--------------------------------------------------------------------------------
 description: "Functions for using gtk from Eiffel"
 date:        "$Date$"
 revision:    "$Revision$"
 status:      "See notice at end of file"
==============================================================================*/
#ifndef _GTK_EIFFEL_H_INCLUDED_
#define _GTK_EIFFEL_H_INCLUDED_

/*==============================================================================
 Included files
==============================================================================*/

#include <gtk/gtk.h>
#include <stdlib.h>
#include "eif_eiffel.h"
#include "eif_argv.h"


/*==============================================================================
 Initialization
--------------------------------------------------------------------------------
 Pass command line arguments to the GTK initialization code 
 In ISE's runtime there are references to these in "argv.h" 
==============================================================================*/

void c_gtk_init_toolkit (); 


/*==============================================================================
 Event handling
==============================================================================*/

/*------------------------------------------------------------------------------
 Data passed back to event handlers
------------------------------------------------------------------------------*/

typedef  struct callback_data {
    EIF_PROC rtn;
    EIF_OBJ obj;
    EIF_OBJ argument;
    EIF_OBJ ev_data;
    EIF_OBJ ev_data_imp;
    EIF_PROC set_event_data;
    char mouse_button;
    char double_click;
    gpointer extra_data;
} callback_data_t;


void c_free_call_back_block (callback_data_t *p);

/* Function to cast an integer to a pointer. */
#define c_integer_to_pointer(p)      ((EIF_POINTER) p)      /*EIF_POINTER*/

/*------------------------------------------------------------------------------
 Called by gtk when a signal is emitted, passes signal on to Eiffel.
------------------------------------------------------------------------------*/

void c_signal_callback (GtkObject *w, gpointer data);


/*------------------------------------------------------------------------------
 Called by gtk when an event is emitted, passes event on to Eiffel.
------------------------------------------------------------------------------*/

void c_event_callback (GtkObject *w, GdkEvent *ev,  gpointer data);


/*------------------------------------------------------------------------------
To be called when signal is disconnected
------------------------------------------------------------------------------*/

void c_gtk_signal_destroy_data (gpointer data);


/*------------------------------------------------------------------------------
 Connect a call back to a widget/event pair
------------------------------------------------------------------------------*/

gint c_gtk_signal_connect (GtkObject *widget, 
			   gchar *name, 
			   EIF_PROC execute_func,
			   EIF_POINTER object,
			   EIF_POINTER argument,
			   EIF_POINTER ev_data,
			   EIF_POINTER ev_data_imp,
			   EIF_PROC event_data_rtn,
			   char mouse_button,
			   char double_click,
			   gpointer extra_data);

/*------------------------------------------------------------------------------
 Connect a call back to a widget/event pair
 To be run after other callbacks (see gtk documentation)
------------------------------------------------------------------------------*/

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

/*------------------------------------------------------------------------------
 Disconnect a call back of a widget/event pair
------------------------------------------------------------------------------*/

void c_gtk_signal_disconnect (GtkObject *widget, 
			      EIF_PROC func,
			      EIF_OBJ object,
			      EIF_OBJ argument);

/*==============================================================================
 Key Event function
==============================================================================*/

int c_gtk_event_keys_state (GtkObject *p);

void c_gtk_widget_set_all_events (GtkObject *w);

/*==============================================================================
 gtk_widget functions
==============================================================================*/

/* True, if widget is destroyed */
int c_gtk_widget_destroyed (GtkWidget *widget);

/* Set widget flags */
void c_gtk_widget_set_flags (GtkWidget *widget, int flags);


EIF_BOOLEAN c_gtk_widget_visible (GtkWidget *w);

/*  c_gtk_widget_realized  (GtkWidget *w) : Is widget realised */
EIF_BOOLEAN c_gtk_widget_realized (GtkWidget *w); 

/*  c_gtk_widget_displayed  (GtkWidget *w) : Is widget visible on the screen? */
EIF_BOOLEAN c_gtk_widget_displayed (GtkWidget *w);

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
 **********************************/

/*
    the coordinates, size and minimum size of a widget
*/
#define c_gtk_widget_x(p)      (GTK_WIDGET(p)->allocation.x)      /*integer*/
#define c_gtk_widget_y(p)      (GTK_WIDGET(p)->allocation.y)      /*integer*/
#define c_gtk_widget_width(p)  (GTK_WIDGET(p)->allocation.width)  /*integer*/
#define c_gtk_widget_height(p) (GTK_WIDGET(p)->allocation.height) /*integer*/

// #define c_gtk_widget_minimum_width(p)  (GTK_WIDGET(p)->requisition.width)  /*integer*/
// #define c_gtk_widget_minimum_height(p) (GTK_WIDGET(p)->requisition.height) /*integer*/

/* gets minimum width and height */
EIF_INTEGER c_gtk_widget_minimum_width (GtkObject *widget); 
EIF_INTEGER c_gtk_widget_minimum_height (GtkObject *widget); 

/* set size */
void c_gtk_widget_set_size (GtkWidget *widget, int width, int height);

/* return widget name */
EIF_REFERENCE c_gtk_widget_get_name (GtkWidget *widget);

/* set widget name */
void c_gtk_widget_set_name (GtkWidget *widget, const gchar *name);

extern void c_gtk_widget_set_bg_color (GtkWidget *widget, int r, int g, int b);
void c_gtk_widget_get_bg_color (GtkWidget *widget, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
void c_gtk_widget_set_fg_color (GtkWidget *widget, int r, int g, int b);
void c_gtk_widget_get_fg_color (GtkWidget *widget, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);


void c_gtk_widget_get_color_info (GtkWidget* widget,
	EIF_INTEGER* fgr,
	EIF_INTEGER* fgg,
	EIF_INTEGER* fgb,
	EIF_INTEGER* fgpix,
	EIF_INTEGER* textr,
	EIF_INTEGER* textg,
	EIF_INTEGER* textb,
	EIF_INTEGER* textpix,
	EIF_INTEGER* bgr,
	EIF_INTEGER* bgg,
	EIF_INTEGER* bgb,
	EIF_INTEGER* bgpix,
	EIF_INTEGER* baser,
	EIF_INTEGER* baseg,
	EIF_INTEGER* baseb,
	EIF_INTEGER* basepix,
	EIF_INTEGER* blackr,
	EIF_INTEGER* blackg,
	EIF_INTEGER* blackb,
	EIF_INTEGER* blackpix,
	EIF_INTEGER* whiter,
	EIF_INTEGER* whiteg,
	EIF_INTEGER* whiteb,
	EIF_INTEGER* whitepix
	);




/*==============================================================================
 gtk_container functions
==============================================================================*/

/* Number of children of a container */
gint c_gtk_container_nb_children (GtkWidget *widget);

/* I-th child of the container */
EIF_POINTER c_gtk_container_ith_child (GtkWidget *widget, guint i);

/* Does the container have the given child? */
int c_gtk_container_has_child (GtkWidget *widget, GtkWidget *child);

/* Add the widget to the scrollable area. */
void c_gtk_scrollable_area_add (GtkWidget *scroll_area, GtkWidget *widget);

/* Does the scrollable area have the given child? */
int c_gtk_scrollable_area_has_child (GtkWidget *scroll_area, GtkWidget *child);

/* Set the container background pixmap. */
void c_gtk_container_set_bg_pixmap (GtkWidget *container, GtkWidget *pixmap);

/*==============================================================================
 gtk_tooltips functions
==============================================================================*/

#define c_gtk_tooltips_delay(p) ((EIF_INTEGER) GTK_TOOLTIPS(p)->delay) /*Integer*/
void c_gtk_tooltips_get_bg_color (GtkTooltips *tooltips, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
void c_gtk_tooltips_get_fg_color (GtkTooltips *tooltips, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
void c_gtk_tooltips_set_fg_color (GtkTooltips *tooltips, int r, int g, int b);
void c_gtk_tooltips_set_bg_color (GtkTooltips *tooltips, int r, int g, int b);

/*==============================================================================
 gtk_toolbar functions
==============================================================================*/

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

/*==============================================================================
 button functions
==============================================================================*/

/*
  Returns the label widget of button. 
  There has to be only a label inside the widget.
*/
GtkWidget* c_gtk_get_label_widget (GtkWidget *widget);

/* Return a state of a toggle button */
EIF_BOOLEAN c_gtk_toggle_button_active (GtkWidget *button);

/*==============================================================================
 Option button functions
==============================================================================*/

EIF_POINTER c_gtk_option_button_selected_menu_item (GtkWidget *widget);
EIF_INTEGER c_gtk_option_button_index_of_menu_item (GtkWidget *option_menu, GtkWidget *menu_item);

/*==============================================================================
 text functions
==============================================================================*/

/* The length of the string in text widget */
int c_gtk_get_text_length (GtkWidget* text);

/* The maximum length of string in text widget */
int c_gtk_get_text_max_length (GtkWidget* text);


/*==============================================================================
 gtk_combo functions
==============================================================================*/

#define c_gtk_combo_entry(p) ((EIF_POINTER) GTK_COMBO(p)->entry)  /*GtkWidget**/
#define c_gtk_combo_list(p)  ((EIF_POINTER) GTK_COMBO(p)->list)   /*GtkWidget**/

/*==============================================================================
 gtk_paned functions
==============================================================================*/

#define c_gtk_paned_child1(p) ((EIF_POINTER) GTK_PANED(p)->child1)  /*GtkWidget**/
#define c_gtk_paned_child2(p) ((EIF_POINTER) GTK_PANED(p)->child2)  /*GtkWidget**/
#define c_gtk_paned_child1_size(p) ((EIF_INTEGER) GTK_PANED(p)->child1_size)  /*gint*/

/*==============================================================================
 gtk_pixmap functions
==============================================================================*/

/* Create an empty pixmap */
GtkWidget* c_gtk_pixmap_create_empty  (GtkWidget *widget);

/* Create a pixmap widget from an xpm file */
GtkWidget *c_gtk_pixmap_create_from_xpm (GtkWidget *widget, char *fname);

/* Read the pixmap for xpm file */
void c_gtk_pixmap_read_from_xpm ( GtkPixmap *pixmap,
				  GtkWidget *pixmap_parent,
				  char *file_name );

/* Create a pixmap with the given size */
GtkWidget* c_gtk_pixmap_create_with_size (GtkWidget *window_parent, gint width, gint height);

/* Create a pixmap with the given size */
void c_gtk_pixmap_set_from_pixmap (GtkWidget *pixmapDest, GtkWidget *pixmapSource);

/*==============================================================================
 gtk_editable functions
==============================================================================*/

/* Editable : data access */
#define c_gtk_editable_position(p) (GTK_EDITABLE(p)->current_pos) 				 /*guint*/
#define c_gtk_editable_selection_start(p) (GTK_EDITABLE(p)->selection_start_pos) /*guint*/
#define c_gtk_editable_selection_end(p) (GTK_EDITABLE(p)->selection_end_pos) 	 /*guint*/
#define c_gtk_editable_has_selection(p) (GTK_EDITABLE(p)->has_selection) 		 /*guint*/
#define c_gtk_editable_editable(p) (GTK_EDITABLE(p)->editable)                   /*guint*/

/*==============================================================================
 gtk_entry functions
==============================================================================*/

#define c_gtk_entry_get_max_length(p)     ((EIF_INTEGER) GTK_ENTRY(p)->text_max_length)     /*integer*/

/*==============================================================================
 gtk_list functions
==============================================================================*/

/* List : add a listItem to a list */
void c_gtk_list_item_select (GtkWidget *item);
void c_gtk_list_item_unselect (GtkWidget *item);
EIF_BOOLEAN c_gtk_list_item_is_selected (GtkWidget *list, GtkWidget *item);
gint c_gtk_list_selection_mode (GtkWidget *item);
guint c_gtk_list_selected (GtkWidget* list);
gint c_gtk_list_selected_item (GtkWidget *item);
void c_gtk_list_insert_item (GtkWidget *list, GtkWidget *item, gint position);
void c_gtk_list_remove_item (GtkWidget *list, GtkWidget *item);

/* List : number of rows */
guint c_gtk_list_rows (GtkWidget *list);

/*==============================================================================
 gtk_notebook functions
==============================================================================*/

/* Number of pages in a notebook */
gint c_gtk_notebook_count (GtkWidget *notebook);
/* tab position of the notebook */
#define c_gtk_notebook_tab_position(p)     ((EIF_INTEGER) GTK_NOTEBOOK(p)->tab_pos)     /*integer*/

/*==============================================================================
 gtk_list functions
==============================================================================*/

gint c_gtk_clist_append_row (GtkWidget* list);
guint c_gtk_clist_selected (GtkWidget* list);
gint c_gtk_clist_ith_selected_item (GtkWidget* list, guint i);
guint c_gtk_clist_selection_length (GtkWidget* list);
void c_gtk_clist_set_fg_color (GtkWidget* clist_row, int row, int r, int g, int b);
void c_gtk_clist_set_bg_color (GtkWidget* clist_row, int row, int r, int g, int b);
void c_gtk_clist_get_fg_color (GtkWidget* list_row, int row, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b);
void c_gtk_clist_get_bg_color (GtkWidget* list_row, int row, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b);
void c_gtk_clist_set_pixtext (GtkWidget* clist, int row, int column, GtkWidget *pixmap, gchar *text);
void c_gtk_clist_unset_pixmap (GtkWidget* clist, int row, int column);

/* CList */
#define c_gtk_clist_rows(p)     (GTK_CLIST(p)->rows)     /*integer*/
#define c_gtk_clist_columns(p)  (GTK_CLIST(p)->columns)  /*integer*/
#define c_gtk_clist_selection_mode(p) (GTK_CLIST(p)->selection_mode)  /*integer*/

/*==============================================================================
 gtk_table functions
==============================================================================*/

/* Routines to get and set the number of rows and columns of a table. */
EIF_INTEGER c_gtk_table_rows        (GtkWidget *widget);
EIF_INTEGER c_gtk_table_columns     (GtkWidget *widget);
void c_gtk_table_set_spacing_if_needed (GtkWidget *widget);
#define c_gtk_table_row_spacing(p)	((EIF_INTEGER) GTK_TABLE(p)->row_spacing)  /* guint16 */
#define c_gtk_table_column_spacing(p)	((EIF_INTEGER) GTK_TABLE(p)->column_spacing)  /* guint16 */


/*==============================================================================
 gtk_ctree functions
==============================================================================*/

/* Routine to create a GtkCTreeNode which is a EV_TREE_ITEM */
EIF_POINTER c_gtk_ctree_insert_node (GtkCTree *, GtkCTreeNode*, GtkCTreeNode*, gchar *, guint8, GdkPixmap*, GdkBitmap*, gboolean, gboolean);

/* Routine to know if a tree item is expanded */
EIF_BOOLEAN c_gtk_ctree_item_is_expanded (GtkCTreeNode *node);

/* Routine to set the selection mode of the tree to SINGLE */
void c_gtk_ctree_set_single_selection_mode (GtkCTree *ctree);

/* Routine to set the selection mode of the tree to SINGLE */
EIF_POINTER c_gtk_ctree_selected_item (GtkCTree *ctree);

/* Routine to set the pixmap and text. */
void c_gtk_ctree_item_set_pixtext (GtkCTree *ctree, GtkCTreeNode *node, gint column, GtkPixmap *pixmap, gchar *txt, guint8 spacing);

/* Routine that gives the position of the node in the ctree. */
EIF_INTEGER c_gtk_ctree_item_get_position_in_tree (GtkCTree *ctree, GtkCTreeNode *node);

/*==============================================================================
 gtk_text functions
==============================================================================*/

/* Insert a text in a text widget. */
void c_gtk_text_insert (GtkWidget *widget, const char *txt);

/* Insert a text in a rich-text widget with font, colors. */
void c_gtk_text_full_insert (GtkWidget *widget, GdkFont *font, int r, int g, int b, const char *txt, gint length);

/*==============================================================================
 gtk_box functions
==============================================================================*/

/* Set the options of a child in a box */
void c_gtk_box_set_child_options (GtkWidget *box, GtkWidget *child,
				  gint expand, gint fill);

EIF_BOOLEAN c_gtk_box_is_child_expandable (GtkWidget *box, GtkWidget *child);

void c_gtk_box_set_child_expandable (GtkWidget *box, GtkWidget *child, gint flag);

#define c_gtk_box_homogeneous(p)	(GTK_BOX(p)->homogeneous)  /* guint */

#define c_gtk_box_spacing(p)	(GTK_BOX(p)->spacing)  /* guint */

#define c_gtk_container_border_width(p)     (GTK_CONTAINER(p)->border_width)     /*integer*/


/*==============================================================================
 gtk_window functions
==============================================================================*/

/* Give the position of a window. */
EIF_INTEGER c_gtk_window_x (GtkWidget *w);
EIF_INTEGER c_gtk_window_y (GtkWidget *w);

/* Information about the window. */
typedef struct {
	GdkGeometry    geometry;
	GdkWindowHints mask;
	GtkWidget     *widget;
	gint           width;
	gint           height;
	gint           last_width;
	gint           last_height;
} GtkWindowGeometryInfo;

/* Give the maximum sizes of a window. */
EIF_INTEGER c_gtk_window_maximum_height (GtkWidget *w);
EIF_INTEGER c_gtk_window_maximum_width  (GtkWidget *w);

void c_gtk_window_set_modal(GtkWindow* window, gboolean modal);

/* Title of the window */
char* c_gtk_window_title(GtkWindow* window);

/*==============================================================================
 gtk_frame functions
==============================================================================*/

#define c_gtk_frame_text(p) ((EIF_POINTER) ((GtkFrame*)p)->label)

/*==============================================================================
 gtk_menu functions
==============================================================================*/

#define c_gtk_menu_item_submenu(p) ((EIF_POINTER) ((GtkMenuItem*)p)->submenu)
/* GtkWidget* */

#define c_gtk_check_menu_item_active(p) (((GtkCheckMenuItem*)p)->active)
/* guint */
	
/*==============================================================================
 gtk_statusbar functions
==============================================================================*/

/* Create a Gtk pixmap in the status bar item. Return the pixmap's pointer. */
EIF_POINTER c_gtk_statusbar_item_create_pixmap_place (GtkWidget *statusbar);

/* Unsets the pixmap of the status bar item */
void c_gtk_statusbar_item_unset_pixmap (GtkWidget *statusbar, GtkWidget *pixmap);
/* Sets the background of the status bar item */
void c_gtk_statusbar_item_set_bg_color (GtkWidget *statusbar, int r, int g, int b);

/* Pointer to the label of the status bar */
#define c_gtk_statusbar_item_label(p) ((EIF_POINTER) ((GtkStatusbar *)p)->label)  /*GtkWidget**/

/* Pointer to the frame of the status bar */
#define c_gtk_statusbar_item_frame(p) ((EIF_POINTER) ((GtkStatusbar *)p)->frame)  /*GtkWidget**/

/*==============================================================================
 gtk_pixmap functions
==============================================================================*/

/* Width of the given pixmap */
EIF_INTEGER c_gtk_pixmap_width (GtkWidget *pixmap);

/* Height of the given pixmap */
EIF_INTEGER c_gtk_pixmap_height (GtkWidget *pixmap);

/* Unref the gdk pixmap and the maskof the given pixmap */
void c_gtk_pixmap_gdk_unref (GtkWidget *pixmap);

/*==============================================================================
 gtk_progressbar functions
==============================================================================*/

EIF_POINTER c_gtk_progress_bar_new_with_adjustment (gfloat val, gfloat min, gfloat max, gfloat step, gfloat page);

void c_gtk_progress_bar_set_adjustment (GtkProgressBar *progressbar, gfloat val, gfloat min, gfloat max, gfloat step);

EIF_INTEGER c_gtk_progress_bar_style (GtkWidget *progressbar);
#define c_gtk_progress_bar_adjustment(p)      (GTK_PROGRESS (p)->adjustment)      /*GtkAdjustment*/


/*==============================================================================
 gtk_file_selection functions
==============================================================================*/

/* Pointer to the gtk_button `OK'. */
#define c_gtk_file_selection_get_ok_button(p)      (GTK_FILE_SELECTION(p)->ok_button)      /*GtkWidget*/

/* Pointer to the gtk_button `Cancel'. */
#define c_gtk_file_selection_get_cancel_button(p)      (GTK_FILE_SELECTION(p)->cancel_button)      /*GtkWidget*/

/* Pointer to the text of the entry of the file or directory selection dialog. */
EIF_POINTER c_gtk_selection_get_selection_entry (GtkWidget *dialog);

/* Pointer to the text of the dir of the file selection dialog. */
EIF_POINTER c_gtk_file_selection_get_dir (GtkWidget *file_dialog);

/* Create a new directory selection dialog. */
EIF_POINTER c_gtk_directory_selection_new (const gchar *name);

/*==============================================================================
 gtk_color_selection functions
==============================================================================*/

/* Pointer to the gtk_button `OK'. */
#define c_gtk_color_selection_get_ok_button(p)      (GTK_COLOR_SELECTION_DIALOG(p)->ok_button)      /*GtkWidget*/

/* Pointer to the gtk_button `Cancel'. */
#define c_gtk_color_selection_get_cancel_button(p)      (GTK_COLOR_SELECTION_DIALOG(p)->cancel_button)      /*GtkWidget*/

/* Pointer to the gtk_button `Help'. */
#define c_gtk_color_selection_get_help_button(p)      (GTK_COLOR_SELECTION_DIALOG(p)->help_button)      /*GtkWidget*/

/* Pointer to the text of the entry of the file selection dialog. */
EIF_POINTER c_gtk_color_selection_dialog_new (gchar *name);

/* Pointer to the text of the entry of the file selection dialog. */
void c_gtk_color_selection_get_color (GtkWidget *file_dialog, EIF_INTEGER* r,  EIF_INTEGER* g, EIF_INTEGER* b);

/* Pointer to the text of the dir of the file selection dialog. */
void c_gtk_color_selection_set_color (GtkWidget *file_dialog, EIF_INTEGER r, EIF_INTEGER g, EIF_INTEGER b);

/*==============================================================================
 gtk_spin_button functions
==============================================================================*/

EIF_POINTER c_gtk_spin_button_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap);

void c_gtk_spin_button_set_step (GtkSpinButton* spinButton, gfloat step);
void c_gtk_spin_button_set_minimum (GtkSpinButton* spinButton, gfloat min);
void c_gtk_spin_button_set_maximum (GtkSpinButton* spinButton, gfloat max);

/* The following value are currently integer but can be real with GTK. Not yet with windows. */
#define c_gtk_spin_button_step(p)      ((EIF_INTEGER) GTK_SPIN_BUTTON(p)->adjustment->step_increment)      /*Integer*/
#define c_gtk_spin_button_minimum(p)      ((EIF_INTEGER) GTK_SPIN_BUTTON(p)->adjustment->lower)      /*Integer*/
#define c_gtk_spin_button_maximum(p)      ((EIF_INTEGER) GTK_SPIN_BUTTON(p)->adjustment->upper)      /*Integer*/
#define c_gtk_spin_button_entry(p)      ((EIF_POINTER) GTK_ENTRY(p))      /*GtkWidget*/

/*==============================================================================
 gtk_range (vertical and horizontal) functions for EV_RANGE and EV_SCROLL_BAR
==============================================================================*/

void c_gtk_range_set_step (GtkRange* range, gfloat step);
void c_gtk_range_set_minimum (GtkRange* range, gfloat min);
void c_gtk_range_set_maximum (GtkRange* range, gfloat max);
void c_gtk_range_set_leap (GtkRange* range, gfloat step);

/* The following value are currently integer but can be real with GTK. Not yet with windows. */
#define c_gtk_range_step(p)      ((EIF_INTEGER) GTK_RANGE(p)->adjustment->step_increment)      /*Integer*/
#define c_gtk_range_minimum(p)      ((EIF_INTEGER) GTK_RANGE(p)->adjustment->lower)      /*Integer*/
#define c_gtk_range_maximum(p)      ((EIF_INTEGER) GTK_RANGE(p)->adjustment->upper)      /*Integer*/
#define c_gtk_range_leap(p)      ((EIF_INTEGER) GTK_RANGE(p)->adjustment->page_increment)      /*Integer*/

/*==============================================================================
 gtk_scale (vertical and horizontal) functions for EV_RANGE
==============================================================================*/
EIF_POINTER c_gtk_vscale_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap);
EIF_POINTER c_gtk_hscale_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap);

/* The following value are currently integer but can be real with GTK. Not yet with windows. */
#define c_gtk_scale_value(p)      ((EIF_INTEGER) GTK_RANGE(p)->adjustment->value)      /*Integer*/

/*==============================================================================
 gtk_scroll (vertical and horizontal) functions for EV_SCROLL_BAR
==============================================================================*/

EIF_POINTER c_gtk_vscrollbar_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap, gfloat page);
EIF_POINTER c_gtk_hscrollbar_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap, gfloat page);
void c_gtk_scrollbar_set_value (GtkScrollbar* scroll, gfloat value);
void c_gtk_scrollbar_set_page_size (GtkScrollbar* scroll, gfloat value);

#define c_gtk_range_adjustment(p)      ((EIF_POINTER) GTK_RANGE(p)->adjustment)      /**GtkAdjusment*/

/* The following value are currently integer but can be real with GTK. Not yet with windows. */
#define c_gtk_scrollbar_value(p)      ((EIF_INTEGER) GTK_RANGE(p)->old_value)      /*Integer*/

/*==============================================================================
 gtk_style functions
==============================================================================*/

void c_gtk_style_default_bg_color (EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
void c_gtk_style_default_fg_color (EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);

/*#define c_gtk_style_base_color_blue(p) \
	((((GtkStyle*)p)->base[GTK_STATE_NORMAL].blue)/257)
*/

/*==============================================================================
 End of file
==============================================================================*/

#endif /* _GTK_EIFFEL_H_INCLUDED_ */

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

