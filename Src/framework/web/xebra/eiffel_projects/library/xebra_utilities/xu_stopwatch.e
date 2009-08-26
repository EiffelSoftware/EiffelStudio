note
	description: "[
		Descendants of this class can start and stop time
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XU_STOPWATCH

feature -- Access

	last_elapsed_time: STRING
			-- The elapsed time between star_time and stop_time
		attribute
				create Result.make_empty
		end
		
feature {NONE} -- Access

	internal_start_time: NATURAL

feature -- Status Setting

	start_time
			-- Starts the stopwatch
		local
			l_time: XU_DATE
		do
			create l_time
			internal_start_time := l_time.time_stamp_milliseconds
		end

	stop_time
			-- Stops the stopwatch
		local
			l_time: XU_DATE
		do
			create l_time
			last_elapsed_time := (l_time.time_stamp_milliseconds - internal_start_time).out + "ms"
		end

end

