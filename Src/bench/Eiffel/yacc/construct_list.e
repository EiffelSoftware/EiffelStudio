-- List used in abstract syntax trees.

class CONSTRUCT_LIST [T]

inherit
	ARRAYED_LIST [T]

creation
	make, make_filled

feature

	initialize is
		do
			-- Do nothing
		end;

	locate_index_of (v: like item; n, start_position: INTEGER): INTEGER is
			-- Index of `n'-th occurrence of item identical to `v'.
			-- (According to the discrimination rule used by `search')
			-- 0 if none.
		require
			valid_occurence: n > 0
			valid_start_position: start_position > 0
		local
			a_occurrences: INTEGER
			i, nb: INTEGER
			l_area: SPECIAL [T]
		do
			from
				l_area := area
				i := start_position - 1
				nb := count
			until
				i = nb or else (a_occurrences = n)
			loop
				if equal (l_area.item (i), v) then
					a_occurrences := a_occurrences + 1;
				end;
				i := i + 1
			end;
			if a_occurrences = n then
				Result := i
			end
		end;

end
