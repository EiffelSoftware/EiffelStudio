indexing

	description:

		"Objects that meassure time"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_TIMER

inherit

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

create
	make


feature {NONE} -- Initialization

	make is
			-- Create new timer.
		do
		end

feature -- Status report

	is_running: BOOLEAN is
			-- Is timer currently running?
		do
			Result := start_time /= Void
		end

	last_duration: DT_DATE_TIME_DURATION


feature -- Timing

	start is
			-- Start timer.
		do
			start_time := system_clock.date_time_now
		end

	calculate_duration is
			-- Calculate duration since `start_time' and now.
		require
			running: is_running
		local
			time_now: DT_DATE_TIME
		do
			time_now := system_clock.date_time_now
			last_duration := time_now.duration (start_time)
			last_duration.set_time_canonical
		ensure
			last_duration_set: last_duration /= Void
		end

feature -- Implementation

	start_time: DT_DATE_TIME

end
