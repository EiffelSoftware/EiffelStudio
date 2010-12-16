note
	description: "Summary description for {OBJECTS_CREATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECTS_CREATION

inherit
	TESTS_COMMON
		redefine
			run
		end

feature -- Running

	run
			-- Run the tests
		do
			Precursor
			test1
			collect_garbage
			test2
			collect_garbage
		end

feature {NONE} -- Tests

	test1
			-- Create 2 NS_NUMBERS using the creation features.
		local
			pool: NS_AUTORELEASE_POOL
			number1: NS_NUMBER
			number2: NS_NUMBER
		do
			create pool.make

			create number1.make_with_bool_ (True)
			create number2.make_with_int_ (232)

			assert (number1.bool_value = True)
			assert (number1.int_value = 1)
			assert (number2.int_value = 232)
		end

	test2
			-- Create 2 NS_NUMBERS using the utility class.
		local
			pool: NS_AUTORELEASE_POOL
			ns_number_utils: NS_NUMBER_UTILS
			number1: NS_NUMBER
			number2: NS_NUMBER
		do
			create pool.make
			create ns_number_utils
			check attached ns_number_utils.number_with_double_ (3.14) as pi then
				number1 := pi
			end
			check attached ns_number_utils.number_with_unsigned_long_long_ (1234567890987654321) as long_long_num then
				number2 := long_long_num
			end

			assert (number1.double_value = 3.14)
			assert (number2.long_long_value = 1234567890987654321)
		end

end
