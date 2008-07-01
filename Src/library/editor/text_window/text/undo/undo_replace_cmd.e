indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REPLACE_CMD

inherit
	UNDO_CMD

create
	make_from_strings

feature -- Initialization

	make_from_strings (c: EDITOR_CURSOR; s1,s2: STRING_GENERAL; w: EDITABLE_TEXT) is
		do
			y_start := c.y_in_lines
			x_start := c.x_in_characters
			old_message := s1
			new_message := s2
			text := w
		end

feature -- Access

	old_message: STRING_32

	new_message: STRING_32

	y_start: INTEGER

	x_start: INTEGER

feature -- Element change

	extend_old (c: CHARACTER_32) is
		do
			old_message.extend (c)
		end

	extend_new (c: CHARACTER_32) is
		do
			new_message.extend (c)
		end

	prepend_old  (c: CHARACTER_32) is
		do
			old_message.precede (c)
		end

	extend_both (c1, c2: CHARACTER_32) is
		do
			old_message.extend (c1)
			new_message.extend (c2)
		end

feature -- Basic operations

	undo is
		local
			cur: EDITOR_CURSOR
		do
			cur := text.cursor
			cur.make_from_character_pos (x_start, y_start, text)
			text.forget_selection
			text.delete_n_chars_at_cursor_pos (new_message.count)
			text.insert_string_at_cursor_pos (old_message)
		end

	redo is
		local
			cur: EDITOR_CURSOR
		do
			cur := text.cursor
			cur.make_from_character_pos (x_start, y_start, text)
			text.delete_n_chars_at_cursor_pos (old_message.count)
			text.forget_selection
			text.insert_string_at_cursor_pos (new_message)
		end


feature {NONE} -- Implementation

	text : EDITABLE_TEXT;

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




end -- class UNDO_REPLACE_CMD
