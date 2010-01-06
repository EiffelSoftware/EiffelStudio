indexing
	description	: "Sortable Array"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I_SORTABLE_ARRAY [G -> COMPARABLE]

inherit
	ARRAY [G]
		redefine
			subarray
		end

create
	make,
	make_from_array

feature -- Access

	found_index: INTEGER

	found: BOOLEAN

	binary_search (aa_item: G) is
		do
			(agent (a_item: G)
				local
					l_mid, l_lower, l_upper: INTEGER
				do
					
					found_index := upper + 1
					found := False
					if a_item < item (lower) or else item (upper) < a_item then
					elseif item (upper).is_equal (a_item) then
						found := True;
						found_index := upper
					elseif item (lower).is_equal (a_item) then
						found := True;
						found_index := lower
					else
						from
							l_lower := lower
							l_upper := upper
						until
							l_lower >= l_upper - 1 or found
						loop
							l_mid := (l_lower + l_upper) // 2
							found := a_item.is_equal (item (l_mid))
							if not found then
								if item (l_mid) < a_item then
									l_lower := l_mid
								else
									l_upper := l_mid
								end
							else
								found_index := l_mid
							end
						end
					end
				end (aa_item)).apply
		end

	balanced_linear_search (aa_item: G; aa_start: INTEGER) is
		do
			(agent (a_item: G; a_start: INTEGER)
				local
					l_lower, l_upper, l_start, l_examined: INTEGER
				do
					found := False
					if not valid_index (a_start) then
						l_start := lower
					else
						l_start := a_start
					end
					if a_item.is_equal (item (l_start)) then
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
							if item (l_lower).is_equal (a_item) then
								found_index := l_lower
								found := True
							elseif item (l_upper).is_equal (a_item) then
								found_index := l_upper;
								found := True
							end
							l_lower := l_lower - 1
							l_upper := l_upper + 1
							l_examined := l_examined + 2
						end
					end
				end (aa_item, aa_start)).apply
		end
				

	linear_search (aa_item: G) is
		do
			(agent (a_item: G) 
				do
					found := False
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
				end (aa_item)).apply
		end

feature -- Basic operations

	next_item_in_range (a_random_generator: RANDOM; a_a_min: INTEGER; a_a_max: INTEGER): INTEGER is
		do
			Result := (agent (random_generator: RANDOM; a_min: INTEGER; a_max: INTEGER): INTEGER
				local
					l_double: DOUBLE
				do
					random_generator.forth
					l_double := a_min + (a_max - a_min) * random_generator.double_item
					Result := l_double.rounded
				end).item ( [a_random_generator, a_a_min, a_a_max])
		end

	sort is
			-- Taken from algorithm provided in "Combinatorial Algorithms, Theory and Practice" by
--| Copyright (c) 1993-2006 University of Southern California and contributors.
			-- isbn 0-13-152447-X.
		do
			(agent 
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
						if ((j - 1) <= f) and (ell <= (j + 1)) then
							f := stack_1.item
							stack_1.remove
							ell := stack_2.item
							stack_2.remove
						elseif ((j - 1) <= f) and (ell > (j + 1)) then
							f := j + 1
						elseif ((j - 1) > f) and (ell <= (j + 1)) then
							ell := j - 1
						elseif ((j - 1) > f) and (ell > (j + 1)) then
							if (j - f) > (ell - j) then
								stack_1.put (f);
								stack_2.put (j - 1);
								f := j + 1
							else
								stack_1.put (j + 1);
								stack_2.put (ell);
								ell := j - 1
							end
						end
					end
				end).apply
		end

feature -- Duplication

	subarray (a_start_pos, a_end_pos: INTEGER): I_SORTABLE_ARRAY [G] is
			-- Array made of items of current array within
			-- bounds `start_pos' and `end_pos'.
		do
			Result := (agent (start_pos, end_pos: INTEGER): I_SORTABLE_ARRAY [G]
				do
					create Result.make (start_pos, end_pos)
					Result.subcopy (Current, start_pos, end_pos, start_pos)
				end).item ( [a_start_pos, a_end_pos])
		end

indexing
--| Copyright (c) 1993-2006 University of Southern California and contributors.
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
		
end

