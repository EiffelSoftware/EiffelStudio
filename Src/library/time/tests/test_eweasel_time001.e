note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EWEASEL_TIME001

inherit
	EQA_TEST_SET

feature -- Test routines

	test_time001
		local
			date: DATE_TIME
			d1, d2: DATE_TIME
			d: DATE_TIME_DURATION
			t: TIME
			date_duration: DATE_DURATION
			time: TIME_DURATION
			date_time_duration: DATE_TIME_DURATION
		do
			create date_duration.make_by_days (10)
			create time.make_by_fine_seconds (1000)
			create date_time_duration.make_by_date_time (date_duration, time)
			date_time_duration := - date_time_duration

			create d1.make_fine (2005, 6, 29, 23, 59, 59.6)
			create d2.make_fine (2005, 6, 30, 12, 3, 25.4)
			d := d2.relative_duration (d1)

			create date.make (2005, 6, 29, 9, 3, 0)
			assert_eweasel_expect_output ("9:3 AM", date.formatted_out ("hh12:mi AM"))
			assert_eweasel_expect_output ("AM 9:3", date.formatted_out ("AM hh12:mi"))
			assert_eweasel_expect_output ("AM 9:3", date.formatted_out ("PM hh12:mi"))
			assert_eweasel_expect_output ("9:3 AM", date.formatted_out ("hh12:mi PM"))
			assert_eweasel_expect_output ("9:3 AM 0", date.formatted_out ("hh12:mi PM ss"))
			assert_eweasel_expect_output ("9 AM:3 0", date.formatted_out ("hh12 PM:mi ss"))
			assert_eweasel_expect_output ("9", date.formatted_out ("hh12"))
			assert_eweasel_expect_output ("09", date.formatted_out ("[0]hh12"))

			create t.make_now
			assert_eweasel_expect_boolean (True, t.time_valid ("3:30:00 AM", "hh12:[0]mi:[0]ss PM"))
			assert_eweasel_expect_boolean (False, t.time_valid ("3:30:00 AM", "hh12:[0]mi:[0]ss"))
			assert_eweasel_expect_boolean (True, t.time_valid ("3:30:00", "hh12:[0]mi:[0]ss"))
			assert_eweasel_expect_boolean (False, t.time_valid ("3:30:00", "hh12:[0]mi:[0]ss PM"))

			create t.make_from_string ("3:30:30 PM", "hh12:[0]mi:[0]ss PM")
			assert_eweasel_expect_output ("3:30:30 PM", t.formatted_out ("hh12:[0]mi:[0]ss PM"))

			create d1.make_now
			assert_eweasel_expect_boolean (True, d1.date_time_valid ("1/1/0000 3:30:00 PM", "mm/dd/yyyy hh12:[0]mi:[0]ss PM"))
			assert_eweasel_expect_boolean (False, d1.date_time_valid ("1/1/0000 3:30:00", "mm/dd/yyyy hh12:[0]mi:[0]ss PM"))
		end

	assert_eweasel_expect_output (s: READABLE_STRING_8; o: READABLE_STRING_8)
		do
			assert ("Expect " + s, o.same_string (s))
		end

	assert_eweasel_expect_boolean (b: BOOLEAN; v: BOOLEAN)
		do
			assert ("Expect " + b.out, v = b)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
