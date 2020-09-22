note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TYPED_POINTER_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_typed_pointer_int
		local
			i: INTEGER
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_int_value ($i)
			assert ("Expected i = -10", i = -10)
		end

	test_typed_pointer_unsinged_int
		local
			n: NATURAL
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_unsigned_int_value ($n)
			assert ("Expected n = 10", n = 10)
		end

	test_typed_pointer_long
		local
			l: INTEGER_64
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_long_value ($l)
			assert ("Expected l = 2147", l = 2147)
		end

	test_typed_pointer_unsigned_long
		local
			n: NATURAL_64
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_unsigned_long_value ($n)
			assert ("Expected n = 10", n = 10)
		end

	test_typed_pointer_float
		local
			f: REAL
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_float_value ($f)
			assert ("Expected f = 10.5", f = 10.5)
		end

	test_typed_pointer_double
		local
			d: REAL_64
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_double_value ($d)
			assert ("Expected f = 3.142857", d.ieee_is_less_equal({REAL_64} 3.142857))
		end

	test_typed_pointer_char
		local
			c: CHARACTER
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_char_value ($c)
			assert ("Expected c = a", c = 'a')
		end

	test_typed_pointer_unsigned_char
		local
			c: CHARACTER
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_unsinged_char_value ($c)
			assert ("Expected c = a", c = 'a')
		end

end


