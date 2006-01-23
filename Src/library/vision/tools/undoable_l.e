indexing

	description:
		"Ancestors of user commands for a history based on a linear list. %
		%This command will create an history of class HISTORY_LIST. %
		%Deferred features : is_error, n_ame, redo, undo, work"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	UNDOABLE_L 

inherit

	UNDOABLE

feature -- Access

	history: HISTORY_LIST is
			-- Trace of previously executed commands
		once
			create Result.make
		ensure then
			result_not_void: Result /= Void
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




end -- class UNDOABLE_L

