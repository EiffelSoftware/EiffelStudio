--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Specialists in prime numbers

indexing

	names: primes;
	date: "$Date$";
	revision: "$Revision$"

class PRIMES

feature -- Access

	next_prime (n: INTEGER): INTEGER is
			-- Lowest prime greater than or equal to `n'
		do
			if n <= 2 then
				Result := 2
			else
					-- `n' > 2
				from
					if n \\ 2 = 0 then
							-- make sure that `Result' is odd
						Result := n + 1
					else
						Result := n
					end
				until
					test_prime (Result)
				loop
					Result := Result + 2
				end
			end
		end;

	former_prime (n: INTEGER): INTEGER is
			-- Greatest prime lower than or equal to `n'
		require
			argument_big_enough: n >= 2
		do
			if n = 2 then
				Result := 2
			else
					-- `n' > 2
				from
					if n \\ 2 = 0 then
							-- make sure that `Result' is odd
						Result := n - 1
					else
						Result := n
					end
				until
					test_prime (Result)
				loop
					Result := Result - 2
				end
			end
		end;

	all_lower_primes (n: INTEGER): ARRAY [BOOLEAN] is
			-- All prime numbers less or equal to `n'
			-- using Eratosthenes' algorithm
		local
			i, j: INTEGER
		do
				-- All odd numbers are candidates
			from
				!!Result.make (1, n);
				i := 1
			until
				i > n
			loop
				Result.put (true, i);
				i := i + 2
			end;
				-- 2 is the lowest prime number
			if n >= 2 then
				Result.put (true, 2);
			end;
				-- Remove all multiples of primes
			from
				i := 3
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
						j := j + 2 * i
					end
				end;
				i := i + 2
			end
		end;

feature -- Comparison

	test_prime (n: INTEGER): BOOLEAN is
			-- Is `n' a prime number?
		require
			n_positive: n >= 0
		local
			to_test, divisor: INTEGER
		do
			if n <= 1 then
				Result := false
			elseif n = 2 then
				Result := true
			elseif n \\ 2 /= 0 then
				from
					divisor := 3
				until
					(n \\ divisor = 0) or else (divisor * divisor >= n)
				loop
					divisor := divisor + 2
				end;
				if divisor * divisor > n then
					Result := true
				end
			end
		end;

end -- class PRIMES
