note
	description: "Indexable data structure sorters using shell sort algorithm"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHELL_SORTER [G]

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
			jg, gap: INTEGER
			v1, v2: G
		do
			if lower < upper then
				from
					gap := (upper - lower + 1) // 2
				until
					gap <= 0
				loop
					from
						i := lower + gap
					until
						i > upper
					loop
						from
							j := i - gap
						until
							j < lower
						loop
							jg := j + gap
							v1 := a_container.item (j)
							v2 := a_container.item (jg)
							if a_comparator.less_than (v2, v1) then
								a_container.put (v2, j)
								a_container.put (v1, jg)
								j := j - gap
							else
								j := lower - 1
							end
						end
						i := i + 1
					end
					gap := gap // 2
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
