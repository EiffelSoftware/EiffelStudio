--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision character format. Contains%
		% information about character formatting%
		% in a rich text."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT

inherit
	EV_ANY
		redefine
			implementation
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a new character format object.
		do
			create {EV_CHARACTER_FORMAT_IMP} implementation.make
			implementation.set_interface (Current)
		end

feature -- Access

	font: EV_FONT is
			-- Font of the current format
		require
		do
			Result := implementation.font
		end

	color: EV_COLOR is
			-- Color of the current format
		require
		do
			Result := implementation.color
		end

feature -- Status report

	is_bold: BOOLEAN is
			-- Is the character bold?
		require
		do
			Result := implementation.is_bold
		end

	is_italic: BOOLEAN is
			-- Is the character in italic?
		require
		do
			Result := implementation.is_italic
		end

feature -- Status setting

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		require
		do
			implementation.set_bold (flag)
		ensure
--			flag_set: (flag implies is_bold) and 
--						(not flag implies not is_bold)
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		require
		do
			implementation.set_italic (flag)
		ensure
--			flag_set: (flag implies is_italic) and 
--						(not flag implies not is_italic)
		end

feature -- Element change

	set_font (value: EV_FONT) is
			-- Make `value' the new font.
		require
			valid_font: is_valid (value)
		do
			implementation.set_font (value)
		ensure
--			font_set: font = value
		end

	set_color (value:EV_COLOR) is
			-- Make `value' the new color.
		require
			valid_color: is_valid (value)
		do
			implementation.set_color (value)
		ensure
			color_set: color.equal_color (value)
		end

feature -- Implementation

	implementation: EV_CHARACTER_FORMAT_I
			-- Implementation of the current object

end -- class EV_CHARACTER_FORMAT

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
--| Revision 1.6  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.2  2000/01/27 19:30:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.1  1999/11/24 17:30:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:53  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
