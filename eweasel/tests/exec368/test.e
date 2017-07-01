class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A
			b: B
			c: C
			t: TEST
			x: COMPARABLE
			y: INTEGER_REF
		do
			x := ""

				-- Empty array.
			report (<<>>, {ARRAY [attached NONE]}, 1)

				-- Simple test.
			report (<<Current>>, {ARRAY [TEST]}, 2)

				-- Non-conforming types.
			report (<<a, b>>, {ARRAY [detachable ANY]}, 3)
			report (<<b, a>>, {ARRAY [detachable ANY]}, 4)

				-- Incompatible types with a common maximal element.
			report (<<a, b, c>>, {ARRAY [detachable C]}, 5)
			report (<<a, c, b>>, {ARRAY [detachable C]}, 6)
			report (<<c, a, b>>, {ARRAY [detachable C]}, 7)

				-- Non-conforming integer constants.
			report (<<1, {NATURAL_8} 0>>, {ARRAY [ANY]}, 8)
			report (<<1, 0x1_0000_0000>>, {ARRAY [ANY]}, 9)

				-- Attached and detachable types.
			report (<<Current, Void>>, {ARRAY [detachable TEST]}, 10)
			report (<<Current, t>>, {ARRAY [detachable TEST]}, 11)
			report (<<Current, a>>, {ARRAY [detachable ANY]}, 12)

				-- Separate and non-separate types.
			report (<<create {A}, create {separate C}>>, {ARRAY [separate C]}, 13)
			report (<<Current, create {separate C}>>, {ARRAY [separate ANY]}, 14)

				-- Separate and detachable types.
			report (<<a, create {separate C}>>, {ARRAY [detachable separate C]}, 15)
			report (<<create {separate C}, Void>>, {ARRAY [detachable separate C]}, 16)
			report (<<t, create {separate C}>>, {ARRAY [detachable separate ANY]}, 17)

				-- Expanded and attached reference types.
			report (<<1, create {INTEGER_REF}>>, {ARRAY [INTEGER_REF]}, 18)
			report (<<1, x>>, {ARRAY [COMPARABLE]}, 19)

				-- Expanded and detachable reference types.
			report (<<1, y>>, {ARRAY [detachable INTEGER_REF]}, 20)
			report (<<1, Void>>, {ARRAY [detachable ANY]}, 21)

				-- Expanded and separate types.
			report (<<1, create {separate C}>>, {ARRAY [separate ANY]}, 22)
			report (<<1, x, create {separate STRING}.make_empty>>, {ARRAY [separate COMPARABLE]}, 23)

				-- Expanded and detachable separate types.
			report (<<1, a, create {separate C}>>, {ARRAY [detachable separate ANY]}, 24)
			report (<<1, y, create {separate STRING}.make_empty, x>>, {ARRAY [detachable separate COMPARABLE]}, 25)
		end

feature {NONE} -- Output

	report (a: ANY; t: TYPE [detachable separate ANY]; n: NATURAL_8)
			-- Compare type of object `a` with type `t` and report if they match in test number `n`.
		local
			actual: TYPE [detachable separate ANY]
			expected: TYPE [detachable separate ANY]
			r: REFLECTOR
		do
			create r
			expected := t
			actual := r.type_of_type (r.attached_type (a.generating_type.type_id))
			io.put_string ("Test #")
			io.put_natural_8 (n)
			if actual ~ expected then
				io.put_string (": OK")
			else
				io.put_string (": Failed - expected `")
				io.put_string (expected.name)
				io.put_string ("` [")
				io.put_integer (expected.type_id)
				io.put_string ("] but got `")
				io.put_string (actual.name)
				io.put_string ("`[")
				io.put_integer (actual.type_id)
				io.put_string ("].")
			end
			io.put_new_line
		end

end
