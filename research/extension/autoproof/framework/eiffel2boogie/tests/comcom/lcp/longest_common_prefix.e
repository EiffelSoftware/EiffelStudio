-- Calculating the longest common prefix of two sequences.
-- (From the VSTTE FM2012 verification competition).

class
	LONGEST_COMMON_PREFIX

feature

	lcp (a: SIMPLE_ARRAY [INTEGER]; x, y: INTEGER): INTEGER
			-- Return the length of the logest common prefix of a [x..] and a [y..]
		note
			status: impure
		require
			x_in_range: 1 <= x and x <= a.count
			y_in_range: 1 <= y and y <= a.count
			modify ([])
		do
			from
				Result := 0
			invariant
				length_non_negative: Result >= 0
				end_in_range_1: x + Result <= a.count + 1
				end_in_range_2: y + Result <= a.count + 1
				is_common: across x |..| (x + Result - 1) as i all a [i.item] = a [y - x + i.item] end
				empty_prefix: a [x] /= a [y] implies Result = 0
			until
				x + Result = a.count + 1 or else
				y + Result = a.count + 1 or else
				a [x + Result] /= a [y + Result]
			loop
				Result := Result + 1
			variant
				a.count - Result + 1
			end
		ensure
			length_non_negative: Result >= 0
			end_in_range_1: x + Result <= a.count + 1
			end_in_range_2: y + Result <= a.count + 1
			is_common: across x |..| (x + Result - 1) as i all a [i.item] = a [y - x + i.item] end
			longest_prefix: (x + Result = a.count + 1) or else (y + Result = a.count + 1) or else (a [x + Result] /= a[y + Result])
			empty_prefix: a[x] /= a[y] implies Result = 0
		end

	test_lcp
			-- Test harness.
		note
			explicit: wrapping
		local
			a: SIMPLE_ARRAY [INTEGER]
			x: INTEGER
		do
			create a.init (<< 1 >>)

			x := lcp (a, 1, 1)
			check x = 1 end

			create a.init (<< 1, 1 >>)

			x := lcp (a, 1, 2)
			check x = 1 end
			x := lcp (a, 1, 1)
			check x = 2 end

			create a.init (<< 1, 2 >>)

			x := lcp (a, 1, 2)
			check x = 0 end
			x := lcp (a, 1, 1)
			check x = 2 end

			create a.init (<< 1, 2, 2, 5>>)

			x := lcp (a, 1, 2)
			check x = 0 end

			create a.init (<< 1, 2, 3, 4, 1, 2, 3>>)

			x := lcp (a, 1, 3)
			check x = 0 end
			x := lcp (a, 1, 5)
			check x = 3 end
			x := lcp (a, 2, 6)
			check x = 2 end
		end

end
