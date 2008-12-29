note

	description:
		"Sets of integers with a finite number of items"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class FIXED_INTEGER_SET inherit

	BOOL_STRING
		rename
			make as boolean_set_make,
			put as bool_string_put,
			print as out_print
		export
			{FIXED_INTEGER_SET, NDFA} is_equal
		end

create
	make
	
create {FIXED_INTEGER_SET}
	boolean_set_make

feature -- Initialization

	make (n: INTEGER)
			-- Make set for at most `n' integers from 1 to `n'.
		require
			n_positive: n > 0
		do
			boolean_set_make (n);
		ensure
			set_empty: is_empty
		end;

feature -- Access

	has (i: INTEGER): BOOLEAN
			-- Is `i' in set?
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			Result := item (i)
		end;

	is_empty: BOOLEAN
			-- Is current set empty?
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := count
				Result := True
			until
				not Result or i > nb
			loop
				Result := not item (i);
				i := i + 1
			end
		end

	smallest: INTEGER
			-- Smallest integer in set;
			-- `count' + 1 if set empty
		local
			nb: INTEGER;
			found: BOOLEAN
		do
			from
				Result := 1
				nb := count
			until
				found or Result > nb
			loop
				if item (Result) then
					found := True
				else
					Result := Result + 1
				end
			end	
		end

	largest: INTEGER
			-- Largest integer in set;
			-- 0 if set empty
		local
			found: BOOLEAN
		do
			from
				Result := count
			until
				found or Result < 1
			loop
				if item (Result) then
					found := True
				else
					Result := Result - 1
				end
			end
		end

	next (p: INTEGER): INTEGER
			-- Next integer in set following `p';
			-- `count' + 1 if `p' equals `largest'
		require
			p_in_set: p >= 1 and p <= count
		local
			nb: INTEGER
			found: BOOLEAN
		do
			from
				Result := p + 1;
				nb := count
			until
				found or Result > nb
			loop
				if item (Result) then
					found := True
				else
					Result := Result + 1
				end
			end
		end

feature -- Element change

	put (i: INTEGER)
			-- Insert `i' into set.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			bool_string_put (True, i)
		ensure
			is_in_set: has (i)
		end;

feature -- Removal

	remove (i: INTEGER)
			-- Delete `i' from set.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			bool_string_put (False, i)
		ensure
			is_not_in_set: not has (i)
		end;

feature -- Conversion

	to_c: ANY
		do
			Result := area
		end;


feature -- Output

	print
			-- List all items in set.
		local
			i: INTEGER;
		do
			io.set_error_default;
			io.put_string (" FIXED_INTEGER_SET: ");
			from
				i := 1
			until
				i > count
			loop
				if has (i) then
					io.put_integer (i);
					io.put_string (" ");
				end;
				i := i +1
			end;
			io.new_line
		end;

invariant

	positive_size: count > 0

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FIXED_INTEGER_SET

