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

	 Smallest_prime: INTEGER is 2;

         Smallest_odd_prime: INTEGER is 3;


	next_prime (n: INTEGER): INTEGER is
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
					test_prime (Result)
				loop
					Result := Result + Smallest_prime
				end
			end
		end;

	former_prime (n: INTEGER): INTEGER is
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
					test_prime (Result)
				loop
					Result := Result - Smallest_prime
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
				i := i + Smallest_prime
			end;
				-- Smallest_prime is the lowest prime number
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

	test_prime (n: INTEGER): BOOLEAN is
			-- Is `n' a prime number?
		require
			n_positive: n >= 0
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

end -- class PRIMES
