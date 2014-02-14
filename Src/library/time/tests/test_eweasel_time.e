note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EWEASEL_TIME

inherit
	EQA_TEST_SET

feature -- Test routines

	test_datetimestring001
		local
			d: DATE
			t: TIME
			s: STRING
		do
			create d.make_from_string ("20010101", "yyyy[0]mm[0]dd")
			create t.make_from_string ("180500", "[0]hh[0]mi[0]ss")
			create d.make_from_string ("01.01.2001", "dd.mm.yyyy")

			create d.make_now
			s := d.formatted_out ("yyyy[0]mm")
		end


	test_duration001
		local
			t1, t2: TIME
			s, os: INTEGER
			td: TIME_DURATION
		do
			from
				create t1.make (0, 0, 0)
				create t2.make (0, 5, 0)
			until
				equal (t1, t2)
			loop
				os := s
				Io.put_string (t2.out + "... ")
				td := t2.relative_duration (t1)
				s := td.seconds_count
				test_true_boolean (s = os + (5 * 60))
				t2.minute_add (5)
			end
		end

	test_duration002
		local
			d1, d2: DATE
			d, od: INTEGER
			dd: DATE_DURATION
		do
			from
				create d1.make (2001, 1, 15)
				create d2.make (1991, 1, 15)
				dd := d2.relative_duration (d1)
				d := dd.days_count
				od := d - 1
			until
				d2.year = d1.year + 10
			loop
				Io.put_string (d2.out + "... ")
				dd := d2.relative_duration (d1)
				d := dd.days_count
				test_true_boolean (d = od + 1)
				d2.day_forth
				od := d
			end
		end

	test_duration003
		local
			d1, d2: DATE_TIME
			s, os: INTEGER_64
			dd: DATE_TIME_DURATION
		do
			from
				create d1.make (2001, 1, 15, 0, 0, 0)
				create d2.make (2000, 6, 1, 0, 0, 0)
				dd := d2.relative_duration (d1)
				s := dd.seconds_count
				os := s - (8 * 3600)
			until
				d2.year = d1.year + 4 and d2.month = 6
			loop
				dd := d2.relative_duration (d1)
				s := dd.seconds_count
				test_true_boolean (s = os + (8 * 3600))
				d2.hour_add (8)
				os := s
			end
		end

	test_duration004
		local
			l_date, l_date2: DATE_TIME
			l_duration: DATE_TIME_DURATION
		do
			create l_date.make (1500, 1, 1, 1, 1, 1)
			create l_date2.make (2010, 1, 1, 1, 1, 1)
			l_date2.time.set_fine_second (.5)

			l_duration := l_date2.duration
			l_duration.set_origin_date_time (l_date)
			expect_output ("12938403660", l_duration.seconds_count.out)
			expect_output ("12938403660.5", l_duration.fine_seconds_count.out)
		end

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
			expect_output ("9:3 AM", date.formatted_out ("hh12:mi AM"))
			expect_output ("AM 9:3", date.formatted_out ("AM hh12:mi"))
			expect_output ("AM 9:3", date.formatted_out ("PM hh12:mi"))
			expect_output ("9:3 AM", date.formatted_out ("hh12:mi PM"))
			expect_output ("9:3 AM 0", date.formatted_out ("hh12:mi PM ss"))
			expect_output ("9 AM:3 0", date.formatted_out ("hh12 PM:mi ss"))
			expect_output ("9", date.formatted_out ("hh12"))
			expect_output ("09", date.formatted_out ("[0]hh12"))

			create t.make_now
			expect_boolean (True, t.time_valid ("3:30:00 AM", "hh12:[0]mi:[0]ss PM"))
			expect_boolean (False, t.time_valid ("3:30:00 AM", "hh12:[0]mi:[0]ss"))
			expect_boolean (True, t.time_valid ("3:30:00", "hh12:[0]mi:[0]ss"))
			expect_boolean (False, t.time_valid ("3:30:00", "hh12:[0]mi:[0]ss PM"))

			create t.make_from_string ("3:30:30 PM", "hh12:[0]mi:[0]ss PM")
			expect_output ("3:30:30 PM", t.formatted_out ("hh12:[0]mi:[0]ss PM"))

			create d1.make_now
			expect_boolean (True, d1.date_time_valid ("1/1/0000 3:30:00 PM", "mm/dd/yyyy hh12:[0]mi:[0]ss PM"))
			expect_boolean (False, d1.date_time_valid ("1/1/0000 3:30:00", "mm/dd/yyyy hh12:[0]mi:[0]ss PM"))
		end

	test_time002
		do
			test_time002_arg (1)
			test_time002_arg (30)
		end

	test_time002_arg (n: INTEGER)
		local
			d1: DATE
			d2: DATE
			d_diff: DATE_DURATION
			dur: DATE_DURATION
			i, j: INTEGER
			l_days: INTEGER
		do
			l_days := n

				-- Simple checks for `month_add' which should we would be violating some assertions
			create d1.make (2008, 1, 29)
			d1.month_add (13)
			test_true_boolean (d1.is_equal (create {DATE}.make (2009, 02, 28)))

			create d1.make (2008, 2, 29)
			d1.month_add (11)
			test_true_boolean (d1.is_equal (create {DATE}.make (2009, 1, 29)))

			create d1.make (2008, 2, 29)
			create d2.make (2008, 12, 30)
			d_diff := d2.relative_duration (d1)
			test_true_boolean (d_diff.days_count = 305)

				-- Iterate for `l_days' days (i.e. we will have at least a leap year
				-- in the process) and for each date, add between 1 to 750 days
				-- (i.e. at leat 2 years) to ensure that duration is properly computed.
			from
				i := 1
				create d1.make (2000, 1, 1)
			until
				i = l_days
			loop
				from
					j := 1
				until
					j = 750
				loop
					d2 := d1.twin
					d2.day_add (j)
					dur := d2.relative_duration (d1)
					test_true_boolean (dur.days_count = j)
					j := j + 1
				end
				d1.day_add (1)
				i := i + 1
			end

				-- Iterate for `l_days' days (i.e. we will have at least a leap year
				-- in the process) and for each date, add between 1 to 750 days
				-- (i.e. at leat 2 years) to ensure that duration is properly computed.
			from
				i := 1
				create d1.make (2000, 1, 1)
			until
				i = l_days
			loop
				from
					j := -1
				until
					j = -750
				loop
					d2 := d1.twin
					d2.day_add (j)
					dur := d2.relative_duration (d1)
					test_true_boolean (dur.days_count = j)
					j := j - 1
				end
				d1.day_add (-1)
				i := i + 1
			end
		end

	test_time004
		local
			d: DATE
			days: INTEGER
			i: INTEGER
		do
				-- Check lower bound of `make_by_days'.
			create d.make (1, 1, 1)
			days := - d.origin.days_from (0)
			create d.make_by_days (days)
			test_true_boolean (d.days = days)

			from
				i := 0
			until
				i > 63935
			loop
				days := i * 365
				create d.make_by_days (days)
				test_true_boolean (d.days = days)
				i := i + 1
			end
		end

	test_time005
		local
			d: DATE
		do
			create d.make_by_days ({INTEGER}.min_value)
		end

feature {NONE} -- Implementation

	test_true_boolean (v: BOOLEAN)
		do
			assert ("Expect True", v)
		end

	expect_output (s: READABLE_STRING_8; o: READABLE_STRING_8)
		do
			assert ("Expect " + s, o.same_string (s))
		end

	expect_boolean (b: BOOLEAN; v: BOOLEAN)
		do
			assert ("Expect " + b.out, v = b)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
