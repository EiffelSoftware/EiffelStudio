indexing
	description:
		"Eiffel Vision default colors. Standard GUI drawing colors."
	keywords: "color, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEFAULT_COLORS

feature -- Access

	Color_dialog: EV_COLOR is
			-- Used for dialog box background.
			-- Name: "color dialog".
		do
			Result := implementation.Color_dialog
			Result.set_name ("color dialog")
		end

	Color_read_only: EV_COLOR is
			-- Used background of editable when read-only.
			-- Name: "color read only".
		do
			Result := implementation.Color_read_only
			Result.set_name ("color read only")
		end

	Color_read_write: EV_COLOR is
			-- Used for background of editable when write/write enabled.
			-- Name: "color read write".
		do
			Result := implementation.Color_read_write
			Result.set_name ("color read write")
		end

	default_background_color: EV_COLOR is
			-- Used for background of most widgets.
			-- Name: "default background".
		do
			Result := implementation.default_background_color
			Result.set_name ("default background")
		end

	default_foreground_color: EV_COLOR is
			-- Used for foreground of most widgets.
			-- Name: "default foreground".
		do
			Result := implementation.default_foreground_color
			Result.set_name ("default foreground")
		end

feature {NONE} -- Implementation

	implementation: EV_DEFAULT_COLORS_IMP is
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.
		once
			create Result
		end

end -- class EV_DEFAULT_COLORS

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.6.6.4  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.3  2000/01/19 18:18:20  oconnor
--| comments
--|
--| Revision 1.6.6.2  2000/01/19 18:10:32  oconnor
--| comments, formatting
--|
--| Revision 1.6.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
