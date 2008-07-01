indexing
	description: "Undo for uncomment and unindent."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_UNSYMBOL_SELECTION_CMD

inherit
	UNDO_CMD

create
	make

feature -- Initialization

	make (l: LINKED_LIST[INTEGER]; symbl: STRING_GENERAL; txt: EDITABLE_TEXT) is
		require
			l_is_not_void: l /= Void
			symbl_is_not_void: symbl /= Void
			txt_is_not_void: txt /= Void
		do
			lines := l
			text := txt
			symbol := symbl
		end

feature -- Basic operations

	undo is
		local
			b, e: EDITOR_CURSOR
		do
			from
				lines.start
				create b.make_from_character_pos(1, 1, text)
				create e.make_from_character_pos(1, 1, text)
			until
				lines.after
			loop
				b.make_from_character_pos(1, lines.item, text)
				e.make_from_character_pos(1, lines.item, text)
				e.go_end_line
				text.symbol_selection (b, e, symbol)
				lines.forth
			end
		end

	redo is
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
				text.unsymbol_selection (b, e, symbol)
				lines.forth
			end
		end

feature {NONE} -- Implementation

	lines: LINKED_LIST[INTEGER]

	text : EDITABLE_TEXT

	symbol: STRING_32;

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




end -- class UNDO_UNCOMMENT_SELECTION_CMD
