indexing
	description: "Undo command for string insertion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard / Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_INSERT_CMD

inherit
	UNDO_CMD

create
	make_from_string

feature -- Initialization

	make_from_string (c: EDITOR_CURSOR; s: STRING; w: EDITABLE_TEXT) is
		do
			y_start := c.y_in_lines
			x_start := c.x_in_characters
			message := s
			text := w
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

	extend_string(s: STRING) is
		do
			message.append_string(s)
		end

feature -- Basic operations

	undo is
		local
			cur: EDITOR_CURSOR
		do
			cur := text.cursor
			text.forget_selection
			cur.make_from_character_pos (x_start, y_start, text)
			text.delete_n_chars_at_cursor_pos (message.count)
		end

	redo is
		local
			cur: EDITOR_CURSOR
		do
			cur := text.cursor
			text.forget_selection
			cur.make_from_character_pos (x_start, y_start, text)
			text.insert_string_at_cursor_pos (message)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	text : EDITABLE_TEXT

invariant
	invariant_clause: -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class UNDO_INSERT_CMD
