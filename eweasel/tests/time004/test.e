class
	TEST

create
	make

feature

	make is
		local
			d: DATE
			days: INTEGER
			i: INTEGER
		do
				-- Check lower bound of `make_by_days'.
			create d.make (1, 1, 1)
			days := - d.origin.days_from (0)
			create d.make_by_days (days)
			assert (d.days = days)

			from
				i := 0
			until
				i > 63935
			loop
				days := i * 365
				create d.make_by_days (days)
				assert (d.days = days)
				i := i + 1
			end
		end

	assert (b: BOOLEAN)
		do
			if not b then
				io.put_string ("Not OK!%N")
			end
		end

end
