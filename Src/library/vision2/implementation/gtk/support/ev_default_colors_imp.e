--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "List of default colors used by the system.%
		% Gtk implementation."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP

inherit
	C_GTK_WIDGET

	C_GTK_STYLE_STRUCT

	C_GDK_COLOR_STRUCT

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR is
			-- Color usely used for the background of dialogs
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := gtk_style_struct_bg (gtk_widget_get_default_style)
			r := gdk_color_struct_red (color)
			g := gdk_color_struct_green (color)
			b := gdk_color_struct_blue (color)
			create Result
			Result.set_rgb_with_16_bit (r, g, b)
		end

	Color_dialog_fg: EV_COLOR is
			-- Color usely used for the foreground of dialogs
		local
			r, g, b: INTEGER
			color: POINTER
		do
			color := gtk_style_struct_fg (gtk_widget_get_default_style)
			r := gdk_color_struct_red (color)
			g := gdk_color_struct_green (color)
			b := gdk_color_struct_blue (color)
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
--| FIXME, can you implement it Sam ?
			color := gtk_style_struct_fg (gtk_widget_get_default_style)
			r := gdk_color_struct_red (color)
			g := gdk_color_struct_green (color)
			b := gdk_color_struct_blue (color)
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
--| FIXME, can you implement it Sam ?
			color := gtk_style_struct_fg (gtk_widget_get_default_style)
			r := gdk_color_struct_red (color)
			g := gdk_color_struct_green (color)
			b := gdk_color_struct_blue (color)
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

end -- class EV_STOCK_COLORS_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

