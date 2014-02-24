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

	make
		do
			thr_make
			launch
		end

	execute
		local
			dt1, dt2: DATE_TIME
			i, j: INTEGER_64
		do
			create dt1.make_now_utc
			create dt2.make_now_utc

			from
				i := 1
			until
				i > 100_000_000
			loop
				j := dt2.relative_duration (dt1).seconds_count
				i := i + 1
			end
		end
end
