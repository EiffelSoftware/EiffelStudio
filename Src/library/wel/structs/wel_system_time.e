indexing
	description: "Wrapper of SYSTEMTIME structure"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_TIME

inherit
	WEL_STRUCTURE
		export
			{NONE} set_item
		end

creation
	make,
	make_by_pointer,
	make_by_current_time

feature -- Initialization

	make_by_current_time is
			-- Create SYSTEMTIME structure and initialize it to current time.
		do
			make
			cwel_get_system_time (item)
		end

feature -- Access

	year: INTEGER is
			-- Year
		do
			Result := cwel_system_time_year (item)
		end

	month: INTEGER is
			-- Month
		do
			Result := cwel_system_time_month (item)
		end

	day_of_week: INTEGER is
			-- Day of week
		do
			Result := cwel_system_time_day_of_week (item)
		end

	day: INTEGER is
			-- Day
		do
			Result := cwel_system_time_day (item)
		end

	hour: INTEGER is
			-- Hour
		do
			Result := cwel_system_time_hour (item)
		end

	minute: INTEGER is
			-- Minute
		do
			Result := cwel_system_time_minute (item)
		end

	second: INTEGER is
			-- Second
		do
			Result := cwel_system_time_second (item)
		end

	milliseconds: INTEGER is
			-- Milliseconds
		do
			Result := cwel_system_time_milliseconds (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of SYSTEMTIME structure
		do
			Result := c_size_of_system_time
		end


feature -- Conversion

	file_time: WEL_FILE_TIME is
			-- SYSTEMTIME in FILETIME format
		do
			create Result.make
			cwel_system_time_to_file_time (item, Result.item)
		end

feature {NONE} -- Externals

	c_size_of_system_time: INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		alias
			"sizeof(SYSTEMTIME)"
		end

	cwel_system_time_to_file_time (st, ft: POINTER) is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_get_system_time (st: POINTER) is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_year (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_month (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_day_of_week (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_day (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_hour (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_minute (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_second (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_milliseconds (st: POINTER): INTEGER is
		external
			"C [macro %"wel_time.h%"]"
		end

end -- class WEL_SYSTEM_TIME
