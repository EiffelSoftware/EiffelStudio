indexing
	description: "Objects that retrieve the system time"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_TIME

create
	make_by_current_time

feature -- Initialization

	make_by_current_time is
			-- Retrieve the system time and initialize `Current' accordingly.
		local
			null_p: POINTER
			raw_time: INTEGER
			tmp_time: POINTER
		do
			raw_time := raw_system_time (null_p)
			tmp_time := raw_to_local_time ($raw_time)
			year := get_year (tmp_time) + 1900
			month := get_month (tmp_time) + 1
			day := get_day (tmp_time)
			hour := get_hour (tmp_time)
			minute := get_minute (tmp_time)
			second := get_second (tmp_time)
		end

feature -- Access

	year: INTEGER

	month: INTEGER

	day: INTEGER
			-- Day of the month (1-31).

	hour: INTEGER

	minute: INTEGER

	second: INTEGER

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	raw_system_time (null_p: POINTER): INTEGER is
			-- Retrieve the current system time (time_t*).
			-- `null_p' should be the NULL pointer or a time_t* structure.
		external
			"C (time_t*): time_t | </usr/include/time.h>"
		alias
			"time"
		end

	raw_to_local_time (raw: POINTER): POINTER is
			-- Convert a raw time to a local time representation.
		external
			"C (time_t*): struct tm* | </usr/include/time.h>"
		alias
			"localtime"
		end

	parse_raw_time (raw_time: POINTER): POINTER is
			-- Convert a raw time_t structure into a C string (char*).
			-- The format of the C string is "Day Mon dd hh:mm:ss yyyy\n".
		external
			"C (struct tm*): char* | </usr/include/time.h>"
		alias
			"asctime"
		end

	get_year (sttime: POINTER): INTEGER is
			-- Extract the year value from a struct tm*.
		external
			"C [struct <time.h>] (struct tm): int"
		alias
			"tm_year"
		end

	get_month (sttime: POINTER): INTEGER is
			-- Extract the year value from a struct tm*.
		external
			"C [struct <time.h>] (struct tm): int"
		alias
			"tm_mon"
		end

	get_day (sttime: POINTER): INTEGER is
			-- Extract the year value from a struct tm*.
		external
			"C [struct <time.h>] (struct tm): int"
		alias
			"tm_mday"
		end

	get_hour (sttime: POINTER): INTEGER is
			-- Extract the year value from a struct tm*.
		external
			"C [struct <time.h>] (struct tm): int"
		alias
			"tm_hour"
		end

	get_minute (sttime: POINTER): INTEGER is
			-- Extract the year value from a struct tm*.
		external
			"C [struct <time.h>] (struct tm): int"
		alias
			"tm_min"
		end

	get_second (sttime: POINTER): INTEGER is
			-- Extract the year value from a struct tm*.
		external
			"C [struct <time.h>] (struct tm): int"
		alias
			"tm_sec"
		end

invariant
	invariant_clause: -- Your invariant here

end -- class WEL_SYSTEM_TIME
