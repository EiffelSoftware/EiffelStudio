indexing
	description:
		"Implementation of comparator facility"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	COMPARATOR_FACILITY_IMPL

feature -- Basic operations

	compare_range (c: COMPARATOR; low, high: INTEGER; 
				state: BOOLEAN): BOOLEAN is
			-- Does `c' return `state' for all items in range from `low' to
			-- `high'?
		require
			comparator_exists: c /= Void
			low_non_negative: low >= 0
			high_non_negative: high >= 0
			boundaries_not_swapped: low <= high
		local
			i: INTEGER
		do
			from
				i := low
				Result := state
			until
				not Result or i > high
			loop
				Result := c.is_true (i)
				i := i + 1
			end
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




end -- class COMPARATOR_FACILITY_IMPL

