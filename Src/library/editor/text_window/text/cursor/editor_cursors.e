indexing
	description: "Interface for editor related cursors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
    EDITOR_CURSORS

feature -- Cursor

	cur_cut_selection: EV_CURSOR is
			-- Editor cut cursor icon
		deferred
		ensure
			result_not_void: Result /= Void
		end

	cur_copy_selection: EV_CURSOR is
			-- Editor copy cursor icon
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




end -- class EDITOR_CURSORS
