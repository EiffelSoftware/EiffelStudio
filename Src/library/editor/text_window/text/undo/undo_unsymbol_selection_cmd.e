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
	UNDO_SYMBOL_SELECTION_CMD
		redefine
			undo,
			redo
		end

create
	make

feature -- Basic operations

	undo is
			-- undo the command
		do
			do_selection (True)
		end

	redo is
			-- redo the command
		do
			do_selection (False)
		end

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
