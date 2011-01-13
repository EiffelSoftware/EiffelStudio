note
	description: "Undo command for string deletion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_DELETE_CMD

inherit
	UNDO_TEXT_CMD

create
	make_from_string

feature -- Initialization

	make_from_string (tc: EDITOR_CURSOR; s: READABLE_STRING_GENERAL; txt: EDITABLE_TEXT)
		require
			tc_not_void: tc /= Void
			s_not_void: s /= Void
			txt_not_void: txt /= Void
		do
			y_start := tc.y_in_lines
			x_start := tc.x_in_characters
			message := s.as_string_32
			text := txt
		end

feature -- Access

	message: STRING_32

	y_start: INTEGER

	x_start: INTEGER

feature -- Element change

	extend (c: CHARACTER_32)
		do
			message.extend (c)
		end

	prepend (tc: EDITOR_CURSOR; c: CHARACTER_32)
		do
			y_start := tc.y_in_lines
			x_start := tc.x_in_characters
			message.precede (c)
		end

feature -- Basic operations

	undo
		local
			cur: detachable EDITOR_CURSOR
		do
			cur := text.cursor
			check cur /= Void end -- Implied by precondition
			text.forget_selection
			cur.set_from_character_pos (x_start, y_start, text)
			if not message.is_empty then
				text.insert_string_at_cursor_pos (message)
			end
		end

	redo
		local
			cur: detachable EDITOR_CURSOR
		do
			cur := text.cursor
			check cur /= Void end -- Implied by precondition
			text.forget_selection
			cur.set_from_character_pos (x_start, y_start, text)
			if not message.is_empty then
				text.delete_n_chars_at_cursor_pos (message.count)
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




end -- class UNDO_DELETE_CMD
