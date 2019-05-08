note
	description: "Testing of EQUALITY_TUPLE class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EQUALITY_TUPLE

obsolete "The test is kept until {EQUALITY_TUPLE} is removed. [2019-05-31]"

inherit
	EQA_TEST_SET

feature

	test_equality
		local
			l_e1, l_e2: EQUALITY_TUPLE [TUPLE]
		do
			create l_e1.make ([2,2])
			create l_e2.make ([2,2])
			assert ("Equal", l_e1.is_equal (l_e2))

			create l_e1.make ([1,2])
			assert ("Not equal", not l_e1.is_equal (l_e2))

			create l_e1.make ([1])
			assert ("Not equal", not l_e1.is_equal (l_e2))
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
