indexing
	description	: "Sortable Array"
	author		: "David Stevens, Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class 
	SORTABLE_ARRAY [G -> COMPARABLE]

inherit
	ARRAY [G]

create 
	make

feature -- Access

	found_index: INTEGER

	found: BOOLEAN

	binary_search (a_item: G) is
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
		end

	balanced_linear_search (a_item: G; a_start: INTEGER) is
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
		end

	linear_search (a_item: G) is
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
		end
	
feature -- Basic operations

	next_item_in_range (random_generator: RANDOM; a_min: INTEGER; a_max: INTEGER): INTEGER is
		local
			l_double: DOUBLE
		do
			random_generator.forth
			l_double := a_min + (a_max - a_min) * random_generator.double_item
			Result := l_double.rounded
		end

	sort is
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
		end
	
end -- class SORTABLE_ARRAY
