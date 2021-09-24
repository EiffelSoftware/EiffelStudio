note
	description: "GTK SD_TOOL_BAR_DRAWER implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I
		rename
			to_sepcial_state as to_gtk_state
		end

	EV_BUTTON_IMP
		rename
			make as make_not_use
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		do
			-- Make user not break the invariant from EV_ANY_I
			set_state_flag (base_make_called_flag, True)

			create internal_shared
		end

feature -- Redefine

	start_draw (a_rectangle: EV_RECTANGLE)
			-- <Precursor>
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_rect, l_rect: EV_RECTANGLE
		do
			is_start_draw_called := True

			if attached tool_bar as l_tool_bar then
				l_tool_bar.start_drawing_session
				from
					l_items := l_tool_bar.items
					l_rect := a_rectangle.twin
					l_items.start
				until
					l_items.after
				loop
					l_item_rect := l_items.item.rectangle
					if l_item_rect.intersects (a_rectangle) then
						-- We find the maximum area we should clear.
						l_rect.merge (l_item_rect)
					end
					l_items.forth
				end
				if not l_tool_bar.is_destroyed then
					internal_shared.setter.clear_background_for_theme (l_tool_bar, l_rect)
				end
			else
				check from_precondition: False end
			end
		end

	end_draw
			-- <Precursor>
		do
			if attached tool_bar as l_tool_bar then
				l_tool_bar.end_drawing_session
			end
			is_start_draw_called := False
		end

	is_start_draw_called: BOOLEAN
			-- <Precursor>

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- <Precursor>
		local
			l_rect: EV_RECTANGLE
			l_docking_drawable: POINTER
		do
			if
				attached tool_bar as l_tool_bar and then
				not l_tool_bar.is_destroyed and then l_tool_bar.is_displayed
			then
				if
					attached a_arguments.tool_bar as l_argument_tool_bar and then
					attached {EV_DRAWING_AREA_IMP} l_argument_tool_bar.implementation as l_tool_bar_imp and then
					attached a_arguments.item as l_item -- Implied by precondition
				then
					l_rect := l_item.rectangle
					l_tool_bar_imp.start_drawing_session
					l_docking_drawable := l_tool_bar_imp.get_drawable
					if not l_docking_drawable.is_default_pointer then
						if attached {SD_TOOL_BAR_BUTTON} l_item as l_button then

							-- Paint button background
							if l_item.state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
								c_gtk_paint_box (l_docking_drawable, button_style, to_gtk_state (l_item.state), gtk_shadow_type (l_item.state),
											l_rect.x, l_rect.y, l_rect.width, l_rect.height, True)
								if attached {SD_TOOL_BAR_DUAL_POPUP_BUTTON} l_item as l_popup_button and then not l_popup_button.is_dropdown_area then
									c_gtk_paint_box (l_docking_drawable, button_style, to_gtk_state (l_item.state), gtk_shadow_type (l_item.state),
											l_rect.x, l_rect.y, l_rect.width - l_popup_button.dropdrown_width, l_rect.height, True)
								end
							end

							-- Paint pixmap
							draw_pixmap (a_arguments, l_docking_drawable)

							-- Paint text
							draw_text (a_arguments, l_docking_drawable)
						else
							if l_item.is_wrap then
								c_gtk_paint_line (l_docking_drawable, button_style, l_rect.left, l_rect.right, l_rect.top + l_item.width // 2, False)
							else
								c_gtk_paint_line (l_docking_drawable, button_style, l_rect.top, l_rect.bottom, l_rect.left + l_item.width // 2, True)
							end
						end
					end
					l_tool_bar_imp.end_drawing_session
				else
					check valid: False end
				end
			end
		end

	on_theme_changed
			-- <Precursor>
		do
		end

	desatuation (a_pixmap: EV_PIXMAP; a_k: REAL)
			-- <Precursor>
		do
		end

	set_tool_bar (a_tool_bar: SD_TOOL_BAR)
			-- <Precursor>
		do
			tool_bar := a_tool_bar
		end

feature {SD_NOTEBOOK_TAB_DRAWER_IMP} -- Command

	draw_button_background (a_drawable: POINTER; a_rect: EV_RECTANGLE; a_state: INTEGER)
			-- Draw button background.
		require
			exist: a_drawable /= default_pointer
			not_void: a_rect /= Void
			vaild: (create {SD_TOOL_BAR_ITEM_STATE}).is_valid (a_state)
		do
			c_gtk_paint_box (a_drawable, button_style, to_gtk_state (a_state), gtk_shadow_type (a_state), a_rect.x, a_rect.y, a_rect.width, a_rect.height, False)
		end

feature {NONE} -- Implementation

	button_style: POINTER
			-- Default theme style from resource.
		do
			Result := gtk_style_source_from_widget (style_source)
		ensure
			not_void: Result /= default_pointer
		end

	gtk_style_source_from_widget (a_widget: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION < 3
					return gtk_rc_get_style ((GtkWidget*) $a_widget);
				#else
					return gtk_widget_get_style_context ($a_widget);
				#endif
			]"
		end

	style_source: POINTER
			-- Button for query theme style.
		once
			Result := {GTK}.gtk_button_new
		end

	gtk_shadow_type (a_state: INTEGER): INTEGER
			-- Get correspond shadow type base on `a_state'
		do
			inspect
				a_state
			when {SD_TOOL_BAR_ITEM_STATE}.checked then
				Result := {GTK}.gtk_shadow_in_enum
			when {SD_TOOL_BAR_ITEM_STATE}.disabled then
				Result := {GTK}.gtk_shadow_none_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot then
				Result := {GTK}.gtk_shadow_out_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				Result := {GTK}.gtk_shadow_out_enum
			when {SD_TOOL_BAR_ITEM_STATE}.normal then
				Result := {GTK}.gtk_shadow_none_enum
			when {SD_TOOL_BAR_ITEM_STATE}.pressed then
				Result := {GTK}.gtk_shadow_in_enum
			end
		end

	to_gtk_state (a_state: INTEGER): INTEGER
			-- Convert from SD_TOOL_BAR_ITEM_STATE to WEL_THEME_TS_CONSTANTS.
		do
			inspect
				a_state
			when {SD_TOOL_BAR_ITEM_STATE}.checked then
				Result := {GTK}.gtk_state_flag_active_enum
			when {SD_TOOL_BAR_ITEM_STATE}.disabled then
				Result := {GTK}.gtk_state_flag_insensitive_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot then
				Result := {GTK}.gtk_state_flag_prelight_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				Result := {GTK}.gtk_state_flag_prelight_enum
			when {SD_TOOL_BAR_ITEM_STATE}.normal then
				Result := {GTK}.gtk_state_flag_normal_enum
			when {SD_TOOL_BAR_ITEM_STATE}.pressed then
				Result := {GTK}.gtk_state_flag_active_enum
			end
		end

	draw_pixmap (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS; a_gtk_object: POINTER)
			-- Draw pixmap on tool bar.
		require
			not_void: a_arguments /= Void
			exist: a_gtk_object /= default_pointer
		local
			l_position: EV_COORDINATE
			l_temp_pixmap: EV_PIXMAP
			l_pixmap: detachable EV_PIXMAP
			l_pixbuf: POINTER
		do
			if
				attached {SD_TOOL_BAR_BUTTON} a_arguments.item as l_button and then
				((l_button.pixel_buffer /= Void or l_button.pixmap /= Void) and attached a_arguments.tool_bar as l_argument_tool_bar)
			then
				-- We should render pixmap by theme.
				if attached l_button.pixel_buffer as l_pixel_buffer then
					l_pixmap := l_pixel_buffer.to_pixmap
				else
					l_pixmap := l_button.pixmap
					if not attached l_pixmap then
						create l_pixmap
						check from_condition_above: False end
					end
				end

				l_position := l_button.pixmap_position

				if l_button.is_sensitive then
					l_argument_tool_bar.draw_pixmap (l_position.x, l_position.y, l_pixmap)
					if attached {SD_TOOL_BAR_POPUP_BUTTON} l_button as l_popup_button then
						-- cache `l_popup_button.dropdown_pixel_buffer.to_pixmap'?
						l_argument_tool_bar.draw_pixmap (l_popup_button.dropdown_left, l_position.y, l_popup_button.dropdown_pixel_buffer.to_pixmap)
					end
				else
					l_temp_pixmap := l_pixmap.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_pixmap.width, l_pixmap.height))
					if attached {EV_PIXMAP_IMP} l_temp_pixmap.implementation as l_temp_imp then
						c_gdk_desatuate (l_temp_imp.pixbuf_from_drawable, $l_pixbuf)
						check exist: l_pixbuf /= default_pointer end
						l_temp_imp.set_pixmap_from_pixbuf (l_pixbuf)
						{GTK2}.g_object_unref (l_pixbuf)
					end
					l_argument_tool_bar.draw_pixmap (l_position.x, l_position.y, l_temp_pixmap)
				end
			end
		end

	draw_text (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS; a_gtk_object: POINTER)
			-- Draw text on tool bar.
		require
			not_void: a_arguments /= Void
			exist: a_gtk_object /= default_pointer
		local
			l_c_string: EV_GTK_C_STRING
			l_pango_layout: POINTER
			l_text_rect: EV_RECTANGLE
			l_state: INTEGER
			l_orignal_font: EV_FONT
		do
			if
				attached {SD_TOOL_BAR_FONT_BUTTON} a_arguments.item as l_font_button and then
				(
					attached l_font_button.text as l_text and
					attached l_font_button.font as l_font and
					attached {EV_DRAWING_AREA} a_arguments.tool_bar as l_tool_bar
				)
			then
				l_orignal_font := l_tool_bar.font
				l_text_rect := l_font_button.text_rectangle
				l_tool_bar.set_font (l_font)
				l_tool_bar.draw_text_top_left (l_text_rect.x, l_text_rect.y, l_text)
				l_tool_bar.set_font (l_orignal_font)
			elseif
				attached {SD_TOOL_BAR_WIDTH_BUTTON} a_arguments.item as l_width_button and then
				attached l_width_button.text as l_text_2 and
				attached a_arguments.tool_bar as l_tool_bar_2
			then
				l_text_rect := l_width_button.text_rectangle
				l_tool_bar_2.draw_ellipsed_text_top_left (l_text_rect.x, l_text_rect.y, l_text_2, l_text_rect.width)
			elseif
				attached {SD_TOOL_BAR_BUTTON} a_arguments.item as l_button and then
				l_button.tool_bar /= Void and then
				attached l_button.text as l_text_3
			then
				if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
					l_c_string := l_app_imp.c_string_from_eiffel_string (l_text_3)
					l_pango_layout := l_app_imp.pango_layout

					{PANGO}.layout_set_text (l_pango_layout, l_c_string.item, l_c_string.string_length)

					l_text_rect := l_button.text_rectangle
					if l_button.is_sensitive then
						l_state := to_gtk_state (l_button.state)
					else
						l_state := {GTK}.gtk_state_flag_insensitive_enum
					end
					c_gtk_paint_layout (a_gtk_object, button_style, l_state, l_text_rect.left, l_text_rect.top, l_text_rect.width, l_text_rect.height, l_pango_layout)
				end
			end
		end

	internal_shared: SD_SHARED
			-- Shared singleton

