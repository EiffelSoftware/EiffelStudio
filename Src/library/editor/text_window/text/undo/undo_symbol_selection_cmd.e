indexing
	description: "Undo command for comment and indent."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_SYMBOL_SELECTION_CMD

inherit
	UNDO_CMD

create
	make

feature -- Initialization

	make (a_lines: like lines; symbl: STRING_GENERAL; txt: EDITABLE_TEXT) is
		require
			a_lines_not_void: a_lines /= Void
			symbl_not_void: symbl /= Void
			txt_not_void: txt /= Void
		do
			lines := a_lines
			symbol := symbl
			text := txt
		ensure
			lines_set: lines = a_lines
			symbol_set: symbol = symbl
			text_set: text = txt
		end

feature -- Access

	lines: LINKED_LIST[INTEGER]

	symbol: STRING_GENERAL
		-- symbol added at the beginning of the lines.

feature -- Basic operations

	undo is
			-- undo the command
		do
			do_selection (False)
		end

	redo is
			-- redo the command
		do
			do_selection (True)
		end

feature {NONE} -- Implementation

	text : EDITABLE_TEXT

	do_selection (a_symbol: BOOLEAN) is
			-- Symbol or unsymbol the section.
		local
			b, e: EDITOR_CURSOR
		do
			from
				lines.start
				create b.make_from_character_pos (1, 1, text)
				create e.make_from_character_pos (1, 1, text)
			until
				lines.after
			loop
				b.make_from_character_pos (1, lines.item, text)
				e.make_from_character_pos (1, lines.item, text)
				e.go_end_line
				if not a_symbol then
					text.unsymbol_selection (b, e, symbol)
				else
					text.symbol_selection (b, e, symbol)
				end
				lines.forth
			end
		end

invariant
	lines_set: lines /= Void
	symbol_not_void: symbol /= Void
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




end -- class UNDO_SYMBOL_SELECTION_CMD
