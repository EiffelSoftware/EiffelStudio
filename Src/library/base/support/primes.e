indexing

	description:
		"Prime number properties";

	copyright: "See notice at end of class";
	names: primes;
	date: "$Date$";
	revision: "$Revision$"

class PRIMES inherit

	COUNTABLE [INTEGER]
		rename
			has as is_prime
		end

feature -- Access

	Smallest_prime: INTEGER is 2;

	Smallest_odd_prime: INTEGER is 3;


	higher_prime (n: INTEGER): INTEGER is
			-- Lowest prime greater than or equal to `n'
		do
			if n <= Smallest_prime then
				Result := Smallest_prime
			else
					-- `n' > Smallest_prime
				from
					if n \\ Smallest_prime = 0 then
							-- make sure that `Result' is odd
						Result := n + 1
					else
						Result := n
					end
				until
					is_prime (Result)
				loop
					Result := Result + Smallest_prime
				end
			end
		end;

	lower_prime (n: INTEGER): INTEGER is
			-- Greatest prime lower than or equal to `n'
		require
			argument_big_enough: n >= Smallest_prime
		do
			if n = Smallest_prime then
				Result := Smallest_prime
			else
					-- `n' > Smallest_prime
				from
					if n \\ Smallest_prime = 0 then
							-- make sure that `Result' is odd
						Result := n - 1
					else
						Result := n
					end
				until
					is_prime (Result)
				loop
					Result := Result - Smallest_prime
				end
			end
		end;

	all_lower_primes (n: INTEGER): ARRAY [BOOLEAN] is
			-- Array of `n' boolean values, where the
			-- value at index `i' is true if and only if
			-- `i' is prime.
		local
			i, j: INTEGER
		do
				-- All odd numbers except 1 are candidates
			from
				!! Result.make (1, n);
				i := 3
			until
				i > n
			loop
				Result.put (true, i);
				i := i + Smallest_prime
			end;
				-- `Smallest_prime' is the lowest prime number
			if n >= Smallest_prime then
				Result.put (true, Smallest_prime);
			end;
				-- Remove all multiples of primes
			from
				i := Smallest_odd_prime
			until
				i * i > n
			loop
				if Result.item (i) then
					from
						j := i * i
					until
						j > n
					loop
						Result.put (false, j);
						j := j + Smallest_prime * i
					end
				end;
				i := i + Smallest_prime
			end
		end;

	is_prime (n: INTEGER): BOOLEAN is
			-- Is `n' a prime number?
		local
			to_test, divisor: INTEGER
		do
			if n <= 1 then
				Result := false
			elseif n = Smallest_prime then
				Result := true
			elseif n \\ Smallest_prime /= 0 then
				from
					divisor := Smallest_odd_prime
				until
					(n \\ divisor = 0) or else (divisor * divisor >= n)
				loop
					divisor := divisor + Smallest_prime
				end;
				if divisor * divisor > n then
					Result := true
				end
			end
		end;

	item (i: INTEGER): INTEGER is
			-- The `i'-th prime number
		local
			candidates: ARRAY [BOOLEAN];
			found: INTEGER
		do
			candidates := all_lower_primes (i * i);
			from
				Result := 2; found := 1
			invariant
				-- Between 1 and `Result' there are `found' primes.
			variant
				i * i - Result
			until
				found = i
			loop
				Result := Result + 1;
				if candidates.item (Result) then
					found := found + 1
				end
			end
		end;

feature -- Inapplicable

	linear_representation: LINEAR [INTEGER] is
		do
		end;

feature -- Obsolete
		
	next_prime (n: INTEGER): INTEGER is
			obsolete "Use `higher_prime' instead"
		do
			Result := higher_prime (n)
		end;

	former_prime (n: INTEGER): INTEGER is
			obsolete "Use `lower_prime' instead"
		do
			Result := lower_prime (n)
		end;

	test_prime (n: INTEGER): BOOLEAN is
			obsolete "Use `is_prime' instead"
		do
			Result := is_prime (n)
		end;

end -- class PRIMES


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
