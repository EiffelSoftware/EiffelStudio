indexing

	description:
		"Sets of integers with a finite number of elements";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FIXED_INTEGER_SET inherit

	BOOL_STRING
		rename
			make as boolean_set_make,
			put as bool_string_put,
			print as out_print
		export
			{NDFA} is_equal
		end

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Make set for at most n integers from 1 to n.
		require
			n_positive: n > 0
		do
			boolean_set_make (n);
			all_false
		ensure
			set_empty: empty
		end;

feature -- Access

	has (i: INTEGER): BOOLEAN is
			-- Is i in the set?
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			Result := item (i)
		end;

	empty: BOOLEAN is
			-- Is current set empty?
		do
			Result := bempty ($area, count) /= 0
		end;

	smallest: INTEGER is
			-- Smallest integer in set;
			-- count + 1 if set empty
		do
			Result := sma ($area, count)
		end;

	largest: INTEGER is
			-- Largest integer in set;
			-- 0 if empty
		do
			Result := lar ($area, count)
		end;

	next (p: INTEGER): INTEGER is
			-- Next integer in Current following p;
			-- count + 1 if p equals to largest.
		require
			p_in_set: p >= 1 and p <= count
		do
			Result := nex ($area, count, p)
		end;

feature -- Element change

	put (i: INTEGER) is
			-- Insert i in the set.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			bool_string_put (true, i)
		ensure
			is_in_set: has (i)
		end;

feature -- Removal

	remove (i: INTEGER) is
			-- Delete i from the set.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			bool_string_put (false, i)
		ensure
			is_not_in_set: not has (i)
		end;

feature -- Conversion

	to_c: ANY is
		do
			Result := area
		end;


feature -- Output

	print is
			-- List Current.
		local
			i: INTEGER;
		do
			io.set_error_default;
			io.putstring (" FIXED_INTEGER_SET: ");
			from
				i := 1
			until
				i > count
			loop
				if has (i) then
					io.putint (i);
					io.putstring (" ");
				end;
				i := i +1
			end;
			io.new_line
		end;

feature {NONE} -- Implementation

	nex (a1: like area; size, pos: INTEGER): INTEGER is
		external
			"C"
		end;

	lar (a1: like area; size: INTEGER): INTEGER is
		external
			"C"
		end;

	sma (a1: like area; size: INTEGER): INTEGER is
		external
			"C"
		end;

	bempty (a1: like area; size: INTEGER): INTEGER is
		external
			"C"
		end;

invariant

	positive_size: count > 0

end -- class FIXED_INTEGER_SET
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
