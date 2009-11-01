class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Execute test.
		local
			items: ARRAY [INTEGER]
			i, j: INTEGER
		do
			items := <<1, 2, 3>>

				-- Simple iteration (empty)
			across
				items as l_cursor
			loop
			end

				-- Extra initialization (empty)
			across
				items as l_cursor
			from
			loop
				i := i + 1
			end

				-- Extra initialization
			across
				items as l_cursor
			from
				i := 1
			loop
				i := i + 1
			end

				-- Extra condition
			across
				items as l_cursor
			until
				i > 2
			loop
				i := i + 1
			end

				-- Extra initialization and condition
			across
				items as l_cursor
			from
				i := 1
			until
				i > 2
			loop
				i := i + 1
			end

				-- Simple iteration (invariant)
			across
				items as l_cursor
			invariant
				j = 0
			loop
			end

				-- Extra initialization (invariant)
			across
				items as l_cursor
			from
				i := 1
			invariant
				j = 0
			loop
				i := i + 1
			end

				-- Extra condition (invariant)
			across
				items as l_cursor
			invariant
				j = 0
			until
				i > 2
			loop
				i := i + 1
			end

				-- Extra initialization and condition (invariant)
			across
				items as l_cursor
			from
				i := 1
			invariant
				j = 0
			until
				i > 2
			loop
				i := i + 1
			end

				-- Simple iteration (invariant, variant)
			i := 1
			across
				items as l_cursor
			invariant
				j = 0
			loop
				i := i + 1
			variant
				items.count - i + 1
			end

				-- Extra initialization (invariant, variant)
			across
				items as l_cursor
			from
				i := 1
			invariant
				j = 0
			loop
				i := i + 1
			variant
				items.count - i + 1
			end

				-- Extra condition (invariant, variant)
			i := 1
			across
				items as l_cursor
			invariant
				j = 0
			until
				i > 2
			loop
				i := i + 1
			variant
				items.count - i + 1
			end

				-- Extra initialization and condition (invariant, variant)
			across
				items as l_cursor
			from
				i := 1
			invariant
				j = 0
			until
				i > 2
			loop
				i := i + 1
			variant
				items.count - i + 1
			end

		end

end
