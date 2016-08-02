class
	TEST

create
	make

feature

	make
		local
			t1: TEST1 [STRING, ANY]
			t2: TEST1 [STRING, NATURAL_64]
			t3: TEST2 [NATURAL_64]
			a: PROCEDURE [STRING, STRING, NATURAL_64]
			i: NATURAL_64
			s: STRING
		do
				-- Create `s' and we will verify when calling `f' below that the argument given
				-- to the routine are equal to `s' which should always be true unless the GC moves
				-- `s' without updating all the references.
			s := "ABC"
			create t3.make (s)
			create t1.make (s)

			t2 := t3
			a := agent t2.f

			from
				i := 0
			until
				i > 1_000_000
			loop
					-- When calling this agent which is bound to a polymorphic feature `f' which causes the
					-- generated code to perform an allocation in the wrapper generated in E1\ececil.c.
					-- Unfortunately at one point, the generated code of the wrapper would generate RTLI(4)
					-- but only protect the first entry by calling RTLIU(1) when RTLIU(4) would have been
					-- expected.
				a (s, s, i)
				i := i + 1
			end
		end


end
