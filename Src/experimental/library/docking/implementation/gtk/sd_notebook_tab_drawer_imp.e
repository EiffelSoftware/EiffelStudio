note
	description: "[
					Gtk implementation to draw native looking notebook tabs.
					]"
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
			draw_pixmap_text_selected,
			draw_pixmap_text_unselected,
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
		make
				-- Creation method
			do
					Precursor {SD_NOTEBOOK_TAB_DRAWER_I}

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
			l_imp: detachable EV_DRAWING_AREA_IMP
		do
			if (tab.is_hot or tab.is_selected)and is_top_side_tab then

				l_vision_rect := close_rectangle
				l_vision_rect.move (tab.x + l_vision_rect.x, l_vision_rect.y)

				-- Draw hot state background
				if tab.is_pointer_in_close_area then
					if attached tab.parent as l_parent then
						l_imp ?= l_parent.implementation
					else
						check False end -- Implied by `tab' is displaying on screen
					end
					check not_void: l_imp /= Void end
					if tab.is_pointer_pressed then
						tool_bar_drawer.draw_button_background (l_imp.c_object, l_vision_rect, {SD_TOOL_BAR_ITEM_STATE}.pressed)
					else
						tool_bar_drawer.draw_button_background (l_imp.c_object, l_vision_rect, {SD_TOOL_BAR_ITEM_STATE}.hot)
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

	draw_pixmap_text_selected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		local
			l_font: EV_FONT
		do
			if a_pixmap.height > 0 then
				-- Draw text
				a_pixmap.set_foreground_color (internal_shared.tab_text_color)
				if a_width - start_x_text_internal >= 0 then
					l_font := a_pixmap.font
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
					a_pixmap.set_font (l_font)
					if is_top_side_tab then
						a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height + 1, text, close_clipping_width (a_width))
					else
						a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height, text, text_clipping_width (a_width))
					end
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if is_top_side_tab then
						a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position + 1, pixmap)
					else
						a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position + 1, pixmap)
					end
				end

				draw_close_button (a_pixmap, internal_shared.icons.close)
			end
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		local
			l_font: EV_FONT
		do
			a_pixmap.set_foreground_color (internal_shared.tab_text_color)
			l_font := a_pixmap.font
			l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			a_pixmap.set_font (l_font)
			if is_top_side_tab then
				-- Draw pixmap
				a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position, pixmap)
				a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, gap_height + start_y_position_text, text, close_clipping_width (a_width))
			else
				-- Draw pixmap
				a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position, pixmap)
				-- Draw text
				a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text, text, text_clipping_width (a_width))
			end

			draw_close_button (a_pixmap, internal_shared.icons.close)
		end

	draw_focus_rect (a_rect: EV_RECTANGLE)
			-- Redefine
		local
			l_imp: detachable SD_DRAWING_AREA_IMP
		do
			if attached tab.parent as l_parent then
				l_imp ?= l_parent.implementation
			else
				check False end -- Implied by `tab' is displaying on screen
			end

			check not_void: l_imp /= Void end

			c_gtk_paint_focus (l_imp.c_object, {EV_GTK_EXTERNALS}.gtk_rc_get_style (l_imp.c_object), a_rect.x, a_rect.y, a_rect.width, a_rect.height)
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

feature {NONE}  -- Implementation	

	gap_height: INTEGER = 0
			-- Redefine

	start_y_position: INTEGER = 1
			-- Redefine

	start_y_position_text: INTEGER
			-- Redefine
		do
			Result := internal_shared.tool_bar_font.height // 3 - 2
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
			Result := {EV_GTK_EXTERNALS}.gtk_rc_get_style (style_source)
		ensure
			not_void: Result /= default_pointer
		end

	style_source: POINTER
			-- Notebook for query theme style.
		once
			Result := {EV_GTK_EXTERNALS}.gtk_notebook_new
		end

	internal_expose (a_width: INTEGER; a_x: INTEGER; a_is_selected: BOOLEAN)
			-- Expose implementation
		local
			l_imp: detachable SD_DRAWING_AREA_IMP
		do
			clear (a_width, a_x)
			if attached tab.parent as l_parent then
				l_imp ?= l_parent.implementation
				check not_void: l_imp /= Void end

				if {EV_GTK_EXTERNALS}.gtk_widget_struct_window (l_imp.c_object) /= default_pointer then
					c_gtk_paint_extension (l_imp.c_object, notebook_style, a_is_selected,
											 a_x, 0 ,a_width, tab.height, is_top_side_tab)
					if a_is_selected then
						draw_pixmap_text_selected (l_parent, tab.x, a_width)
					else
						draw_pixmap_text_unselected (l_parent, tab.x, a_width)
					end
				end
			else
				check False end -- Implied by `tab' is displaying on screen
			end
		end

	c_gtk_paint_extension (a_gtk_widget: POINTER; a_style: POINTER; a_selected: BOOLEAN;
									a_x, a_y, a_width, a_height: INTEGER;
									a_top: BOOLEAN)
			-- Gtk Draw notebook tabs.
			-- See gdknotebook.c gtk_notebook_draw_tab
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				GtkWidget *l_widget;
				GtkStyle *l_style;
				l_widget = GTK_WIDGET ($a_gtk_widget);
				l_style = gtk_style_attach (GTK_STYLE ($a_style), l_widget->window);
				
				GtkStateType l_state_type;
				GtkPositionType l_gap_side;
				GdkRectangle l_area = {$a_x, $a_y, $a_width, $a_height};
				
				if ($a_selected)
					l_state_type = GTK_STATE_NORMAL;
				else 
					l_state_type = GTK_STATE_ACTIVE;
				
				l_gap_side = 0;
				if ($a_top)
					l_gap_side = GTK_POS_BOTTOM;
				else
					l_gap_side = GTK_POS_TOP;
				
				gtk_paint_extension(l_style, l_widget->window,
					l_state_type, GTK_SHADOW_OUT,
					&l_area, l_widget, "tab",
					$a_x, $a_y, $a_width, $a_height,
					l_gap_side);

				gtk_style_detach (l_style);		
			}
			]"
		end

	c_gtk_paint_focus (a_gtk_widget: POINTER; a_style: POINTER; a_x, a_y, a_width, a_height: INTEGER)
			-- Draws a focus indicator around the given rectangle.
		external
			"C inline use <gtk/gtk.h>		"
		alias
			"[
			{
				GtkWidget *l_widget;
				GtkStyle *l_style;
				l_widget = GTK_WIDGET ($a_gtk_widget);
				l_style = gtk_style_attach (GTK_STYLE ($a_style), l_widget->window);
				
				GdkRectangle l_area = {$a_x, $a_y, $a_width, $a_height};
				
				gtk_paint_focus  (	l_style,
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

			}
			]"
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
