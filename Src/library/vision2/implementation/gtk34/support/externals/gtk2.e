note
	description: "Gtk Version Dependent Externals"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK2

inherit
	GDK

feature -- Style constants

--GTK_TYPE_STYLE_CONTEXT

--GTK_STYLE_CONTEXT (o: UNKNOWN)

--GTK_STYLE_CONTEXT_CLASS (c: UNKNOWN)

--GTK_IS_STYLE_CONTEXT (o: UNKNOWN)

--GTK_IS_STYLE_CONTEXT_CLASS (c: UNKNOWN)

--GTK_STYLE_CONTEXT_GET_CLASS (o: UNKNOWN)

	GTK_STYLE_PROPERTY_BACKGROUND_COLOR: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_STYLE_PROPERTY_BACKGROUND_COLOR"
		end

	GTK_STYLE_PROPERTY_COLOR: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_STYLE_PROPERTY_COLOR"
		end

	GTK_STYLE_PROPERTY_FONT: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_STYLE_PROPERTY_FONT"
		end

	GTK_STYLE_PROVIDER_PRIORITY_APPLICATION: NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_STYLE_PROVIDER_PRIORITY_APPLICATION"
		end

--GTK_STYLE_PROPERTY_FONT

--GTK_STYLE_PROPERTY_PADDING

--GTK_STYLE_PROPERTY_BORDER_WIDTH

--GTK_STYLE_PROPERTY_MARGIN

--GTK_STYLE_PROPERTY_BORDER_RADIUS

--GTK_STYLE_PROPERTY_BORDER_STYLE

--GTK_STYLE_PROPERTY_BORDER_COLOR

--GTK_STYLE_PROPERTY_BACKGROUND_IMAGE

--GTK_STYLE_CLASS_CELL

--GTK_STYLE_CLASS_ENTRY

--GTK_STYLE_CLASS_COMBOBOX_ENTRY

--GTK_STYLE_CLASS_BUTTON

--GTK_STYLE_CLASS_CALENDAR

--GTK_STYLE_CLASS_SLIDER

--GTK_STYLE_CLASS_BACKGROUND

--GTK_STYLE_CLASS_RUBBERBAND

--GTK_STYLE_CLASS_TOOLTIP

--GTK_STYLE_CLASS_MENU

--GTK_STYLE_CLASS_MENUBAR

--GTK_STYLE_CLASS_MENUITEM

--GTK_STYLE_CLASS_TOOLBAR

--GTK_STYLE_CLASS_PRIMARY_TOOLBAR

--GTK_STYLE_CLASS_INLINE_TOOLBAR

--GTK_STYLE_CLASS_RADIO

--GTK_STYLE_CLASS_CHECK

--GTK_STYLE_CLASS_DEFAULT

--GTK_STYLE_CLASS_TROUGH

--GTK_STYLE_CLASS_SCROLLBAR

--GTK_STYLE_CLASS_SCALE

--GTK_STYLE_CLASS_SCALE_HAS_MARKS_ABOVE

--GTK_STYLE_CLASS_SCALE_HAS_MARKS_BELOW

--GTK_STYLE_CLASS_HEADER

--GTK_STYLE_CLASS_ACCELERATOR

--GTK_STYLE_CLASS_RAISED

--GTK_STYLE_CLASS_GRIP

--GTK_STYLE_CLASS_DOCK

--GTK_STYLE_CLASS_PROGRESSBAR

--GTK_STYLE_CLASS_SPINNER

--GTK_STYLE_CLASS_MARK

--GTK_STYLE_CLASS_EXPANDER

--GTK_STYLE_CLASS_SPINBUTTON

--GTK_STYLE_CLASS_NOTEBOOK

--GTK_STYLE_CLASS_VIEW

--GTK_STYLE_CLASS_SIDEBAR

--GTK_STYLE_CLASS_IMAGE

--GTK_STYLE_CLASS_HIGHLIGHT

--GTK_STYLE_CLASS_FRAME

--GTK_STYLE_CLASS_DND

--GTK_STYLE_CLASS_PANE_SEPARATOR

--GTK_STYLE_CLASS_SEPARATOR

--GTK_STYLE_CLASS_INFO

--GTK_STYLE_CLASS_WARNING

--GTK_STYLE_CLASS_QUESTION

--GTK_STYLE_CLASS_ERROR

--GTK_STYLE_CLASS_HORIZONTAL

--GTK_STYLE_CLASS_VERTICAL

--GTK_STYLE_REGION_ROW

--GTK_STYLE_REGION_COLUMN

--GTK_STYLE_REGION_COLUMN_HEADER

--GTK_STYLE_REGION_TAB

