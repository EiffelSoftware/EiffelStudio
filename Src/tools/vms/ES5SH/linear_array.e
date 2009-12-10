indexing
	description: "Multiple purpose array which is linear, extendable, sortable and iterable"
	author: "Mark Howard"
	date: "$Date$"
	revision: "$Revision$"
	path: "$File: //rose/source/kernel/infrastructure/containers/rose_linear_array.e $"

class ROSE_LINEAR_ARRAY [G]

inherit
	SORTABLE_ARRAY [G]
		redefine
			binary_search,
			linear_search
		end

create
	make, make_empty, make_from_array, make_from_linear, make_from_array_reversed, make_with_default_value

convert
	make_from_array({ARRAY[G]})

feature {NONE} -- Correction

--	correct_mismatch is
--			-- Attempt to correct object mismatch using `mismatch_information'.
--		local
--			l_mismatch: MISMATCH_INFORMATION
--		do
--			l_mismatch := mismatch_information
--		end

feature -- Access

	infix "+" (a_other: LINEAR [G]): like Current is
			-- Union of 'Current' and 'a_other'
		require
			valid_other: a_other /= Void
		do
			Result := twin
			if a_other /= Void  then
				from a_other.start until a_other.off loop
					Result.extend (a_other.item)
					a_other.forth
				end
			end
		end

	subset (a_indices: ARRAY [INTEGER]): like Current is
			-- Subset composed of items at 'a_indices' from this array
		local
			i, j, k, l_lower: INTEGER
		do
			k := a_indices.count
			l_lower := a_indices.lower
			create Result.make (1,k)
			from i := 1 until i > k loop
				j := a_indices.item (l_lower + i - 1)
				if not valid_index (j) then
					(create {EXCEPTIONS}).raise ("Invalid index given to ROSE_LINEAR_ARRAY.subset")
				end
				Result.put (item (j),i)
				i := i + 1
			end
		end

	subset3 (a_indices: ARRAY [INTEGER]): like Current is
			-- Subset composed of items at 'a_indices' from this array
			-- compare to subset feature, subset3 has loose requirement. If a_indices[i] is invalid, put null in position i.
		local
			i, j, k, l_lower: INTEGER
		do
			k := a_indices.count
			l_lower := a_indices.lower
			create Result.make (1,k)
			from i := 1 until i > k loop
				j := a_indices.item (l_lower + i - 1)
				if not valid_index (j) then
					Print ("%NInvalid index given to ROSE_LINEAR_ARRAY.subset%N")
				else
					Result.put (item (j),i)
				end
				i := i + 1
			end
		end

	subarray_by_flags(a_flags : ARRAY[BOOLEAN]) : like Current is
		-- sub array by a valid flag array
		do
			create Result.make_empty
			if a_flags /= Void then
				from start until off loop
					if a_flags.valid_index (index) and then a_flags[index] then
						Result.extend(current_item)
					end
					forth
				end
			end
		end

--	random_subarray (a_count: INTEGER) : like Current is
--			-- a random subarray of size `a_count'
--			-- empty is `a_count' <= 0, the entire array is `a_count' >= `count'
--		local
--			l_needed, l_remaining, l_found, l_seed, i : INTEGER
--			l_date : ROSE_DATE
--			l_random : RANDOM
--			l_random_double : DOUBLE
--		do
--			if a_count <= 0 then
--				l_needed := 0
--			elseif a_count >= count then
--				l_needed := count
--			else
--				l_needed := a_count
--			end

