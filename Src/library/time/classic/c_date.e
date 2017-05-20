note
	description: "Representation of a date at C level"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_timeval, l_tm, l_time: POINTER
			l_micro: INTEGER
		do
			l_timeval := l_timeval.memory_alloc (timeval_structure_size)
			l_time := l_time.memory_alloc (time_t_structure_size)
			gettimeofday (l_timeval)
			get_time (l_timeval, l_time)
			if is_utc then
				l_tm := gmtime (l_time)
			else
				l_tm := localtime (l_time)
			end
			create internal_item.make_from_pointer (l_tm, tm_structure_size)

			l_micro := get_micro (l_timeval)
			if l_micro < 0 or l_micro > 999999 then
				microseconds_now := 0
			else
				microseconds_now := l_micro
			end

			l_time.memory_free
			l_timeval.memory_free
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
		do
			Result := microseconds_now // 1000
		end

	microseconds_now: INTEGER
			-- Current microseconds (includes milliseconds)

feature {NONE} -- Externals

	gettimeofday (p: POINTER)
			-- Set current date and time in `p', pointer to a `struct timeval' area.
		external
			"C inline use %"eif_time.h%""
		alias
			"[
			#ifdef EIF_WINDOWS
    			static const uint64_t EPOCH = ((uint64_t) 116444736000000000ULL);

				SYSTEMTIME  system_time;
				FILETIME    file_time;
				uint64_t    time;
				struct timeval *tp = (struct timeval *) $p;

				GetSystemTime (&system_time );
				SystemTimeToFileTime (&system_time, &file_time );
				time = ((uint64_t) file_time.dwLowDateTime );
				time += ((uint64_t) file_time.dwHighDateTime) << 32;

				tp->tv_sec  = (long) ((time - EPOCH) / 10000000L);
				tp->tv_usec = (long) (system_time.wMilliseconds * 1000);
			#else
				gettimeofday((struct timeval *) $p, NULL);
			#endif
			]"
		end

feature {NONE} -- `struct timeval' encapsulation

	timeval_structure_size: INTEGER
			-- Size of `struct timeval'.
		external
			"C macro use %"eif_time.h%""
		alias
			"sizeof(struct timeval)"
		end

	time_t_structure_size: INTEGER
			-- Size of `struct time'.
		external
			"C macro use <time.h>"
		alias
			"sizeof(time_t)"
		end

	tm_structure_size: INTEGER
			-- Size of `struct tm'.
		external
			"C macro use <time.h>"
		alias
			"sizeof(struct tm)"
		end

	get_time (p, t: POINTER)
			-- Get `p->tv_sec'.
		external
			"C inline use <time.h>"
		alias
			"*(time_t *) $t = (((struct timeval *)$p)->tv_sec);"
		end

	get_micro (p: POINTER): INTEGER
			-- get `p->tv_usec' (which has to be an integer type -1 to 1000000 according to POSIX)
		external
			"C struct struct timeval access tv_usec use <time.h>"
		end

feature {NONE} -- `struct tm' encapsulation

	internal_item: MANAGED_POINTER
			-- Pointer to `struct tm' area.

	localtime (t: POINTER): POINTER
			-- Pointer to `struct tm' area.
		external
			"C inline use <time.h>"
		alias
			"localtime ((time_t *) $t)"
		end

	gmtime (t: POINTER): POINTER
			-- Pointer to `struct tm' area in UTC.
		external
			"C inline use <time.h>"
		alias
			"gmtime ((time_t *) $t)"
		end

	get_tm_year (p: POINTER): INTEGER
			-- Get `p->tm_year', number of years since 1900.
		external
			"C struct struct tm access tm_year use <time.h>"
		end

	get_tm_mon (p: POINTER): INTEGER
			-- Get `p->tm_mon'.
		external
			"C struct struct tm access tm_mon use <time.h>"
		end

	get_tm_mday (p: POINTER): INTEGER
			-- Get `p->tm_mday'.
		external
			"C struct struct tm access tm_mday use <time.h>"
		end

	get_tm_hour (p: POINTER): INTEGER
			-- Get `p->tm_hour'.
		external
			"C struct struct tm access tm_hour use <time.h>"
		end

	get_tm_min (p: POINTER): INTEGER
			-- Get `p->tm_min'.
		external
			"C struct struct tm access tm_min use <time.h>"
		end

	get_tm_sec (p: POINTER): INTEGER
			-- Get `p->tm_sec'.
		external
			"C struct struct tm access tm_sec use <time.h>"
		end


note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class C_DATE
