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

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a new character format object.
		do
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
		do
		end

	is_italic: BOOLEAN is
			-- Is the character in italic?
		do
		end

	is_underline: BOOLEAN is
			-- Is the character underline?
		do
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
		end

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		do
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		do
		end

	set_underline (flag: BOOLEAN) is
			-- Set underline characters if `flag', unset otherwise.
		do
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

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
