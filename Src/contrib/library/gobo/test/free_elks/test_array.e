indexing

	description:

		"Test features of class ARRAY"

	library: "FreeELKS Library"
	copyright: "Copyright (c) 2006-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class TEST_ARRAY

inherit

	TS_TEST_CASE

	KL_SHARED_EIFFEL_COMPILER

create

	make_default

feature -- Test

	test_subarray is
			-- Test feature `subarray'.
		local
			l_ai1: ARRAY [INTEGER]
			l_ai2: ARRAY [INTEGER]
		do
			l_ai1 := <<1, 2, 3, 4, 5, 6>>
			l_ai2 := l_ai1.subarray (3, 5)
			assert_iarrays_same ("same_items", <<3, 4, 5>>, l_ai2)
			assert_integers_equal ("lower_set", 3, l_ai2.lower)
			assert_integers_equal ("upper_set", 5, l_ai2.upper)
				-- Empty subarray.
			l_ai2 := l_ai1.subarray (6, 5)
			assert_integers_equal ("same_items2", 0, l_ai2.count)
			assert_integers_equal ("lower_set2", 6, l_ai2.lower)
			assert_integers_equal ("upper_set2", 5, l_ai2.upper)
		end

	test_subarray___fail_ise_ge is
			-- Test feature `subarray'.
			-- Does not work with ISE Eiffel and Gobo Eiffel.
		local
			l_ai1: ARRAY [INTEGER]
			l_ai2: ARRAY [INTEGER]
		do
			if not eiffel_compiler.is_ise and not eiffel_compiler.is_ge then
					-- Subarray of an empty array.
				create l_ai1.make (4, 3)
				l_ai2 := l_ai1.subarray (4, 3)
				assert_integers_equal ("same_items3", 0, l_ai2.count)
				assert_integers_equal ("lower_set3", 4, l_ai2.lower)
				assert_integers_equal ("upper_set3", 3, l_ai2.upper)
			end
		end

	test_clear_all is
			-- Test feature `clear_all'.
		local
			l_ai: ARRAY [INTEGER]
			l_as: ARRAY [STRING]
			void_as: ARRAY [STRING]
		do
			create l_ai.make (4, 7)
			l_ai.put (1, 4)
			l_ai.put (2, 5)
			l_ai.put (3, 6)
			l_ai.put (4, 7)
			assert_iarrays_same ("ai_initialized", <<1, 2, 3, 4>>, l_ai)
			assert_integers_equal ("ai_lower_set", 4, l_ai.lower)
			assert_integers_equal ("ai_upper_set", 7, l_ai.upper)
			l_ai.clear_all
			assert_iarrays_same ("ai_all_cleared", <<0, 0, 0, 0>>, l_ai)
			assert_integers_equal ("ai_same_lower", 4, l_ai.lower)
			assert_integers_equal ("ai_same_upper", 7, l_ai.upper)
			l_as := <<"1", "2", "3", "4">>
			assert_arrays_equal ("as_initialized", <<"1", "2", "3", "4">>, l_as)
			l_as.clear_all
			create void_as.make (1, 4)
			assert_arrays_same ("as_all_cleared", void_as, l_as)
				-- Empty array.
			create l_as.make (3, 2)
			assert_integers_equal ("as_empty2", 0, l_as.count)
			l_as.clear_all
			assert_integers_equal ("as_still_empty2", 0, l_as.count)
			assert_integers_equal ("as_same_lower2", 3, l_as.lower)
			assert_integers_equal ("as_same_upper2", 2, l_as.upper)
		end

	test_manifest_array_character is
			-- Test manifest arrays of CHARACTER.
		local
			l_array: ARRAY [CHARACTER]
		do
			l_array := <<'a', 'c'>>
			assert_characters_equal ("item1", 'a', l_array.item (1))
			assert_characters_equal ("item2", 'c', l_array.item (2))
		end

	test_manifest_array_boolean is
			-- Test manifest arrays of BOOLEAN.
		local
			l_array: ARRAY [BOOLEAN]
		do
			l_array := <<True, False, True>>
			assert ("item1", l_array.item (1))
			assert ("item2", not l_array.item (2))
			assert ("item3", l_array.item (3))
		end

	test_manifest_array_integer_8 is
			-- Test manifest arrays of INTEGER_8.
		local
			l_array: ARRAY [INTEGER_8]
			i1, i2: INTEGER_8
		do
			i1 := 100
			i2 := -4
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_integer_16 is
			-- Test manifest arrays of INTEGER_16.
		local
			l_array: ARRAY [INTEGER_16]
			i1, i2: INTEGER_16
		do
			i1 := 10000
			i2 := -9999
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_integer_32 is
			-- Test manifest arrays of INTEGER_32.
		local
			l_array: ARRAY [INTEGER_32]
			i1, i2: INTEGER_32
		do
			i1 := 123456
			i2 := -654321
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_integer_64 is
			-- Test manifest arrays of INTEGER_64.
		local
			l_array: ARRAY [INTEGER_64]
			i1, i2: INTEGER_64
		do
			i1 := 12345678912345678
			i2 := 9876543219876543
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_natural_8 is
			-- Test manifest arrays of NATURAL_8.
		local
			l_array: ARRAY [NATURAL_8]
			i1, i2: NATURAL_8
		do
			i1 := 100
			i2 := 4
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_natural_16 is
			-- Test manifest arrays of NATURAL_16.
		local
			l_array: ARRAY [NATURAL_16]
			i1, i2: NATURAL_16
		do
			i1 := 10000
			i2 := 9999
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_natural_32 is
			-- Test manifest arrays of NATURAL_32.
		local
			l_array: ARRAY [NATURAL_32]
			i1, i2: NATURAL_32
		do
			i1 := 123456
			i2 := 654321
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_natural_64 is
			-- Test manifest arrays of NATURAL_64.
		local
			l_array: ARRAY [NATURAL_64]
			i1, i2: NATURAL_64
		do
			i1 := 12345678912345678
			i2 := 9876543219876543
			l_array := <<i1, i2>>
			assert ("item1", l_array.item (1) = i1)
			assert ("item2", l_array.item (2) = i2)
		end

	test_manifest_array_real_32 is
			-- Test manifest arrays of REAL_32.
		local
			l_array: ARRAY [REAL_32]
			r1, r2: REAL_32
		do
			r1 := 1.45
			r2 := -4.2E+7
			l_array := <<r1, r2>>
			assert ("item1", l_array.item (1) = r1)
			assert ("item2", l_array.item (2) = r2)
		end

	test_manifest_array_real_64 is
			-- Test manifest arrays of REAL_64.
		local
			l_array: ARRAY [REAL_64]
			r1, r2: REAL_64
		do
			r1 := 1.45
			r2 := -4.2E+7
			l_array := <<r1, r2>>
			assert ("item1", l_array.item (1) = r1)
			assert ("item2", l_array.item (2) = r2)
		end

	test_manifest_any is
			-- Test manifest arrays of ANY.
		local
			l_array: ARRAY [ANY]
			s1: STRING
			i2: INTEGER
		do
			s1 := "gobo"
			i2 := 5
			l_array := <<s1, i2>>
			assert ("item1", l_array.item (1) = s1)
			assert_strings_equal ("item2a", i2.generating_type, l_array.item (2).generating_type)
			assert_strings_equal ("item2b", i2.out, l_array.item (2).out)
		end

end
