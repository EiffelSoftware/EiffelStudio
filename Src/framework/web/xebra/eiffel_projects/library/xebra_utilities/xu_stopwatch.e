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

feature {NONE} -- Implementation

	the_start_time: NATURAL

	start_time
			-- Starts the stopwatch
		local
			l_time: XU_DATE
		do
			create l_time
			the_start_time := l_time.time_stamp_milliseconds
		end

	stop_time: STRING
			-- Stops the stopwatch and returns the elapsed time
		local
			l_time: XU_DATE
		do
			create l_time
			Result := (l_time.time_stamp_milliseconds - the_start_time).out + "ms"

		end

end

