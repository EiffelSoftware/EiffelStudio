indexing 
	description:
		" EiffelVision text. A text area that contains%
		%a rich text."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT

inherit
	EV_TEXT_AREA
		redefine
			implementation,
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			!EV_TEXT_IMP!implementation.make
			widget_make (par)
		end

feature -- Access

	character_format: EV_CHARACTER_FORMAT is
			-- Current character format.
		require
			exists: not destroyed
		do
			Result := implementation.character_format
		end

feature -- Status setting

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		require
			exists: not destroyed
			valid_format: format /= Void
		do
			implementation.apply_format (format)
		end

feature -- Element change

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		require
			exists: not destroyed
		do
			implementation.set_character_format (format)
--		ensure
--			format_set: character_format = format
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
		require
			exists: not destroyed
			x_large_enough: value_x >= 0
			y_large_enough: value_y >= 0
		do
			Result := implementation.index_from_position (value_x, value_y)
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
		require
			exists: not destroyed
			index_large_enough: value >= 0
			index_small_enough: value <= text_length + 2
		do
			Result := implementation.position_from_index (value)
		ensure
			result_not_void: Result /= Void
		end

feature -- Implementation

	implementation: EV_TEXT_I

end -- class EV_TEXT

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
