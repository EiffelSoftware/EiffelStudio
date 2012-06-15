note
	description: "Concrete of an external iteration cursor for {SEARCH_TABLE}."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_TABLE_ITERATION_CURSOR [K -> HASHABLE]

inherit
	ITERATION_CURSOR [K]

create
	make

feature {NONE} -- Initialization

	make (a_target: like target)
			-- Initialize current with `a_target'.
		do
			target := a_target
			iteration_position := a_target.next_iteration_position (-1)
		ensure
			target_set: target = a_target
		end

feature -- Access

	item: K
			-- <Precursor>
		do
			check attached target.content.item (iteration_position) as l_item then
				Result := l_item
			end
		end

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := iteration_position >= target.capacity
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			iteration_position := target.next_iteration_position (iteration_position)
		end

feature {NONE} -- Access

	iteration_position: INTEGER
			-- Current position in traversal of `target'.

	target: SEARCH_TABLE [K];
			-- Associated structure used for iteration.

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
