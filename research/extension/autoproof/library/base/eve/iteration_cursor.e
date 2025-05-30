note
	description: "External iteration cursor used by `across...loop...end'."
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ITERATION_CURSOR [G]

feature -- Access

	item: G
			-- Item at current cursor position.
		require
			closed: closed
			valid_position: not after
		deferred
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		require
			closed: closed
		deferred
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		require
			valid_position: not after
			subjects_closed: across subjects as s all s.closed end
		deferred
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
