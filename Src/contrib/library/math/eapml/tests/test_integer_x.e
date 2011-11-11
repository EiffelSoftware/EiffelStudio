note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_INTEGER_X

inherit
	EQA_TEST_SET
	INTEGER_X_ASSIGNMENT
		undefine
			default_create
		end

feature -- Basic operations tests
	test_init
		local
			one: INTEGER_X
		do
			create one
		end

	test_default_zero
		local
			one: INTEGER_X
		do
			create one
			assert ("{INTEGER_X}.default_create", one.to_integer_32 = 0)
		end

	test_make_ui
		local
			one: INTEGER_X
		do
			create one.make_from_natural (0xffffffff)
			assert ("{INTEGER_X}.make_ui", one.to_natural_32 = 0xffffffff)
		end

	test_as_natural
		local
			one: INTEGER_X
		do
			create one.make_from_natural (0xffffffff)
			assert ("{INTEGER_X}.as_natural", one.to_natural_32 = 0xffffffff)
		end

	test_make_si
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0x7fffffff)
			assert ("{INTEGER_X}.make_si", one.to_integer_32 = 0x7fffffff)
		end

	test_as_integer
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0x7fffffff)
			assert ("{INTEGER_X}.as_integer", one.to_integer_32 = 0x7fffffff)
		end

	test_fits_natural_8_1
		local
			one: INTEGER_X
			int: NATURAL_8
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits natural 8 1", one.fits_natural_8)
		end

	test_fits_natural_8_2
		local
			one: INTEGER_X
			int: NATURAL_8
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits natural 8 2", not one.fits_natural_8)
		end

	test_fits_natural_8_3
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits natural 8 3", one.fits_natural_8)
		end

	test_fits_natural_8_4
		local
			one: INTEGER_X
		do
			create one.make_from_integer (-1)
			assert ("test fits natural 8 4", not one.fits_natural_8)
		end

	test_fits_natural_16_1
		local
			one: INTEGER_X
			int: NATURAL_16
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits natural 16 1", one.fits_natural_16)
		end

	test_fits_natural_16_2
		local
			one: INTEGER_X
			int: NATURAL_16
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits natural 16 2", not one.fits_natural_16)
		end

	test_fits_natural_16_3
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits natural 16 3", one.fits_natural_16)
		end

	test_fits_natural_16_4
		local
			one: INTEGER_X
		do
			create one.make_from_integer (-1)
			assert ("test fits natural 16 4", not one.fits_natural_16)
		end

	test_fits_natural_32_1
		local
			one: INTEGER_X
			int: NATURAL_32
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits natural 32 1", one.fits_natural_32)
		end

	test_fits_natural_32_2
		local
			one: INTEGER_X
			int: NATURAL_32
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits natural 32 2", not one.fits_natural_32)
		end

	test_fits_natural_32_3
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits natural 32 3", one.fits_natural_32)
		end

	test_fits_natural_32_4
		local
			one: INTEGER_X
		do
			create one.make_from_integer (-1)
			assert ("test fits natural 32 4", not one.fits_natural_32)
		end

	test_fits_natural_64_1
		local
			one: INTEGER_X
			int: NATURAL_64
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits natural 64 1", one.fits_natural_64)
		end

	test_fits_natural_64_2
		local
			one: INTEGER_X
			int: NATURAL_64
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits natural 64 2", not one.fits_natural_64)
		end

	test_fits_natural_64_3
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits natural 64 3", one.fits_natural_64)
		end

	test_fits_natural_64_4
		local
			one: INTEGER_X
		do
			create one.make_from_integer (-1)
			assert ("test fits natural 64 4", not one.fits_natural_64)
		end

	test_fits_integer_8_1
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits integer 8 1", one.fits_integer_8)
		end

	test_fits_integer_8_2
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.min_value.out)
			assert ("test fits integer 8 2", one.fits_integer_8)
		end

	test_fits_integer_8_3
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits integer 8 3", not one.fits_integer_8)
		end

	test_fits_integer_8_4
		local
			one: INTEGER_X
			int: INTEGER_8
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test fits integer 8 4", not one.fits_integer_8)
		end

	test_fits_integer_8_5
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits integer 8 5", one.fits_integer_8)
		end

	test_fits_integer_16_1
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits integer 16 1", one.fits_integer_16)
		end

	test_fits_integer_16_2
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.min_value.out)
			assert ("test fits integer 16 2", one.fits_integer_16)
		end

	test_fits_integer_16_3
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits integer 16 3", not one.fits_integer_16)
		end

	test_fits_integer_16_4
		local
			one: INTEGER_X
			int: INTEGER_16
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test fits integer 16 4", not one.fits_integer_16)
		end

	test_fits_integer_16_5
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits integer 16 5", one.fits_integer_16)
		end

	test_fits_integer_32_1
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits integer 32 1", one.fits_integer_32)
		end

	test_fits_integer_32_2
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.min_value.out)
			assert ("test fits integer 32 2", one.fits_integer_32)
		end

	test_fits_integer_32_3
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits integer 32 3", not one.fits_integer_32)
		end

	test_fits_integer_32_4
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test fits integer 32 4", not one.fits_integer_32)
		end

	test_fits_integer_32_5
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits integer 32 5", one.fits_integer_32)
		end

	test_fits_integer_64_1
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits integer 64 1", one.fits_integer_64)
		end

	test_fits_integer_64_2
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.min_value.out)
			assert ("test fits integer 64 2", one.fits_integer_64)
		end

	test_fits_integer_64_3
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.max_value.out)
			one.plus (one.one)
			assert ("test fits integer 64 3", not one.fits_integer_64)
		end

	test_fits_integer_64_4
		local
			one: INTEGER_X
			int: INTEGER_64
		do
			create one.make_from_string (int.min_value.out)
			one.minus (one.one)
			assert ("test fits integer 64 4", not one.fits_integer_64)
		end

	test_fits_integer_64_5
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.max_value.out)
			assert ("test fits integer 64 5", one.fits_integer_64)
		end

	test_fits_integer_64_6
		local
			one: INTEGER_X
			int: INTEGER_32
		do
			create one.make_from_string (int.min_value.out)
			assert ("test fits integer 64 6", one.fits_integer_64)
		end

	test_fits_integer_64_7
		local
			one: INTEGER_X
		do
			create one.make_from_integer (0)
			assert ("test fits integer 64 7", one.fits_integer_64)
		end

	test_swap
		local
			one: INTEGER_X
			two: INTEGER_X
		do
			create one.make_from_integer (1)
			create two.make_from_integer (2)
			swap (one, two)
			assert ("{INTEGER_X}.swap 1", two.to_integer_32 = 1)
			assert ("{INTEGER_X}.swap 2", one.to_integer_32 = 2)
		end

	test_init_set
		local
			one: INTEGER_X
			two: INTEGER_X
		do
			create one.make_from_string ("0982430984230470238742037402394230948")
			create two.make_set (one)
			assert ("{INTEGER_X}.init_set", one ~ two)
		end

	test_sub
			-- Test integer subtraction cases, ++ +- -+ --, 0 sum
		local
			posone: INTEGER_X
			postwo: INTEGER_X
			negone: INTEGER_X
			negtwo: INTEGER_X
			ans: INTEGER_X
		do
			create posone.make_from_integer (1000)
			create postwo.make_from_integer (2000)
			create negone.make_from_integer (-1000)
			create negtwo.make_from_integer (-2000)
			ans := posone - postwo
			assert ("{INTEGER_X}.sub test", ans.to_integer_32 = 1000 - 2000)
			ans := postwo - negone
			assert ("{INTEGER_X}.sub test", ans.to_integer_32 = 2000 - -1000)
			ans := negone - postwo
			assert ("{INTEGER_X}.sub test", ans.to_integer_32 = -1000 - 2000)
			ans := negone - negtwo
			assert ("{INTEGER_X}.sub test", ans.to_integer_32 = -1000 - -2000)
			ans := posone - posone
			assert ("{INTEGER_X}.sub test", ans.to_integer_32 = 1000 - 1000)
		end

	test_negative
		local
			one: INTEGER_X
			two: INTEGER_X
		do
			create one.make_from_integer (1)
			create two.make_from_integer (-1)
			assert ("test negative", one ~ two or one ~ -two)
		end

	test_mul
			-- Test multiplication cases, +- -+
		local
			posone: INTEGER_X
			negone: INTEGER_X
			ans: INTEGER_X
		do
			create posone.make_from_integer (1000)
			create negone.make_from_integer (-1000)
			ans := posone * posone
			assert ("{INTEGER_X}.mul test", ans.to_integer_32 = 1000 * 1000)
			ans := posone * negone
			assert ("{INTEGER_X}.mul test", ans.to_integer_32 = 1000 * -1000)
		end

	test_div
			-- Test integer division cases, pp, ppr, np, npr, nn, nnr
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			four: INTEGER_X
			quot: INTEGER_X
		do
			create one.make_from_integer (42)
			create two.make_from_integer (2)
			create three.make_from_integer (-42)
			create four.make_from_integer (-2)
			quot := one / two
			assert ("{INTEGER_X}.div test", quot.to_integer_32 = 42 // 2)
			quot := two / one
			assert ("{INTEGER_X}.div test", quot.to_integer_32 = 2 // 42)
			quot := three / two
			assert ("{INTEGER_X}.div test", quot.to_integer_32 = -42 // 2)
			quot := two / three
			assert ("{INTEGER_X}.div test", quot.to_integer_32 = 2 // -42)
			quot := three / four
			assert ("{INTEGER_X}.div test", quot.to_integer_32 = -42 // -2)
			quot := four / three
			assert ("{INTEGER_X}.div test", quot.to_integer_32 = -2 // -42)
		end

	test_abs
			-- Test absolute value cases
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			ans: INTEGER_X
		do
			create one.make_from_integer (1)
			create two.make_from_integer (-1)
			create three.make_from_integer (0)
			ans := one.abs_value
			assert ("INTEGER_X.abs positive", ans.to_integer_32 = 1)
			ans := two.abs_value
			assert ("INTEGER_X.abs negative", ans.to_integer_32 = 1)
			ans := three.abs_value
			assert ("INTEGER_X.abs zero", ans.to_integer_32 = 0)
		end

	test_comp
			-- Test comparison function cases
		local
			one: INTEGER_X
			two: INTEGER_X
			three:INTEGER_X
		do
			create one.make_from_integer (1000)
			create two.make_from_integer (2000)
			create three.make_from_integer (1000)

			assert ("INTEGER_X.comp eq", one.is_equal (three) = TRUE)
			assert ("INTEGER_X.comp lt", one.is_less (two) = TRUE)
			assert ("INTEGER_X.comp lt", two.is_less (one) = FALSE)
			assert ("INTEGER_X.comp le", one.is_less_equal (two) = TRUE)
			assert ("INTEGER_X.comp le", one.is_less_equal (three) = TRUE)
			assert ("INTEGER_X.comp le", two.is_less_equal (one) = FALSE)
			assert ("INTEGER_X.comp gt", one.is_greater (two) = FALSE)
			assert ("INTEGER_X.comp gt", two.is_greater (one) = TRUE)
			assert ("INTEGER_X.comp ge", one.is_greater_equal (two) = FALSE)
			assert ("INTEGER_X.comp ge", one.is_greater_equal (three) = TRUE)
			assert ("INTEGER_X.comp ge", two.is_greater_equal (one) = TRUE)

		end



end


