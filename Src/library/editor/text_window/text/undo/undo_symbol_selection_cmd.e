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

	make (begin_s, end_s: EDITOR_CURSOR; symbl: STRING; txt: EDITABLE_TEXT) is
		require
			begin_s_not_void: begin_s /= Void
			end_s_not_void: end_s /= Void
			symbl_not_void: symbl /= Void
			txt_not_void: txt /= Void
		do
			begin_selection := begin_s.twin
			end_selection := end_s.twin
			symbol := symbl
			text := txt
		ensure	
			begin_selection_set: begin_selection.is_equal (begin_s)
			end_selection_set: end_selection.is_equal (end_s)
			symbol_set: symbol = symbl
			text_set: text = txt
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

invariant
	begin_selection_not_void: begin_selection /= Void
	end_selection_not_void: end_selection /= Void
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
