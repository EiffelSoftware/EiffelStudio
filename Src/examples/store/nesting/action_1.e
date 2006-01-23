indexing

	description: "Nested queries example."
	legal: "See notice at end of class."
	production: "EiffelStore"
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class ACTION_1 inherit

	ACTION
		redefine
			execute
		end
feature

	selection: DB_SELECTION

	make (sel: DB_SELECTION) is
		require
			sel_not_void: sel /= Void
		do
			selection := sel
		ensure
			selection = sel
		end
        
	execute is
		do
			process_row
		end

	process_row is
		deferred
		end

	select_string: STRING is
		deferred
		ensure
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


end -- class ACTION_1


