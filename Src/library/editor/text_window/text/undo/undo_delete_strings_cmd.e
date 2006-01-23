indexing
	description: "Undo removing trailing blanks command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_DELETE_STRINGS_CMD

inherit
	UNDO_CMD

create
	make

feature {NONE} -- Initialization

	make (a_text: EDITABLE_TEXT) is
			-- Initialization
		require
			a_text_attached: a_text /= Void
		do
			create undo_remove_trailing_blank_list.make
			text := a_text
		ensure
			text_not_void: text = a_text
		end

feature -- Transformation

	add (urc: UNDO_DELETE_CMD) is
			-- add the undo command to the list
		do
			undo_remove_trailing_blank_list.extend (urc)
		end

feature -- Status report

	converse : BOOLEAN
			-- Converse redo and undo behavior?

feature -- Status change

	set_converse (b: BOOLEAN) is
			-- Set `converse' with `b'.
		do
			converse := b
		end

feature -- Basic Operations

	redo is
			-- undo this command
		do
			if not converse then
				actual_redo
			else
				actual_undo
			end
		end

	undo is
			-- redo this command
		do
			if not converse then
				actual_undo
			else
				actual_redo
			end
		end

feature {NONE} -- Implementation

	actual_undo is
			-- Actual undo
		local
			x_in_characters, y_in_lines : INTEGER
		do
			x_in_characters := text.cursor.x_in_characters
			y_in_lines := text.cursor.y_in_lines
			from
				undo_remove_trailing_blank_list.finish
			until
				undo_remove_trailing_blank_list.before
			loop
				undo_remove_trailing_blank_list.item.undo
				undo_remove_trailing_blank_list.back
			end
			text.cursor.make_from_character_pos (x_in_characters, y_in_lines, text)
		end

	actual_redo is
			-- Actual redo
		local
			x_in_characters, y_in_lines : INTEGER
		do
			x_in_characters := text.cursor.x_in_characters
			y_in_lines := text.cursor.y_in_lines
			from
				undo_remove_trailing_blank_list.start
			until
				undo_remove_trailing_blank_list.after
			loop
				undo_remove_trailing_blank_list.item.redo
				undo_remove_trailing_blank_list.forth
			end
			text.cursor.make_from_character_pos (x_in_characters, y_in_lines, text)
		end

	undo_remove_trailing_blank_list: LINKED_LIST [UNDO_DELETE_CMD]

	text: EDITABLE_TEXT

invariant

	undo_list_not_void: undo_remove_trailing_blank_list /= Void
	text_not_void: text /= Void

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




end
