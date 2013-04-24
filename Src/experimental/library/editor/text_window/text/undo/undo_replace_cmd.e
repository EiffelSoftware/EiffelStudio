note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REPLACE_CMD

inherit
	UNDO_TEXT_CMD

create
	make_from_strings

feature -- Initialization

	make_from_strings (c: EDITOR_CURSOR; s1,s2: READABLE_STRING_GENERAL; w: EDITABLE_TEXT)
		do
			y_start := c.y_in_lines
			x_start := c.x_in_characters
			old_message := s1.as_string_32
			new_message := s2.as_string_32
			text := w
		end

feature -- Access

	old_message: STRING_32

	new_message: STRING_32

	y_start: INTEGER

	x_start: INTEGER

feature -- Element change

	extend_old (c: CHARACTER_32)
		do
			old_message.extend (c)
		end

	extend_new (c: CHARACTER_32)
		do
			new_message.extend (c)
		end

	prepend_old  (c: CHARACTER_32)
		do
			old_message.precede (c)
		end

	extend_both (c1, c2: CHARACTER_32)
		do
			old_message.extend (c1)
			new_message.extend (c2)
		end

feature -- Basic operations

	undo
		local
			cur: detachable EDITOR_CURSOR
		do
			cur := text.cursor
			check cur /= Void end -- Implied by precondition
			cur.set_from_character_pos (x_start, y_start, text)
			text.forget_selection
			if not new_message.is_empty then
				text.delete_n_chars_at_cursor_pos (new_message.count)
			end
			if not old_message.is_empty then
				text.insert_string_at_cursor_pos (old_message)
			end
		end

	redo
		local
			cur: detachable EDITOR_CURSOR
		do
			cur := text.cursor
			check cur /= Void end -- Implied by precondition
			cur.set_from_character_pos (x_start, y_start, text)
			if not old_message.is_empty then
				text.delete_n_chars_at_cursor_pos (old_message.count)
			end
			text.forget_selection
			if not new_message.is_empty then
				text.insert_string_at_cursor_pos (new_message)
			end
		end

note
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