--			if l_needed = 0 then
--				create Result.make_empty
--			else
--				l_remaining := count
--				l_found := 0
--				create Result.make(1,l_needed)
--				create l_random.make
--				create l_date.make_now
--				l_seed := l_date.second
--				l_random.set_seed (l_seed)
--				from i := 1 until i > count or l_needed = 0 loop
--					l_random.forth
--					l_random_double := l_random.double_item
--					if l_random_double <= l_needed/l_remaining then
--						-- add this to the array
--						l_found := l_found + 1
--						l_needed := l_needed - 1
--						Result[l_found] := item(i)
--					end
--					i := i + 1
--					l_remaining := l_remaining - 1
--				end
--			end
--		end

	valid_subarray(a_valid : FUNCTION[ANY, TUPLE[G], BOOLEAN]) : like Current is
		-- sub array by a agent
		local
			i : INTEGER
		do
			create Result.make_empty
			if a_valid /= Void then
				from i := lower until i > upper loop
					if a_valid.item([item(i)]) then
						Result.extend(item(i))
					end
					i := i + 1
				end
			end
		end

	valid_flags(a_valid : FUNCTION[ANY, TUPLE[G], BOOLEAN]) : ROSE_LINEAR_ARRAY[BOOLEAN] is
		-- valid data item flags
		local
			i : INTEGER
		do
			create Result.make(lower, upper)
			if a_valid /= Void then
				from i := lower until i > upper loop
					Result.put(a_valid.item([item(i)]), i)
					i := i + 1
				end
			else
				from i := lower until i > upper loop
					Result.put(True, i)
					i := i + 1
				end
			end
		end

	values_intersect (a_linear: LINEAR [G]): BOOLEAN is
			--do the elements of a_linear intersect our elements?
		do
			from a_linear.start until Result or else a_linear.off loop
				Result := has_value (a_linear.item)
				a_linear.forth
			end
		end

	references_intersect (a_linear: LINEAR [G]): BOOLEAN is
		do
			from a_linear.start until Result or else a_linear.off loop
				Result := has_reference (a_linear.item)
				a_linear.forth
			end
		end

	min_max (a_comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]): PAIR [G,G] is
		do
			if not is_empty then
				from
					start
					create Result.make (item (lower),item (lower))
				until
					off
				loop
					if a_comparison.item ([current_item,Result.first]) then
						Result.set_first (current_item)
					end
					if a_comparison.item ([Result.second,current_item]) then
						Result.set_second (current_item)
					end
					forth
				end
			end
		end

	equivalent_from_order (a_order: FUNCTION [ANY,TUPLE [G,G],BOOLEAN]; a_1: G; a_2: G): BOOLEAN is
			-- determine if two items are the same using just a less_than function
		do
			Result := (not a_order.item ([a_1, a_2])) and (not a_order.item ([a_2, a_1]))
		end

	quotient_with_less_than_function (a_order : FUNCTION [ANY,TUPLE [G,G],BOOLEAN]): ROSE_LINEAR_ARRAY [ROSE_LINEAR_ARRAY [G]] is
			-- create a quotient, just using less than function
		do
			Result := ordered_quotient (a_order, agent equivalent_from_order (a_order, ?, ?))
		end

	ordered_quotient (a_order : FUNCTION [ANY,TUPLE [G,G],BOOLEAN]; a_equivalent: FUNCTION [ANY,TUPLE [G,G],BOOLEAN]): ROSE_LINEAR_ARRAY [ROSE_LINEAR_ARRAY [G]] is
			-- create ordered quotient
		local
			l_array : ROSE_LINEAR_ARRAY [G]
		do
			create l_array.make_from_array (Current)
			l_array.sort_by (a_order)
			Result := l_array.quotient (a_equivalent)
		end

	quotient (a_equivalent: FUNCTION [ANY,TUPLE [G,G],BOOLEAN]): ROSE_LINEAR_ARRAY [ROSE_LINEAR_ARRAY [G]] is
			-- create quotient; assumes you have sorted the array
		local
			l_last: G
			l_array: ROSE_LINEAR_ARRAY [G]
		do
			create Result.make_empty
			from start until off loop
				if index = lower then
					create l_array.make_empty
					l_array.extend (current_item)
					Result.extend (l_array)
				else
					if a_equivalent.item ([current_item,l_last]) then
						l_array.extend (current_item)
					else
						create l_array.make_empty
						Result.extend (l_array)
						l_array.extend (current_item)
					end
				end
				l_last := current_item
				forth
			end
		end

	is_sorted: BOOLEAN is
			-- Is `Current' sorted?
		require
			comparison_not_void: comparison /= Void
		local
			i: INTEGER
			l_last_item, l_current_item: like item
		do
			Result := True
			if count > 1 then
				from
					i := lower + 1
					l_last_item := item (lower)
				until
					i > upper or not Result
				loop
					l_current_item := item (i)
					comparison.call ([l_last_item, l_current_item])
					Result := comparison.last_result
					l_last_item := l_current_item
					i := i + 1
				end
			end
		end

feature -- Basic operations

	subarray (a_start_pos, a_end_pos: INTEGER): like Current is
		require
			valid_start_pos: valid_index (a_start_pos)
			valid_end_pos: a_end_pos <= upper
			valid_bounds: (a_start_pos <= a_end_pos) or (a_start_pos = a_end_pos + 1)
		do
			create Result.make_from_array(array_subarray(a_start_pos, a_end_pos))
		ensure
			lower: Result.lower = 1
			upper: Result.count = a_end_pos - a_start_pos + 1
		end

	reversed: like Current is
			-- Reversed array from current (last swapped with first etc.)
		local
			i: INTEGER
		do
			create Result.make_empty
			from
				i := count
			until
				i < 1
			loop
				Result.extend (item (i))
				i := i - 1
			end
		end

	comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]

	sort_by (a_comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]) is
			-- Sort this array using 'a_comparison'.
		do
			comparison := a_comparison
			sort
			comparison := Void
		end

	sort_by_and_remember (a_routine: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]) is
			-- Sort this array using 'a_comparison', and remember 'a_comparison' for further searching
		require
			need_comparison: a_routine /= Void or comparison /= Void
		do
			if a_routine /= Void then
				comparison := a_routine
			end
			sort
		end

	set_comparison (a_comparison : like comparison) is
			-- Assign `a_comparison' to `comparison'.
		do
			comparison := a_comparison
		ensure
			comparison_set : comparison = a_comparison
		end

	binary_search (a_g: G) is
			-- binary search for item `a_g'
			-- current better be sorted ...
		do
			Precursor (a_g)
			index := found_index
		end

	linear_search (a_g: G) is
			-- linear search (look at every item) for item `a_g'
		do
			Precursor (a_g)
			index := found_index
		end

	concatenate (a_linear: LINEAR [G]) is
			-- Appends each element of 'a_linear' to the end of this array.
		do
			if a_linear /= Void then
				from a_linear.start until a_linear.off loop
					extend (a_linear.item)
					a_linear.forth
				end
			end
		end

	merge_values (a_linear: LINEAR [G]) is
		do
			from a_linear.start until a_linear.off loop
				if not has_value (a_linear.item) then
					extend (a_linear.item)
				end
				a_linear.forth
			end
		end

	merge_references (a_linear: LINEAR [G]) is
		do
			from a_linear.start until a_linear.off loop
				if not has_reference (a_linear.item) then
					extend (a_linear.item)
				end
				a_linear.forth
			end
		end

	union_values (a_linear: LINEAR [G]): like Current is
		do
			Result := twin
			Result.merge_values (a_linear)
		end

	union_references (a_linear: LINEAR [G]): like Current is
		do
			Result := twin
			Result.merge_references (a_linear)
		end

	union_values_is_equal (a_linear: LINEAR [G]): like Current is
		do
			Result := twin
			from a_linear.start until a_linear.off loop
				if not has(a_linear.item) then
					Result.extend(a_linear.item)
				end
				a_linear.forth
			end
		end

	intersection_values(a_linear: LINEAR [G]): like Current is
			-- Intersection of current and argument array values, uses is_equal
		do
			create Result.make_empty
			from a_linear.start until a_linear.off loop
				if has(a_linear.item) then
					Result.extend(a_linear.item)
				end
				a_linear.forth
			end
		end

	ordered_union_values (a_other: like Current; a_comparison: like comparison; a_distinct: BOOLEAN): like Current is
			-- Current and other must already been in the order specified by comparison
			-- Perform a full linear merge to get an ordered union of the two sets
		require
			a_other_not_void: a_other /= Void
		local
			i, j: INTEGER
		do
			if count = 0 then
				Result := a_other.twin
			elseif a_other.count = 0 then
				Result := twin
			else
				create Result.make_empty
				from i := lower; j := a_other.lower
				until i > upper and j > a_other.upper
				loop
					if j > a_other.upper or else (i <= upper and a_comparison.item ([item (i), a_other.item (j)])) then
						Result.extend (item (i))
						i := i + 1
					elseif i > upper or else a_comparison.item ([a_other.item (j), item (i)]) then
						Result.extend (a_other.item (j))
						j := j + 1
					else
						Result.extend (item (i))
						if not a_distinct then
							Result.extend (a_other.item (j))
						end
						i := i + 1
						j := j + 1
					end
				end
			end
		end

	selected_items(a_ixs : ARRAY[INTEGER]) : like Current is
		local
			i, l_ix : INTEGER
		do
			if a_ixs /= Void then
				create Result.make(1, a_ixs.count)
				from i := 1 until i > a_ixs.count loop
					l_ix := a_ixs.item(i)
					if valid_index(l_ix) then
						Result.put(item(l_ix), i)
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Comparison

	less_than (a, b: G): BOOLEAN is
		do
			if a /= Void and b /= Void then
				Result := comparison.item ([a,b])
			elseif a /= Void and b = Void then
				Result := True
			else
				Result := False
			end
		end

end -- class ROSE_LINEAR_ARRAY
