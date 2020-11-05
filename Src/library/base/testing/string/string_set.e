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

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
