indexing
	description: "Undo for uncomment and unindent."
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

	make (l: LINKED_LIST[INTEGER]; symbl: STRING; txt: EDITABLE_TEXT) is
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

	symbol: STRING

end -- class UNDO_UNCOMMENT_SELECTION_CMD
