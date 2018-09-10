class LCP

feature

	lcp (a: ARRAY [INTEGER]; x, y: INTEGER): INTEGER
		note
			pure: True
		require
			a_not_empty: a.count >= 1
			x_in_range: 1 <= x and x <= a.count
			y_in_range: 1 <= y and y <= a.count
		do
			from
				Result := 0
			invariant
				Result >= 0
				x + Result <= a.count + 1
				y + Result <= a.count + 1
				across 0 |..| (Result-1) as i all a[x+i.item] = a[y+i.item] end
				(a[x] /= a[y]) implies (Result = 0)
			until
				x + Result = a.count + 1 or else
				y + Result = a.count + 1 or else
				a[x + Result] /= a[y + Result]
			loop
				Result := Result + 1
			variant
				a.count - Result + 1
			end
		ensure
			in_range0: Result >= 0
			in_range1: x + Result <= a.count + 1
			in_range2: y + Result <= a.count + 1
			is_prefix: across 0 |..| (Result-1) as i all a[x+i.item] = a[y+i.item] end
			longest_prefix: (x + Result = a.count + 1) or else (y + Result = a.count + 1) or else (a[x+Result] /= a[y+Result])

			trigger: (Result = 0) = (a[x] /= a[y]) -- necessary for proofs where result = 0
		end

	lcp_basic
		note
			framing: False
		local
			a: ARRAY [INTEGER]
			x: INTEGER
		do
			a := << 1 >>

			x := lcp (a, 1, 1)
			check x = 1 end

			a := << 1, 1 >>

			x := lcp (a, 1, 2)
			check x = 1 end
			x := lcp (a, 1, 1)
			check x = 2 end

			a := << 1, 2 >>

			x := lcp (a, 1, 2)
			check x = 0 end
			x := lcp (a, 1, 1)
			check x = 2 end

			a := << 1, 2, 2, 5 >>

			x := lcp (a, 1, 2)
			check x = 0 end

			a := << 1, 2, 3, 4, 1, 2, 3 >>

			x := lcp (a, 1, 3)
			check x = 0 end
			x := lcp (a, 1, 5)
			check x = 3 end
			x := lcp (a, 2, 6)
			check x = 2 end
		end

end
