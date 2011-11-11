note
	description: "Summary description for {INTEGER_X_DIVISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INTEGER_X_DIVISION

inherit
	EQA_TEST_SET
	INTEGER_X_DIVISION
		undefine
			default_create
		end

feature
	test_tdiv_q_1
		local
			one: INTEGER_X
			two: INTEGER_X
			three: INTEGER_X
			expected: INTEGER_X
		do
			create one
			create two.make_from_hex_string ("-014fae42 56ad0915 2a7b2b66 fe887b52 e06ffa35 d359cd33 14156137 564096ef 90eb9c01 9ee82ea9")
			create three.make_from_hex_string ("474c50aa 62d128fa b3b99224 0846a26e f58bf664")
			create expected.make_from_hex_string ("-04b547f5 df885395 a422bbce 998d2570 9019af3a")
			tdiv_q (one, two, three)
			assert ("test tdiv q 1", one ~ expected)
		end
end
