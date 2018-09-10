note
	description: "Sortable Array"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SORTABLE_ARRAY [G -> COMPARABLE]

inherit
	ARRAY [G]
		redefine
			subarray
		end

create
	make_empty,
	make,
	make_filled,
	make_from_array

feature -- Access

	found_index: INTEGER
			-- Found index.

	found: BOOLEAN
			-- Found.

	binary_search (a_item: G)
		local
			l_mid, l_lower, l_upper: INTEGER
			l_item_lower, l_item_upper: G
		do
			found_index := upper + 1
			found := False
			if a_item /= Void and then lower <= upper then
				l_item_lower := item (lower)
				l_item_upper := item (upper)
				if l_item_lower = Void or else l_item_upper = Void or else a_item < l_item_lower or else l_item_upper < a_item then
				elseif l_item_upper ~ a_item then
					found := True
					found_index := upper
				elseif l_item_lower ~ a_item then
					found := True
					found_index := lower
				else
					from
						l_lower := lower
						l_upper := upper
					until
						l_lower >= l_upper - 1 or found
					loop
						l_mid := (l_lower + l_upper) // 2
						found := a_item ~ item (l_mid)
						if found then
							found_index := l_mid
						elseif item (l_mid) < a_item then
							l_lower := l_mid
						else
							l_upper := l_mid
						end
					end
				end
			end
		end

	balanced_linear_search (a_item: G; a_start: INTEGER)
			-- Balanced linear search.
		local
			l_lower, l_upper, l_start, l_examined: INTEGER
		do
			found := False
			if valid_index (a_start) then
				l_start := a_start
			else
				l_start := lower
			end
			if l_start <= upper then
				if a_item ~ item (l_start) then
					found := True
					found_index := l_start
				else
					from
						l_lower := l_start - 1
						l_upper := l_start + 1
						l_examined := 1
					until
						found or l_examined >= count
					loop
						if l_lower < lower then
							l_lower := upper
						end
						if l_upper > upper then
							l_upper := lower
						end

						if item (lower) ~ a_item then
							found_index := l_lower
							found := True
						elseif item (upper) ~ a_item then
							found_index := l_upper
							found := True
						end
						l_lower := l_lower - 1
						l_upper := l_upper + 1
						l_examined := l_examined + 2
					end
				end
			end
		end

	linear_search (a_item: G)
			-- Linear search.
		do
			found := False
			from
				found_index := lower
			until
				found_index > upper or found
			loop
				found := item (found_index) ~ a_item
				if not found then
					found_index := found_index + 1
				end
			end
		end

feature -- Basic operations

	next_item_in_range (random_generator: RANDOM; a_min: INTEGER; a_max: INTEGER): INTEGER
		do
			random_generator.forth
			Result := (a_min + (a_max - a_min) * random_generator.double_item).rounded
		end

	sort
			-- Taken from algorithm provided in "Combinatorial Algorithms, Theory and Practice" by
			-- Edward M. Reingold, Jurg Nievergelt, and Narsingh Deo; Prentice-Hall Copyright 1977, page 289.
			-- isbn 0-13-152447-X.
		local
			stack_1: ARRAYED_STACK [INTEGER]
			stack_2: ARRAYED_STACK [INTEGER]
			f, i, j: INTEGER
			ell: INTEGER
			l_random: INTEGER
			l_temp_item: like item
			l_random_generator: RANDOM
		do
			create l_random_generator.make
			create stack_1.make (0)
			create stack_2.make (0)
			stack_1.put (0)
			stack_2.put (0)
			ell := upper
			from
				f := lower
			until
				f >= ell
			loop
				l_random := next_item_in_range (l_random_generator, f, ell)
				if l_random /= f then
					l_temp_item := item (f)
					put (item (l_random), f)
					put (l_temp_item, l_random)
				end
				from
					i := f + 1
				until
					i > upper or not (item (i) < item (f))
				loop
					i := i + 1
				end
				from
					j := ell
				until
					not (item (f) < item (j))
				loop
					j := j - 1
				end
				from
				until
					i >= j
				loop
					l_temp_item := item (i)
					put (item (j), i)
					put (l_temp_item, j)
					from
						i := i + 1
					until
						not (item (i) < item (f))
					loop
						i := i + 1
					end
					from
						j := j - 1
					until
						not (item (f) < item (j))
					loop
						j := j - 1
					end
				end
				if f /= j then
					l_temp_item := item (f)
					put (item (j), f)
					put (l_temp_item, j)
				end
				if j - 1 <= f and ell <= j + 1 then
					f := stack_1.item
					stack_1.remove
					ell := stack_2.item
					stack_2.remove
				elseif j - 1 <= f and ell > j + 1 then
					f := j + 1
				elseif j - 1 > f and ell <= j + 1 then
					ell := j - 1
				elseif j - 1 > f and ell > j + 1 then
					if j - f > ell - j then
						stack_1.put (f)
						stack_2.put (j - 1)
						f := j + 1
					else
						stack_1.put (j + 1)
						stack_2.put (ell)
						ell := j - 1
					end
				end
			end
		end

feature -- Duplication

	subarray (start_pos, end_pos: INTEGER): SORTABLE_ARRAY [G]
			-- Array made of items of current array within
			-- bounds `start_pos' and `end_pos'.
		do
			if start_pos <= end_pos then
				create Result.make_filled (item (start_pos), start_pos, end_pos)
					-- Only copy elements if needed.
				Result.subcopy (Current, start_pos, end_pos, start_pos)
			else
					-- make empty
				create Result.make_empty
				Result.rebase (start_pos)
			end
		end

note
	ca_ignore: "CA057", "CA057: comparison operator with negation can be simplified"
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
