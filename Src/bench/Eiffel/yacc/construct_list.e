-- List used in abstract syntax trees.

class CONSTRUCT_LIST [T]

inherit

	AST_YACC
		undefine
			copy, setup, consistent, is_equal
		redefine
			pass_address
		end

	FIXED_LIST [T]

creation
	make, make_filled

feature

	pass_address (n: INTEGER) is
			-- Eiffel-yacc interface
		do
			c_get_address (n, $Current, $make_filled);
			c_get_list_area ($to_c);
		end;

	set is
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

feature {NONE} -- Externals

	c_get_list_area (ptr: POINTER) is
			-- Send `ptr' to Yacc
		external	
			"C"
		end;

end
