note
	description: "Indexable data structure sorters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SORTER [G]

feature {NONE} -- Initialization

	make (a_comparator: like comparator)
			-- Create a new sorter.
		require
			a_comparator_not_void: a_comparator /= Void
		do
			comparator := a_comparator
		ensure
			comparator_set: comparator = a_comparator
		end

feature -- Access

	comparator: PART_COMPARATOR [G]
			-- Comparison criterion

feature -- Status report

	is_sortable_container (a_container: INDEXABLE [G, INTEGER]): BOOLEAN
			-- Is `a_container' useable for sorting?
		do
			Result := attached a_container
		end

	sorted (a_container: INDEXABLE [G, INTEGER]): BOOLEAN
			-- Is `a_container' sorted in increasing order?
		require
			valid_container: is_sortable_container (a_container)
		do
			Result := sorted_with_comparator (a_container, comparator)
		end

	reverse_sorted (a_container: INDEXABLE [G, INTEGER]): BOOLEAN
			-- Is `a_container' sorted in decreasing order?
		require
			valid_container: is_sortable_container (a_container)
		do
			if a_container.is_empty then
				Result := True
			else
				Result := sorted_with_comparator (a_container, create {REVERSE_PART_COMPARATOR [G]}.make (comparator))
			end
		end

	sorted_with_comparator (a_container: INDEXABLE [G, INTEGER]; a_comparator: PART_COMPARATOR [G]): BOOLEAN
			-- Is `a_container' sorted according to
			-- `a_comparator''s comparison criterion?
		require
			valid_container: is_sortable_container (a_container)
			a_comparator_not_void: a_comparator /= Void
		do
			Result := a_container.is_empty or else
				subsorted_with_comparator (a_container, a_comparator, a_container.lower, a_container.upper)
		end

	subsorted (a_container: INDEXABLE [G, INTEGER]; lower, upper: INTEGER): BOOLEAN
			-- Is `a_container' sorted in increasing order
			-- within bounds `lower'..`upper'?
		require
			valid_container: is_sortable_container (a_container)
			valid_lower: a_container.valid_index (lower)
			valid_upper: a_container.valid_index (upper)
			valid_bounds: lower <= upper
		do
			Result := subsorted_with_comparator (a_container, comparator, lower, upper)
		end

	reverse_subsorted (a_container: INDEXABLE [G, INTEGER]; lower, upper: INTEGER): BOOLEAN
			-- Is `a_container' sorted in decreasing order
			-- within bounds `lower'..`upper'?
		require
			valid_container: is_sortable_container (a_container)
			valid_lower: a_container.valid_index (lower)
			valid_upper: a_container.valid_index (upper)
			valid_bounds: lower <= upper
		local
			a_comparator: REVERSE_PART_COMPARATOR [G]
		do
			create a_comparator.make (comparator)
			Result := subsorted_with_comparator (a_container, a_comparator, lower, upper)
		end

	subsorted_with_comparator (a_container: INDEXABLE [G, INTEGER]; a_comparator: PART_COMPARATOR [G]; lower, upper: INTEGER): BOOLEAN
			-- Is `a_container' sorted according to `a_comparator''s
			-- comparison criterion within bounds `lower'..`upper'?
		require
			valid_container: is_sortable_container (a_container)
			a_comparator_not_void: a_comparator /= Void
			valid_lower: a_container.valid_index (lower)
			valid_upper: a_container.valid_index (upper)
			valid_bounds: lower <= upper
		local
			i: INTEGER
			v1, v2: G
		do
			from
				Result := True
				v2 := a_container.item (lower)
				i := lower + 1
			until
				i > upper
			loop
				v1 := v2
				v2 := a_container.item (i)
				if a_comparator.less_than (v2, v1) then
					Result := False
						-- Jump out of the loop.
					i := upper + 1
				else
					i := i + 1
				end
			end
		end

feature -- Sort

	sort (a_container: INDEXABLE [G, INTEGER])
			-- Sort `a_container' in increasing order.
		require
			valid_container: is_sortable_container (a_container)
		do
			sort_with_comparator (a_container, comparator)
		ensure
			sorted: sorted (a_container)
		end

	reverse_sort (a_container: INDEXABLE [G, INTEGER])
			-- Sort `a_container' in decreasing order.
		require
			valid_container: is_sortable_container (a_container)
		do
			if not a_container.is_empty then
				sort_with_comparator (a_container, create {REVERSE_PART_COMPARATOR [G]}.make (comparator))
			end
		ensure
			sorted: reverse_sorted (a_container)
		end

	sort_with_comparator (a_container: INDEXABLE [G, INTEGER]; a_comparator: PART_COMPARATOR [G])
			-- Sort `a_container' according to
			-- `a_comparator''s comparison criterion?
		require
			valid_container: is_sortable_container (a_container)
			a_comparator_not_void: a_comparator /= Void
		do
			if not a_container.is_empty then
				subsort_with_comparator (a_container, a_comparator, a_container.lower, a_container.upper)
			end
		ensure
			sorted: sorted_with_comparator (a_container, a_comparator)
		end

	subsort (a_container: INDEXABLE [G, INTEGER]; lower, upper: INTEGER)
			-- Sort `a_container' in increasing order
			-- within bounds `lower'..`upper'.
		require
			valid_container: is_sortable_container (a_container)
			valid_lower: a_container.valid_index (lower)
			valid_upper: a_container.valid_index (upper)
			valid_bounds: lower <= upper
		do
			subsort_with_comparator (a_container, comparator, lower, upper)
		ensure
			subsorted: subsorted (a_container, lower, upper)
		end

	reverse_subsort (a_container: INDEXABLE [G, INTEGER]; lower, upper: INTEGER)
			-- Sort `a_container' in decreasing order
			-- within bounds `lower'..`upper'.
		require
			valid_container: is_sortable_container (a_container)
			valid_lower: a_container.valid_index (lower)
			valid_upper: a_container.valid_index (upper)
			valid_bounds: lower <= upper
		local
			a_comparator: REVERSE_PART_COMPARATOR [G]
		do
			create a_comparator.make (comparator)
			subsort_with_comparator (a_container, a_comparator, lower, upper)
		ensure
			subsorted: reverse_subsorted (a_container, lower, upper)
		end

	subsort_with_comparator (a_container: INDEXABLE [G, INTEGER]; a_comparator: PART_COMPARATOR [G]; lower, upper: INTEGER)
			-- Sort `a_container' according to `a_comparator''s
			-- comparison criterion within bounds `lower'..`upper'?
		require
			valid_container: is_sortable_container (a_container)
			a_comparator_not_void: a_comparator /= Void
			valid_lower: a_container.valid_index (lower)
			valid_upper: a_container.valid_index (upper)
			valid_bounds: lower <= upper
		deferred
		ensure
			subsorted: subsorted_with_comparator (a_container, a_comparator, lower, upper)
		end

invariant
	comparator_not_void: comparator /= Void

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
