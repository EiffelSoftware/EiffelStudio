--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "List of default colors used by the system.%
		% Gtk implementation."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_DEFAULT_COLORS_IMP

inherit
	C_GTK_WIDGET

	C_GTK_STYLE_STRUCT

	C_GDK_COLOR_STRUCT

feature -- Access

	Color_dialog: EV_COLOR is
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

end -- class EV_DEFAULT_COLORS_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:29  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.6  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.7.6.5  2000/01/27 19:29:33  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.4  1999/12/17 23:16:58  oconnor
--| update for new names from EV_COLOR
--|
--| Revision 1.7.6.3  1999/12/08 17:42:27  oconnor
--| removed more inherited externals
--|
--| Revision 1.7.6.2  1999/12/01 17:37:11  oconnor
--| migrating to new externals
--|
--| Revision 1.7.6.1  1999/11/24 17:29:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/04 23:10:27  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.7.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
