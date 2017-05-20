note
	description: "Comparators based on COMPARABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPARABLE_COMPARATOR [G -> COMPARABLE]

inherit
	COMPARATOR [G]

feature -- Status report

	less_than (u, v: G): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := u < v
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
