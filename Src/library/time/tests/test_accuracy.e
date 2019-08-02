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
			s: STRING
			fmt: FORMAT_INTEGER
			i: INTEGER
		do
			test_accuracy_for ("2012-06-29 10:14:47.722", Void)
			test_accuracy_for ("2012-06-29 10:14:47.723", Void)
			test_accuracy_for ("2012-06-29 10:14:47.999", Void)
			test_accuracy_for ("2012-06-29 10:14:47.000", Void)
			test_accuracy_for ("2012-06-29 10:14:47.00", "2012-06-29 10:14:47.000")
			test_accuracy_for ("2012-06-29 10:14:47.0", "2012-06-29 10:14:47.000")

			s := "2013-06-19 10:27:56."
			from
				i := 0
				create fmt.make (3)
				fmt.set_fill ('0')
			until
				i = 999
			loop
				test_accuracy_for (s + fmt.formatted (i), Void)
				i := i + 1
			end
		end

	test_accuracy_for (a_date_string: STRING_8; a_expected: detachable READABLE_STRING_8)
			-- New test routine
		local
			l_date_time: DATE_TIME
			l_date_string: READABLE_STRING_8
			l_date_string_2, l_code: STRING
		do
			l_code := "yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss.ff3"
			create l_date_time.make_from_string (a_date_string, l_code)
			l_date_string_2 := l_date_time.formatted_out (l_code)
			if a_expected /= Void then
				l_date_string := a_expected
			else
				l_date_string := a_date_string
			end
			assert ("input equals output: Expected: " + l_date_string + " - Actual: " + l_date_string_2, l_date_string.same_string (l_date_string_2))
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
