indexing
	description: "External C calls to the custom gtk_eiffel library."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_C_GTK

feature -- Externals

	gdk_display: POINTER is
			-- Display * Result
		external
			" C [macro <gdk/gdkx.h>]"
		alias
			"GDK_DISPLAY()"
		end

	x_list_fonts (display, pattern: POINTER; max_return: INTEGER; actual_size: POINTER): POINTER is
			-- Display * display
			-- char * pattern
			-- int max_return
			-- int * actual_size
			-- char ** Result
		external
			" C | <X11/Xlib.h>"
		alias
			"XListFonts"
		end

	x_free_font_names (fonts_list: POINTER) is
			-- char ** fonts_list
		external
			" C | <X11/Xlib.h>"
		alias
			"XFreeFontNames"
		end

	c_match_font_name (pattern: POINTER): POINTER is
			-- Match to first in list or return NULL.
			-- `pattern' and `Result': char *
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_init_toolkit is 
			-- Parsed as:
			-- void c_gtk_init_toolkit (
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			-- void c_gtk_init_toolkit (); 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_gtk_events_process_events_queue ();
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_events_process_events_queue is 
			-- Parsed as:
			-- void c_gtk_events_process_events_queue (
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			--  
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_gtk_events_process_events_queue ();
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- typedef  struct callback_data {
			--     EIF_PROCEDURE  rtn;
			--     EIF_OBJECT  obj;
			--     EIF_OBJECT  argument;
			--     EIF_OBJECT  ev_data;
			--     EIF_OBJECT  ev_data_imp;
			--     EIF_PROCEDURE  set_event_data;
			--     char mouse_button;
			--     char double_click;
			--     gpointer extra_data;
			-- } callback_data_t;
			-- 
			-- 
			-- void c_free_call_back_block (callback_data_t *p);
		external
			"C | %"gtk_eiffel.h%""
		end

	c_free_call_back_block (a_p: POINTER) is 
			-- Parsed as:
			-- void c_free_call_back_block (
			--     callback_data_t *a_p
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- void c_free_call_back_block (callback_data_t *p);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_signal_callback (a_w: POINTER; a_data: POINTER) is 
			-- Parsed as:
			-- void c_signal_callback (
			--     GtkObject *a_w,
			--     gpointer a_data
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_signal_callback (GtkObject *w, gpointer data);
		external
			" C | %"gtk_eiffel.h%""
		end

--	c_event_callback (a_w: POINTER; a_ev: POINTER; a_data: POINTER) is 
			-- Parsed as:
			-- void c_event_callback (
			--     GtkObject *a_w,
			--     GdkEvent *a_ev,
			--     gpointer a_data
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_event_callback (GtkObject *w, GdkEvent *ev,  gpointer data);
--		external
--			" C | %"gtk_eiffel.h%""
--		end

	c_gtk_signal_destroy_data (a_data: POINTER) is 
			-- Parsed as:
			-- void c_gtk_signal_destroy_data (
			--     gpointer a_data
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_gtk_signal_destroy_data (gpointer data);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_signal_connect (a_widget: POINTER; a_name: POINTER; a_execute_func: POINTER; a_object: POINTER; a_argument: POINTER; a_ev_data: POINTER; a_ev_data_imp: POINTER; a_event_data_rtn: POINTER; a_mouse_button: INTEGER; a_double_click: INTEGER; a_extra_data: POINTER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_signal_connect (
			--     GtkObject *a_widget,
			--     gchar *a_name,
			--     EIF_PROCEDURE a_execute_func,
			--     EIF_REFERENCE a_object,
			--     EIF_REFERENCE a_argument,
			--     EIF_REFERENCE a_ev_data,
			--     EIF_REFERENCE a_ev_data_imp,
			--     EIF_PROCEDURE a_event_data_rtn,
			--     char a_mouse_button,
			--     char a_double_click,
			--     gpointer a_extra_data
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- gint c_gtk_signal_connect (GtkObject *widget, 
			-- 			   gchar *name, 
			-- 			   EIF_PROCEDURE  execute_func,
			-- 			   EIF_REFERENCE object,
			-- 			   EIF_REFERENCE argument,
			-- 			   EIF_REFERENCE ev_data,
			-- 			   EIF_REFERENCE ev_data_imp,
			-- 			   EIF_PROCEDURE  event_data_rtn,
			-- 			   char mouse_button,
			-- 			   char double_click,
			-- 			   gpointer extra_data);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_signal_connect_after (a_widget: POINTER; a_name: POINTER; a_execute_func: POINTER; a_object: POINTER; a_argument: POINTER; a_ev_data: POINTER; a_ev_data_imp: POINTER; a_event_data_rtn: POINTER; a_mouse_button: INTEGER; a_double_click: INTEGER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_signal_connect_after (
			--     GtkObject *a_widget,
			--     gchar *a_name,
			--     EIF_PROCEDURE a_execute_func,
			--     EIF_POINTER a_object,
			--     EIF_POINTER a_argument,
			--     EIF_POINTER a_ev_data,
			--     EIF_POINTER a_ev_data_imp,
			--     EIF_PROCEDURE a_event_data_rtn,
			--     char a_mouse_button,
			--     char a_double_click
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- gint c_gtk_signal_connect_after (GtkObject *widget, 
			-- 			   gchar *name, 
			-- 			   EIF_PROCEDURE  execute_func,
			-- 			   EIF_POINTER object,
			-- 			   EIF_POINTER argument,
			-- 			   EIF_POINTER ev_data,
			-- 			   EIF_POINTER ev_data_imp,
			-- 			   EIF_PROCEDURE  event_data_rtn,
			-- 			   char mouse_button,
			-- 			   char double_click);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_add_accelerator (a_widget: POINTER; a_signal_name: POINTER; a_keycode: INTEGER; a_shift_mask: BOOLEAN; a_control_mask: BOOLEAN; a_alt_mask: BOOLEAN) is 
			-- Parsed as:
			-- void c_gtk_widget_add_accelerator (
			--     GtkWidget *a_widget,
			--     gchar *a_signal_name,
			--     guint a_keycode,
			--     gboolean a_shift_mask,
			--     gboolean a_control_mask,
			--     gboolean a_alt_mask
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 		
			-- void c_gtk_widget_add_accelerator (GtkWidget * widget, const gchar *signal_name,
			-- 				guint keycode,
			-- 				gboolean shift_mask, gboolean control_mask, gboolean alt_mask);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_object_class_user_signal_new (a_object: POINTER; a_name: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_object_class_user_signal_new (
			--     GtkObject *a_object,
			--     gchar *a_name
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- EIF_INTEGER c_gtk_object_class_user_signal_new (GtkObject *object, const gchar *name);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_event_keys_state (a_p: POINTER): INTEGER is 
			-- Parsed as:
			-- int c_gtk_event_keys_state (
			--     GtkObject *a_p
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- int c_gtk_event_keys_state (GtkObject *p);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_all_events (a_w: POINTER) is 
			-- Parsed as:
			-- void c_gtk_widget_set_all_events (
			--     GtkObject *a_w
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_widget_set_all_events (GtkObject *w);
		external
			" C | %"gtk_eiffel.h%""
		end

--	c_gtk_widget_grab_focus (a_wid: POINTER) is 
			-- Parsed as:
			-- void c_gtk_widget_grab_focus (
			--     GtkWidget *a_wid
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- void c_gtk_widget_grab_focus (GtkWidget *wid);
--		external
--			" C | %"gtk_eiffel.h%""
--		end

	c_gtk_widget_destroyed (a_widget: POINTER): INTEGER is 
			-- Parsed as:
			-- int c_gtk_widget_destroyed (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- int c_gtk_widget_destroyed (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_flags (a_widget: POINTER; a_flags: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_widget_set_flags (
			--     GtkWidget *a_widget,
			--     int a_flags
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_widget_set_flags (GtkWidget *widget, int flags);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_position_set (a_w: POINTER; a_x: INTEGER; a_y: INTEGER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_widget_position_set (
			--     GtkWidget *a_w,
			--     gint a_x,
			--     gint a_y
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			--  
			-- 
			-- 
			--  
			-- EIF_BOOLEAN c_gtk_widget_position_set (GtkWidget *w, gint x, gint y);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_minimum_size_set (a_w: POINTER; a_width: INTEGER; a_height: INTEGER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_widget_minimum_size_set (
			--     GtkWidget *a_w,
			--     guint a_width,
			--     guint a_height
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_BOOLEAN c_gtk_widget_minimum_size_set (GtkWidget *w, guint width, guint height);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_size (a_widget: POINTER; a_width: INTEGER; a_height: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_widget_set_size (
			--     GtkWidget *a_widget,
			--     int a_width,
			--     int a_height
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			--  
			-- 
			--  
			-- void c_gtk_widget_set_size (GtkWidget *widget, int width, int height);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_get_name (a_widget: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_REFERENCE c_gtk_widget_get_name (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_REFERENCE c_gtk_widget_get_name (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_name (a_widget: POINTER; a_name: POINTER) is 
			-- Parsed as:
			-- void c_gtk_widget_set_name (
			--     GtkWidget *a_widget,
			--     gchar *a_name
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_widget_set_name (GtkWidget *widget, const gchar *name);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_get_color_info (a_widget: POINTER; a_fgr: POINTER; a_fgg: POINTER; a_fgb: POINTER; a_fgpix: POINTER; a_textr: POINTER; a_textg: POINTER; a_textb: POINTER; a_textpix: POINTER; a_bgr: POINTER; a_bgg: POINTER; a_bgb: POINTER; a_bgpix: POINTER; a_baser: POINTER; a_baseg: POINTER; a_baseb: POINTER; a_basepix: POINTER; a_blackr: POINTER; a_blackg: POINTER; a_blackb: POINTER; a_blackpix: POINTER; a_whiter: POINTER; a_whiteg: POINTER; a_whiteb: POINTER; a_whitepix: POINTER) is 
			-- Parsed as:
			-- void c_gtk_widget_get_color_info (
			--     GtkWidget *a_widget,
			--     EIF_INTEGER *a_fgr,
			--     EIF_INTEGER *a_fgg,
			--     EIF_INTEGER *a_fgb,
			--     EIF_INTEGER *a_fgpix,
			--     EIF_INTEGER *a_textr,
			--     EIF_INTEGER *a_textg,
			--     EIF_INTEGER *a_textb,
			--     EIF_INTEGER *a_textpix,
			--     EIF_INTEGER *a_bgr,
			--     EIF_INTEGER *a_bgg,
			--     EIF_INTEGER *a_bgb,
			--     EIF_INTEGER *a_bgpix,
			--     EIF_INTEGER *a_baser,
			--     EIF_INTEGER *a_baseg,
			--     EIF_INTEGER *a_baseb,
			--     EIF_INTEGER *a_basepix,
			--     EIF_INTEGER *a_blackr,
			--     EIF_INTEGER *a_blackg,
			--     EIF_INTEGER *a_blackb,
			--     EIF_INTEGER *a_blackpix,
			--     EIF_INTEGER *a_whiter,
			--     EIF_INTEGER *a_whiteg,
			--     EIF_INTEGER *a_whiteb,
			--     EIF_INTEGER *a_whitepix
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			-- void c_gtk_widget_get_color_info (GtkWidget* widget,
			-- 	EIF_INTEGER* fgr,
			-- 	EIF_INTEGER* fgg,
			-- 	EIF_INTEGER* fgb,
			-- 	EIF_INTEGER* fgpix,
			-- 	EIF_INTEGER* textr,
			-- 	EIF_INTEGER* textg,
			-- 	EIF_INTEGER* textb,
			-- 	EIF_INTEGER* textpix,
			-- 	EIF_INTEGER* bgr,
			-- 	EIF_INTEGER* bgg,
			-- 	EIF_INTEGER* bgb,
			-- 	EIF_INTEGER* bgpix,
			-- 	EIF_INTEGER* baser,
			-- 	EIF_INTEGER* baseg,
			-- 	EIF_INTEGER* baseb,
			-- 	EIF_INTEGER* basepix,
			-- 	EIF_INTEGER* blackr,
			-- 	EIF_INTEGER* blackg,
			-- 	EIF_INTEGER* blackb,
			-- 	EIF_INTEGER* blackpix,
			-- 	EIF_INTEGER* whiter,
			-- 	EIF_INTEGER* whiteg,
			-- 	EIF_INTEGER* whiteb,
			-- 	EIF_INTEGER* whitepix
			-- 	);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_container_nb_children (a_widget: POINTER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_container_nb_children (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- gint c_gtk_container_nb_children (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_container_ith_child (a_widget: POINTER; a_i: INTEGER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_container_ith_child (
			--     GtkWidget *a_widget,
			--     guint a_i
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_container_ith_child (GtkWidget *widget, guint i);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_container_has_child (a_widget: POINTER; a_child: POINTER): INTEGER is 
			-- Parsed as:
			-- int c_gtk_container_has_child (
			--     GtkWidget *a_widget,
			--     GtkWidget *a_child
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- int c_gtk_container_has_child (GtkWidget *widget, GtkWidget *child);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_scrollable_area_add (a_scroll_area: POINTER; a_widget: POINTER) is 
			-- Parsed as:
			-- void c_gtk_scrollable_area_add (
			--     GtkWidget *a_scroll_area,
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_scrollable_area_add (GtkWidget *scroll_area, GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_scrollable_area_has_child (a_scroll_area: POINTER; a_child: POINTER): INTEGER is 
			-- Parsed as:
			-- int c_gtk_scrollable_area_has_child (
			--     GtkWidget *a_scroll_area,
			--     GtkWidget *a_child
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- int c_gtk_scrollable_area_has_child (GtkWidget *scroll_area, GtkWidget *child);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_container_set_bg_pixmap (a_container: POINTER; a_pixmap: POINTER) is 
			-- Parsed as:
			-- void c_gtk_container_set_bg_pixmap (
			--     GtkWidget *a_container,
			--     GtkWidget *a_pixmap
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_container_set_bg_pixmap (GtkWidget *container, GtkWidget *pixmap);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_container_remove_all_children (a_container: POINTER) is 
			-- Parsed as:
			-- void c_gtk_container_remove_all_children (
			--     GtkContainer *a_container
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_container_remove_all_children (GtkContainer *container);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_get_bg_color (a_tooltips: POINTER; a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_tooltips_get_bg_color (
			--     GtkTooltips *a_tooltips,
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- void c_gtk_tooltips_get_bg_color (GtkTooltips *tooltips, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_get_fg_color (a_tooltips: POINTER; a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_tooltips_get_fg_color (
			--     GtkTooltips *a_tooltips,
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_tooltips_get_fg_color (GtkTooltips *tooltips, EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_set_fg_color (a_tooltips: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_tooltips_set_fg_color (
			--     GtkTooltips *a_tooltips,
			--     int a_r,
			--     int a_g,
			--     int a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_tooltips_set_fg_color (GtkTooltips *tooltips, int r, int g, int b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_tooltips_set_bg_color (a_tooltips: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_tooltips_set_bg_color (
			--     GtkTooltips *a_tooltips,
			--     int a_r,
			--     int a_g,
			--     int a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_tooltips_set_bg_color (GtkTooltips *tooltips, int r, int g, int b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_toolbar_callback (a_w: POINTER; a_data: POINTER) is 
			-- Parsed as:
			-- void c_toolbar_callback (
			--     GtkObject *a_w,
			--     gpointer a_data
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- void c_toolbar_callback (GtkObject *w, gpointer data);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_toolbar_append_item (a_toolbar: POINTER; a_text: POINTER; a_tip: POINTER; a_private_tip: POINTER; a_icon: POINTER; a_func: POINTER; a_object: POINTER; a_p: POINTER) is 
			-- Parsed as:
			-- void c_gtk_toolbar_append_item (
			--     GtkToolbar *a_toolbar,
			--     char *a_text,
			--     char *a_tip,
			--     char *a_private_tip,
			--     GtkWidget *a_icon,
			--     EIF_PROCEDURE a_func,
			--     EIF_OBJECT a_object,
			--     callback_data_t **a_p
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_toolbar_append_item (GtkToolbar *toolbar, 
			-- 				const char *text, 
			-- 				const char *tip,
			-- 				const char *private_tip,
			-- 				GtkWidget *icon,
			-- 				EIF_PROCEDURE  func, EIF_OBJECT  object,
			-- 				callback_data_t **p);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_toolbar_new_horizontal: POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_toolbar_new_horizontal (
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- EIF_POINTER c_gtk_toolbar_new_horizontal (void);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_get_label_widget (a_widget: POINTER): POINTER is 
			-- Parsed as:
			-- GtkWidget* c_gtk_get_label_widget (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- GtkWidget* c_gtk_get_label_widget (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_toggle_button_active (a_button: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_toggle_button_active (
			--     GtkWidget *a_button
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_BOOLEAN c_gtk_toggle_button_active (GtkWidget *button);
		external
			" C | %"gtk_eiffel.h%""
		end

	toggle_button_state_selection_callback (a_togglebutton: POINTER; a_data: POINTER) is 
			-- Parsed as:
			-- void toggle_button_state_selection_callback (
			--     GtkToggleButton *a_togglebutton,
			--     gpointer a_data
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void toggle_button_state_selection_callback(GtkToggleButton *togglebutton,gpointer data);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_option_button_selected_menu_item (a_widget: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_option_button_selected_menu_item (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- EIF_POINTER c_gtk_option_button_selected_menu_item (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_option_button_index_of_menu_item (a_option_menu: POINTER; a_menu_item: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_option_button_index_of_menu_item (
			--     GtkWidget *a_option_menu,
			--     GtkWidget *a_menu_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_INTEGER c_gtk_option_button_index_of_menu_item (GtkWidget *option_menu, GtkWidget *menu_item);
		external
			" C | %"gtk_eiffel.h%""
		end

--	c_gtk_option_button_set_fg_color (a_option_menu: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_option_button_set_fg_color (
			--     GtkOptionMenu *a_option_menu,
			--     gint a_r,
			--     gint a_g,
			--     gint a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_option_button_set_fg_color (GtkOptionMenu *option_menu, gint r, gint g, gint b);
--		external
--			" C | %"gtk_eiffel.h%""
--		end

	c_gtk_option_button_set_bg_color (a_option_menu: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_option_button_set_bg_color (
			--     GtkOptionMenu *a_option_menu,
			--     gint a_r,
			--     gint a_g,
			--     gint a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_option_button_set_bg_color (GtkOptionMenu *option_menu, gint r, gint g, gint b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_menu_remove_all_items (a_menu: POINTER) is 
			-- Parsed as:
			-- void c_gtk_menu_remove_all_items (
			--     GtkMenu *a_menu
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_gtk_menu_remove_all_items (GtkMenu *menu);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_menu_get_child (a_menu: POINTER; a_i: INTEGER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_menu_get_child (
			--     GtkMenu *a_menu,
			--     gint a_i
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- EIF_POINTER c_gtk_menu_get_child (GtkMenu *menu, gint i);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_menu_nb_children (a_menu: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_menu_nb_children (
			--     GtkMenu *a_menu
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- EIF_INTEGER c_gtk_menu_nb_children (GtkMenu *menu);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_get_text_length (a_text: POINTER): INTEGER is 
			-- Parsed as:
			-- int c_gtk_get_text_length (
			--     GtkWidget *a_text
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- int c_gtk_get_text_length (GtkWidget* text);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_get_text_max_length (a_text: POINTER): INTEGER is 
			-- Parsed as:
			-- int c_gtk_get_text_max_length (
			--     GtkWidget *a_text
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- int c_gtk_get_text_max_length (GtkWidget* text);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_pixmap_create_empty (a_widget: POINTER): POINTER is 
			-- Parsed as:
			-- GtkWidget* c_gtk_pixmap_create_empty (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- GtkWidget* c_gtk_pixmap_create_empty  (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_pixmap_create_from_xpm (a_widget: POINTER; a_fname: POINTER): POINTER is 
			-- Parsed as:
			-- GtkWidget* c_gtk_pixmap_create_from_xpm (
			--     GtkWidget *a_widget,
			--     char *a_fname
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- GtkWidget *c_gtk_pixmap_create_from_xpm (GtkWidget *widget, char *fname);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_pixmap_read_from_xpm (a_pixmap: POINTER; a_pixmap_parent: POINTER; a_file_name: POINTER) is 
			-- Parsed as:
			-- void c_gtk_pixmap_read_from_xpm (
			--     GtkPixmap *a_pixmap,
			--     GtkWidget *a_pixmap_parent,
			--     char *a_file_name
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_pixmap_read_from_xpm ( GtkPixmap *pixmap,
			-- 				  GtkWidget *pixmap_parent,
			-- 				  char *file_name );
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_pixmap_create_with_size (a_window_parent: POINTER; a_width: INTEGER; a_height: INTEGER): POINTER is 
			-- Parsed as:
			-- GtkWidget* c_gtk_pixmap_create_with_size (
			--     GtkWidget *a_window_parent,
			--     gint a_width,
			--     gint a_height
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- GtkWidget* c_gtk_pixmap_create_with_size (GtkWidget *window_parent, gint width, gint height);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_pixmap_set_from_pixmap (a_pixmapDest: POINTER; a_pixmapSource: POINTER) is 
			-- Parsed as:
			-- void c_gtk_pixmap_set_from_pixmap (
			--     GtkWidget *a_pixmapDest,
			--     GtkWidget *a_pixmapSource
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_pixmap_set_from_pixmap (GtkWidget *pixmapDest, GtkWidget *pixmapSource);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_item_select (a_item: POINTER) is 
			-- Parsed as:
			-- void c_gtk_list_item_select (
			--     GtkWidget *a_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- void c_gtk_list_item_select (GtkWidget *item);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_item_unselect (a_item: POINTER) is 
			-- Parsed as:
			-- void c_gtk_list_item_unselect (
			--     GtkWidget *a_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_list_item_unselect (GtkWidget *item);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_item_is_selected (a_list: POINTER; a_item: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_list_item_is_selected (
			--     GtkWidget *a_list,
			--     GtkWidget *a_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_BOOLEAN c_gtk_list_item_is_selected (GtkWidget *list, GtkWidget *item);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_selection_mode (a_item: POINTER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_list_selection_mode (
			--     GtkWidget *a_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- gint c_gtk_list_selection_mode (GtkWidget *item);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_selected (a_list: POINTER): INTEGER is 
			-- Parsed as:
			-- guint c_gtk_list_selected (
			--     GtkWidget *a_list
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- guint c_gtk_list_selected (GtkWidget* list);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_selected_item (a_item: POINTER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_list_selected_item (
			--     GtkWidget *a_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- gint c_gtk_list_selected_item (GtkWidget *item);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_insert_item (a_list: POINTER; a_item: POINTER; a_position: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_list_insert_item (
			--     GtkWidget *a_list,
			--     GtkWidget *a_item,
			--     gint a_position
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_list_insert_item (GtkWidget *list, GtkWidget *item, gint position);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_remove_item (a_list: POINTER; a_item: POINTER) is 
			-- Parsed as:
			-- void c_gtk_list_remove_item (
			--     GtkWidget *a_list,
			--     GtkWidget *a_item
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_list_remove_item (GtkWidget *list, GtkWidget *item);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_list_rows (a_list: POINTER): INTEGER is 
			-- Parsed as:
			-- guint c_gtk_list_rows (
			--     GtkWidget *a_list
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- guint c_gtk_list_rows (GtkWidget *list);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_notebook_count (a_notebook: POINTER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_notebook_count (
			--     GtkWidget *a_notebook
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- gint c_gtk_notebook_count (GtkWidget *notebook);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_append_row (a_list: POINTER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_clist_append_row (
			--     GtkWidget *a_list
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			--  
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- gint c_gtk_clist_append_row (GtkWidget* list);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_selected (a_list: POINTER): INTEGER is 
			-- Parsed as:
			-- guint c_gtk_clist_selected (
			--     GtkWidget *a_list
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- guint c_gtk_clist_selected (GtkWidget* list);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_ith_selected_item (a_list: POINTER; a_i: INTEGER): INTEGER is 
			-- Parsed as:
			-- gint c_gtk_clist_ith_selected_item (
			--     GtkWidget *a_list,
			--     guint a_i
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- gint c_gtk_clist_ith_selected_item (GtkWidget* list, guint i);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_selection_length (a_list: POINTER): INTEGER is 
			-- Parsed as:
			-- guint c_gtk_clist_selection_length (
			--     GtkWidget *a_list
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- guint c_gtk_clist_selection_length (GtkWidget* list);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_set_fg_color (a_clist_row: POINTER; a_row: INTEGER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_clist_set_fg_color (
			--     GtkWidget *a_clist_row,
			--     int a_row,
			--     int a_r,
			--     int a_g,
			--     int a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_clist_set_fg_color (GtkWidget* clist_row, int row, int r, int g, int b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_set_bg_color (a_clist_row: POINTER; a_row: INTEGER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_clist_set_bg_color (
			--     GtkWidget *a_clist_row,
			--     int a_row,
			--     int a_r,
			--     int a_g,
			--     int a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_clist_set_bg_color (GtkWidget* clist_row, int row, int r, int g, int b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_get_fg_color (a_list_row: POINTER; a_row: INTEGER; a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_clist_get_fg_color (
			--     GtkWidget *a_list_row,
			--     int a_row,
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_clist_get_fg_color (GtkWidget* list_row, int row, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_get_bg_color (a_list_row: POINTER; a_row: INTEGER; a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_clist_get_bg_color (
			--     GtkWidget *a_list_row,
			--     int a_row,
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_clist_get_bg_color (GtkWidget* list_row, int row, EIF_INTEGER *r, EIF_INTEGER *g, EIF_INTEGER *b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_set_pixtext (a_clist: POINTER; a_row: INTEGER; a_column: INTEGER; a_pixmap: POINTER; a_text: POINTER) is 
			-- Parsed as:
			-- void c_gtk_clist_set_pixtext (
			--     GtkWidget *a_clist,
			--     int a_row,
			--     int a_column,
			--     GtkWidget *a_pixmap,
			--     gchar *a_text
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_clist_set_pixtext (GtkWidget* clist, int row, int column, GtkWidget *pixmap, gchar *text);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_unset_pixmap (a_clist: POINTER; a_row: INTEGER; a_column: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_clist_unset_pixmap (
			--     GtkWidget *a_clist,
			--     int a_row,
			--     int a_column
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_clist_unset_pixmap (GtkWidget* clist, int row, int column);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_title_shown (a_clist: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_clist_title_shown (
			--     GtkCList *a_clist
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_BOOLEAN c_gtk_clist_title_shown (GtkCList *clist);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_clist_column_width (a_clist: POINTER; a_column: INTEGER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_clist_column_width (
			--     GtkCList *a_clist,
			--     gint a_column
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_INTEGER c_gtk_clist_column_width (GtkCList *clist, gint column);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_table_rows (a_widget: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_table_rows (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- EIF_INTEGER c_gtk_table_rows        (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_table_columns (a_widget: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_table_columns (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_INTEGER c_gtk_table_columns     (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_table_set_spacing_if_needed (a_widget: POINTER) is 
			-- Parsed as:
			-- void c_gtk_table_set_spacing_if_needed (
			--     GtkWidget *a_widget
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_table_set_spacing_if_needed (GtkWidget *widget);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_insert_node: POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_ctree_insert_node (
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_ctree_insert_node (GtkCTree *, GtkCTreeNode*, GtkCTreeNode*, gchar *, guint8, GdkPixmap*, GdkBitmap*, gboolean, gboolean);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_item_is_expanded (a_node: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_ctree_item_is_expanded (
			--     GtkCTreeNode *a_node
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_BOOLEAN c_gtk_ctree_item_is_expanded (GtkCTreeNode *node);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_set_single_selection_mode (a_ctree: POINTER) is 
			-- Parsed as:
			-- void c_gtk_ctree_set_single_selection_mode (
			--     GtkCTree *a_ctree
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_ctree_set_single_selection_mode (GtkCTree *ctree);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_selected_item (a_ctree: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_ctree_selected_item (
			--     GtkCTree *a_ctree
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_ctree_selected_item (GtkCTree *ctree);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_item_set_pixtext (a_ctree: POINTER; a_node: POINTER; a_column: INTEGER; a_pixmap: POINTER; a_txt: POINTER; a_spacing: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_ctree_item_set_pixtext (
			--     GtkCTree *a_ctree,
			--     GtkCTreeNode *a_node,
			--     gint a_column,
			--     GtkPixmap *a_pixmap,
			--     gchar *a_txt,
			--     guint8 a_spacing
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_ctree_item_set_pixtext (GtkCTree *ctree, GtkCTreeNode *node, gint column, GtkPixmap *pixmap, gchar *txt, guint8 spacing);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_ctree_item_get_position_in_tree (a_ctree: POINTER; a_node: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_ctree_item_get_position_in_tree (
			--     GtkCTree *a_ctree,
			--     GtkCTreeNode *a_node
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_INTEGER c_gtk_ctree_item_get_position_in_tree (GtkCTree *ctree, GtkCTreeNode *node);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_text_insert (a_widget: POINTER; a_txt: POINTER) is 
			-- Parsed as:
			-- void c_gtk_text_insert (
			--     GtkWidget *a_widget,
			--     char *a_txt
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- void c_gtk_text_insert (GtkWidget *widget, const char *txt);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_text_full_insert (a_widget: POINTER; a_font: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER; a_txt: POINTER; a_length: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_text_full_insert (
			--     GtkWidget *a_widget,
			--     GdkFont *a_font,
			--     int a_r,
			--     int a_g,
			--     int a_b,
			--     char *a_txt,
			--     gint a_length
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_text_full_insert (GtkWidget *widget, GdkFont *font, int r, int g, int b, const char *txt, gint length);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_box_set_child_options (a_box: POINTER; a_child: POINTER; a_expand: INTEGER; a_fill: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_box_set_child_options (
			--     GtkWidget *a_box,
			--     GtkWidget *a_child,
			--     gint a_expand,
			--     gint a_fill
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- void c_gtk_box_set_child_options (GtkWidget *box, GtkWidget *child,
			-- 				  gint expand, gint fill);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_box_is_child_expandable (a_box: POINTER; a_child: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_BOOLEAN c_gtk_box_is_child_expandable (
			--     GtkWidget *a_box,
			--     GtkWidget *a_child
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- EIF_BOOLEAN c_gtk_box_is_child_expandable (GtkWidget *box, GtkWidget *child);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_box_set_child_expandable (a_box: POINTER; a_child: POINTER; a_flag: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_box_set_child_expandable (
			--     GtkWidget *a_box,
			--     GtkWidget *a_child,
			--     gint a_flag
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_box_set_child_expandable (GtkWidget *box, GtkWidget *child, gint flag);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_window_x (a_w: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_window_x (
			--     GtkWidget *a_w
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- EIF_INTEGER c_gtk_window_x (GtkWidget *w);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_window_y (a_w: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_window_y (
			--     GtkWidget *a_w
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_INTEGER c_gtk_window_y (GtkWidget *w);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_window_maximum_height (a_w: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_window_maximum_height (
			--     GtkWidget *a_w
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- EIF_INTEGER c_gtk_window_maximum_height (GtkWidget *w);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_window_maximum_width (a_w: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_window_maximum_width (
			--     GtkWidget *a_w
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_INTEGER c_gtk_window_maximum_width  (GtkWidget *w);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_window_set_modal (a_window: POINTER; a_modal: BOOLEAN) is 
			-- Parsed as:
			-- void c_gtk_window_set_modal (
			--     GtkWindow *a_window,
			--     gboolean a_modal
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_window_set_modal(GtkWindow* window, gboolean modal);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_window_title (a_window: POINTER): POINTER is 
			-- Parsed as:
			-- char* c_gtk_window_title (
			--     GtkWindow *a_window
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- char* c_gtk_window_title(GtkWindow* window);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_statusbar_item_create_pixmap_place (a_statusbar: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_statusbar_item_create_pixmap_place (
			--     GtkWidget *a_statusbar
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- 	
			--  
			-- 
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_statusbar_item_create_pixmap_place (GtkWidget *statusbar);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_statusbar_item_unset_pixmap (a_statusbar: POINTER; a_pixmap: POINTER) is 
			-- Parsed as:
			-- void c_gtk_statusbar_item_unset_pixmap (
			--     GtkWidget *a_statusbar,
			--     GtkWidget *a_pixmap
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_statusbar_item_unset_pixmap (GtkWidget *statusbar, GtkWidget *pixmap);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_statusbar_item_set_bg_color (a_statusbar: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_statusbar_item_set_bg_color (
			--     GtkWidget *a_statusbar,
			--     int a_r,
			--     int a_g,
			--     int a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			--  
			-- void c_gtk_statusbar_item_set_bg_color (GtkWidget *statusbar, int r, int g, int b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progress_bar_new_with_adjustment (a_val: REAL; a_min: REAL; a_max: REAL; a_step: REAL; a_page: REAL): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_progress_bar_new_with_adjustment (
			--     gfloat a_val,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step,
			--     gfloat a_page
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- EIF_POINTER c_gtk_progress_bar_new_with_adjustment (gfloat val, gfloat min, gfloat max, gfloat step, gfloat page);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progress_bar_set_adjustment (a_progressbar: POINTER; a_val: REAL; a_min: REAL; a_max: REAL; a_step: REAL) is 
			-- Parsed as:
			-- void c_gtk_progress_bar_set_adjustment (
			--     GtkProgressBar *a_progressbar,
			--     gfloat a_val,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_progress_bar_set_adjustment (GtkProgressBar *progressbar, gfloat val, gfloat min, gfloat max, gfloat step);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progress_bar_style (a_progressbar: POINTER): INTEGER is 
			-- Parsed as:
			-- EIF_INTEGER c_gtk_progress_bar_style (
			--     GtkWidget *a_progressbar
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- EIF_INTEGER c_gtk_progress_bar_style (GtkWidget *progressbar);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progressbar_set_minimum (a_bar: POINTER; a_value: REAL) is 
			-- Parsed as:
			-- void c_gtk_progressbar_set_minimum (
			--     GtkProgressBar *a_bar,
			--     gfloat a_value
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			-- void c_gtk_progressbar_set_minimum (GtkProgressBar *bar, gfloat value);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progressbar_get_minimum (a_bar: POINTER): REAL is 
			-- Parsed as:
			-- gfloat c_gtk_progressbar_get_minimum (
			--     GtkProgressBar *a_bar
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- gfloat c_gtk_progressbar_get_minimum (GtkProgressBar *bar);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progressbar_set_maximum (a_bar: POINTER; a_value: REAL) is 
			-- Parsed as:
			-- void c_gtk_progressbar_set_maximum (
			--     GtkProgressBar *a_bar,
			--     gfloat a_value
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_progressbar_set_maximum (GtkProgressBar *bar, gfloat value);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progressbar_get_maximum (a_bar: POINTER): REAL is 
			-- Parsed as:
			-- gfloat c_gtk_progressbar_get_maximum (
			--     GtkProgressBar *a_bar
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- gfloat c_gtk_progressbar_get_maximum (GtkProgressBar *bar);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progressbar_set_step (a_bar: POINTER; a_value: REAL) is 
			-- Parsed as:
			-- void c_gtk_progressbar_set_step (
			--     GtkProgressBar *a_bar,
			--     gfloat a_value
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_progressbar_set_step (GtkProgressBar *bar, gfloat value);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_progressbar_get_step (a_bar: POINTER): REAL is 
			-- Parsed as:
			-- gfloat c_gtk_progressbar_get_step (
			--     GtkProgressBar *a_bar
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- gfloat c_gtk_progressbar_get_step (GtkProgressBar *bar);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_selection_get_selection_entry (a_dialog: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_selection_get_selection_entry (
			--     GtkWidget *a_dialog
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_selection_get_selection_entry (GtkWidget *dialog);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_file_selection_get_dir (a_file_dialog: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_file_selection_get_dir (
			--     GtkWidget *a_file_dialog
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_file_selection_get_dir (GtkWidget *file_dialog);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_directory_selection_new (a_name: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_directory_selection_new (
			--     gchar *a_name
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_directory_selection_new (const gchar *name);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_color_selection_dialog_new (a_name: POINTER): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_color_selection_dialog_new (
			--     gchar *a_name
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- EIF_POINTER c_gtk_color_selection_dialog_new (gchar *name);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_color_selection_get_color (a_file_dialog: POINTER; a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_color_selection_get_color (
			--     GtkWidget *a_file_dialog,
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_color_selection_get_color (GtkWidget *file_dialog, EIF_INTEGER* r,  EIF_INTEGER* g, EIF_INTEGER* b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_color_selection_set_color (a_file_dialog: POINTER; a_r: INTEGER; a_g: INTEGER; a_b: INTEGER) is 
			-- Parsed as:
			-- void c_gtk_color_selection_set_color (
			--     GtkWidget *a_file_dialog,
			--     EIF_INTEGER a_r,
			--     EIF_INTEGER a_g,
			--     EIF_INTEGER a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- void c_gtk_color_selection_set_color (GtkWidget *file_dialog, EIF_INTEGER r, EIF_INTEGER g, EIF_INTEGER b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_new (a_value: REAL; a_min: REAL; a_max: REAL; a_step: REAL; a_leap: REAL): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_spin_button_new (
			--     gfloat a_value,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step,
			--     gfloat a_leap
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- EIF_POINTER c_gtk_spin_button_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_set_step (a_spinButton: POINTER; a_step: REAL) is 
			-- Parsed as:
			-- void c_gtk_spin_button_set_step (
			--     GtkSpinButton *a_spinButton,
			--     gfloat a_step
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- void c_gtk_spin_button_set_step (GtkSpinButton* spinButton, gfloat step);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_set_minimum (a_spinButton: POINTER; a_min: REAL) is 
			-- Parsed as:
			-- void c_gtk_spin_button_set_minimum (
			--     GtkSpinButton *a_spinButton,
			--     gfloat a_min
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_spin_button_set_minimum (GtkSpinButton* spinButton, gfloat min);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_spin_button_set_maximum (a_spinButton: POINTER; a_max: REAL) is 
			-- Parsed as:
			-- void c_gtk_spin_button_set_maximum (
			--     GtkSpinButton *a_spinButton,
			--     gfloat a_max
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_spin_button_set_maximum (GtkSpinButton* spinButton, gfloat max);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_step (a_range: POINTER; a_step: REAL) is 
			-- Parsed as:
			-- void c_gtk_range_set_step (
			--     GtkRange *a_range,
			--     gfloat a_step
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_gtk_range_set_step (GtkRange* range, gfloat step);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_minimum (a_range: POINTER; a_min: REAL) is 
			-- Parsed as:
			-- void c_gtk_range_set_minimum (
			--     GtkRange *a_range,
			--     gfloat a_min
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_range_set_minimum (GtkRange* range, gfloat min);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_maximum (a_range: POINTER; a_max: REAL) is 
			-- Parsed as:
			-- void c_gtk_range_set_maximum (
			--     GtkRange *a_range,
			--     gfloat a_max
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_range_set_maximum (GtkRange* range, gfloat max);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_range_set_leap (a_range: POINTER; a_step: REAL) is 
			-- Parsed as:
			-- void c_gtk_range_set_leap (
			--     GtkRange *a_range,
			--     gfloat a_step
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_range_set_leap (GtkRange* range, gfloat step);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_vscale_new (a_value: REAL; a_min: REAL; a_max: REAL; a_step: REAL; a_leap: REAL): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_vscale_new (
			--     gfloat a_value,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step,
			--     gfloat a_leap
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			-- EIF_POINTER c_gtk_vscale_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_hscale_new (a_value: REAL; a_min: REAL; a_max: REAL; a_step: REAL; a_leap: REAL): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_hscale_new (
			--     gfloat a_value,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step,
			--     gfloat a_leap
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_POINTER c_gtk_hscale_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_vscrollbar_new (a_value: REAL; a_min: REAL; a_max: REAL; a_step: REAL; a_leap: REAL; a_page: REAL): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_vscrollbar_new (
			--     gfloat a_value,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step,
			--     gfloat a_leap,
			--     gfloat a_page
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- EIF_POINTER c_gtk_vscrollbar_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap, gfloat page);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_hscrollbar_new (a_value: REAL; a_min: REAL; a_max: REAL; a_step: REAL; a_leap: REAL; a_page: REAL): POINTER is 
			-- Parsed as:
			-- EIF_POINTER c_gtk_hscrollbar_new (
			--     gfloat a_value,
			--     gfloat a_min,
			--     gfloat a_max,
			--     gfloat a_step,
			--     gfloat a_leap,
			--     gfloat a_page
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- EIF_POINTER c_gtk_hscrollbar_new (gfloat value, gfloat min, gfloat max, gfloat step, gfloat leap, gfloat page);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_scrollbar_set_value (a_scroll: POINTER; a_value: REAL) is 
			-- Parsed as:
			-- void c_gtk_scrollbar_set_value (
			--     GtkScrollbar *a_scroll,
			--     gfloat a_value
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_scrollbar_set_value (GtkScrollbar* scroll, gfloat value);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_scrollbar_set_page_size (a_scroll: POINTER; a_value: REAL) is 
			-- Parsed as:
			-- void c_gtk_scrollbar_set_page_size (
			--     GtkScrollbar *a_scroll,
			--     gfloat a_value
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_scrollbar_set_page_size (GtkScrollbar* scroll, gfloat value);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_style_default_bg_color (a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_style_default_bg_color (
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- 
			-- 
			-- 
			--  
			-- 
			-- 
			--  
			-- 
			-- 
			-- 
			-- void c_gtk_style_default_bg_color (EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
		external
			" C | %"gtk_eiffel.h%""
		end

	c_gtk_style_default_fg_color (a_r: POINTER; a_g: POINTER; a_b: POINTER) is 
			-- Parsed as:
			-- void c_gtk_style_default_fg_color (
			--     EIF_INTEGER *a_r,
			--     EIF_INTEGER *a_g,
			--     EIF_INTEGER *a_b
			-- );
			--
			-- Original C code from %"gtk_eiffel.h%":
			-- 
			-- void c_gtk_style_default_fg_color (EIF_INTEGER* r, EIF_INTEGER* g, EIF_INTEGER* b);
		external
			" C | %"gtk_eiffel.h%""
		end

end -- class EV_C_GTK

--! This file was generated by the GOTE converter.
--! It is derived from the headers of GTK.
--! It is licenced under LGPL. (see www.gnu.org)

