note

	description: "Nested queries example."
	legal: "See notice at end of class."
	production: "EiffelStore"
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class ACTION_2 inherit

	ACTION

feature

	selection: DB_SELECTION

	make (sel: DB_SELECTION)
		require
			sel_not_void: sel /= Void
		do
			selection := sel
		ensure
			selection = sel
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


end -- class ACTION_2






