--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision character format,implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHARACTER_FORMAT_I

inherit
	EV_ANY_I

feature -- Access

	font: EV_FONT is
			-- Font of the current format
		require
		deferred
		end

	color: EV_COLOR is
			-- Color of the current format
		require
		deferred
		end

feature -- Status report

	is_bold: BOOLEAN is
			-- Is the character bold?
		require
		deferred
		end

	is_italic: BOOLEAN is
			-- Is the character in italic?
		require
		deferred
		end

feature -- Status setting

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		require
		deferred
		ensure
--			flag_set: (flag implies is_bold) and 
--						(not flag implies not is_bold)
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		require
		deferred
		ensure
--			flag_set: (flag implies is_italic) and 
--						(not flag implies not is_italic)
		end

feature -- Element change

	set_font (value: EV_FONT) is
			-- Make `value' the new font.
		require
			valid_font: is_valid (value)
		deferred
		ensure
--			font_set: font = value
		end

	set_color (value: EV_COLOR) is
			-- Make `value' the new color.
		require
			valid_color: is_valid (value)
		deferred
		ensure
			color_set: color.equal_color (value)
		end

end -- class EV_CHARACTER_FORMAT_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.6  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:29:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
