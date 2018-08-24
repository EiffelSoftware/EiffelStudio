class
	A_TERMINATION

feature

	fibonacci (n: INTEGER): INTEGER
		require
			n >= 0
			decreases (n, 0, -n)
		do
			if n <= 1 then
				Result := n
			else
				Result := fibonacci (n - 1) + fibonacci (n - 2)
			end
		end

	fibonacci_bad (n: INTEGER): INTEGER
		require
			decreases (n)
		do
			Result := fibonacci_bad (n - 1) + fibonacci_bad (n - 2)
		end

	fibonacci_function (n: INTEGER): INTEGER
		note
			status: functional
		require
			n >= 0
		do
			Result := if n <= 1 then n else fibonacci_function (n - 1) + fibonacci_function (n - 2) end
		end

	fibonacci_function_bad (n: INTEGER): INTEGER
		note
			status: functional
		do
			Result := fibonacci_function_bad (n - 1) + fibonacci_function_bad (n - 2)
		end

	ref_recursive (r1, r2: ANY)
		note
			explicit: contracts, wrapping
		require
			r1 /= Void
		do
			if r2 /= Void then
				ref_recursive (r2, Void) -- OK: decreases r1, r2 by default
			end
		end

	ref_recursive_bad1 (r1, r2: ANY)
		note
			explicit: contracts, wrapping
		require
			r1 /= Void
		do
			if r2 /= Void then
				ref_recursive_bad1 (r2, r1) -- Bad
			end
		end

	ref_recursive_bad2 (r1, r2: ANY)
		note
			explicit: contracts, wrapping
		require
			r1 /= Void
			decreases (r1)
		do
			if r2 /= Void then
				ref_recursive_bad2 (r2, Void) -- Bad
			end
		end

	set_sum (s: MML_SET [INTEGER]): INTEGER
		local
			x: INTEGER
		do
			if s.is_empty then
				Result := 0
			else
				x := s.any_item
				Result := x + set_sum (s / x)
			end
		end

	set_sum_bad (s: MML_SET [INTEGER]): INTEGER
		local
			x: INTEGER
		do
			if not s.is_empty then
				x := s.any_item
			end
			Result := x + set_sum_bad (s / x)
		end

	sequence_sum (s: MML_SEQUENCE [INTEGER]): INTEGER
		do
			if s.is_empty then
				Result := 0
			else
				Result := s.first + sequence_sum (s.but_first)
			end
		end

	sequence_sum_bad (s: MML_SEQUENCE [INTEGER]): INTEGER
		do
			if s.is_empty then
				Result := 0
			else
				Result := s [1] + sequence_sum_bad (s)
			end
		end

	bag_sum (b: MML_BAG [INTEGER]): INTEGER
		local
			x: INTEGER
		do
			if b.is_empty then
				Result := 0
			else
				x := b.domain.any_item
				Result := x + bag_sum (b / x)
			end
		end

	bag_sum_bad (b: MML_BAG [INTEGER]): INTEGER
		do
			Result := bag_sum_bad (b)
		end

	no_args_bad
			-- This used to crash before
		note
			explicit: contracts, wrapping
		do
			no_args_bad -- Bad
		end

	no_termination_check
			-- Explicitly allow non-termination
		note
			explicit: contracts, wrapping
		require
			decreases ([])
		do
			no_termination_check -- OK
		end

end
