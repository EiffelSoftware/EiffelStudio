note
	description: "Wrapper of SYSTEMTIME structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make,
	make_by_pointer,
	make_by_current_time

feature -- Initialization

	make_by_current_time
			-- Create SYSTEMTIME structure and initialize it to current time.
		do
			make
			cwel_get_system_time (item)
		end

feature -- Access

	year: INTEGER
			-- Year
		do
			Result := cwel_system_time_year (item)
		end

	month: INTEGER
			-- Month
		do
			Result := cwel_system_time_month (item)
		end

	day_of_week: INTEGER
			-- Day of week
		do
			Result := cwel_system_time_day_of_week (item)
		end

	day: INTEGER
			-- Day
		do
			Result := cwel_system_time_day (item)
		end

	hour: INTEGER
			-- Hour
		do
			Result := cwel_system_time_hour (item)
		end

	minute: INTEGER
			-- Minute
		do
			Result := cwel_system_time_minute (item)
		end

	second: INTEGER
			-- Second
		do
			Result := cwel_system_time_second (item)
		end

	milliseconds: INTEGER
			-- Milliseconds
		do
			Result := cwel_system_time_milliseconds (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of SYSTEMTIME structure
		do
			Result := c_size_of_system_time
		end


feature -- Conversion

	file_time: WEL_FILE_TIME
			-- SYSTEMTIME in FILETIME format
		do
			create Result.make
			cwel_system_time_to_file_time (item, Result.item)
		end

feature {NONE} -- Externals

	c_size_of_system_time: INTEGER
		external
			"C [macro %"wel_time.h%"]"
		alias
			"sizeof(SYSTEMTIME)"
		end

	cwel_system_time_to_file_time (st, ft: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_get_system_time (st: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_year (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_month (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_day_of_week (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_day (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_hour (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_minute (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_second (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_system_time_milliseconds (st: POINTER): INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
