indexing
	description: "Undo command for string deletion."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_DELETE_CMD

inherit
	UNDO_CMD

create
	make_from_string

feature -- Initialization

	make_from_string (tc: EDITOR_CURSOR; s: STRING; txt: EDITABLE_TEXT) is
		do
			y_start := tc.y_in_lines
			x_start := tc.x_in_characters
			message := s
			text := txt
		end

feature -- Access

	message: STRING

	y_start: INTEGER

	x_start: INTEGER

feature -- Element change

	extend (c: CHARACTER) is
		do
			message.extend (c)
		end

	prepend (tc: EDITOR_CURSOR; c: CHARACTER) is
		do
			y_start := tc.y_in_lines
			x_start := tc.x_in_characters
			message.precede (c)
		end

feature -- Basic operations

	undo	is
		local
			cur: EDITOR_CURSOR
		do
			cur := text.cursor
			text.forget_selection
			cur.make_from_character_pos (x_start, y_start, text)
			text.insert_string_at_cursor_pos (message)
		end

	redo is
		local
			cur: EDITOR_CURSOR
		do
			cur := text.cursor
			text.forget_selection
			cur.make_from_character_pos (x_start, y_start, text)
			text.delete_n_chars_at_cursor_pos (message.count)
		end


feature {NONE} -- Implementation

	text : EDITABLE_TEXT

end -- class UNDO_DELETE_CMD
