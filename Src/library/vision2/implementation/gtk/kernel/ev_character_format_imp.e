--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision character format, gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a new character format object.
		do
			create color.make_rgb (0, 0, 0)
			create font.make
		end

feature -- Access

	font: EV_FONT
			-- Font of the current format

	color: EV_COLOR
			-- Color of the current format

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := False
		end

	is_bold: BOOLEAN is
			-- Is the character bold?
		local
			font_imp: EV_FONT_IMP
		do
			font_imp ?= font.implementation
			Result := font_imp.is_bold
		end

	is_italic: BOOLEAN is
			-- Is the character in italic?
		local
			font_imp: EV_FONT_IMP
		do
			font_imp ?= font.implementation
			Result := font_imp.is_italic
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
		end

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		local
			font_imp: EV_FONT_IMP
		do
			font_imp ?= font.implementation
			font_imp.set_bold (flag)
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		local
			font_imp: EV_FONT_IMP
		do
			font_imp ?= font.implementation
			font_imp.set_italic (flag)
		end

feature -- Element change

	set_font (value: EV_FONT) is
			-- Make `value' the new font.
		do
			font := value
		end

	set_color (value:EV_COLOR) is
			-- Make `value' the new color.
		do
			color := value
		end

end -- class EV_CHARACTER_FORMAT_IMP

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
--| Revision 1.4  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:29:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
