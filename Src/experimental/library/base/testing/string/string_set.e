note
	description: "Summary description for {STRING_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRING_SET

inherit
	EQA_TEST_SET

feature {NONE} -- Checking

	check_string_equality (m: READABLE_STRING_GENERAL; a, b: READABLE_STRING_GENERAL)
			-- If `a' and `b' are not equal print something on the console.
		do
			assert_32 (m, a.same_string (b))
		end

	check_equality (m: READABLE_STRING_GENERAL; a,b: ANY)
		do
			assert_32 (m, equal (a, b))
		end

	check_boolean (m: READABLE_STRING_GENERAL; cond: BOOLEAN)
		do
			assert_32 (m, cond)
		end

end
