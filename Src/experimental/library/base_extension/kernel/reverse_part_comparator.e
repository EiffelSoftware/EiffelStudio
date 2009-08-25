note
	description: "Reverse partial order comparators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REVERSE_PART_COMPARATOR [G]

inherit
	PART_COMPARATOR [G]

create
	make

feature {NONE} -- Initialization

	make (a_comparator: like comparator)
			-- Create a new reverse comparator based on `a_comparator'.
		require
			a_comparator_not_void: a_comparator /= Void
		do
			comparator := a_comparator
		ensure
			comparator_set: comparator = a_comparator
		end

feature -- Status report

	less_than (u, v: G): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := comparator.less_than (v, u)
		ensure then
			definition: Result = comparator.less_than (v, u)
		end

feature -- Access

	comparator: PART_COMPARATOR [G]
			-- Base comparator

feature -- Setting

	set_comparator (a_comparator: like comparator)
			-- Set `comparator' to `a_comparator'.
		require
			a_comparator_not_void: a_comparator /= Void
		do
			comparator := a_comparator
		ensure
			comparator_set: comparator = a_comparator
		end

invariant
	comparator_not_void: comparator /= Void

note
	copyright: "[
		Copyright (c) 1984-2009, Eiffel Software and others
		Copyright (c) 2000, Eric Bezault and others
		]"
	license: "[
		Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)
		MIT License (see http://www.eiffel.com/licensing/mit.txt)
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
