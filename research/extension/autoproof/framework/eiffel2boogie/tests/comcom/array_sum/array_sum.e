-- Calculating the sum of array elements.
-- This example demonstrates logic functions, recursion and sequences.

class
	ARRAY_SUM

feature

	seq_sum (s: MML_SEQUENCE [INTEGER]): INTEGER
			-- Sum of elements in `s'.
			-- (MML_SEQUENCE is a logic class: its objects are mathematical values
			-- and its operations are defined in a Boogie theory).
		note
			status: functional -- This is a logic function (its body acts as a postcondition)
		do
			Result := if s.is_empty then 0 else s.last + seq_sum (s.but_last) end
			-- Try replacing the body with one of the following to test well-formedness checking
--			Result := s.last + seq_sum (s.but_last)
--			Result := if s.is_empty then 0 else s.last + seq_sum (s) end
		end

	array_sum (a: SIMPLE_ARRAY [INTEGER]): INTEGER
			-- Calculate sum of elements in array `a'.
		note
			status: impure -- We do not intend to use this function in contracts
		require
			modify ([]) -- But it doesn't modify existing objects
		local
			i: INTEGER
		do
			from
				i := 1
			invariant
				in_bounds: 1 <= i and i <= a.count + 1
				is_partial_sum: Result = seq_sum (a.sequence.front (i - 1))
			until
				i > a.count
			loop
				check a.sequence.front (i).but_last = a.sequence.front (i - 1) end
				Result := Result + a[i]
				i := i + 1
			end
		ensure
			is_sum: Result = seq_sum (a.sequence)
		end


end
