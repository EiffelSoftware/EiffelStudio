indexing 
	description:
		" EiffelVision rich text, gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP

inherit
	EV_RICH_TEXT_I

	EV_TEXT_IMP
		redefine
			insert_text
		end

creation
	make

feature -- Access

	character_format: EV_CHARACTER_FORMAT
			-- Current character format.

feature -- Status setting

	insert_text (txt: STRING) is
		local
			a: ANY
			font_imp: EV_FONT_IMP
			color: EV_COLOR
		do
			if character_format /= Void then
				a := txt.to_c
				font_imp ?= character_format.font.implementation
				color := character_format.color
				c_gtk_text_full_insert (widget, font_imp.widget,
					color.red, color.green, color.blue,
					$a, txt.count)

--				gtk_text_insert (widget, font_imp.widget,
--					default_pointer, default_pointer,
--					$a, txt.count)
			else
				{EV_TEXT_IMP} Precursor (txt)
			end
		end

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		do
		end

feature -- Element change

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		do
			character_format := format
		end

feature -- Basic operation

	index_from_position (value_x, value_y: INTEGER): INTEGER is
			-- One-based character index of the character which is
			-- the nearest to `a_x' and `a_y' position in the client
			-- area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area. The coordinates are truncated
			-- to integer values and are in screen units relative
			-- to the upper-left corner of the client area of the
			-- control.
		do
		end

	position_from_index (value: INTEGER): EV_COORDINATES is
			-- Coordinates of a character at `value' in
			-- the client area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area.
			-- The coordinates are truncated to integer values and
			-- are in screen units relative to the upper-left
			-- corner of the client area of the control.
		do
		end

end -- class EV_RICH_TEXT_IMP

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
