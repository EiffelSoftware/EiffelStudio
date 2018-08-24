class
	VSTTE2010

feature -- VSTTE 2010: Sum & max

	sum_and_max (a: SIMPLE_ARRAY [INTEGER]): TUPLE [sum, max: INTEGER]
			-- Calculate sum and maximum of array `a'.
		note
			framing: False
		require
			a_not_void: a /= Void
			a_not_empty: a.count > 0
			a_non_negative: across a as ai all ai.item >= 0 end
		local
			i: INTEGER
			sum, max: INTEGER
		do
			from
				i := 0
			invariant
				0 <= i and i <= a.count
				sum <= i * max
			until
				i >= a.count
			loop
				sum := sum + a [i + 1]
				if a [i + 1] > max then
					max := a [i + 1]
				end
				i := i + 1
			variant
				a.count - i
			end

			Result := [sum, max]
		ensure
			sum_in_range: Result.sum <= a.count * Result.max
		end

end
