indexing
	description: "Cursor in EiffelStudio editors"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_CURSOR

inherit
	TEXT_CURSOR
		redefine
			set_current_char,
			update_current_char,
			text,
			char_is_separator
		end

	EB_SHARED_EDITOR_DATA
		undefine
			is_equal
		end

create
	make_from_relative_pos,
	make_from_character_pos, make_from_integer

feature -- Element change

	set_current_char (a_token: EDITOR_TOKEN; a_position: INTEGER) is
			-- Make `a_token' be the new value for `token'.
			-- Set the value of `pos_in_token' to `a_position'.
			-- Update `x_in_pixels' accordingly.
		do
			{TEXT_CURSOR} Precursor (a_token, a_position)
			on_cursor_move
		end

feature {EDITABLE_TEXT} -- Implementation

	update_current_char is
			-- Update the current token and the the position in it.
			-- It is required that the cursor is not in the left margin.
		do
			on_cursor_move

				-- Update the current token.
			{TEXT_CURSOR} Precursor
		end

feature {NONE} -- Implementation

	char_is_separator (char: CHARACTER): BOOLEAN is
			-- Is `char' a word separator?
		do
			Result := Precursor (char) or else
					(Editor_preferences.underscore_is_separator and then (char = '_'))
		end

	text: EDITABLE_TEXT
			-- Text that contains `current'.

feature {NONE} -- Observer Pattern

	on_cursor_move is
			-- Notify associated text that `Current' has moved.
		do
			text.on_cursor_move (Current)
		end

end -- class EDITOR_CURSOR
