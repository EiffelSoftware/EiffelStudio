note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ACCURACY

inherit

	EQA_TEST_SET

feature -- Test routines

	test_accuracy
			-- New test routine
		local
			l_date_time: DATE_TIME
			l_date_string, l_date_string_2, l_code: STRING
		do
			l_date_string := "2012-06-29 10:14:47.723"
			l_code := "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss.ff3"
			create l_date_time.make_from_string (l_date_string, l_code)
			l_date_string_2 := l_date_time.formatted_out (l_code)
			assert ("input equals output: Expected: " + l_date_string + " - Actual: " + l_date_string_2, l_date_string.same_string (l_date_string_2))
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
