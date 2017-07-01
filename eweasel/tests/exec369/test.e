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

				-- Simple test.
			report (<<if q then Current else Current end>>, {ARRAY [TEST]}, 2)

				-- Non-conforming types.
			report (<<if q then a else b end>>, {ARRAY [detachable ANY]}, 3)
			report (<<if q then b else a end>>, {ARRAY [detachable ANY]}, 4)

				-- Incompatible types with a common maximal element.
			report (<<if q then a elseif q1 then b else c end>>, {ARRAY [detachable C]}, 5)
			report (<<if q then a elseif q1 then c else b end>>, {ARRAY [detachable C]}, 6)
			report (<<if q then c elseif q1 then a else b end>>, {ARRAY [detachable C]}, 7)

				-- Non-conforming integer constants.
			report (<<if q then 1 else {NATURAL_8} 0 end>>, {ARRAY [ANY]}, 8)
			report (<<if q then 1 else 0x1_0000_0000 end>>, {ARRAY [ANY]}, 9)

				-- Attached and detachable types.
			report (<<if q then Current else Void end>>, {ARRAY [detachable TEST]}, 10)
			report (<<if q then Current else t end>>, {ARRAY [detachable TEST]}, 11)
			report (<<if q then Current else a end>>, {ARRAY [detachable ANY]}, 12)

				-- Separate and non-separate types.
			report (<<if q then create {A} else create {separate C} end>>, {ARRAY [separate C]}, 13)
			report (<<if q then Current else create {separate C} end>>, {ARRAY [separate ANY]}, 14)

				-- Separate and detachable types.
			report (<<if q then a else create {separate C} end>>, {ARRAY [detachable separate C]}, 15)
			report (<<if q then create {separate C} else Void end>>, {ARRAY [detachable separate C]}, 16)
			report (<<if q then t else create {separate C} end>>, {ARRAY [detachable separate ANY]}, 17)

				-- Expanded and attached reference types.
			report (<<if q then 1 else create {INTEGER_REF} end>>, {ARRAY [INTEGER_REF]}, 18)
			report (<<if q then 1 else x end>>, {ARRAY [COMPARABLE]}, 19)

				-- Expanded and detachable reference types.
			report (<<if q then 1 else y end>>, {ARRAY [detachable INTEGER_REF]}, 20)
			report (<<if q then 1 else Void end>>, {ARRAY [detachable ANY]}, 21)

				-- Expanded and separate types.
			report (<<if q then 1 else create {separate C} end>>, {ARRAY [separate ANY]}, 22)
			report (<<if q then 1 elseif q1 then x else create {separate STRING}.make_empty end>>, {ARRAY [separate COMPARABLE]}, 23)

				-- Expanded and detachable separate types.
			report (<<if q then 1 elseif q1 then a else create {separate C} end>>, {ARRAY [detachable separate ANY]}, 24)
			report (<<if q then 1 elseif q1 then y elseif q2 then create {separate STRING}.make_empty else x end>>, {ARRAY [detachable separate COMPARABLE]}, 25)
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

feature {NONE} -- Status report

	q, q1, q2: BOOLEAN
			-- A random boolean value.
		do
		end

end
