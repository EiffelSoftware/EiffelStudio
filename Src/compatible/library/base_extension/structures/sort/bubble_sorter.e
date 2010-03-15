note
	description: "Indexable data structure sorters using bubble sort algorithm"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUBBLE_SORTER [G]

inherit
	SORTER [G]

create
	make

feature -- Sort

	subsort_with_comparator (a_container: INDEXABLE [G, INTEGER]; a_comparator: PART_COMPARATOR [G]; lower, upper: INTEGER)
			-- Sort `a_container' according to `a_comparator''s
			-- comparison criterion within bounds `lower'..`upper'?
		local
			i, j: INTEGER
			flipped: BOOLEAN
			v1, v2: G
		do
			from
				i := upper
			until
				i <= lower
			loop
				from
					j := lower
				until
					j >= i
				loop
					v1 := a_container.item (j)
					v2 := a_container.item (j + 1)
					if a_comparator.less_than (v2, v1) then
						a_container.put (v2, j)
						a_container.put (v1, j + 1)
						flipped := True
					end
					j := j + 1
				end
				if flipped then
					i := i - 1
					flipped := False
				else
					i := lower
				end
			end
		end

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
