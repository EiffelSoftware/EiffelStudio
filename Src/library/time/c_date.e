indexing
	description: "Representation of a date at C level"
	date: "$Date$"
	revision: "$Revision$"

class
	C_DATE

feature -- Status

	year_now: INTEGER is
			-- Current year.
		do
			Result := 1900 + get_tm_year (tm_item)
		ensure
			year_valid: Result >= 1900
		end

	month_now: INTEGER is
			-- Current month.
		do
			Result := get_tm_mon (tm_item)
		ensure
			month_valid: Result >= 0 and Result <= 11
		end
		
	day_now: INTEGER is
			-- Current day.
		do
			Result := get_tm_mday (tm_item)
		ensure
			day_valid: Result >= 1 and Result <= 31
		end
		
	hour_now: INTEGER is
			-- Current hour.
		do
			Result := get_tm_hour (tm_item)
		ensure
			hour_valid: Result >= 0 and Result <= 23
		end
		
	minute_now: INTEGER is
			-- Current hour.
		do
			Result := get_tm_min (tm_item)
		ensure
			minute_valid: Result >= 0 and Result <= 59
		end
		
	second_now: INTEGER is
			-- Current hour.
		do
			Result := get_tm_sec (tm_item)
			if Result > 59 then
					-- Some platform returns up to 61 for leap seconds.
				Result := 59
			end
		ensure
			second_valid: Result >= 0 and Result <= 59
		end
		
	millisecond_now: INTEGER is
			-- Current millisecond.
		local
			p: POINTER
		do
			p := p.memory_alloc (timeb_structure_size)
			ftime (p)
			Result := get_millitm (p)
			p.memory_free
			
			if Result < 0 or Result > 999 then
				Result := 0
			end
		ensure
			millisecond_valid: Result >= 0 and Result <= 999
		end
		
feature {NONE} -- Externals

	time (p: POINTER): INTEGER is
			-- Number of seconds since January 1, 1970.
		external
			"C macro signature (time_t *): EIF_INTEGER use <time.h>"
		alias
			"time"
		end
		
	ftime (p: POINTER) is
			-- Set current date and time in `p', pointer to a `struct timeb' area.
		external
			"C macro signature (struct timeb*) use <sys/timeb.h>"
		end

feature {NONE} -- `struct timeb' encapsulation
		
	timeb_structure_size: INTEGER is
			-- Size of `struct timeb'.
		external
			"C macro use <sys/timeb.h>"
		alias
			"sizeof(struct timeb)"
		end
		
	get_millitm (p: POINTER): INTEGER is
			-- Get `p->millitm'.
		external
			"C struct struct timeb access millitm use <sys/timeb.h>"
		end
		
feature {NONE} -- `struct tm' encapsulation

	tm_item: POINTER is
			-- Pointer to `struct tm' area.
		local
			p: POINTER
			l_time: INTEGER
		do
			l_time := time (p)
			Result := localtime ($l_time)
		end
		
	localtime (i: POINTER): POINTER is
			-- Pointer to `struct tm' area.
		external
			"C macro signature (time_t *): EIF_POINTER use <time.h>"
		alias
			"localtime"
		end
		
	get_tm_year (p: POINTER): INTEGER is
			-- Get `p->tm_year', number of years since 1900.
		external
			"C struct struct tm access tm_year use <time.h>"
		end

	get_tm_mon (p: POINTER): INTEGER is
			-- Get `p->tm_mon'.
		external
			"C struct struct tm access tm_mon use <time.h>"
		end
		
	get_tm_mday (p: POINTER): INTEGER is
			-- Get `p->tm_mday'.
		external
			"C struct struct tm access tm_mday use <time.h>"
		end

	get_tm_hour (p: POINTER): INTEGER is
			-- Get `p->tm_hour'.
		external
			"C struct struct tm access tm_hour use <time.h>"
		end
	
	get_tm_min (p: POINTER): INTEGER is
			-- Get `p->tm_min'.
		external
			"C struct struct tm access tm_min use <time.h>"
		end
	
	get_tm_sec (p: POINTER): INTEGER is
			-- Get `p->tm_sec'.
		external
			"C struct struct tm access tm_sec use <time.h>"
		end	
		
end -- class C_DATE
