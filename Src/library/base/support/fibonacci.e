indexing

	description:
		"Fibonacci number properties";

	copyright: "See notice at end of class";
	names: fibonacci;
	date: "$Date$";
	revision: "$Revision$"

class FIBONACCI inherit

	COUNTABLE [INTEGER]
		rename
			has as is_fibonacci
		end

feature -- Access

	First : INTEGER is 1;

	Second : INTEGER is 1;

	higher_prime (n: INTEGER): INTEGER is
			-- Lowest fibonacci number greater than or equal to `n'
		do
			if n <= First then
				Result := First
			else
					-- `n' > First
				from
					Result := n
				until
					is_fibonacci (Result)
				loop
					Result := Result + 1
				end
			end
		end;

	lower_prime (n: INTEGER): INTEGER is
			-- Greatest fibonacci number lower than or equal to `n'
		require
			argument_big_enough: n >= Second
		do
			if n = Second then
				Result := Second
			else
					-- `n' > Second
				from
					Result := n - 1
				until
					is_fibonacci (Result)
				loop
					Result := Result - 1
				end
			end
		end;

	all_lower_primes (n: INTEGER): ARRAY [BOOLEAN] is
			-- Array of `n' boolean values, where the
			-- value at index `i' is true if and only if
			-- `i' is a fibonacci number.
		local
			i, j: INTEGER
		do
			from
				!! Result.make (1, n);
				j := 1
				i := item (j)
			until
				i > n
			loop
				Result.put (true, i);
				j := j + 1
				i := item (j)
			end;
		end;

	is_fibonacci (n: INTEGER): BOOLEAN is
			-- Is `n' a fibonacci number?
		local
			to_test, count : INTEGER
		do
			if n <= First then
				Result := false
			elseif n = First then
				Result := true
			else
				from
					count := First
					to_test := item (count)
				until
				   to_test >= n	
				loop
					count := count + 1
					to_test := item (count)
				end;
				Result := to_test = n
			end
		end;

	item (i: INTEGER): INTEGER is
			-- The `i'-th fibonacci number
		local
			count : INTEGER
			last, second_last : INTEGER
		do
			if i = 1 then
				Result := First
			elseif i = 2 then
				Result := Second
			else
				from
					last := Second	
					second_last := First
					count := 2
				until
					count = i
				loop
					Result := last + second_last
					second_last := last
					last := Result
					count := count + 1
				end
			end
		end;

feature {NONE} -- Inapplicable

	linear_representation: LINEAR [INTEGER] is
		do
		end;

end -- class FIBONACCI


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
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
