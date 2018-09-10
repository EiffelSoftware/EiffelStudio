-- Calculating the sum and the maximum of array elements.
-- (From the VSTTE 2010 verification competition).

class SUM_AND_MAX

feature

	sum_and_max (a: SIMPLE_ARRAY [INTEGER]): TUPLE [sum: INTEGER; max: INTEGER]
			-- Calculate sum and maximum of array `a'.
		note
			status: impure -- We do not intend to use this function in contracts
		require
			modify ([]) -- But it doesn't modify existing objects
		local
			i: INTEGER
			sum, max: INTEGER
		do
			from
				i := 0
			invariant
				i1: 0 <= i and i <= a.count
				i2: sum <= i * max
			until
				i >= a.count
			loop
				sum := sum + a [i + 1]
				if a [i + 1] > max then
					max := a [i + 1]
				end
				i := i + 1 -- Try commenting this out
			end
			Result := [sum, max]
		ensure
			sum_in_range: Result.sum <= a.count * Result.max
		end
end
