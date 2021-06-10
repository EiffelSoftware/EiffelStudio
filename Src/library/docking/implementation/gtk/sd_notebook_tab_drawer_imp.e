note
	description: "Gtk implementation to draw native looking notebook tabs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_DRAWER_IMP

inherit
	SD_NOTEBOOK_TAB_DRAWER_I
		redefine
			make,
			expose_unselected,
			expose_selected,
			expose_hot,
			draw_focus_rect
		end

	EV_BUTTON_IMP -- Only for export
		rename
			make as make_not_use,
			pixmap as pixmap_not_use,
			set_pixmap as set_pixmap_not_use,
			text as text_not_use,
			set_text as set_text_not_use,
			height as height_not_use,
			width as width_not_use
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initlialization

	make (a_tab: SD_NOTEBOOK_TAB)
			-- <Precursor>
		do
			Precursor (a_tab)

				-- Make user not break the invariant from EV_ANY_I
			set_state_flag (base_make_called_flag, True)
		end

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw unselected notebook tab.
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			internal_expose (a_width, tab.x, False)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw selected notebook tab.
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			internal_expose (a_width, tab.x, True)
			if attached tab.parent as l_parent then
				if l_parent.has_focus then
					tab.draw_focus_rect
				end
			else
				check False end -- Implied by `tab' is displaying on screen
			end
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw hot notebook tab.
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			internal_expose (a_width, tab.x, False)
		end

	tool_bar_drawer: SD_TOOL_BAR_DRAWER_IMP
			-- Tool bar drawer which used for drawing close button.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP)
			-- Redefine
		local
			l_vision_rect: EV_RECTANGLE
			l_drawable: POINTER
		do
			if (tab.is_hot or tab.is_selected)and is_top_side_tab then

				l_vision_rect := close_rectangle
				l_vision_rect.move (tab.x + l_vision_rect.x, l_vision_rect.y)

				-- Draw hot state background
				if tab.is_pointer_in_close_area then
					if attached tab.parent as l_parent then
						if attached {EV_DRAWING_AREA_IMP} l_parent.implementation as l_imp then
							l_drawable := l_imp.get_drawable
							if l_drawable /= default_pointer then
								if tab.is_pointer_pressed then
									tool_bar_drawer.draw_button_background (l_drawable, l_vision_rect, {SD_TOOL_BAR_ITEM_STATE}.pressed)
								else
									tool_bar_drawer.draw_button_background (l_drawable, l_vision_rect, {SD_TOOL_BAR_ITEM_STATE}.hot)
								end
								l_imp.release_drawable (l_drawable)
							end
						end
					else
						check False end -- Implied by `tab' is displaying on screen
					end
				end

				-- We draw close button
				if tab.is_pointer_pressed and tab.is_pointer_in_close_area then
					a_drawable.draw_pixmap (tab.x + start_x_close + 1, start_y_close, a_close_pixmap)
				else
					a_drawable.draw_pixmap (tab.x + start_x_close, start_y_close, a_close_pixmap)
				end
			end
		end

	draw_pixmap_text_selected (a_drawable: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		local
			l_font: EV_FONT
		do
			if a_drawable.height > 0 then
				-- Draw text
				a_drawable.set_foreground_color (internal_shared.tab_text_color)
				if a_width - start_x_text_internal >= 0 then
					l_font := a_drawable.font
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
					a_drawable.set_font (l_font)
					if is_top_side_tab then
						a_drawable.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height + 1, text, close_clipping_width (a_width))
					else
						a_drawable.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height, text, text_clipping_width (a_width))
					end
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if is_top_side_tab then
						a_drawable.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position + 1, pixmap)
					else
						a_drawable.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position + 1, pixmap)
					end
				end
				draw_close_button (a_drawable, internal_shared.icons.close)
			end
		end

	draw_pixmap_text_unselected (a_drawable: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		local
			l_font: EV_FONT
		do
			if a_drawable.height > 0 then
				-- Draw text
				a_drawable.set_foreground_color (internal_shared.tab_text_color)

				if a_width - start_x_text_internal >= 0 then
					l_font := a_drawable.font
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
					a_drawable.set_font (l_font)

					if is_top_side_tab then
						a_drawable.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height, text, close_clipping_width (a_width))
					else
						a_drawable.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height, text, text_clipping_width (a_width))
					end
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if is_top_side_tab then
						a_drawable.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position, pixmap)
					else
						a_drawable.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position, pixmap)
					end
				end

				draw_close_button (a_drawable, internal_shared.icons.close)
			end
		end

	draw_focus_rect (a_rect: EV_RECTANGLE)
			-- Redefine
		local
			l_drawable: POINTER
		do
			if attached tab.parent as l_parent then
				if attached {SD_DRAWING_AREA_IMP} l_parent.implementation as l_imp then
					l_drawable := l_imp.get_drawable
					if not l_drawable.is_default_pointer then
						c_gtk_paint_focus (l_drawable, {GTK}.gtk_widget_get_style_context (l_imp.c_object), a_rect.x, a_rect.y, a_rect.width, a_rect.height)
						l_imp.release_drawable (l_drawable)
					end
				end
			else
				check False end -- Implied by `tab' is displaying on screen
			end
		end

	pixmap_y_position: INTEGER
			-- Pixmap positon relative to Current.
		do
			if pixmap /= Void then
				Result := (height / 2 - pixmap.height / 2).floor - 1
			else
				Result := start_y_position_text
			end
		end

feature {NONE} -- Implementation

	gap_height: INTEGER = 0
			-- Redefine

	start_y_position: INTEGER = 1
			-- Redefine

	start_y_position_text: INTEGER
			-- Redefine
		do
			Result := internal_shared.tool_bar_font.height // 2 - 2
		end

	clear (a_width, a_x: INTEGER)
			-- Clear `tab''s area.
		do
			if attached tab.parent as l_parent then
				l_parent.set_foreground_color (l_parent.background_color)
				l_parent.fill_rectangle (a_x, 0, a_width, l_parent.height)
			else
				check False end -- Implied by `tab' is displaying on screen
			end
		end

	notebook_style: POINTER
			-- Default theme style from resource.
		do
			Result := {GTK}.gtk_widget_get_style_context (style_source)
		ensure
			not_void: Result /= default_pointer
		end

	style_source: POINTER
			-- Notebook for query theme style.
		once
			Result := {GTK}.gtk_notebook_new
		end

	internal_expose (a_width: INTEGER; a_x: INTEGER; a_is_selected: BOOLEAN)
			-- Expose implementation
		local
			l_drawable: POINTER
		do
			clear (a_width, a_x)
			if attached tab.parent as l_parent then
				if
					attached {SD_DRAWING_AREA_IMP} l_parent.implementation as l_imp and then
					{GTK}.gtk_widget_get_window (l_imp.c_object) /= default_pointer
				then
					l_drawable := l_imp.get_drawable
					c_gtk_paint_extension (l_drawable, notebook_style, a_is_selected,
											 a_x, 0 ,a_width, tab.height, is_top_side_tab)
					if a_is_selected then
						draw_pixmap_text_selected (l_parent, tab.x, a_width)
					else
						draw_pixmap_text_unselected (l_parent, tab.x, a_width)
					end
					l_imp.release_drawable (l_drawable)
				end
			else
				check False end -- Implied by `tab' is displaying on screen
			end
		end

	c_gtk_paint_extension (a_drawable, a_style: POINTER; a_selected: BOOLEAN;
									a_x, a_y, a_width, a_height: INTEGER;
									a_top: BOOLEAN)
			-- Gtk Draw notebook tabs.
			-- See gdknotebook.c gtk_notebook_draw_tab
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
			
				GtkPositionType l_gap_side;
				if ($a_top)
					l_gap_side = GTK_POS_BOTTOM;
				else
					l_gap_side = GTK_POS_TOP;
				
				
				#if GTK_MAJOR_VERSION < 3
					GtkWidget *l_widget;
					GtkStyle *l_style;
					l_widget = GTK_WIDGET ($a_drawable);
					l_style = gtk_style_attach (GTK_STYLE ($a_style), l_widget->window);
					
					GtkStateType l_state_type;
					
					GdkRectangle l_area = {$a_x, $a_y, $a_width, $a_height};
					
					if ($a_selected)
						l_state_type = GTK_STATE_NORMAL;
					else 
						l_state_type = GTK_STATE_ACTIVE;
					
					
					gtk_paint_extension(l_style, l_widget->window,
						l_state_type, GTK_SHADOW_OUT,
						&l_area, l_widget, "tab",
						$a_x, $a_y, $a_width, $a_height,
						l_gap_side);

					gtk_style_detach (l_style);
				#else
					GtkStateFlags l_flags;
					
						/* Temporary store and restore existing flags in `a_style'. */
					l_flags = gtk_style_context_get_state ((GtkStyleContext*) $a_style);
					
					if ($a_selected)
						gtk_style_context_set_state ((GtkStyleContext*) $a_style, GTK_STATE_FLAG_NORMAL);
					else 
						gtk_style_context_set_state ((GtkStyleContext*) $a_style, GTK_STATE_FLAG_ACTIVE);

					gtk_render_extension ((GtkStyleContext*) $a_style, (cairo_t*) $a_drawable, (gdouble) $a_x, (gdouble) $a_y, (gdouble) $a_width, (gdouble) $a_height, l_gap_side);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, l_flags);
				#endif
			}
			]"
		end

	c_gtk_paint_focus (a_drawable, a_style: POINTER; a_x, a_y, a_width, a_height: INTEGER)
			-- Draws a focus indicator around the given rectangle.
		external
			"C inline use <gtk/gtk.h>		"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION < 3
					GtkWidget *l_widget;
					GtkStyle *l_style;
					l_widget = GTK_WIDGET ($a_drawable);
					l_style = gtk_style_attach (GTK_STYLE ($a_style), l_widget->window);
					
					GdkRectangle l_area = {$a_x, $a_y, $a_width, $a_height};
					
					gtk_paint_focus (	l_style,
										l_widget->window,
									 	GTK_STATE_ACTIVE,
									 	&l_area,
									 	l_widget,
									 	"tab",
									 	$a_x,
									 	$a_y,
									 	$a_width,
									 	$a_height);

					gtk_style_detach (l_style);
				#else
					GtkStateFlags l_flags;
					
						/* Temporary store and restore existing flags in `a_style'. */
					l_flags = gtk_style_context_get_state ((GtkStyleContext*) $a_style);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, GTK_STATE_FLAG_ACTIVE);

					gtk_render_focus ((GtkStyleContext*) $a_style, (cairo_t*) $a_drawable, (gdouble) $a_x, (gdouble) $a_y, (gdouble) $a_width, (gdouble) $a_height);
					
					gtk_style_context_set_state ((GtkStyleContext*) $a_style, l_flags);
				#endif
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
