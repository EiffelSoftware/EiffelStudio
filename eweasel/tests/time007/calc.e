class
	CALC

inherit
	THREAD
		rename
			make as thr_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_is_local: BOOLEAN)
		do
			is_local := a_is_local
			thr_make
			launch
		end

	is_local: BOOLEAN

	execute
		local
			dt1, dt2: C_DATE
			i: INTEGER_64
			min1, min2: NATURAL_64
		do
			if is_local then
				create dt1
			else
				create dt1.make_utc
			end
			min1 := minute_count (dt1)

			from
				i := 1
			until
				i > 100_000_000
			loop
				if is_local then
					create dt2
				else
					create dt2.make_utc
				end
				min2 := minute_count (dt2)
				if min2 - min1 > 1 then
					io.put_string ("A " + (min2 - min1).out + " minute(s) delay between 2 calls, very unlikely%N")
				else
					min1 := min2
				end
			end
		end

	minute_count (a_date: C_DATE): NATURAL_64
		do
			Result := a_date.year_now.to_natural_64 * 365 * 24 * 60 +
				a_date.month_now.to_natural_64 * 30 * 24 * 60 +
				a_date.day_now.to_natural_64 * 24 * 60 +
				a_date.hour_now.to_natural_64 * 60 +
				a_date.minute_now.to_natural_64
		end

end
