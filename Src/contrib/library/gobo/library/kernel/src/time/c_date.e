note
	description: "Representation of a date at C level"
	date: "$Date$"
	revision: "$Revision$"

class
	C_DATE

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_utc

feature {NONE} -- Initialization

	default_create
			-- Create an instance of C_DATA using current local time.
		do
			is_utc := False
			update
		end

	make_utc
			-- Create an instance of C_DATE holding UTC values.
		do
			is_utc := True
			update
		ensure
			is_utc: is_utc
		end

feature -- Access

	is_utc: BOOLEAN
			-- Is Current holding value in UTC format?

feature -- Update

	update
			-- Pointer to `struct tm' area.
		local
			l_timeb, l_tm, l_time: POINTER
			l_milli: INTEGER
		do
			l_timeb := l_timeb.memory_alloc (timeb_structure_size)
			l_time := l_time.memory_alloc (time_t_structure_size)
			ftime (l_timeb)
			get_time (l_timeb, l_time)
			if is_utc then
				l_tm := gmtime (l_time)
			else
				l_tm := localtime (l_time)
			end
			create internal_item.make_from_pointer (l_tm, tm_structure_size)

			l_milli := get_millitm (l_timeb)
			if l_milli < 0 or l_milli > 999 then
				millisecond_now := 0
			else
				millisecond_now := l_milli
			end

			l_timeb.memory_free
			l_time.memory_free
		end

feature -- Status

	year_now: INTEGER
			-- Current year at creation time or after last call to `update'.
		do
			Result := 1900 + get_tm_year (internal_item.item)
		ensure
			year_valid: Result >= 1900
		end

	month_now: INTEGER
			-- Current month at creation time or after last call to `update'.
		do
			Result := get_tm_mon (internal_item.item) + 1
		ensure
			month_valid: Result >= 1 and Result <= 12
		end

	day_now: INTEGER
			-- Current day at creation time or after last call to `update'.
		do
			Result := get_tm_mday (internal_item.item)
		ensure
			day_valid: Result >= 1 and Result <= 31
		end

	hour_now: INTEGER
			-- Current hour at creation time or after last call to `update'.
		do
			Result := get_tm_hour (internal_item.item)
		ensure
			hour_valid: Result >= 0 and Result <= 23
		end

	minute_now: INTEGER
			-- Current minute at creation time or after last call to `update'.
		do
			Result := get_tm_min (internal_item.item)
		ensure
			minute_valid: Result >= 0 and Result <= 59
		end

	second_now: INTEGER
			-- Current second at creation time or after last call to `update'.
		do
			Result := get_tm_sec (internal_item.item)
			if Result > 59 then
					-- Some platform returns up to 61 for leap seconds.
				Result := 59
			end
		ensure
			second_valid: Result >= 0 and Result <= 59
		end

	millisecond_now: INTEGER
			-- Current millisecond at creation time or after last call to `update'.

feature {NONE} -- Externals

	ftime (p: POINTER)
			-- Set current date and time in `p', pointer to a `struct timeb' area.
		external
			"C inline use %"ge_time.h%""
		alias
			"GE_ftime($p);"
		end

feature {NONE} -- `struct timeb' encapsulation

	timeb_structure_size: INTEGER
			-- Size of `struct timeb'.
		external
			"C inline use %"ge_time.h%""
		alias
			"return GE_timebsz;"
		end

	get_millitm (p: POINTER): INTEGER
			-- Get `p->millitm'.
		external
			"C inline use %"ge_time.h%""
		alias
			"return GE_timebmillitm($p);"
		end

	get_time (p, t: POINTER)
			-- Get `p->time'.
		external
			"C inline use %"ge_time.h%", <time.h>"
		alias
			"*(time_t *) $t = GE_timebtime($p);"
		end

feature {NONE} -- `struct tm' encapsulation

	internal_item: MANAGED_POINTER
			-- Pointer to `struct tm' area.

	tm_structure_size: INTEGER
			-- Size of `struct tm'.
		external
			"C inline use <time.h>"
		alias
			"return sizeof(struct tm);"
		end

	time_t_structure_size: INTEGER
			-- Size of `struct time_t'.
		external
			"C inline use <time.h>"
		alias
			"return sizeof(time_t);"
		end

	localtime (t: POINTER): POINTER
			-- Pointer to `struct tm' area.
		external
			"C inline use <time.h>"
		alias
			"return localtime((time_t *) $t);"
		end

	gmtime (t: POINTER): POINTER
			-- Pointer to `struct tm' area in UTC.
		external
			"C inline use <time.h>"
		alias
			"return gmtime((time_t *) $t);"
		end

	get_tm_year (p: POINTER): INTEGER
			-- Get `p->tm_year', number of years since 1900.
		external
			"C inline use <time.h>"
		alias
			"return ((struct tm *) $p)->tm_year;"
		end

	get_tm_mon (p: POINTER): INTEGER
			-- Get `p->tm_mon'.
		external
			"C inline use <time.h>"
		alias
			"return ((struct tm *) $p)->tm_mon;"
		end

	get_tm_mday (p: POINTER): INTEGER
			-- Get `p->tm_mday'.
		external
			"C inline use <time.h>"
		alias
			"return ((struct tm *) $p)->tm_mday;"
		end

	get_tm_hour (p: POINTER): INTEGER
			-- Get `p->tm_hour'.
		external
			"C inline use <time.h>"
		alias
			"return ((struct tm *) $p)->tm_hour;"
		end

	get_tm_min (p: POINTER): INTEGER
			-- Get `p->tm_min'.
		external
			"C inline use <time.h>"
		alias
			"return ((struct tm *) $p)->tm_min;"
		end

	get_tm_sec (p: POINTER): INTEGER
			-- Get `p->tm_sec'.
		external
			"C inline use <time.h>"
		alias
			"return ((struct tm *) $p)->tm_sec;"
		end

end