feature {NONE} -- Externals

	c_gtk_paint_line (a_drawable, a_style: POINTER; a_start, a_end, a_position: INTEGER; a_vertical: BOOLEAN)
			-- Draw vertical separator line.
		require
			exist: a_drawable /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION < 3
					GtkWidget* l_widget;
					l_widget = GTK_WIDGET ($a_drawable);
					if ($a_vertical)
						gtk_paint_vline (l_widget->style, l_widget->window, GTK_STATE_NORMAL, NULL, l_widget, "toolbar", $a_start, $a_end, $a_position);
					else
						gtk_paint_hline (l_widget->style, l_widget->window, GTK_STATE_NORMAL, NULL, l_widget, "toolbar", $a_start, $a_end, $a_position);
				#else
					gdouble l_x0, l_y0, l_x1, l_y1;
					if ($a_vertical)
					{
						l_x0 = (gdouble) $a_start;
						l_x1 = (gdouble) $a_end;
						l_y0 = (gdouble) $a_position;
						l_y1 = l_y0;
					}
					else
					{
						l_y0 = (gdouble) $a_start;
						l_y1 = (gdouble) $a_end;
						l_x0 = (gdouble) $a_position;
						l_x1 = l_x0;
					}
					gtk_render_line ((GtkStyleContext*) $a_style, (cairo_t*) $a_drawable, l_x0, l_y0, l_x1, l_y1);
				#endif
			}
			]"
		end


	c_gtk_paint_box (a_drawable, a_style: POINTER; a_gtk_state_type: INTEGER; a_gtk_shadow_type: INTEGER; a_x, a_y, a_width, a_height: INTEGER; a_inset_shadow: BOOLEAN)
			-- Paint background.
		require
			exist: a_drawable /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION < 3
					GtkWidget* l_widget;
					GtkStyle *l_style;
					
					l_widget = GTK_WIDGET ($a_drawable);
						// We need to attach the style to the window
						// otherwise the color depths may be different.
					l_style = gtk_style_attach (GTK_STYLE ($a_style), l_widget->window);
					
					if ($a_inset_shadow)
					{
						// Set thickness value not less than 3, then we can draw inset gradient border in clearlook themes.
						l_style->xthickness = 3;
						l_style->ythickness = 3;
					}else
					{
						l_style->xthickness = 1;
						l_style->ythickness = 1;				
					}
					
					gtk_paint_box (l_style, l_widget->window,
						$a_gtk_state_type, $a_gtk_shadow_type,
						NULL, l_widget, "button",				
						$a_x, $a_y, $a_width, $a_height);

					gtk_style_detach (l_style);
				#else
					GtkStateFlags l_flags;
					
						/* Temporary store and restore existing flags in `a_style'. */
					l_flags = gtk_style_context_get_state ((GtkStyleContext*) $a_style);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, (GtkStateFlags) $a_gtk_state_type);
					
					gtk_render_frame ((GtkStyleContext*) $a_style, (cairo_t*) $a_drawable, (gdouble) $a_x, (gdouble) $a_y, (gdouble) $a_width, (gdouble) $a_height);
					gtk_render_background ((GtkStyleContext*) $a_style, (cairo_t*) $a_drawable, (gdouble) $a_x, (gdouble) $a_y, (gdouble) $a_width, (gdouble) $a_height);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, l_flags);
				#endif
			}
			]"
		end

	c_gtk_paint_layout (a_drawable, a_style: POINTER; a_gtk_state_type: INTEGER; a_rect_x, a_rect_y, a_rect_width, a_rect_height: INTEGER; a_pango_layout: POINTER)
			-- Paint texts.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION < 3
					GtkWidget* l_widget;
					l_widget = GTK_WIDGET ($a_drawable);

					GdkRectangle l_rect = {$a_rect_x, $a_rect_y, $a_rect_width, $a_rect_height};
					PangoLayout* l_pango_layout = (PangoLayout*) $a_pango_layout;

					gtk_paint_layout (l_widget->style, l_widget->window,
						$a_gtk_state_type, FALSE, &l_rect, l_widget, "label",
						$a_rect_x, $a_rect_y, l_pango_layout);
				#else

					GtkStateFlags l_flags;
					
						/* Temporary store and restore existing flags in `a_style'. */
					l_flags = gtk_style_context_get_state ((GtkStyleContext*) $a_style);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, (GtkStateFlags) $a_gtk_state_type);

					gtk_render_layout ((GtkStyleContext*) $a_style, (cairo_t*) $a_drawable, (gdouble) $a_rect_x, (gdouble) $a_rect_y, (PangoLayout*) $a_pango_layout);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, l_flags);
				#endif
			}
			]"
		end

	c_gdk_desatuate (a_pixmap_buf: POINTER; a_result: POINTER)
			-- Desatuate `a_pixmap_buf'.
			-- Result is a desatuated pixmap buf.
		require
			exist: a_pixmap_buf /= default_pointer
		external
			"C inline use <gdk/gdk.h>"
		alias
			"[
			{
				GdkPixbuf *pixbuf = (GdkPixbuf *)$a_pixmap_buf;
				GdkPixbuf *stated;

				stated = gdk_pixbuf_copy (pixbuf);
				gdk_pixbuf_saturate_and_pixelate (pixbuf, stated, 0.8, TRUE);

				*((GdkPixbuf **) $a_result) = stated;
			}
			]"
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
