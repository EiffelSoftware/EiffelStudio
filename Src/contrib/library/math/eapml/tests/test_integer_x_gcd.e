note
	description: "Summary description for {TEST_INTEGER_X_GCD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_GCD

inherit
	EQA_TEST_SET
	INTEGER_X_GCD
		undefine
			default_create
		end

feature
	test_gcd_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("75bd a09fab66 22ddfba5 6141c975")
			create three.make_from_hex_string ("db7c 2abf62e3 5e668076 bead208b")
			create expected.make_from_integer (1)
			gcd (one, two, three)
			assert ("test gcd 1", one ~ expected)
		end

	test_gcd_2
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("1f3e 0565ad11 0943df37 0be1f345")
			create three.make_from_hex_string ("db7c 2abf62e3 5e668076 bead208b")
			create expected.make_from_integer (1)
			gcd (one, two, three)
			assert ("test gcd 2", one ~ expected)
		end

	test_gcd_3
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("b900 97df5038 7e2f36a6 2ed3a8f4")
			create three.make_from_hex_string ("db7c 2abf62e3 5e668076 bead208b")
			create expected.make_from_integer (1)
			gcd (one, two, three)
			assert ("test gcd 3", one ~ expected)
		end

	test_gcd_4
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("905a 1c3f4cec 73b96934 ac732c70")
			create three.make_from_hex_string ("db7c 2abf62e3 5e668076 bead208b")
			create expected.make_from_integer (1)
			gcd (one, two, three)
			assert ("test gcd 4", one ~ expected)
		end

	test_gcd_5
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("1ffb369d437c5d32145fd9a1223ab960e362ffd5545b675f7ead44be35a12c61699c05dd8ecafb643b9feb6912fb6df6c57eca1c0e4ff132ed5d77d6bb5d96a4395")
			create three.make_from_hex_string ("1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
			create expected.make_from_hex_string ("1")
			gcd (one, two, three)
			assert ("test gcd 5", one ~ expected)
		end
end
