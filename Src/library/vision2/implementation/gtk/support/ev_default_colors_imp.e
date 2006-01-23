indexing
	description: "List of default colors used by the system.%
		% Gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR is
			-- Color usely used for the background of dialogs
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := {EV_GTK_EXTERNALS}.gtk_style_struct_bg ({EV_GTK_EXTERNALS}.gtk_widget_get_default_style)
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	Color_dialog_fg: EV_COLOR is
			-- Color usely used for the foreground of dialogs
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := {EV_GTK_EXTERNALS}.gtk_style_struct_fg ({EV_GTK_EXTERNALS}.gtk_widget_get_default_style)
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	Color_3d_highlight: EV_COLOR is
			-- Used for 3D-effects (light color)
			-- Name "color highlight"
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := {EV_GTK_EXTERNALS}.gtk_style_struct_fg ({EV_GTK_EXTERNALS}.gtk_widget_get_default_style)
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	Color_3d_shadow: EV_COLOR is
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := {EV_GTK_EXTERNALS}.gtk_style_struct_fg ({EV_GTK_EXTERNALS}.gtk_widget_get_default_style)
			r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (color)
			g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (color)
			b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	Color_read_only: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read-only mode
		do
			check True end
			Result := Color_dialog
		end

	Color_read_write: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read / write mode
		do
			check True end
			Result := Color_dialog
		end

	default_background_color: EV_COLOR is
			-- Default background color for most of the widgets.
		do
			check True end
			Result := Color_dialog
		end

	default_foreground_color: EV_COLOR is
			-- Default foreground color for most of the widgets.
		do
			check True end
			Result := Color_dialog_fg
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




end -- class EV_STOCK_COLORS_IMP

