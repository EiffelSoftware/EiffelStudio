indexing

	description:

		"Test features of class DOUBLE"

	library: "FreeELKS Library"
	copyright: "Copyright (c) 2006-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class TEST_DOUBLE

inherit

	TS_TEST_CASE

	KL_SHARED_EIFFEL_COMPILER

create

	make_default

feature -- Test

	test_default_create is
			-- Test feature 'default_create'.
		local
			r: DOUBLE
		do
			assert ("default", r = 0.0)
		end

	test_is_less is
			-- Test feature 'is_less alias "<"'.
		local
			r1, r2: DOUBLE
		do
			r1 := 1.5
			r2 := 2.7
			assert ("less_than1", r1 < r2)
			r1 := 10.9
			r2 := 8.2
			assert ("not_less_than1", not (r1 < r2))
			r1 := 5.4
			r2 := 5.4
			assert ("not_less_than2", not (r1 < r2))
		end

	test_is_less_equal is
			-- Test feature 'is_less_equal alias "<="'.
		local
			r1, r2: DOUBLE
		do
			r1 := 1.5
			r2 := 2.7
			assert ("less_equal1", r1 <= r2)
			r1 := 10.9
			r2 := 8.2
			assert ("not_less_equal", not (r1 <= r2))
			r1 := 5.4
			r2 := 5.4
			assert ("less_equal2", r1 <= r2)
		end

	test_is_greater is
			-- Test feature 'is_greater alias ">"'.
		local
			r1, r2: DOUBLE
		do
			r1 := 1.5
			r2 := 2.7
			assert ("not_greater_than1", not (r1 > r2))
			r1 := 10.9
			r2 := 8.2
			assert ("greater_than1", r1 > r2)
			r1 := 5.4
			r2 := 5.4
			assert ("not_greater_than2", not (r1 > r2))
		end

	test_is_greater_equal is
			-- Test feature 'is_greater_equal alias ">="'.
		local
			r1, r2: DOUBLE
		do
			r1 := 1.5
			r2 := 2.7
			assert ("not_greater_equal1", not (r1 >= r2))
			r1 := 10.9
			r2 := 8.2
			assert ("greater_equal1", r1 >= r2)
			r1 := 5.4
			r2 := 5.4
			assert ("greater_equal2", r1 >= r2)
		end

	test_out is
			-- Test feature 'out'.
		local
			r: DOUBLE
			l_out: STRING
		do
			r := 10.9
			l_out := r.out
			assert ("not_void1", l_out /= Void)
			assert ("string_type1", l_out.same_type (""))
			assert_equal ("value1", "10.9", l_out)
			assert ("new_string1", l_out /= r.out)
			r := -10.9
			l_out := r.out
			assert ("not_void2", l_out /= Void)
			assert ("string_type2", l_out.same_type (""))
			assert_equal ("value2", "-10.9", l_out)
			assert ("new_string2", l_out /= r.out)
		end

	test_item is
			-- Test feature 'item'.
		local
			r: DOUBLE
		do
			r := 5.4
			assert ("item1", r.item = 5.4)
			r := -10.9
			assert ("item2", r.item = -10.9)
			assert ("item3", ({DOUBLE} 25.2).item = 25.2)
			assert ("item4", ({DOUBLE} -100.0).item = -100.0)
		end

	test_set_item___fail_ise is
			-- Test feature 'set_item'.
			-- Does not work with ISE Eiffel.
		local
			r: DOUBLE
		do
			if not eiffel_compiler.is_ise then
				r.set_item (5.4)
				assert ("item1", r = 5.4)
				r.set_item (-10.9)
				assert ("item2", r = -10.9)
					-- We get a new "5.5" at each call (it's an expanded type).
					-- So setting the 'item' of one occurrence of "5.5" does not
					-- change the 'item' of the next occurrence of "5.5".
				({DOUBLE} 5.5).set_item (-10.3)
				assert ("item3", (5.5).item = 5.5)
					-- Setting the 'item' of the result of a function does not
					-- set the 'item' of the result of the next call of this
					-- function.
				({DOUBLE} 4.4 + {DOUBLE} 6.5).set_item (-11.5)
				assert ("item4", ({DOUBLE} 4.4 + {DOUBLE} 6.5).item = 10.9)
			end
		end

	test_to_reference is
			-- Test feature 'to_reference'.
		local
			r: DOUBLE
			rref: DOUBLE_REF
		do
			r := 5.3
			rref := r.to_reference
			assert ("not_void1", rref /= Void)
			assert ("item1", rref.item = 5.3)
			r := -10.2
			rref := r.to_reference
			assert ("not_void2", rref /= Void)
			assert ("item2", rref.item = -10.2)
		end

	test_make_from_reference___fail_ise is
			-- Test feature 'make_from_reference'.
			-- Does not work with ISE Eiffel.
		local
			r: DOUBLE
			rref: DOUBLE_REF
		do
			if not eiffel_compiler.is_ise then
				create rref
				rref.set_item (5.7)
				create r.make_from_reference (rref)
				assert ("item1", r = 5.7)
				create rref
				rref.set_item (-10.1)
				create r.make_from_reference (rref)
				assert ("item2", r = -10.1)
			end
		end

	test_plus is
			-- Test feature 'plus alias "+"'.
		local
			r1, r2, r3: DOUBLE
		do
			r1 := 2.2
			r2 := 5.5
			r3 := 7.7
			assert ("plus1", r1 + r2 = r3)
		end

	test_minus is
			-- Test feature 'minus alias "-"'.
		local
			r1, r2, r3: DOUBLE
		do
			r1 := 5.5
			r2 := 2.2
			r3 := 3.3
			assert ("minus1", r1 - r2 = r3)
		end

	test_product is
			-- Test feature 'product alias "*"'.
		local
			r1, r2, r3: DOUBLE
		do
			r1 := 5.4
			r2 := 2.0
			r3 := 10.8
			assert ("times1", r1 * r2 = r3)
		end

	test_quotient is
			-- Test feature 'quotient alias "/"'.
		local
			r1, r2, r3: DOUBLE
		do
			r1 := 10.4
			r2 := 2.0
			r3 := 5.2
			assert ("divide1", r1 / r2 = r3)
		end

	test_power is
			-- Test feature 'power alias "^"'.
		local
			r1, r2, r3: DOUBLE
		do
			r1 := 9.0
			r2 := 0.5
			r3 := 3.0
			assert ("power1", r1 ^ r2 = r3)
			r1 := 2.0
			r2 := 3.0
			r3 := 8.0
			assert ("power2", r1 ^ r2 = r3)
		end

	test_opposite is
			-- Test feature 'opposite alias "-"'.
		local
			r1, r2: DOUBLE
		do
			r1 := 5.1
			r2 := -5.1
			assert ("minus1", -r1 = r2)
		end

	test_identity is
			-- Test feature 'identity alias "+"'.
		local
			r1, r2: DOUBLE
		do
			r1 := 5.9
			r2 := 5.9
			assert ("plus1", +r1 = r2)
		end

	test_truncated_to_integer is
			-- Test feature 'truncated_to_integer'.
		local
			r: DOUBLE
			i: INTEGER
		do
			r := 97.8
			i := 97
			assert ("truncated_to_integer1", r.truncated_to_integer = i)
		end

	test_truncated_to_integer_64 is
			-- Test feature 'truncated_to_integer_64'.
		local
			r: DOUBLE
			i: INTEGER_64
		do
			r := 97.8
			i := 97
			assert ("truncated_to_integer_64_1", r.truncated_to_integer_64 = i)
		end

	test_truncated_to_real is
			-- Test feature 'truncated_to_real'.
		local
			r: DOUBLE
			r2: REAL
		do
			r := 97.5
			r2 := 97.5
			assert ("truncated_to_real_1", r.truncated_to_real = r2)
		end

	test_ceiling_real_64 is
			-- Test feature 'ceiling_real_64'.
		local
			r1, r2: DOUBLE
		do
			r1 := 7.8
			r2 := 8.0
			assert ("ceiling_real_64_1", r1.ceiling_real_64 = r2)
		end

	test_floor_real_64 is
			-- Test feature 'floor_real_64'.
		local
			r1, r2: DOUBLE
		do
			r1 := 7.8
			r2 := 7.0
			assert ("floor_real_64_1", r1.floor_real_64 = r2)
		end

	test_abs is
			-- Test feature 'abs'.
		local
			r1, r2: DOUBLE
		do
			r1 := 7.8
			r2 := 7.8
			assert ("abs1", r1.abs = r2)
			r1 := -9.1
			r2 := 9.1
			assert ("abs1", r1.abs = r2)
		end

	test_convert is
			-- Test conversion.
		local
			r: DOUBLE
			rref: DOUBLE_REF
		do
				-- Convert to.
			r := 5.3
			rref := r
			assert ("not_void1", rref /= Void)
			assert ("item1", rref.item = 5.3)
			r := -10.2
			rref := r
			assert ("not_void2", rref /= Void)
			assert ("item2", rref.item = -10.2)
				-- Convert from.
			create rref
			rref.set_item (5.1)
			r := rref
			assert ("item3", r = 5.1)
			create rref
			rref.set_item (-10.6)
			r := rref
			assert ("item4", r = -10.6)
		end

end
