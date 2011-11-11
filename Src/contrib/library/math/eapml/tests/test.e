note
	description : "Library unit test root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
		do
		end

		test1: detachable TEST_INTEGER_X
		test2: detachable TEST_INTEGER_FUNCTIONS
		test3: detachable TEST_INTEGER_X_ASSIGNMENT
		test4: detachable TEST_SPECIAL_ARITHMETIC
		test5: detachable TEST_SPECIAL_DIVISION
		test6: detachable TEST_SPECIAL_LOGIC
		test7: detachable TEST_SPECIAL_NUMBER_THEORETIC
		test9: detachable TEST_RANDSTRUCT_LC
		test10: detachable TEST_RANDSTRUCT_MT
		test11: detachable TEST_INTEGER_X_RANDOM
		test12: detachable TEST_INTEGER_X_ACCESS
		test13: detachable TEST_INTEGER_X_IO
		test14: detachable TEST_INTEGER_X_NUMBER_THEORY
		test15: detachable TEST_INTEGER_X_ARITHMETIC
		test16: detachable TEST_SPECIAL_GCD
		test17: detachable TEST_INTEGER_X_DIVISION
		test18: detachable TEST_INTEGER_X_GCD
		test19: detachable TEST_INTEGER_X_LOGIC
		test20: detachable TEST_LIMB_MANIPULATION
		test21: detachable IMMUTABLE_INTEGER_X
		test22: detachable INTEGER_X
end
