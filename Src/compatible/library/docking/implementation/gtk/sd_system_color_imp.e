note
	description: "System color on Unix."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR_IMP

inherit
	SD_SYSTEM_COLOR

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initlization
	make
			-- Creation method
		do
		end

feature -- Access

	default_background_color: EV_COLOR
			-- Default background color
		local
			l_stock_colors: EV_STOCK_COLORS
		do
			create l_stock_colors
			Result := l_stock_colors.default_background_color
		end

	mdi_back_ground_color: EV_COLOR
			-- Background color of Multiple Document Interface (MDI) Applications.
		do
			Result := active_color
		end

	focused_selection_color: EV_COLOR
			-- Focused selection color for title bar.
		do
			Result := selected_color
		end

	non_focused_selection_color: EV_COLOR
			-- Non focused selection color for title bar.
		do
			Result := normal_color
		end

	non_focused_title_text_color: EV_COLOR
			-- Non focuesd title text color
		local
			l_helper: SD_COLOR_HELPER
		do
			create l_helper
			Result := l_helper.text_color_by (non_focused_selection_title_color)
		end

	non_focused_selection_title_color: EV_COLOR
			-- Non focused selection title color
		do
			Result := insesitive_color
		end

	active_border_color: EV_COLOR
			-- Active border color
		do
			Result := active_color--dark_color
		end

	focused_title_text_color: EV_COLOR
			-- Focused title text color
		local
			l_grid: EV_GRID
		do
			create l_grid
			Result := l_grid.focused_selection_text_color
		end

	button_text_color: EV_COLOR
			-- Button text color
		local
			l_grid: EV_GRID
		do
			create l_grid
			Result := l_grid.foreground_color
		end

feature -- Font

	tool_bar_font: EV_FONT
			-- Redefine.
		local
			l_drawing_area: EV_DRAWING_AREA
		do
			create l_drawing_area
			Result := l_drawing_area.font
		end

feature -- HoT zone factory

	hot_zone_factory: SD_HOT_ZONE_OLD_FACTORY
			-- Hot zone factory which will be used on GTK.
		do
			create Result
		end

feature {NONE} -- GTK text_aa colors.

	normal_color: EV_COLOR
			-- State during normal operation.
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := normal_bg_color({EV_GTK_EXTERNALS}.gtk_style_struct_bg ({EV_GTK_EXTERNALS}.gtk_rc_get_style (tree_view)))
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	active_color: EV_COLOR
			-- State of a currently active widget, such as a depressed button.
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := active_bg_color({EV_GTK_EXTERNALS}.gtk_style_struct_bg ({EV_GTK_EXTERNALS}.gtk_rc_get_style (tree_view)))
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	dark_color: EV_COLOR
			-- Dark color of a widget.
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := normal_bg_color({EV_GTK_EXTERNALS}.gtk_style_struct_dark ({EV_GTK_EXTERNALS}.gtk_rc_get_style (tree_view)))
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	prelight_color: EV_COLOR
			-- State indicating that the mouse pointer is over the widget and widget will respond to mouse clicks.
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := prelight_bg_color({EV_GTK_EXTERNALS}.gtk_style_struct_bg ({EV_GTK_EXTERNALS}.gtk_rc_get_style (tree_view)))
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	selected_color: EV_COLOR
			-- State of a selected item, such the selected row in a list.
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := selected_bg_color({EV_GTK_EXTERNALS}.gtk_style_struct_bg ({EV_GTK_EXTERNALS}.gtk_rc_get_style (tree_view)))
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	insesitive_color: EV_COLOR
			-- State indicating that the widget is unresponsive to user actions.
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := insesitive_bg_color({EV_GTK_EXTERNALS}.gtk_style_struct_bg ({EV_GTK_EXTERNALS}.gtk_rc_get_style (tree_view)))
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

feature {NONE} -- Implementation

	frozen normal_bg_color (a_c_array: POINTER): POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_NORMAL])"
		end

	frozen selected_bg_color (a_c_array: POINTER): POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_SELECTED])"
		end

	frozen active_bg_color (a_c_array: POINTER): POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_ACTIVE])"
		end

	frozen prelight_bg_color (a_c_array: POINTER): POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_PRELIGHT])"
		end

	frozen insesitive_bg_color (a_c_array: POINTER): POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_INSENSITIVE])"
		end

feature {NONE} -- Implementation

	frozen tree_view : POINTER
		once
			Result := {EV_GTK_EXTERNALS}.gtk_tree_view_new
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
