indexing
	description: "Undo command for comment and indent."
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

	make (begin_s, end_s: EDITOR_CURSOR; symbl: STRING; txt: EDITABLE_TEXT) is
		do
			begin_selection := clone (begin_s)
			end_selection := clone (end_s)
			symbol := symbl
			text := txt
		end

feature -- Access

	begin_selection: EDITOR_CURSOR
		-- beginning of the "symboled" block

	end_selection: EDITOR_CURSOR
		-- end of the "symboled" block

	symbol: STRING
		-- symbol added at the beginning of the lines.

feature -- Basic operations

	undo is
			-- undo the command
		do
			text.unsymbol_selection (begin_selection, end_selection, symbol)
		end

	redo is
			-- redo the command
		do
			text.symbol_selection (begin_selection, end_selection, symbol)
		end


feature {NONE} -- Implementation

	text : EDITABLE_TEXT

end -- class UNDO_SYMBOL_SELECTION_CMD
