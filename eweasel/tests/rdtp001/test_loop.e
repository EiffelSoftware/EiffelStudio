indexing
	description: "Test for various loop flavours."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_LOOP

feature

	make is
		local
			a: ARRAY [INTEGER]
			i: INTEGER
			b: BOOLEAN
		do
			a := <<1, 2, 3, 4, 5>>
			b := True
				-- Loop_body without iteration
				-- All clauses
			from
				i := 5
			invariant
				b
			until
				i = 3
			loop
				i := i - 1
			variant
				i
			end
				-- No Invariant
			from
				i := 5
			until
				i = 3
			loop
				i := i - 1
			variant
				i
			end
				-- No variant
			from
				i := 5
			invariant
				b
			until
				i = 3
			loop
				i := i - 1
			end
				-- No Invariant, Variant
			from
				i := 5
			until
				i = 3
			loop
				i := i - 1
			end
				-- Loop_body with iteration
				-- All clauses
			across
				a as c
			from
				i := 5
			invariant
				c /= Void
			until
				i = 3
			loop
				i := i - 1
			variant
				i
			end
				-- No Initialization
			across
				a as c
			invariant
				c /= Void
			until
				i = 3
			loop
				i := i - 1
			variant
				i
			end
				-- No Invariant
			across
				a as c
			from
				i := 5
			until
				i = 3
			loop
				i := i - 1
			variant
				i
			end
				-- No Exit_condition
			across
				a as c
			from
				i := 5
			invariant
				c /= Void
			loop
				i := i - 1
			variant
				i
			end
				-- No variant
			across
				a as c
			from
				i := 5
			invariant
				c /= Void
			until
				i = 3
			loop
				i := i - 1
			end
				-- No Initialization, Invariant
			across
				a as c
			until
				i = 3
			loop
				i := i - 1
			variant
				i
			end
				-- No Initialization, Exit_condition
			across
				a as c
			invariant
				c /= Void
			loop
				i := i - 1
			variant
				i
			end
				-- No Initialization, Variant
			across
				a as c
			invariant
				c /= Void
			until
				i = 3
			loop
				i := i - 1
			end
				-- No Invariant, Exit_condition
			across
				a as c
			from
				i := 5
			loop
				i := i - 1
			variant
				i
			end
				-- No Invariant, Variant
			across
				a as c
			from
				i := 5
			until
				i = 3
			loop
				i := i - 1
			end
				-- No Exit_condition, Variant
			across
				a as c
			from
				i := 5
			invariant
				c /= Void
			loop
				i := i - 1
			end
				-- No Initialization, Invariant, Exit_condition
			across
				a as c
			loop
				i := i - 1
			variant
				i
			end
				-- No Initialization, Invariant, Variant
			across
				a as c
			until
				i = 3
			loop
				i := i - 1
			end
				-- No Initialization, Exit_condition, Variant
			across
				a as c
			invariant
				c /= Void
			loop
				i := i - 1
			end
				-- No Invariant, Exit_condition, Variant
			across
				a as c
			from
				i := 5
			loop
				i := i - 1
			end
				-- No Initialization, Invariant, Exit_condition, Variant
			across
				a as c
			loop
				i := i - 1
			end
				-- All_body
				-- All clauses
			b := across
				a as c
			invariant
				c /= Void
			until
				i = 3
			all
				c.item = 3
			variant
				i
			end
				-- No Invariant
			b := across
				a as c
			until
				i = 3
			all
				c.item = 3
			variant
				i
			end
				-- No Exit_condition
			b := across
				a as c
			invariant
				c /= Void
			all
				c.item = 3
			variant
				i
			end
				-- No variant
			b := across
				a as c
			invariant
				c /= Void
			until
				i = 3
			all
				c.item = 3
			end
				-- No Invariant, Exit_condition
			b := across
				a as c
			from
				i := 5
			all
				c.item = 3
			variant
				i
			end
				-- No Invariant, Variant
			b := across
				a as c
			from
				i := 5
			until
				i = 3
			all
				c.item = 3
			end
				-- No Exit_condition, Variant
			b := across
				a as c
			from
				i := 5
			invariant
				c /= Void
			all
				c.item = 3
			end
				-- No Invariant, Exit_condition, Variant
			b := across
				a as c
			all
				c.item = 3
			end
				-- Some_body
				-- All clauses
			b := across
				a as c
			invariant
				c /= Void
			until
				i = 3
			some
				c.item = 3
			variant
				i
			end
				-- No Invariant
			b := across
				a as c
			until
				i = 3
			some
				c.item = 3
			variant
				i
			end
				-- No Exit_condition
			b := across
				a as c
			invariant
				c /= Void
			some
				c.item = 3
			variant
				i
			end
				-- No variant
			b := across
				a as c
			invariant
				c /= Void
			until
				i = 3
			some
				c.item = 3
			end
				-- No Invariant, Exit_condition
			b := across
				a as c
			from
				i := 5
			some
				c.item = 3
			variant
				i
			end
				-- No Invariant, Variant
			b := across
				a as c
			from
				i := 5
			until
				i = 3
			some
				c.item = 3
			end
				-- No Exit_condition, Variant
			b := across
				a as c
			from
				i := 5
			invariant
				c /= Void
			some
				c.item = 3
			end
				-- No Invariant, Exit_condition, Variant
			b := across
				a as c
			some
				c.item = 3
			end
		end

end
