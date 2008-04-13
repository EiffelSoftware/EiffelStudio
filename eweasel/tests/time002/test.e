class
	TEST

create
	make

feature

	make is
		local
			d1: DATE
			d2: DATE
			d_diff: DATE_DURATION
			dur: DATE_DURATION
			i, j: INTEGER
		do
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

				-- Iterate for 2000 days (i.e. we will have at least a leap year
				-- in the process) and for each date, add between 1 to 750 days
				-- (i.e. at leat 2 years) to ensure that duration is properly computed.
			from
				i := 1
				create d1.make (2000, 1, 1)
			until
				i = 2000
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

				-- Iterate for 2000 days (i.e. we will have at least a leap year
				-- in the process) and for each date, add between 1 to 750 days
				-- (i.e. at leat 2 years) to ensure that duration is properly computed.
			from
				i := 1
				create d1.make (2000, 1, 1)
			until
				i = 2000
			loop
				from
					j := 1
				until
					j = 750
				loop
					d2 := d1.twin
					d2.day_add (-j)
					dur := d2.relative_duration (d1)
					test_true_boolean (dur.days_count = j)
					j := j + 1
				end
				d1.day_add (-1)
				i := i + 1
			end
		end

	test_true_boolean (v: BOOLEAN) is
		do
			if not v then
				print ("Failure%N")
			end
		end

end
