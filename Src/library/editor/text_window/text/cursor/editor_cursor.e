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
--			char_is_separator,
			set_line
		end

create
	make_from_relative_pos,
	make_from_character_pos, make_from_integer

feature -- Element change

	set_line (a_line: EDITOR_LINE) is
			-- Make `a_line' the new value of `line'.
		do			
			if editor_preferences.remove_trailing_white_space and then line /= Void then					
				text.remove_trailing_white_space				
			end
			Precursor {TEXT_CURSOR} (a_line)
		end

	set_current_char (a_token: EDITOR_TOKEN; a_position: INTEGER) is
			-- Make `a_token' be the new value for `token'.
			-- Set the value of `pos_in_token' to `a_position'.
			-- Update `x_in_pixels' accordingly.
		do
			Precursor {TEXT_CURSOR} (a_token, a_position)
			text.on_cursor_move (Current)
		end

feature {EDITABLE_TEXT} -- Implementation

	update_current_char is
			-- Update the current token and the the position in it.
			-- It is required that the cursor is not in the left margin.
		do
			Precursor {TEXT_CURSOR}
			text.on_cursor_move (Current)
		end

feature {NONE} -- Implementation

--	char_is_separator (char: CHARACTER): BOOLEAN is
--			-- Is `char' a word separator?
--		do
--			Result := Precursor (char) or else
--					(Editor_preferences.underscore_is_separator and then (char = '_'))
--		end

	text: EDITABLE_TEXT
			-- Text that contains `current'.

end -- class EDITOR_CURSOR
