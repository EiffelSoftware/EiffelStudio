indexing
	description: "Compute time stamps"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_TIME

feature -- Access

	time (p: POINTER): INTEGER is
			-- Return current time in seconds since January 1st 1970 00:00:00.
		external
			"C macro signature (time_t *): EIF_INTEGER use <time.h>"
		end
		
end -- class CLI_TIME
