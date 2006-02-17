indexing
	description: "System color on Unix."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR_IMP

feature -- Access

	mdi_back_ground_color: EV_COLOR is
			-- Background color of Multiple Document Interface (MDI) Applications.
		do
			Result := active_color
		end

	focused_selection_color: EV_COLOR is
			-- Focused selection color for title bar.
		do
			Result := selected_color
		end

	non_focused_selection_color: EV_COLOR is
			-- Non focused selection color for title bar.
		do
			Result := normal_color
		end

feature {NONE} -- GTK text_aa colors.

	normal_color: EV_COLOR is
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

	active_color: EV_COLOR is
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

	prelight_color: EV_COLOR is
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

	selected_color: EV_COLOR is
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

	insesitive_color: EV_COLOR is
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

	frozen normal_bg_color (a_c_array: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_NORMAL])"
		end

	frozen selected_bg_color (a_c_array: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_SELECTED])"
		end

	frozen active_bg_color (a_c_array: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_ACTIVE])"
		end

	frozen prelight_bg_color (a_c_array: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_PRELIGHT])"
		end

	frozen insesitive_bg_color (a_c_array: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"&(((GdkColor *)$a_c_array)[GTK_STATE_INSENSITIVE])"
		end

feature {NONE} -- Implementation

	frozen tree_view : POINTER is
		once
			Result := {EV_GTK_EXTERNALS}.gtk_tree_view_new
		end

indexing
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