feature -- Style

	gtk_style_context_new: POINTER
		external
			"C signature (): GtkStyleContext* use <ev_gtk.h>"
		end

	gtk_style_context_add_provider_for_screen (screen: POINTER; provider: POINTER; priority: NATURAL_32)
		external
			"C signature (GdkScreen*, GtkStyleProvider*, guint) use <ev_gtk.h>"
		end

	gtk_style_context_remove_provider_for_screen (screen: POINTER; provider: POINTER)
		external
			"C signature (GdkScreen*, GtkStyleProvider*) use <ev_gtk.h>"
		end

	gtk_style_context_add_provider (context: POINTER; provider: POINTER; priority: NATURAL_32)
		external
			"C signature (GtkStyleContext*, GtkStyleProvider*, guint) use <ev_gtk.h>"
		end

	gtk_style_context_remove_provider (context: POINTER; provider: POINTER)
		external
			"C signature (GtkStyleContext*, GtkStyleProvider*) use <ev_gtk.h>"
		end

	gtk_style_context_get_property (context: POINTER; property: POINTER; state: INTEGER_8; value: POINTER)
		external
			"C signature (GtkStyleContext*, gchar*, GtkStateFlags, GValue*) use <ev_gtk.h>"
		end

	gtk_style_context_set_path (context: POINTER; path: POINTER)
		external
			"C signature (GtkStyleContext*, GtkWidgetPath*) use <ev_gtk.h>"
		end

	gtk_style_context_get_path (context: POINTER): POINTER
		external
			"C signature (GtkStyleContext*): GtkWidgetPath* use <ev_gtk.h>"
		end

	gtk_style_context_list_classes (context: POINTER): POINTER
		external
			"C signature (GtkStyleContext*): GList* use <ev_gtk.h>"
		end

	gtk_style_context_add_class (context: POINTER; class_name: POINTER)
		external
			"C signature (GtkStyleContext*, gchar*) use <ev_gtk.h>"
		end

	gtk_style_context_remove_class (context: POINTER; class_name: POINTER)
		external
			"C signature (GtkStyleContext*, gchar*) use <ev_gtk.h>"
		end

	gtk_style_context_has_class (context: POINTER; class_name: POINTER)
		external
			"C signature (GtkStyleContext*, gchar*) use <ev_gtk.h>"
		end

	gtk_style_context_get_style_property (context: POINTER; property_name: POINTER; value: POINTER)
		external
			"C signature (GtkStyleContext*, gchar*, GValue*) use <ev_gtk.h>"
		end

	gtk_style_context_get_style (context: POINTER)
		external
			"C signature (GtkStyleContext*) use <ev_gtk.h>"
		end

	gtk_style_context_set_screen (context: POINTER; screen: POINTER)
		external
			"C signature (GtkStyleContext*, GdkScreen*) use <ev_gtk.h>"
		end

	gtk_style_context_get_screen (context: POINTER): POINTER
		external
			"C signature (GtkStyleContext*): GdkScreen* use <ev_gtk.h>"
		end

	gtk_style_context_set_junction_sides (context: POINTER; sides: INTEGER_8)
		external
			"C signature (GtkStyleContext*, GtkJunctionSides) use <ev_gtk.h>"
		end

	gtk_style_context_get_junction_sides (context: POINTER): INTEGER_8
		external
			"C signature (GtkStyleContext*): GtkJunctionSides use <ev_gtk.h>"
		end

	gtk_style_context_lookup_color (context: POINTER; color_name: POINTER; color: POINTER)
			-- Lookup color named `color_name` for context `context`
		external
			"C signature (GtkStyleContext*, gchar*, GdkRGBA*) use <ev_gtk.h>"
		end

	gtk_style_context_get (context: POINTER; state: INTEGER; property: POINTER; description: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_style_context_get ($context, $state, $property, $description, NULL)"
		end

	gtk_style_context_get_border (context: POINTER; state: INTEGER_8; border: POINTER)
		external
			"C signature (GtkStyleContext*, GtkStateFlags, GtkBorder*) use <ev_gtk.h>"
		end

	gtk_style_context_get_padding (context: POINTER; state: INTEGER_8; padding: POINTER)
		external
			"C signature (GtkStyleContext*, GtkStateFlags, GtkBorder*) use <ev_gtk.h>"
		end

	gtk_style_context_get_margin (context: POINTER; state: INTEGER_8; margin: POINTER)
		external
			"C signature (GtkStyleContext*, GtkStateFlags, GtkBorder*) use <ev_gtk.h>"
		end

	gtk_style_context_reset_widgets (screen: POINTER)
		external
			"C signature (GdkScreen*) use <ev_gtk.h>"
		end

feature -- Window

	frozen gtk_window_set_accept_focus (a_window: POINTER; a_accept: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_window_set_accept_focus((GtkWindow*)$a_window, (gboolean) $a_accept)"
		end

	frozen gtk_window_get_focus (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWindow*): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_window_get_position (a_window: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (GtkWindow*, gint*, gint*) use <ev_gtk.h>"
		end

	frozen gtk_window_get_size (a_window: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (GtkWindow*, gint*, gint*) use <ev_gtk.h>"
		end

	frozen gtk_window_set_decorated (a_window: POINTER; a_decor: BOOLEAN)
		external
			"C signature (GtkWindow*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_window_move (a_window: POINTER; a_x, a_y: INTEGER_32)
		external
			"C signature (GtkWindow*, gint, gint) use <ev_gtk.h>"
		end

	frozen gtk_window_has_toplevel_focus (a_window: POINTER): BOOLEAN
		external
			"C signature (GtkWindow*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_window_is_active (a_window: POINTER): BOOLEAN
		external
			"C signature (GtkWindow*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_window_resize (a_window: POINTER; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C signature (GtkWindow*, gint, gint) use <ev_gtk.h>"
		end

	frozen gtk_window_present (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_iconify (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_deiconify (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_stick (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_unstick (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_maximize (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_unmaximize (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_fullscreen (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_unfullscreen (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_window_set_icon (a_window, a_icon: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_window_set_icon ((GtkWindow*) $a_window, (GdkPixbuf*) $a_icon)"
		end

feature -- Window, Enum		

	frozen gtk_win_pos_center_on_parent_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_CENTER_ON_PARENT"
		end

feature -- Event box

	frozen gtk_event_box_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_is_event_box (a_object: POINTER): BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_IS_EVENT_BOX"
		end

	frozen gtk_event_box_set_visible_window (a_event_box: POINTER; visible_window: BOOLEAN)
		external
			"C signature (GtkEventBox*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_event_box_set_above_child (a_event_box: POINTER; above_child: BOOLEAN)
		external
			"C signature (GtkEventBox*, gboolean) use <ev_gtk.h>"
		end

feature -- Orientation

	gtk_orientable_set_orientation (a_orientable: POINTER; a_orientation: NATURAL_8)
		external
			"C signature (GtkOrientable*, GtkOrientation) use <ev_gtk.h>"
		end

feature -- Layout

	frozen gtk_layout_new (a_hadjustment, a_vadjustment: POINTER): POINTER
		external
			"C signature (GtkAdjustment*, GtkAdjustment*): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_layout_put (a_layout, a_child_widget: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkLayout*, GtkWidget*, gint, gint) use <ev_gtk.h>"
		end

	frozen gtk_layout_move (a_layout, a_child_widget: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkLayout*, GtkWidget*, gint, gint) use <ev_gtk.h>"
		end

	frozen gtk_layout_set_size (a_layout: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkLayout*, guint, guint) use <ev_gtk.h>"
		end

	frozen gtk_layout_get_size (a_layout: POINTER; a_x, a_y: TYPED_POINTER [INTEGER])
		external
			"C signature (GtkLayout*, guint*, guint*) use <ev_gtk.h>"
		end

	frozen gtk_layout_get_bin_window (a_layout: POINTER): POINTER
		external
			"C signature (GtkLayout*): GdkWindow* use <ev_gtk.h>"
		end

--GtkAdjustment *     gtk_layout_get_hadjustment          (GtkLayout *layout);
--GtkAdjustment *     gtk_layout_get_vadjustment          (GtkLayout *layout);
--void                gtk_layout_set_hadjustment          (GtkLayout *layout,
--                                                         GtkAdjustment *adjustment);
--void                gtk_layout_set_vadjustment          (GtkLayout *layout,
--                                                         GtkAdjustment *adjustment);


feature -- Icon

	icon_theme_list_icon_names (icon_theme: POINTER; a_context: POINTER): detachable ARRAYED_LIST [STRING_32]
		local
			glist, p: POINTER
			i, n: INTEGER
			str: EV_GTK_C_STRING
		do
			glist := gtk_icon_theme_list_icons (icon_theme, a_context)
			if not glist.is_default_pointer then
				n := g_list_length (glist)
				create Result.make (n)
				from
					i := 1
				until
					i > n
				loop
					p := g_list_nth_data (glist, i - 1)
					if not p.is_default_pointer then
						create str.make_from_pointer (p)
						Result.extend (str.string)
						{GTK}.g_free (p)
					end
					i := i + 1
				end
			end
			{GTK}.g_list_free (glist)
		ensure
			instance_free: class
		end

	gtk_icon_theme_list_icons (icon_theme: POINTER; a_context: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (GList*)gtk_icon_theme_list_icons ((GtkIconTheme *)$icon_theme, (const gchar *)$a_context);"
		end

	gtk_icon_theme_load_icon (icon_theme: POINTER; icon_name: POINTER; size: INTEGER_8; flags: INTEGER_8; error: POINTER ) : POINTER
		note
			eis: "name=gtk_icon_theme_load_icon", "src=https://developer.gnome.org/gtk3/stable/GtkIconTheme.html#gtk-icon-theme-load-icon"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_icon_theme_load_icon ((GtkIconTheme *)$icon_theme,
				                          (const gchar *)$icon_name,
				                          (gint)$size,
				                          (GtkIconLookupFlags)$flags,
				                          (GError **)$error)
			]"
		end

	gtk_icon_theme_get_for_screen (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_icon_theme_get_for_screen ((GdkScreen*) $a_screen)"
		end

	gtk_icon_theme_get_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_icon_theme_get_default ();"
		end

	gtk_icon_theme_lookup_icon (icon_theme: POINTER; icon_name: POINTER; size: INTEGER; flags: INTEGER): POINTER
		note
			eis: "name=gtk_icon_theme_lookup_icon", "src=https://developer.gnome.org/gtk3/stable/GtkIconTheme.html#gtk-icon-theme-lookup-icon"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_icon_theme_lookup_icon ((GtkIconTheme *)$icon_theme,
				                            (const gchar *)$icon_name,
				                            (gint)$size,
				                            (GtkIconLookupFlags)$flags)
		     ]"
		end

	frozen gtk_image_new_from_icon_name (icon_name: POINTER; size: INTEGER): POINTER
		external
			"C signature (const gchar *, GtkIconSize): GtkWidget* use <ev_gtk.h>"
		end

feature -- Render		

	gtk_render_check (context: POINTER; cr: POINTER; x: REAL_64; y: REAL_64 ; width: REAL_64 ; height: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end

	gtk_render_option (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end


	gtk_render_arrow (context: POINTER; cr: POINTER; angle: REAL_64 ; x: REAL_64 ; y: REAL_64 ; size: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end

	frozen gtk_render_background (context: POINTER; cr: POINTER; x, y, width, height: REAL_64)
			-- Renders the background of an element.		
		note
			eis: "name=gtk_render_background", "src=https://developer.gnome.org/gtk3/stable/GtkStyleContext.html#gtk-render-background"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_render_background ((GtkStyleContext *)$context,
                       (cairo_t *)$cr,
                       (gdouble)$x, (gdouble)$y, (gdouble)$width, (gdouble)$height
					);
			]"
		end

	frozen gtk_render_frame (context: POINTER; cr: POINTER; x, y, width, height: REAL_64)
			-- Renders a frame around the rectangle defined by x , y , width , height .
		note
			eis: "name=gtk_render_frame", "src=https://developer.gnome.org/gtk3/stable/GtkStyleContext.html#gtk-render-frame"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_render_frame ((GtkStyleContext *)$context,
                  	(cairo_t *)$cr,
                  	(gdouble)$x, (gdouble)$y, (gdouble)$width, (gdouble)$height
                  );
			]"
		end

	gtk_render_expander (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end


	gtk_render_focus (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end


	gtk_render_layout (context: POINTER; cr: POINTER; x: REAL_64; y: REAL_64; layout: POINTER)
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, PangoLayout*) use <ev_gtk.h>"
		end


	gtk_render_line (context: POINTER; cr: POINTER; x0: REAL_64 ; y0: REAL_64 ; x1: REAL_64 ; y1: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end

	gtk_render_slider (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 ; orientation: INTEGER_8)
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble, GtkOrientation) use <ev_gtk.h>"
		end

	gtk_render_extension (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 ; gap_side: INTEGER_8)
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble, GtkPositionType) use <ev_gtk.h>"
		end

	gtk_render_handle (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end

	gtk_render_activity (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 )
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble) use <ev_gtk.h>"
		end

feature -- Container

	gtk_container_child_get_property (container: POINTER; child: POINTER; property_name: POINTER; value: POINTER)
		external
			"C signature (GtkContainer*, GtkWidget*, gchar*, GValue*) use <ev_gtk.h>"
		end

feature -- IMContext

	frozen gtk_im_context_simple_new: POINTER
		external
			"C signature (): GtkIMContext* use <ev_gtk.h>"
		end

	frozen gtk_im_context_reset (a_context: POINTER)
		external
			"C signature (GtkIMContext*) use <ev_gtk.h>"
		end

	frozen gtk_im_context_focus_in (a_context: POINTER)
		external
			"C signature (GtkIMContext*) use <ev_gtk.h>"
		end

	frozen gtk_im_context_focus_out (a_context: POINTER)
		external
			"C signature (GtkIMContext*) use <ev_gtk.h>"
		end

	frozen gtk_im_context_filter_keypress (a_context, a_event_key: POINTER): BOOLEAN
		external
			"C signature (GtkIMContext*, GdkEventKey*): EIF_BOOLEAN use <ev_gtk.h>"
		end

	frozen gtk_im_context_set_client_window (a_context, a_window: POINTER)
		external
			"C signature (GtkIMContext*, GdkWindow*) use <ev_gtk.h>"
		end

	frozen gtk_im_context_get_surrounding (a_context: POINTER; a_text_ptr: TYPED_POINTER [POINTER]; a_cursor_index: TYPED_POINTER [INTEGER]): BOOLEAN
		external
			"C signature (GtkIMContext*, gchar**, gint*): EIF_BOOLEAN use <ev_gtk.h>"
		end

feature -- Events		

	frozen events_pending: BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_pending (NULL)"
		end

	frozen gtk_event_iteration: BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_iteration(NULL, FALSE)"
		end

	frozen g_main_context_pending (ctx: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_pending ($ctx)"
		end

	frozen g_main_context_iteration (ctx: POINTER; a_may_block: BOOLEAN): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_iteration($ctx, $a_may_block)"
		end

	frozen dispatch_events
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_dispatch(g_main_context_default())"
		end

	frozen g_main_context_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_default()"
		end

	frozen g_main_context_dispatch (a_context: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_dispatch((GMainContext*) $a_context)"
		end

	frozen g_main_context_release (a_context: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_release((GMainContext*) $a_context)"
		end

	frozen g_main_context_acquire (a_context: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_main_context_acquire((GMainContext*) $a_context)"
		end

feature -- Widgets		

	frozen gtk_widget_is_toplevel (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_has_screen (a_widget: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_has_screen ((GtkWidget*) $a_widget)"
		end

	frozen gtk_widget_get_screen (a_widget: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_get_screen ((GtkWidget*) $a_widget)"
		end

	frozen gtk_widget_get_realized (a_widget: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_get_realized ((GtkWidget*) $a_widget)"
		end

	frozen gtk_widget_destroy (a_widget: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_destroy((GtkWidget*) $a_widget)"
		end

feature -- Toolbar		

	frozen gtk_toolbar_new: POINTER
		external
			"C signature () use <ev_gtk.h>"
		end

	frozen gtk_toolbar_set_style (a_toolbar: POINTER; a_style: INTEGER)
		external
			"C signature (GtkToolbar*, GtkToolbarStyle) use <ev_gtk.h>"
		end

	frozen gtk_toolbar_set_show_arrow (a_toolbar: POINTER; show_arrow: BOOLEAN)
		external
			"C signature (GtkToolbar*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_toolbar_insert (a_toolbar, a_toolitem: POINTER; a_pos: INTEGER_32)
		external
			"C signature (GtkToolbar*, GtkToolItem*, gint) use <ev_gtk.h>"
		end

	frozen gtk_toolbar_icons_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_ICONS"
		end

	frozen gtk_toolbar_text_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_TEXT"
		end

	frozen gtk_toolbar_both_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_BOTH"
		end

	frozen gtk_toolbar_both_horiz_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_BOTH_HORIZ"
		end


feature -- Labels		

	frozen gtk_label_set_angle (a_label: POINTER; a_angle: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_label_set_angle ((GtkLabel*) $a_label, (double) $a_angle);
			]"
		end

	frozen gtk_label_set_ellipsize (a_label: POINTER; a_mode: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_label_set_ellipsize ((GtkLabel*) $a_label, (PangoEllipsizeMode) $a_mode);
			]"
		end

	frozen gtk_label_get_label (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkLabel*): EIF_POINTER use <ev_gtk.h>"
		end

feature -- Mem

	frozen glib_mem_profiler_table: POINTER
		external
			"C macro use <ev_gtk.h>"
		alias
			"glib_mem_profiler_table"
		end

feature -- ScrolledWindow

	frozen gtk_scrolled_window_set_shadow_type (a_window: POINTER; a_shadow_type: INTEGER_32)
		external
			"C signature (GtkScrolledWindow*, GtkShadowType) use <ev_gtk.h>"
		end

feature -- Enum		

	frozen gtk_icon_size_dialog_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_ICON_SIZE_DIALOG"
		end

	frozen gtk_tree_view_column_get_button (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkTreeViewColumn*): GtkWidget* use <ev_gtk.h>"
		end

--	frozen gdk_drawable_get_size (a_drawable: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
--		external
	--			"C signature (GdkDrawable*, gint*, gint*) use <ev_gtk.h>"
--		end

	frozen gtk_combo_box_popup (a_combo: POINTER)
		external
			"C signature (GtkComboBox*) use <ev_gtk.h>"
		end

	frozen gtk_combo_box_popdown (a_combo: POINTER)
		external
			"C signature (GtkComboBox*) use <ev_gtk.h>"
		end

	frozen gtk_entry_set_has_frame (a_entry: POINTER; has_frame: BOOLEAN)
		external
			"C signature (GtkEntry*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_entry_set_alignment (a_entry: POINTER; a_alignment: REAL_32)
		external
			"C signature (GtkEntry*, gfloat) use <ev_gtk.h>"
		end

	frozen gtk_get_current_event_time: NATURAL_32
		external
			"C signature (): guint32 use <ev_gtk.h>"
		end

	frozen gtk_tree_path_list_free_contents (a_list: POINTER)
			-- Free tree path items contained within `a_list'
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_list_foreach ((GList*) $a_list, (GFunc) gtk_tree_path_free, NULL)"
		end

	frozen g_value_unset (a_value: POINTER)
		external
			"C signature (GValue*) use <ev_gtk.h>"
		end

	frozen gtk_tree_view_column_grow_only_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_GROW_ONLY"
		end

	frozen gtk_tree_view_column_fixed_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_FIXED"
		end

	frozen gtk_text_view_set_tabs (a_text_view, a_tab_array: POINTER)
		external
			"C signature (GtkTextView*, PangoTabArray*) use <ev_gtk.h>"
		end

	frozen gdk_event_window_state_struct_changed_mask (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventWindowState): EIF_INTEGER"
		alias
			"changed_mask"
		end

	frozen gdk_event_window_state_struct_new_window_state (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventWindowState): EIF_INTEGER"
		alias
			"new_window_state"
		end

	frozen gtk_widget_get_has_window (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_set_has_window (a_widget: POINTER; a_has_window: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_widget_set_redraw_on_allocate (a_widget: POINTER; redraw_on_allocate: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_widget_set_can_default (a_widget: POINTER; a_can_default: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_widget_set_app_paintable (a_widget: POINTER; a_paintable: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_widget_set_tooltip_text (a_widget: POINTER; a_text: POINTER)
		external
			"C signature (GtkWidget*, gchar*) use <ev_gtk.h>"
		end

	frozen gtk_widget_get_tooltip_text (a_widget: POINTER): POINTER
		external
			"C signature (GtkWidget*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_widget_set_minimum_size (a_c_widget: POINTER; a_width, a_height: INTEGER_32)
			-- Set the gtk minimum size (i.e size request), to  `a_width` x `a_height`.
			-- if a value is -1, it unsets the minimum size for the related property (width or height).
		do
			gtk_widget_set_size_request (a_c_widget, a_width, a_height)
		ensure
			instance_free: class
		end

	frozen gtk_widget_minimum_width (a_c_widget: POINTER): INTEGER_32
		do
			gtk_widget_get_size_request (a_c_widget, $Result, default_pointer)
		ensure then
			instance_free: class
		end

	frozen gtk_widget_minimum_height (a_c_widget: POINTER): INTEGER_32
		do
			gtk_widget_get_size_request (a_c_widget, default_pointer, $Result)
		ensure then
			instance_free: class
		end

	frozen gtk_widget_get_size_request (a_widget: POINTER; w, h: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_get_size_request ((GtkWidget*) $a_widget, (gint*) $w, (gint*) $h)"
		ensure
			instance_free: class
		end

	frozen gtk_widget_set_size_request (a_widget: POINTER; a_width, a_height: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_size_request ((GtkWidget*) $a_widget, (gint) $a_width, (gint) $a_height)"
		end

	frozen gtk_widget_size_allocate (a_widget: POINTER; a_allocation: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_size_allocate ((GtkWidget*) $a_widget, (GtkAllocation*) $a_allocation)"
		end

	frozen gtk_tree_view_scroll_to_cell (a_tree_view, a_tree_path, a_tree_column: POINTER; use_align: BOOLEAN; x_align, y_align: REAL_32)
		external
			"C signature (GtkTreeView*, GtkTreePath*, GtkTreeViewColumn*, gboolean, gfloat, gfloat) use <ev_gtk.h>"
		end

	frozen gtk_widget_style_get_integer (a_widget, a_property: POINTER; a_int_ptr: TYPED_POINTER [INTEGER_32])
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_style_get ((GtkWidget*) $a_widget, (gchar*) $a_property, (gint*) $a_int_ptr, NULL);"
		end

	frozen gtk_tree_view_get_expander_column (a_tree_view: POINTER): POINTER
		external
			"C signature (GtkTreeView*): GtkTreeViewColumn* use <ev_gtk.h>"
		end

	frozen gtk_tree_path_new_from_string (a_string: POINTER): POINTER
		external
			"C signature (gchar*): GtkTreePath* use <ev_gtk.h>"
		end

	frozen gtk_separator_tool_item_new: POINTER
		external
			"C signature (): GtkToolItem* use <ev_gtk.h>"
		end

	frozen gtk_separator_tool_item_set_draw (a_tool_item: POINTER; a_draw: BOOLEAN)
		external
			"C signature (GtkSeparatorToolItem*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_tool_item_set_is_important (a_toolitem: POINTER; is_important: BOOLEAN)
		external
			"C signature (GtkToolItem*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_toggle_tool_button_set_active (a_button: POINTER; a_active: BOOLEAN)
		external
			"C signature (GtkToggleToolButton*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_toggle_tool_button_get_active (a_button: POINTER): BOOLEAN
		external
			"C signature (GtkToggleToolButton*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_tool_button_new (icon_widget, a_label_text: POINTER): POINTER
		external
			"C signature (GtkWidget*, gchar*): GtkToolItem* use <ev_gtk.h>"
		end

	frozen gtk_radio_tool_button_new (a_radio_group: POINTER): POINTER
		external
			"C signature (GSList*): GtkToolItem* use <ev_gtk.h>"
		end

	frozen gtk_radio_tool_button_set_group (a_radio_button, a_radio_group: POINTER)
		external
			"C signature (GtkRadioToolButton*, GSList*) use <ev_gtk.h>"
		end

	frozen gtk_radio_tool_button_get_group (a_radio_button: POINTER): POINTER
		external
			"C signature (GtkRadioToolButton*): GSList* use <ev_gtk.h>"
		end

	frozen gtk_toggle_tool_button_new: POINTER
		external
			"C signature (): GtkToolItem* use <ev_gtk.h>"
		end

	frozen gtk_tool_button_set_icon_widget (tool_button, icon_widget: POINTER)
		external
			"C signature (GtkToolButton*, GtkWidget*) use <ev_gtk.h>"
		end

	frozen gtk_tool_button_set_label (tool_button, a_text: POINTER)
		external
			"C signature (GtkToolButton*, gchar*) use <ev_gtk.h>"
		end

	frozen gtk_tool_button_get_label (tool_button: POINTER): POINTER
		external
			"C signature (GtkToolButton*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_ok_enum_label: POINTER
		do
			Result := (create {C_STRING}.make ("_OK")).item
		ensure
			instance_free: class
		end

	frozen gtk_open_enum_label: POINTER
		do
			Result := (create {C_STRING}.make ("_OPEN")).item
		ensure
			instance_free: class
		end

	frozen gtk_response_ok_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_OK"
		end

	frozen gtk_response_yes_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_YES"
		end

	frozen gtk_response_no_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_NO"
		end

	frozen gtk_response_delete_event_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_DELETE_EVENT"
		end

	frozen gtk_response_accept_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_ACCEPT"
		end

	frozen gtk_response_cancel_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_CANCEL"
		end

	frozen gtk_response_apply_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_APPLY"
		end

	frozen gtk_save_enum_label: POINTER
		do
			Result := (create {C_STRING}.make ("_SAVE")).item
		ensure
			instance_free: class
		end

	frozen gtk_cancel_enum_label: POINTER
		do
			Result := (create {C_STRING}.make ("_CANCEL")).item
		ensure
			instance_free: class
		end

	frozen gtk_combo_box_get_active (a_combo: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_get_active ((GtkComboBox*) $a_combo)"
		end

	frozen gtk_combo_box_set_active (a_combo: POINTER; a_active: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_set_active ((GtkComboBox*) $a_combo, (gint) $a_active)"
		end

	frozen gtk_entry_get_completion (a_entry: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_entry_get_completion ((GtkEntry*) $a_entry)"
		end

	frozen gtk_combo_box_new_with_entry: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_combo_box_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_combo_box_set_model (a_combo_box, a_model: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_set_model ((GtkComboBox*) $a_combo_box, (GtkTreeModel*) $a_model)"
		end

	frozen gtk_combo_box_set_entry_text_column (a_combo_box: POINTER; a_column: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_set_entry_text_column ((GtkComboBox*) $a_combo_box, (gint) $a_column)"
		end

	frozen gtk_cell_layout_pack_start (a_cell_layout, a_cell_renderer: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_pack_start ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		end

	frozen gtk_cell_layout_set_attribute (a_cell_layout, a_cell_renderer, a_attribute: POINTER; a_pos: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_set_attributes ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gchar*) $a_attribute, (gint) $a_pos, NULL)"
		end

	frozen gtk_cell_layout_reorder (a_cell_layout, a_cell_renderer: POINTER; a_pos: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_reorder ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gint) $a_pos)"
		end

	frozen gtk_cell_layout_clear (a_cell_layout: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_clear ((GtkCellLayout*) $a_cell_layout)"
		end

	frozen gtk_tree_path_free (a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_free ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_get_path_at_pos (a_tree_view: POINTER; a_x, a_y: INTEGER_32; a_tree_path, a_tree_column: POINTER; a_cell_x, a_cell_y: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_path_at_pos ((GtkTreeView*) $a_tree_view, (gint) $a_x, (gint) $a_y, (GtkTreePath**) $a_tree_path, (GtkTreeViewColumn**) $a_tree_column, (gint*) $a_cell_x, (gint*) $a_cell_y)"
		end

	frozen gtk_tree_view_column_cell_get_size (a_tree_view_column: POINTER; a_cell_area: POINTER; a_x_offset, a_y_offset, a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_cell_get_size ((GtkTreeViewColumn*) $a_tree_view_column, (GdkRectangle*) $a_cell_area, (gint*) $a_x_offset, (gint*) $a_y_offset, (gint*) $a_width, (gint*) $a_height)"
		end

	frozen gtk_tree_view_columns_autosize (a_tree_view: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_columns_autosize ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_store_clear (a_tree_store: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_clear ((GtkTreeStore*) $a_tree_store)"
		end

	frozen gtk_list_store_clear (a_list_store: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_clear ((GtkListStore*) $a_list_store)"
		end

	frozen gtk_tree_view_get_headers_visible (a_tree_view: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_headers_visible ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_view_set_headers_visible (a_tree_view: POINTER; a_visible: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_set_headers_visible ((GtkTreeView*) $a_tree_view, (gboolean) $a_visible)"
		end

	frozen gtk_tree_view_set_enable_search (a_tree_view: POINTER; enable_search: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_set_enable_search ((GtkTreeView*) $a_tree_view, (gboolean) $enable_search)"
		end

	frozen gtk_tree_path_get_depth (a_tree_path: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_get_depth ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_get_indices (a_tree_path: POINTER): POINTER
		external
			"C signature (GtkTreePath*): gint* use <ev_gtk.h>"
		end

	frozen sizeof_gint: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"sizeof(gint)"
		end

	frozen gtk_tree_path_next (a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_next ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_prev (a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_prev ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_up (a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_up ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_down (a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_down ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_selection_get_selected_rows (a_tree_selection: POINTER; a_model: TYPED_POINTER [POINTER]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_get_selected_rows ((GtkTreeSelection*) $a_tree_selection, (GtkTreeModel**) $a_model)"
		end

	frozen gtk_tree_selection_count_selected_rows (a_tree_selection: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_count_selected_rows ((GtkTreeSelection*) $a_tree_selection)"
		end

	frozen gtk_tree_selection_select_iter (a_tree_selection, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_select_iter ((GtkTreeSelection*) $a_tree_selection, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_selection_unselect_iter (a_tree_selection, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_unselect_iter ((GtkTreeSelection*) $a_tree_selection, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_selection_select_all (a_tree_selection: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_select_all ((GtkTreeSelection*) $a_tree_selection)"
		end

	frozen gtk_tree_selection_unselect_all (a_tree_selection: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_unselect_all ((GtkTreeSelection*) $a_tree_selection)"
		end

	frozen gtk_tree_model_get_n_columns (a_tree_model: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_n_columns ((GtkTreeModel*) $a_tree_model)"
		end

	frozen gtk_tree_model_get_iter (a_tree_model, a_tree_iter, a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_iter ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_model_get_path (a_tree_model, a_tree_iter: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_path ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_model_get_value (a_tree_model, a_tree_iter: POINTER; a_column: INTEGER_32; a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_value ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter, (gint) $a_column, (GValue*) $a_value)"
		end

	frozen gtk_tree_view_row_expanded (a_tree_view, a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_row_expanded ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_expand_row (a_tree_view, a_tree_path: POINTER; open_all: BOOLEAN): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_expand_row ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path, (gboolean) $open_all)"
		end

	frozen gtk_tree_view_expand_to_path (a_tree_view, a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_expand_to_path ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_collapse_row (a_tree_view, a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_collapse_row ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_get_column (a_tree_view: POINTER; a_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_column ((GtkTreeView*) $a_tree_view, (gint) $a_index)"
		end

	frozen gtk_tree_view_get_bin_window (a_tree_view: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_bin_window ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_view_get_columns (a_tree_view: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_columns ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_view_get_selection (a_tree_view: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_selection ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_selection_set_mode (a_tree_sel: POINTER; a_mode: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_set_mode ((GtkTreeSelection*) $a_tree_sel, (GtkSelectionMode) $a_mode)"
		end

	frozen gtk_tree_selection_get_mode (a_tree_sel: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_get_mode ((GtkTreeSelection*) $a_tree_sel)"
		end

	frozen gtk_tree_view_column_set_alignment (a_tree_view_column: POINTER; a_align: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_alignment ((GtkTreeViewColumn*) $a_tree_view_column, (gfloat) $a_align)"
		end

	frozen gtk_tree_view_column_set_fixed_width (a_tree_view_column: POINTER; a_width: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_fixed_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		end

	frozen gtk_tree_view_column_get_fixed_width (a_tree_view_column: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_fixed_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_set_sizing (a_tree_view_column: POINTER; a_size_mode: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_sizing ((GtkTreeViewColumn*) $a_tree_view_column, (GtkTreeViewColumnSizing) $a_size_mode)"
		end

	frozen gtk_tree_view_column_set_resizable (a_tree_view_column: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_resizable ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_expand)"
		end

	frozen gtk_tree_view_column_set_clickable (a_tree_view_column: POINTER; a_clickable: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_clickable ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_clickable)"
		end

	frozen gtk_tree_view_column_set_widget (a_tree_view_column: POINTER; a_widget: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_widget ((GtkTreeViewColumn*) $a_tree_view_column, (GtkWidget*) $a_widget)"
		end

	frozen gtk_tree_view_column_get_widget (a_tree_view_column: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_widget ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_get_width (a_tree_view_column: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_set_visible (a_tree_view_column: POINTER; a_visible: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_visible ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_visible)"
		end

	frozen gtk_tree_view_column_get_min_width (a_tree_view_column: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_min_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_set_min_width (a_tree_view_column: POINTER; a_width: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_min_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		end

	frozen gtk_tree_view_column_set_max_width (a_tree_view_column: POINTER; a_width: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_max_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		end

	frozen gtk_tree_view_column_add_attribute (a_tree_view_column, a_cell_renderer, a_attribute: POINTER; a_column: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_add_attribute ((GtkTreeViewColumn*) $a_tree_view_column, (GtkCellRenderer*) $a_cell_renderer, (gchar*) $a_attribute, (gint) $a_column)"
		end

	frozen gtk_cell_renderer_text_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_renderer_text_new()"
		end

	frozen gtk_cell_renderer_pixbuf_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_renderer_pixbuf_new()"
		end

	frozen gtk_cell_renderer_get_preferred_size (cell: POINTER; widget: POINTER; minimum_size: POINTER; natural_size: POINTER)
		note
			eis: "name=gtk_cell_renderer_get_preferred_size", "src=https://developer.gnome.org/gtk3/stable/GtkCellRenderer.html#gtk-cell-renderer-get-preferred-size"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_cell_renderer_get_preferred_size ((GtkCellRenderer *)$cell,
                                      (GtkWidget *)$widget,
                                      (GtkRequisition *)$minimum_size,
                                      (GtkRequisition *)$natural_size)

			]"
		end

	frozen gtk_cell_renderer_get_fixed_size (a_cell_renderer, a_width, a_height: POINTER)
		external
			"C signature (GtkCellRenderer*, gint*, gint*) use <ev_gtk.h>"
		end

	frozen gtk_cell_renderer_set_fixed_size (a_cell_renderer: POINTER; a_width, a_height: INTEGER_32)
		external
			"C signature (GtkCellRenderer*, gint, gint) use <ev_gtk.h>"
		end

	frozen gtk_cell_renderer_toggle_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_renderer_toggle_new()"
		end

	frozen gtk_tree_view_insert_column (a_tree_view: POINTER; a_column: POINTER; a_position: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_insert_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column, (gint) $a_position)"
		end

	frozen gtk_tree_view_remove_column (a_tree_view: POINTER; a_column: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_remove_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column)"
		end

	frozen gtk_tree_view_append_column (a_tree_view: POINTER; a_column: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_append_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column)"
		end

	frozen gtk_tree_view_column_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_new()"
		end

	frozen gtk_tree_view_column_set_title (a_tree_column, a_title: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_title((GtkTreeViewColumn*) $a_tree_column, (gchar*) $a_title)"
		end

	frozen gtk_tree_view_column_pack_start (a_tree_column, a_cell_renderer: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_pack_start ((GtkTreeViewColumn*) $a_tree_column, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		end

	frozen gtk_tree_view_column_pack_end (a_tree_column, a_cell_renderer: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_pack_end ((GtkTreeViewColumn*) $a_tree_column, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		end

	frozen g_type_string: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"G_TYPE_STRING"
		end

	frozen g_type_boolean: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"G_TYPE_BOOLEAN"
		end

	frozen c_g_value_struct_allocate: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(GValue), 1)"
		end

	frozen c_gtk_tree_iter_allocate: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(GtkTreeIter), 1)"
		end

	frozen g_value_init_int (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_INT)"
		end

	frozen g_value_init_pointer (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_POINTER)"
		end

	frozen g_value_init_string (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_STRING)"
		end

	frozen g_value_init_object (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_OBJECT)"
		end

	frozen g_value_set_int (a_value: POINTER; a_int: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_int ((GValue*) $a_value, (gint) $a_int)"
		end

	frozen g_value_get_int (a_value: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_int ((GValue*) $a_value)"
		end

	frozen g_value_set_boolean (a_value: POINTER; a_boolean: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_boolean ((GValue*) $a_value, (gboolean) $a_boolean)"
		end

	frozen g_value_get_boolean (a_value: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_boolean ((GValue*) $a_value)"
		end

	frozen g_value_set_pointer (a_value: POINTER; a_pointer: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_pointer ((GValue*) $a_value, (gpointer) $a_pointer)"
		end

	frozen g_value_set_object (a_value: POINTER; a_pointer: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_object ((GValue*) $a_value, (gpointer) $a_pointer)"
		end

	frozen g_value_set_string (a_value: POINTER; a_string: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_string ((GValue*) $a_value, (gchar*) $a_string)"
		end

	frozen g_value_get_string (a_value: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_string ((GValue*) $a_value)"
		end

	frozen g_value_take_string (a_value: POINTER; a_string: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_take_string ((GValue*) $a_value, (gchar*) $a_string)"
		end

	frozen gtk_tree_view_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_tree_view_set_model (a_view, a_model: POINTER)
		external
			"C signature (GtkTreeView*, GtkTreeModel*) use <ev_gtk.h>"
		end

	frozen gtk_tree_store_newv (n_columns: INTEGER_32; types: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_newv ((gint) $n_columns, (GType*) $types)"
		end

	frozen gtk_list_store_newv (n_columns: INTEGER_32; types: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_newv ((gint) $n_columns, (GType*) $types)"
		end

	frozen gtk_tree_store_append (a_tree_store, a_tree_iter, a_parent_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_append ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (GtkTreeIter*) $a_parent_iter)"
		end

	frozen gtk_list_store_append (a_list_store, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_append ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_store_insert (a_tree_store, a_tree_iter, a_parent_iter: POINTER; a_index: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_insert ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (GtkTreeIter*) $a_parent_iter, (gint) $a_index)"
		end

	frozen gtk_list_store_insert (a_list_store, a_tree_iter: POINTER; a_index: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_insert ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index)"
		end

	frozen gtk_tree_store_remove (a_tree_store, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_remove ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_list_store_remove (a_list_store, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_remove ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_store_set_value (a_tree_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_set_value ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GValue*) $a_value)"
		end

	frozen gtk_list_store_set_value (a_list_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_set_value ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GValue*) $a_value)"
		end

	frozen gtk_tree_store_set_pixbuf (a_tree_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_pixbuf: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_set ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GdkPixbuf*) $a_pixbuf, -1)"
		end

	frozen gtk_list_store_set_pixbuf (a_list_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_pixbuf: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_set ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GdkPixbuf*) $a_pixbuf, -1)"
		end

	frozen gtk_entry_set_max_length (a_entry: POINTER; a_max: INTEGER_32)
		external
			"C (GtkEntry*, gint) | <ev_gtk.h>"
		end

	frozen gtk_fixed_get_type: INTEGER_32
		external
			"C (): GtkType | <ev_gtk.h>"
		end

	frozen gtk_fixed_move (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GtkFixed*, GtkWidget*, gint, gint) | <ev_gtk.h>"
		end

	frozen gtk_fixed_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_fixed_put (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GtkFixed*, GtkWidget*, gint, gint) | <ev_gtk.h>"
		end

	frozen set_gdk_rectangle_struct_height (a_c_struct: POINTER; a_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"height"
		end

	frozen set_gdk_rectangle_struct_width (a_c_struct: POINTER; a_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"width"
		end

	frozen set_gdk_rectangle_struct_x (a_c_struct: POINTER; a_x: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"x"
		end

	frozen set_gdk_rectangle_struct_y (a_c_struct: POINTER; a_y: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"y"
		end

	frozen gtk_args_array_i_th (args_array: POINTER; an_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"((GValue*)$args_array + (int)($an_index))"
		end

	frozen g_value_array_i_th (args_array: POINTER; an_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"((GValue*)$args_array + (int)($an_index - 1))"
		end

	frozen gtk_color_chooser_get_rgba (a_color_selection, a_color: POINTER)
		external
			"C signature (GtkColorChooser*, GdkRGBA*) use <ev_gtk.h>"
		end

	frozen gtk_color_chooser_set_rgba (a_color_selection, a_color: POINTER)
		external
			"C signature (GtkColorChooser*, GdkRGBA*) use <ev_gtk.h>"
		end

	frozen gtk_color_chooser_set_use_alpha (a_color_selection: POINTER; use_alpha: BOOLEAN)
		external
			"C signature (GtkColorChooser*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_accel_label_new (a_string: POINTER): POINTER
		external
			"C signature (gchar*): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_menu_item_new_with_mnemonic (a_label: POINTER): POINTER
		external
			"C signature (gchar*): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_label_set_text_with_mnemonic (a_label, a_text: POINTER)
		external
			"C signature (GtkLabel*, gchar*) use <ev_gtk.h>"
		end

	frozen gtk_accel_groups_activate (a_object: POINTER; a_key, a_modifier_type: INTEGER_32): BOOLEAN
		external
			"C signature (GObject*, guint, GdkModifierType): gboolean use <ev_gtk.h>"
		end

feature -- i18n		

	frozen g_locale_to_utf8 (a_string: POINTER; a_length: INTEGER_32; bytes_read, bytes_written: TYPED_POINTER [INTEGER_32]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					gsize temp_bytes_read;
					gsize temp_bytes_written;
					*$a_result = g_locale_to_utf8 ((gchar*) $a_string, (gssize) $a_length, &temp_bytes_read, &temp_bytes_written, (GError**) $gerror);
					*$bytes_read = (EIF_INTEGER) temp_bytes_read;
					*$bytes_written = (EIF_INTEGER) temp_bytes_written;
				}
			]"
		end

	frozen g_filename_to_utf8 (a_string: POINTER; a_length: INTEGER_32; bytes_read, bytes_written: TYPED_POINTER [INTEGER_32]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					gsize temp_bytes_read;
					gsize temp_bytes_written;
					*$a_result = g_filename_to_utf8 ((gchar*) $a_string, (gssize) $a_length, &temp_bytes_read, &temp_bytes_written, (GError**) $gerror);
					*$bytes_read = (EIF_INTEGER) temp_bytes_read;
					*$bytes_written = (EIF_INTEGER) temp_bytes_written;
				}
			]"
		end

feature -- Value		

	frozen gtk_value_pointer (arg: POINTER): POINTER
			-- Pointer to the value of a GtkArg.
		external
			"C signature (GValue*): EIF_POINTER use <ev_gtk.h>"
		alias
			"g_value_peek_pointer"
		end

	frozen gtk_value_int (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_int"
		end

	frozen gtk_value_uchar (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_uchar"
		end

	frozen gtk_value_enum (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_enum"
		end

	frozen gtk_value_flags (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_flags"
		end

	frozen gtk_value_uint (arg: POINTER): NATURAL_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_NATURAL use <ev_gtk.h>"
		alias
			"g_value_get_uint"
		end

feature -- Widget		

	frozen gtk_widget_get_pango_context (a_widget: POINTER): POINTER
		external
			"C signature (GtkWidget*): PangoContext* use <ev_gtk.h>"
		end

	frozen gtk_widget_create_pango_layout (a_widget: POINTER; a_text: POINTER): POINTER
		external
			"C signature (GtkWidget*, gchar*): PangoLayout* use <ev_gtk.h>"
		end

	frozen gtk_widget_get_mapped (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

feature -- Object

	frozen g_object_get_pointer (a_object: POINTER; a_property: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				EIF_POINTER v;
				g_object_get ((gpointer) $a_object, (const gchar *) $a_property, &v, NULL);
				return (EIF_POINTER) v;
			]"
		end

	frozen g_object_set_pointer (a_object: POINTER; a_property: POINTER; arg1: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gpointer) $arg1, NULL)"
		ensure
			is_class: class
		end


	frozen g_object_set_string (a_object: POINTER; a_property: POINTER; string_arg: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gchar*) $string_arg, NULL)"
		ensure
			is_class: class
		end


	frozen g_object_get_string (a_object: POINTER; a_property: POINTER; string_arg: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_get ((gpointer) $a_object, (gchar*) $a_property, (gchar**) $string_arg, NULL)"
		ensure
			is_class: class
		end


	frozen g_object_get_object_property (a_object: POINTER; a_property: POINTER; obj: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				g_object_get ($a_object, $a_property, $obj, NULL);
              ]"
		end

	frozen g_object_get_integer (a_object: POINTER; a_property: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gint v;
				g_object_get ((gpointer) $a_object, (const gchar *) $a_property, &v, NULL);
				return (EIF_INTEGER) v;
			]"
		end

	frozen g_object_set_integer (a_object: POINTER; a_property: POINTER; int_arg: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (const gchar *) $a_property, $int_arg, NULL)"
		end

	frozen g_object_set_real_32 (a_object: POINTER; a_property: POINTER; real_arg: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, (gfloat) $real_arg, NULL)"
		end

	frozen g_object_set_boolean (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $bool_arg ? TRUE : FALSE, NULL)"
		end

	frozen g_object_set_menu_icons (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $bool_arg ? TRUE : FALSE, NULL)"
		end

feature -- Signal

	frozen signal_list_ids (a_object: POINTER): LIST [NATURAL_32]
		local
			i, nb: INTEGER
			unb: NATURAL_32
			p: POINTER
			mp: MANAGED_POINTER
		do
			p := g_signal_list_ids (a_object, $unb)
			nb := unb.to_integer_32
			if nb > 0 and not p.is_default_pointer then
				create {ARRAYED_LIST [NATURAL_32]} Result.make (nb)
				create mp.share_from_pointer (p, nb * {MANAGED_POINTER}.natural_32_bytes)
				from
					i := 1
				until
					i > nb
				loop
					Result.extend (mp.read_natural_32 ((i - 1) * {MANAGED_POINTER}.natural_32_bytes))
					i := i + 1
				end
			else
				create {ARRAYED_LIST [NATURAL_32]} Result.make (0)
			end
		ensure
			instance_free: class
		end

	frozen g_signal_list_ids (a_object: POINTER; a_count: TYPED_POINTER [NATURAL_32]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_list_ids (G_OBJECT_TYPE($a_object), (guint *) $a_count)"
		end

	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER_32)
		do
			debug ("gtk_signal")
				print ("signal_disconnect (" + a_object.out + ", " + a_handler_id.out + ")%N")
			end
			c_signal_disconnect (a_object, a_handler_id)
		ensure
			instance_free: class
		end

	frozen c_signal_disconnect (a_object: POINTER; a_handler_id: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_handler_disconnect ((gpointer) $a_object, (gulong) $a_handler_id)"
		end

	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER_32): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_handlers_disconnect_matched ((gpointer) $a_c_object, G_SIGNAL_MATCH_DATA, 0, 0, NULL, NULL, (gpointer) (rt_int_ptr) $data)"
		end

feature -- Editable		

	frozen gtk_editable_get_selection_bounds (a_editable: POINTER; a_start, a_end: TYPED_POINTER [INTEGER_32]): BOOLEAN
		external
			"C signature (GtkEditable*, gint*, gint*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN
		external
			"C signature (GtkEditable*): EIF_BOOLEAN use <ev_gtk.h>"
		end

feature -- Text		

	frozen gtk_text_view_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_text_view_new_with_buffer (a_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_create_mark (a_text_buffer: POINTER; a_name: POINTER; a_text_iter: POINTER; left_gravity: BOOLEAN): POINTER
		external
			"C signature (GtkTextBuffer*, gchar*, GtkTextIter*, gboolean): GtkTextMark* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_delete_mark (a_text_buffer: POINTER; a_text_mark: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextMark*) use <ev_gtk.h>"
		end

	frozen gtk_text_view_get_buffer (a_text_view: POINTER): POINTER
		external
			"C signature (GtkTextView*): GtkTextBuffer* use <ev_gtk.h>"
		end

	frozen gtk_text_view_set_buffer (a_text_view: POINTER; a_text_buffer: POINTER)
		external
			"C signature (GtkTextView*, GtkTextBuffer*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_set_text (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_insert (a_text_buffer: POINTER; a_text_iter: POINTER; a_string: POINTER; a_length: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gchar *, gint) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_insert_range (a_text_buffer: POINTER; a_text_iter: POINTER; a_start_iter: POINTER; a_end_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_start_iter (a_text_buffer: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_end_iter (a_text_buffer: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_char_count (a_text_buffer: POINTER): INTEGER_32
		external
			"C signature (GtkTextBuffer*): gint use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_selection_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_selection_bound (a_text_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_insert (a_text_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_move_mark (a_text_buffer: POINTER; a_text_mark: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextMark*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_text (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER; inc_hid_chars: BOOLEAN): POINTER
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, gboolean): gchar* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_line_count (a_text_buffer: POINTER): INTEGER_32
		external
			"C signature (GtkTextBuffer*): gint use <ev_gtk.h>"
		end

	frozen gtk_text_iter_get_text (a_start_iter: POINTER; a_end_iter: POINTER): POINTER
		external
			"C signature (GtkTextIter*, GtkTextIter*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_text_iter_get_line (a_iter: POINTER): INTEGER_32
		external
			"C signature (GtkTextIter*): gint use <ev_gtk.h>"
		end

	frozen gtk_text_iter_set_line (a_iter: POINTER; a_line: INTEGER_32)
		external
			"C signature (GtkTextIter*, gint) use <ev_gtk.h>"
		end

	frozen gtk_text_view_set_editable (a_text_view: POINTER; a_setting: BOOLEAN)
		external
			"C signature (GtkTextView*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_text_view_set_wrap_mode (a_text_view: POINTER; a_wrap_mode: INTEGER_32)
		external
			"C signature (GtkTextView*, GtkWrapMode) use <ev_gtk.h>"
		end

	Gtk_wrap_none_enum: INTEGER_32 = 0

	Gtk_wrap_char_enum: INTEGER_32 = 1

	Gtk_wrap_word_enum: INTEGER_32 = 2

	frozen gtk_text_tag_new (a_name: POINTER): POINTER
		external
			"C signature (gchar*): GtkTextTag* use <ev_gtk.h>"
		end

	frozen gtk_text_view_window_to_buffer_coords (a_text_view: POINTER; a_window_type: NATURAL_8; a_window_x, a_window_y: INTEGER; a_buffer_x, a_buffer_y: TYPED_POINTER [INTEGER])
		external
			"C signature (GtkTextView*, GtkTextWindowType, gint, gint, gint*, gint*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_new (a_text_tag_table: POINTER): POINTER
		external
			"C signature (GtkTextTagTable*): GtkTextBuffer* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_apply_tag (a_buffer: POINTER; a_tag: POINTER; a_start: POINTER; a_end: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextTag*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_tag_table (a_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkTextTagTable* use <ev_gtk.h>"
		end

	frozen gtk_text_tag_table_add (a_table: POINTER; a_tag: POINTER)
		external
			"C signature (GtkTextTagTable*, GtkTextTag*) use <ev_gtk.h>"
		end

	frozen gtk_text_tag_table_lookup (a_table: POINTER; a_name: POINTER): POINTER
		external
			"C signature (GtkTextTagTable*, gchar*): GtkTextTag* use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_iter_at_line (a_text_buffer: POINTER; a_text_iter: POINTER; a_line_number: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_iter_at_mark (a_text_buffer: POINTER; a_text_iter: POINTER; a_text_mark: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextMark*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_get_iter_at_offset (a_text_buffer: POINTER; a_text_iter: POINTER; a_char_offset: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_delete_selection (a_text_buffer: POINTER; a_interactive: BOOLEAN; a_default_editable: BOOLEAN)
		external
			"C signature (GtkTextBuffer*, gboolean, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_delete (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_place_cursor (a_text_buffer: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <ev_gtk.h>"
		end

	frozen gtk_text_iter_forward_to_line_end (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		end

	frozen gtk_text_iter_forward_line (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		end

	frozen gtk_text_iter_backward_line (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		end

	frozen gtk_text_iter_forward_char (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		end

	frozen gtk_text_iter_backward_char (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		end

	frozen gtk_text_view_forward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_text_view_backward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_text_view_get_iter_at_location (a_text_view, a_text_iter: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkTextView*, GtkTextIter*, gint, gint) use <ev_gtk.h>"
		end

	frozen gtk_text_view_forward_display_line_end (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_text_iter_get_offset (a_text_iter: POINTER): INTEGER_32
		external
			"C signature (GtkTextIter*): gint use <ev_gtk.h>"
		end

	frozen gtk_clipboard_get (a_atom: POINTER): POINTER
		external
			"C signature (GdkAtom): GtkClipboard* use <ev_gtk.h>"
		end

	frozen gtk_clipboard_set_text (a_clipboard: POINTER; a_text: POINTER; a_length: INTEGER_32)
		external
			"C signature (GtkClipboard*, gchar*, gint) use <ev_gtk.h>"
		end

	frozen gtk_clipboard_wait_for_text (a_clipboard: POINTER): POINTER
		external
			"C signature (GtkClipboard*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_clipboard_wait_is_text_available (a_clipboard: POINTER): BOOLEAN
		external
			"C signature (GtkClipboard*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_cut_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; default_editable: BOOLEAN)
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_copy_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkClipboard*) use <ev_gtk.h>"
		end

	frozen gtk_text_buffer_paste_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; a_text_iter: POINTER; default_editable: BOOLEAN)
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, GtkTextIter*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_text_view_scroll_to_iter (a_text_view: POINTER; a_text_iter: POINTER; within_margin: REAL_64; use_align: BOOLEAN; xalign: REAL_64; yalign: REAL_64)
		external
			"C signature (GtkTextView*, GtkTextIter*, gdouble, gboolean, gdouble, gdouble) use <ev_gtk.h> "
		end

	frozen gtk_text_view_scroll_to_mark (a_text_view: POINTER; a_text_mark: POINTER; within_margin: REAL_64; use_align: BOOLEAN; xalign: REAL_64; yalign: REAL_64)
		external
			"C signature (GtkTextView*, GtkTextMark*, gdouble, gboolean, gdouble, gdouble) use <ev_gtk.h> "
		end

	frozen gtk_text_view_get_iter_location (a_text_view, a_text_iter, a_rectangle: POINTER)
		external
			"C signature (GtkTextView*, GtkTextIter*, GdkRectangle*) use <ev_gtk.h>"
		end

	frozen gtk_text_iter_copy (a_text_iter: POINTER): POINTER
		external
			"C signature (GtkTextIter*): GtkTextIter* use <ev_gtk.h>"
		end

feature -- Image

	frozen gtk_image_set_from_pixbuf (a_image: POINTER; a_pixbuf: POINTER)
		external
			"C signature (GtkImage*, GdkPixbuf*) use <ev_gtk.h>"
		end

	frozen gtk_image_get_pixbuf (a_image: POINTER): POINTER
		external
			"C signature (GtkImage*): GdkPixbuf* use <ev_gtk.h>"
		end

	frozen gtk_image_new_from_pixbuf (a_pixbuf: POINTER): POINTER
		external
			"C signature (GdkPixbuf*): GtkImage* use <ev_gtk.h>"
		end

	frozen gtk_image_new: POINTER
		external
			"C signature (): GtkImage* use <ev_gtk.h>"
		end

feature -- Dialog		

	frozen gtk_dialog_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_dialog_add_button (a_dialog, a_text: POINTER; a_response_id: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_dialog_add_button ((GtkDialog*) $a_dialog, (gchar*) $a_text, (gint) $a_response_id)"
		end

	frozen gtk_dialog_get_widget_for_response (a_dialog: POINTER; a_response_id: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_dialog_get_widget_for_response ((GtkDialog*) $a_dialog, (gint) $a_response_id)"
		end

	frozen gtk_dialog_set_default_response (a_dialog: POINTER; a_response_id: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_dialog_set_default_response ((GtkDialog*) $a_dialog, (gint) $a_response_id)"
		end

feature -- File, FileChooser		

	frozen gtk_file_filter_new: POINTER
		external
			"C signature () use <ev_gtk.h>"
		end

	frozen gtk_file_filter_add_pattern (a_filter, a_pattern: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_filter_add_pattern ((GtkFileFilter*) $a_filter, (gchar*) $a_pattern)"
		end

	frozen gtk_file_filter_set_name (a_filter, a_name: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_filter_set_name ((GtkFileFilter*) $a_filter, (gchar*) $a_name)"
		end

	frozen gtk_file_chooser_set_filter (a_file_chooser, a_filter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		end

	frozen gtk_file_chooser_add_filter (a_file_chooser, a_filter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_add_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		end

	frozen gtk_file_chooser_remove_filter (a_file_chooser, a_filter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_remove_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		end

	frozen gtk_file_chooser_action_open_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_OPEN"
		end

	frozen gtk_file_chooser_action_save_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_SAVE"
		end

	frozen gtk_file_chooser_action_select_folder_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER"
		end

	frozen gtk_file_chooser_action_create_folder_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER"
		end

	frozen gtk_file_chooser_set_current_name (a_dialog: POINTER; a_filename: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_current_name ((GtkFileChooser*) $a_dialog, (gchar*) $a_filename)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_current_folder (a_dialog: POINTER; a_folder: POINTER)
		external
			"C signature (GtkFileChooser*, gchar*) use <ev_gtk.h>"
		end

	frozen gtk_file_chooser_list_filters (a_file_chooser: POINTER): POINTER
		external
			"C signature (GtkFileChooser*): GSList use <ev_gtk.h>"
		end

	frozen gtk_file_chooser_dialog_new (a_title, a_parent: POINTER; a_action: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_dialog_new ((gchar*) $a_title, (GtkWindow*) $a_parent, (GtkFileChooserAction) $a_action, NULL, NULL)"
		end

	frozen gtk_file_chooser (a_dialog: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER ( $a_dialog )"
		end

	frozen gtk_file_chooser_get_filename (a_dialog: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_get_filename ((GtkFileChooser*) $a_dialog)"
		end

	frozen gtk_file_chooser_get_filenames (a_dialog: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_get_filenames ((GtkFileChooser*) $a_dialog)"
		end

	frozen gtk_file_chooser_set_filename (a_dialog: POINTER; a_filename: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_filename ((GtkFileChooser*) $a_dialog, (gchar*) $a_filename)"
		end

	frozen gtk_file_chooser_set_local_only (a_dialog: POINTER; a_local_only: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_local_only ((GtkFileChooser*) $a_dialog, (gboolean) $a_local_only)"
		end

	frozen gtk_file_chooser_set_create_folders (a_dialog: POINTER; a_create: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_create_folders ((GtkFileChooser*) $a_dialog, (gboolean) $a_create)"
		end

	frozen gtk_file_chooser_set_select_multiple (a_dialog: POINTER; a_multiple: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_select_multiple ((GtkFileChooser*) $a_dialog, (gboolean) $a_multiple)"
		end

	frozen gtk_file_chooser_get_filter (a_dialog: POINTER): POINTER
		external
			"C signature (GtkFileChooser*): GtkFileFilter* use <ev_gtk.h>"
		end

feature -- Tooltip

	frozen gtk_tool_item_set_tooltip_text (a_tool_item: POINTER; a_text: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_tool_item_set_tooltip_text ((GtkToolItem *)$a_tool_item,
                                (const gchar *)$a_text)
             ]"
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
