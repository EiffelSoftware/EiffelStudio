note
	description: "Sortable"
	author: "David Stevens"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SORTABLE [G]

feature -- Access

	found_index: INTEGER
	found: BOOLEAN

	count: INTEGER
		do
			Result := upper - lower + 1
		end

	lower, upper: INTEGER
			-- Lower and upper indices.
		deferred
		end

	valid_index (i: INTEGER): BOOLEAN
		do
			Result := lower <= i and i <= upper
		end

	--item (i: INTEGER): G is
	item alias "[]" (i: INTEGER): G
			-- Entry at index `i'.
		deferred
		end

	less_than (a, b: G): BOOLEAN
		deferred
		end

	greater_than (a, b: G): BOOLEAN
		do
			Result := not less_than (a, b) and not a.is_equal (b)
		end

feature -- Basic operations

	linear_search (a_item: G)
		do
			found := false
			from
				found_index := lower
			until
				found_index > upper or found
			loop
				found := item (found_index).is_equal (a_item)
				if not found then
					found_index := found_index + 1
				end
			end
		ensure
			really_found: found implies a_item.is_equal (item (found_index))
		end

	binary_search (a_item: G)
		local
			l_lower,l_upper: INTEGER
		do
			found_index := lower
			found := false
			if lower > upper then
				-- Do nothing
			elseif less_than (a_item,item (lower)) then
				found_index := lower
			elseif less_than (item (upper),a_item) then
				found_index := upper + 1
			elseif item (upper).is_equal (a_item) then
				found := True
				found_index := upper
			elseif item (lower).is_equal (a_item) then
				found := True
				found_index := lower
			else
				from
					l_lower := lower
					l_upper := upper
				until
					l_lower >= l_upper - 1 or found
				loop
					found_index := (l_lower + l_upper) // 2
					found := a_item.is_equal (item (found_index))
					if not found then
						if less_than (item (found_index),a_item) then
							l_lower := found_index
						else
							l_upper := found_index
						end
					end
				end
				--now set found_index to index where a_item should be inserted
				if not found and then less_than (item (found_index),a_item) then
					found_index := found_index + 1
				end
			end
		ensure
			really_found: found implies a_item.is_equal (item (found_index))
		end

	dynamic_binary_search (a_compare: FUNCTION [ANY,TUPLE [G],INTEGER])
		local
			l_lower,l_upper: INTEGER
		do
			found_index := lower
			found := False
			if lower > upper then
				-- Do nothing
			elseif a_compare.item ([item (lower)]) < 0 then
				found_index := lower
			elseif a_compare.item ([item (upper)]) > 0 then
				found_index := upper + 1
			elseif a_compare.item ([item (upper)]) = 0 then
				found := True
				found_index := upper
			elseif a_compare.item ([item (lower)]) = 0 then
				found := True
				found_index := lower
			else
				from
					l_lower := lower
					l_upper := upper
				until
					l_lower >= l_upper - 1 or found
				loop
					found_index := (l_lower + l_upper) // 2
					found := a_compare.item ([item (found_index)]) = 0
					if not found then
						if a_compare.item ([item (found_index)]) > 0 then
							l_lower := found_index
						else
							l_upper := found_index
						end
					end
				end
				--now set found_index to index where a_item should be inserted
				if not found and then a_compare.item ([item (found_index)]) > 0 then
					found_index := found_index + 1
				end
			end
		ensure
			really_found: found implies a_compare.item ([item (found_index)]) = 0
		end

	put (a_value: like item; i: INTEGER)
			-- Replace `i'-th entry.
		deferred
		end

	sort
			-- Taken from algorithm provided in "Combinatorial Algorithms, Theory and Practice" by
			-- Edward M. Reingold, Jurg Nievergelt, and Narsingh Deo; Prentice-Hall Copyright 1977, page 289.
			-- isbn 0-13-152447-X.
		local
			l_first_stack, l_last_stack: ARRAYED_STACK [INTEGER]
			l_first, l_last, i, j: INTEGER
			l_random: INTEGER
			l_random_generator: RANGED_RANDOM
		do
			-- This is an iterative (non-recursive) implementation of quicksort.
			--   l_first is 'first'.
			--   l_last is 'last'.
			--   l_first_stack is a stack of 'l_first's.
			--   l_last_stack is a stack of 'l_last's.
			--   These could have been implemented as STACK [PAIR [INTEGER, INTEGER]]
			-- Initialize.
			create l_random_generator.make
			create l_first_stack.make (0)
			create l_last_stack.make (0)
			l_first_stack.put (0)
			l_last_stack.put (0)
			l_last := upper
			-- Sort.
			from
				l_first := lower
			until
				l_first >= l_last
			loop
				-- Pick a random element and place it at the beginning of the current range.
				-- All of the other elements will be shuffled until you can say that there is
				-- a point where all elements to the left are lower than the first and all to
				-- the right are larger.  Then they move the first element to it's correct
				-- position.  All elements to the left (which are all smaller) are then sorted
				-- in the same way.  The same goes for the right.
				l_random := l_random_generator.next_item_in_range (l_first, l_last)
				if l_random /= l_first then
					internal_swap (l_first, l_random)
				end
				from i := l_first + 1 until i > l_last or not less_than (item (i), item (l_first)) loop i := i + 1 end
				from j := l_last until not less_than (item (l_first), item (j)) loop j := j - 1 end
				-- You may find that 'item' fails because 'j' is less than 'lower'.
				-- If j falls below 'lower' (or even 'l_first') then you have a bug in your
				-- 'less_than' routine.  It must be a bug because if j<l_first is True then
				-- you must have passed the point where 'j' and 'l_first' were the same and the
				-- loop didn't stop!  Therefore 'less_than (a, a)' was True and that is
				-- not supposed to happen.
				-- At this point, we know that all items from l_first+1 to i-1 are less than item (l_first) and
				-- all items from j+1 to l_last are greater than or equal.
				from
				until
					i >= j
				loop
					internal_swap (i, j)
					from i := i + 1 until not less_than (item (i), item (l_first)) loop i := i + 1 end
					from j := j - 1 until not less_than (item (l_first), item (j)) loop j := j - 1 end
				end
				if l_first /= j then
					internal_swap (l_first, j)
				end
				if ((j - 1) <= l_first) and (l_last <= (j + 1)) then
					-- both subtables are trivial
					l_first := l_first_stack.item
					l_first_stack.remove
					l_last := l_last_stack.item
					l_last_stack.remove
				elseif ((j - 1) <= l_first) and (l_last > (j + 1)) then
					-- only right subtable is nontrivial
					l_first := j + 1
				elseif ((j - 1) > l_first) and (l_last <= (j + 1)) then
					-- only left subtable is nontrivial
					l_last := j - 1
				elseif ((j - 1) > l_first) and (l_last > (j + 1)) then
					-- neither subtable is trivial; put larger one on S
					if (j - l_first) > (l_last - j) then
						-- left subtable is longer
						l_first_stack.put (l_first)
						l_last_stack.put (j - 1)
						l_first := j + 1
					else
						-- right subtable is longer
						l_first_stack.put (j + 1)
						l_last_stack.put (l_last)
						l_last := j - 1
					end
				end
			end
		end

feature {NONE} -- Implementation

	integer_valued_less (a_1, a_2: G): INTEGER
		do
			if less_than (a_1,a_2) then
				Result := -1
			elseif less_than (a_2,a_1) then
				Result := 1
			end
		end

	internal_swap (i, j: INTEGER)
		local
			l_temp_item: like item
		do
			l_temp_item := item (i)
			put (item (j), i)
			put (l_temp_item, j)
		end

end -- class SORTABLE
