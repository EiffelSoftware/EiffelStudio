note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_FORMAT

inherit

	EQA_TEST_SET

feature -- Test routines

	test_0hh0mi0ss
		local
			t: TIME
		do
			create t.make_from_string ("180500", "[0]hh[0]mi[0]ss")
		end

	test_yyyy_mm_dd
		do
			test_formatted_out_date ("YYYY MM DD", new_date)
		end

	test_yyyy_slash_mm_slash_dd
		do
			test_formatted_out_date ("YYYY/MM/DD", new_date)
		end

	test_ddd_comma_dd_mmm_yyyy
		do
			test_formatted_out_date ("ddd, dd mmm yyyy", new_date)
		end

	test_ddd_comma_0dd_mmm_yyyy
		do
			test_formatted_out_date ("ddd, [0]dd mmm yyyy", new_date)
		end

	test_ddd_comma_dd_mmm_yyyy__hh_mi_ss
		do
			test_formatted_out_date_time ("ddd, [0]dd mmm yyyy [0]hh:[0]mi:[0]ss", new_date_time)
		end

	test_ddd_comma_dd_mmm_yyyy__hh_mi_ss_ff2
		do
			test_formatted_out_date_time ("ddd, [0]dd mmm yyyy [0]hh:[0]mi:[0]ss.ff2", new_date_time)
		end

	new_date: DATE
		do
			create Result.make (2013, 01, 30) -- "WED, 30 JAN 2013"
			create Result.make (2013, 10, 30) -- "WED, 30 JAN 2013"
		end

	new_date_time: DATE_TIME
		do
			create Result.make (2013, 01, 30, 21, 34, 33) -- "WED, 30 JAN 2013 21:34:33"
			create Result.make (2013, 10, 30, 21, 34, 33) -- "WED, 30 JAN 2013 21:34:33"
		end

feature {NONE} -- Implementation

	test_formatted_out_date (a_code_string: STRING_8; v: DATE)
		local
			s: STRING
			c: DATE_VALIDITY_CHECKER
			d: DATE
		do
			s := v.formatted_out (a_code_string)
			create c
			create d.make_from_string (s, a_code_string)

			assert ("is formatted_out valid", c.date_valid (s, a_code_string))
			assert ("roundtrip succeed", s.same_string (d.formatted_out (a_code_string)))
		end

	test_formatted_out_date_time (a_code_string: STRING_8; v: DATE_TIME)
		local
			s: STRING
			c: DATE_TIME_VALIDITY_CHECKER
			d: DATE_TIME
		do
			s := v.formatted_out (a_code_string)
			create c
			create d.make_from_string (s, a_code_string)

			assert ("is formatted_out valid", c.date_time_valid (s, a_code_string))
			assert ("roundtrip succeed", s.same_string (d.formatted_out (a_code_string)))
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
