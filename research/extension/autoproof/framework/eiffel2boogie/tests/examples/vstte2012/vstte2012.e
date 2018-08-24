class VSTTE2012

feature -- VSTTE2012: two way sort

	two_way_sort (a: SIMPLE_ARRAY [BOOLEAN]): INTEGER
			-- Sort bollean array `a' in linear time.
			-- Returns number of False elements in array.
		note
			status: impure
		require
			a.count >= 0

			modify (a)
		local
			i, j: INTEGER
		do
			from
				i := 0
				j := a.count
			invariant
				aa: a.is_wrapped
				a: i >= 0 and i <= j and j <= a.count
				d: across 1 |..| i as ai all a.sequence[ai.item] = False end
				e: across (j+1) |..| a.count as ai all a.sequence[ai.item] = True end
				f: a.sequence.to_bag ~ a.sequence.old_.to_bag
			until
				i = j
			loop
				if a[i+1] = False then
					i := i + 1
				elseif a[j] = True then
					j := j - 1
				else
					i := i + 1
					a[i] := False
					a[j] := True
					j := j - 1
				end
			variant
				j - i
			end
			Result := i
		ensure
			false_first: across 1 |..| Result as ai all a.sequence[ai.item] = False end
			true_last: across (Result+1) |..| a.count as ai all a.sequence[ai.item] = True end
			is_permutation: a.sequence.to_bag ~ old a.sequence.to_bag
		end

feature -- VSTTE2012: Ring Buffer

	ring_buffer_client
			-- Using composites.
		local
			rb: RING_BUFFER
		do
			create rb.make (2)
			rb.extend (3)
			rb.extend (7)
			check rb.item = 3 end
			rb.remove
			rb.extend (11)
			check rb.item = 7 end
			rb.remove
			check rb.item = 11 end
			rb.remove
		end

end
