note
	description: "[
				Summary description for {HTTP_DATE}.
				
				
			       HTTP-date    = rfc1123-date | rfc850-date | asctime-date
			       rfc1123-date = wkday "," SP date1 SP time SP "GMT"
			       rfc850-date  = weekday "," SP date2 SP time SP "GMT"
			       asctime-date = wkday SP date3 SP time SP 4DIGIT
			       date1        = 2DIGIT SP month SP 4DIGIT
			                      ; day month year (e.g., 02 Jun 1982)
			       date2        = 2DIGIT "-" month "-" 2DIGIT
			                      ; day-month-year (e.g., 02-Jun-82)
			       date3        = month SP ( 2DIGIT | ( SP 1DIGIT ))
			                      ; month day (e.g., Jun  2)
			       time         = 2DIGIT ":" 2DIGIT ":" 2DIGIT
			                      ; 00:00:00 - 23:59:59
			       wkday        = "Mon" | "Tue" | "Wed"
			                    | "Thu" | "Fri" | "Sat" | "Sun"
			       weekday      = "Monday" | "Tuesday" | "Wednesday"
			                    | "Thursday" | "Friday" | "Saturday" | "Sunday"
			       month        = "Jan" | "Feb" | "Mar" | "Apr"
			                    | "May" | "Jun" | "Jul" | "Aug"
			                    | "Sep" | "Oct" | "Nov" | "Dec"
			                    
			 Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
			 Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
			 Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format

			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RFC2616", "protocol=URI", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html"

class
	HTTP_DATE

inherit
	DEBUG_OUTPUT

create
	make_now_utc,
	make_from_timestamp,
	make_from_string,
	make_from_rfc3339_string,
	make_from_date_time

feature {NONE} -- Initialization

	make_from_timestamp (n: INTEGER_64)
			-- Build from unix timestamp `n'
		do
			internal_timestamp := n
				--| FIXME: find workaround when `n' is not INTEGER_32
			create date_time.make_from_epoch (n.as_integer_32)
		end

	make_from_string (s: READABLE_STRING_GENERAL)
			-- Create from string representation `s'
			-- Supports: RFC 1123 and RFC 850
			-- Tolerant with: GMT+offset and GMT-offset
			--| Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
			--| Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
		do
			if attached string_to_date_time (s) as dt then
				date_time := dt
			elseif attached ansi_c_string_to_date_time (s) as dt then
				date_time := dt
			elseif attached rfc3339_string_to_date_time (s) as dt then
				date_time := dt
			else
				has_error := True
				date_time := epoch
			end
		end

	make_from_rfc3339_string (s: READABLE_STRING_GENERAL)
		do
			if attached rfc3339_string_to_date_time (s) as dt then
				date_time := dt
			else
				has_error := True
				date_time := epoch
			end
		end

	make_from_date_time (dt: DATE_TIME)
			-- Build from date `dt'
		do
			date_time := dt
		end

	make_now_utc
			-- Build from current utc date time.
		do
			create date_time.make_now_utc
		end

feature -- Access

	has_error: BOOLEAN
			-- Error occurred during creation with `make_from_string'?

	date_time: DATE_TIME
			-- Associated Date time.

	string: STRING
			-- String representation recommended for HTTP date.
			--| Sun, 06 Nov 1994 08:49:37 GMT			
		do
			Result := rfc1123_string
		end

	timestamp: INTEGER_64
			-- Unix timestamp.
		do
			Result := internal_timestamp
			if Result = 0 then
				Result := date_time.definite_duration (epoch).seconds_count
				internal_timestamp := Result
			end
		end

feature {NONE} -- Internal

	epoch: DATE_TIME
		once ("THREAD")
			create Result.make_from_epoch (0)
		end

	internal_timestamp: like timestamp

	internal_rfc1123_string: detachable STRING

feature -- Conversion to string

	yyyy_mmm_dd_string: STRING
			-- String representation [YYYY mmm dd]
			-- ex: 2012 Dec 25
		do
			create Result.make (11)
			append_date_time_to_yyyy_mmm_dd_string (date_time, Result)
		end

	rfc1123_string: STRING
			-- String representation following RFC 1123.
			-- format: [ddd, dd mmm yyyy hh:mi:ss GMT]
			-- ex: Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
		local
			s: like internal_rfc1123_string
		do
			s := internal_rfc1123_string
			if s = Void then
				create s.make (32)
				append_date_time_to_rfc1123_string (date_time, s)
				internal_rfc1123_string := s
			end
			Result := s
		end

	rfc850_string: STRING
			-- String representation following RFC 850.
			-- format: [mmm, dd-mmm-yy hh:mi:ss GMT]
		do
			create Result.make (32)
			append_date_time_to_rfc850_string (date_time, Result)
		end

	iso8601_string,
	rfc3339_string: STRING
			-- String representation following RFC 3339.
			-- format: [yyyy-mm-ddThh:mi:ssZ]
			-- https://www.rfc-editor.org/rfc/rfc3339.txt
			-- note: RFC 3339 is a profile of ISO 8601.
			-- https://en.wikipedia.org/wiki/ISO_8601
		do
			create Result.make (25)
			append_date_time_to_rfc3339_string (date_time, Result)
		end

	ansi_c_string: STRING
			-- ANSI C's asctime() format	
			--| Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format
		do
			create Result.make (32)
			append_date_time_to_ansi_c_string (date_time, Result)
		end

feature -- Conversion into string		

	append_to_yyyy_mmm_dd_string (s: STRING_GENERAL)
			-- Append `datetime' as [yyyy mmm dd] format to `s'.
		do
			append_date_time_to_yyyy_mmm_dd_string (date_time, s)
		end

	append_to_rfc1123_string (s: STRING_GENERAL)
			-- Append `date_time' as [ddd, dd mmm yyyy hh:mi:ss GMT] format to `s'.
		do
			append_date_time_to_rfc1123_string (date_time, s)
		end

	append_rfc850_string (s: STRING_GENERAL)
			-- Append `date_time' as [mmm, dd-mmm-yy hh:mi:ss GMT] format to `s'.
		do
			append_date_time_to_rfc850_string (date_time, s)
		end

	append_to_ansi_c_string (s: STRING_GENERAL)
			-- Append `date_time' as ANSI C's asctime format to `s'.
			--| Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format
		do
			append_date_time_to_ansi_c_string (date_time, s)
		end

feature -- Conversion into string

	append_date_time_to_yyyy_mmm_dd_string (dt: DATE_TIME; s: STRING_GENERAL)
			-- Append `dt' as [yyyy mmm dd] format to `s'.
		do
			append_integer_to (dt.year, s)					-- yyyy
			s.append_code (32) -- 32 ' '					-- SPace
			append_month_mmm_to (dt.month, s)				-- mmm
			s.append_code (32) -- 32 ' '					-- SPace
			append_2_digits_integer_to (dt.day, s)			-- dd
		end

	append_date_time_to_rfc1123_string (dt: DATE_TIME; s: STRING_GENERAL)
			-- Append `dt' as [ddd, dd mmm yyyy hh:mi:ss GMT] format to `s'.
		do
			append_day_ddd_to (dt.date.day_of_the_week, s)	-- ddd
			s.append_code (44) -- 44 ','					-- ','
			s.append_code (32) -- 32 ' '					-- SPace
			append_2_digits_integer_to (dt.day, s)			-- dd
			s.append_code (32) -- 32 ' '					-- SPace
			append_month_mmm_to (dt.month, s)				-- mmm
			s.append_code (32) -- 32 ' '					-- SPace
			append_integer_to (dt.year, s)					-- yyyy
			s.append_code (32) -- 32 ' '					-- SPace
			append_2_digits_time_to (dt.time, s)			-- hh:mi:ss
			s.append (" GMT")								-- SPace + GMT
		end

	append_date_time_to_rfc850_string (dt: DATE_TIME; s: STRING_GENERAL)
			-- Append `dt' as [mmm, dd-mmm-yy hh:mi:ss GMT] format to `s'.
		do
			append_day_name_to (dt.date.day_of_the_week, s)	-- mmm
			s.append_code (44) -- 44 ','					-- ','
			s.append_code (32) -- 32 ' '					-- SPace
			append_2_digits_integer_to (dt.day, s)			-- dd
			s.append_code (45) -- 45 '-'					-- '-'
			append_month_mmm_to (dt.month, s)				-- mmm
			s.append_code (45) -- 45 '-'					-- '-'
			append_integer_to (dt.year \\ 100, s)			-- yy
			s.append_code (32) -- 32 ' '					-- SPace
			append_2_digits_time_to (dt.time, s)			-- hh:mi:ss
			s.append (" GMT")								-- SPace + GMT
		end

	append_date_time_to_iso8601_string,
	append_date_time_to_rfc3339_string (dt: DATE_TIME; s: STRING_GENERAL)
			-- Append `dt' as [yyyy-mm-ddThh:mi:ssZ] format to `s'.
		do
			append_integer_to (dt.year, s)					-- yyyy
			s.append_code (45) -- 45 '-'					-- '-'
			append_2_digits_integer_to (dt.month, s)		-- mm
			s.append_code (45) -- 45 '-'					-- '-'
			append_2_digits_integer_to (dt.day, s)			-- dd
			s.append_code (84) -- 84 'T'					-- 'T'
			append_2_digits_fine_time_to (dt.time, s)			-- hh:mi:ss
			s.append ("Z")									-- Z
		end

	append_date_time_to_ansi_c_string (dt: DATE_TIME; s: STRING_GENERAL)
			-- Append `dt' as ANSI C's asctime format to `s'.
			-- Sun Nov  6 08:49:37 1994    ; ANSI C's asctime() format
		do
			append_day_ddd_to (dt.date.day_of_the_week, s)	-- ddd
			s.append_code (32) -- 32 ' '					-- SPace
			append_month_mmm_to (dt.month, s)				-- mmm
			s.append_code (32) -- 32 ' '					-- SPace
			s.append_code (32) -- 32 ' '					-- SPace
			append_integer_to (dt.day, s)					-- d
			s.append_code (32) -- 32 ' '					-- SPace
			append_2_digits_time_to (dt.time, s) 			-- hh:mi:ss
			s.append_code (32) -- 32 ' '					-- SPace
			append_integer_to (dt.year, s)					-- yyyy
		end

feature -- Status report

	debug_output: STRING
		do
			if attached internal_rfc1123_string as st then
				Result := st.string
			else
				create Result.make (32)
				append_date_time_to_rfc1123_string (date_time, Result)
			end
		end

feature -- Helper routines.

	append_2_digits_integer_to (i: INTEGER; s: STRING_GENERAL)
		require
			is_not_negative: i >= 0
		do
			if i <= 9 then
				s.append_code (48) -- 48 '0'
			end
			append_integer_to (i, s)
		end

	append_2_digits_time_to (t: TIME; s: STRING_GENERAL)
		do
			append_2_digits_integer_to (t.hour, s)		-- hh
			s.append_code (58) -- 58 ':'				-- :
			append_2_digits_integer_to (t.minute, s)	-- mi
			s.append_code (58) -- 58 ':'				-- :
			append_2_digits_integer_to (t.second, s)	-- ss
		end

	append_2_digits_fine_time_to (t: TIME; s: STRING_GENERAL)
		local
			fd: FORMAT_DOUBLE
			r64: REAL_64
			f: STRING
		do
			append_2_digits_integer_to (t.hour, s)		-- hh
			s.append_code (58) -- 58 ':'				-- :
			append_2_digits_integer_to (t.minute, s)	-- mi
			s.append_code (58) -- 58 ':'				-- :
			create fd.make (2, 2)
			fd.show_trailing_zeros
			fd.show_zero
			r64 := t.second + t.fractional_second * 0.01
			f := fd.formatted (r64)
			if f.ends_with_general (".00") then
				append_2_digits_integer_to (t.second, s)	-- ss				
			else
				if r64 < 10 then
					s.append_code (48) -- 48 '0'
				end
				s.append (f)		-- ss.nn
			end
		end

	append_day_ddd_to (d: INTEGER; s: STRING_GENERAL)
		require
			1 <= d and d <= 7
		do
			inspect d
			when 1 then s.append ("Sun")
			when 2 then s.append ("Mon")
			when 3 then s.append ("Tue")
			when 4 then s.append ("Wed")
			when 5 then s.append ("Thu")
			when 6 then s.append ("Fri")
			when 7 then s.append ("Sat")
			else
				-- Error				
			end
		end

	append_day_name_to (d: INTEGER; s: STRING_GENERAL)
		require
			1 <= d and d <= 7
		do
			inspect d
			when 1 then s.append ("Sunday")
			when 2 then s.append ("Monday")
			when 3 then s.append ("Tuesday")
			when 4 then s.append ("Wednesday")
			when 5 then s.append ("Thursday")
			when 6 then s.append ("Friday")
			when 7 then s.append ("Saturday")
			else
				-- Error				
			end
		end

	append_month_mmm_to (m: INTEGER; s: STRING_GENERAL)
		require
			1 <= m and m <= 12
		do
			inspect m
			when 1 then s.append ("Jan")
			when 2 then s.append ("Feb")
			when 3 then s.append ("Mar")
			when 4 then s.append ("Apr")
			when 5 then s.append ("May")
			when 6 then s.append ("Jun")
			when 7 then s.append ("Jul")
			when 8 then s.append ("Aug")
			when 9 then s.append ("Sep")
			when 10 then s.append ("Oct")
			when 11 then s.append ("Nov")
			when 12 then s.append ("Dec")
			else
				-- Error				
			end
		end

	append_integer_to (i: INTEGER; s: STRING_GENERAL)
		do
			if attached {STRING_32} s as s32 then
				s32.append_integer (i)
			elseif attached {STRING_8} s as s8 then
				s8.append_integer (i)
			else
				s.append (i.out)
			end
		end

feature {NONE} -- Implementation

	string_to_date_time (s: READABLE_STRING_GENERAL): detachable DATE_TIME
			-- String representation of `dt' using the RFC 1123
			--       HTTP-date    = rfc1123-date | rfc850-date | asctime-date
			--       rfc1123-date = wkday "," SP date1 SP time SP "GMT"
			--       rfc850-date  = weekday "," SP date2 SP time SP "GMT"
			--       asctime-date = wkday SP date3 SP time SP 4DIGIT
			--       date1        = 2DIGIT SP month SP 4DIGIT
			--                      ; day month year (e.g., 02 Jun 1982)
			--       date2        = 2DIGIT "-" month "-" 2DIGIT
			--                      ; day-month-year (e.g., 02-Jun-82)
			--       date3        = month SP ( 2DIGIT | ( SP 1DIGIT ))
			--                      ; month day (e.g., Jun  2)
			--       time         = 2DIGIT ":" 2DIGIT ":" 2DIGIT
			--                      ; 00:00:00 - 23:59:59
			--       wkday        = "Mon" | "Tue" | "Wed"
			--                    | "Thu" | "Fri" | "Sat" | "Sun"
			--       weekday      = "Monday" | "Tuesday" | "Wednesday"
			--                    | "Thursday" | "Friday" | "Saturday" | "Sunday"
			--       month        = "Jan" | "Feb" | "Mar" | "Apr"
			--                    | "May" | "Jun" | "Jul" | "Aug"
			--                    | "Sep" | "Oct" | "Nov" | "Dec"
			--| Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
			--| Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
			--| Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format
		note
			EIS: "name=RFC2616", "protocol=URI", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html"
		local
			t: STRING_32
			l_ddd, l_mmm: detachable STRING_32
			l_dd, l_yyyy, l_hh, l_mi, l_ss, l_ff2: INTEGER
			l_mo: INTEGER
			l_gmt_offset: INTEGER -- minutes
			i, n: INTEGER
			err: BOOLEAN
		do
			i := 1
			n := s.count
			create t.make (4)

				-- Skip blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| ddd
			t.wipe_out
			from until i > n or else not s[i].is_alpha loop
				t.extend (s[i])
				i := i + 1
			end
			if i <= n and t.count >= 3 then -- Accept full day string
				l_ddd := t.as_lower
			else
				err := True
			end

				--| blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| ,[0]dd
			if not err and i <= n and s[i] = ',' then
				i := i + 1
				from until i > n or else not s[i].is_space  loop i := i + 1 end
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.is_integer end
					l_dd := t.to_integer
				else
					err := True
				end
			else
				err := True
			end

				--| blanks or '-'
			if s[i] = '-' then
				i := i + 1
			else
				from until i > n or else not s[i].is_space  loop i := i + 1 end
			end

				--| mmm
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_alpha loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count >= 3 then
					l_mmm := t.as_upper
					if l_mmm.count > 3 then
							-- Tolerant to full month name ..
						l_mmm.keep_head (3)
					end
					if     l_mmm.same_string ("JAN") then l_mo := 01
					elseif l_mmm.same_string ("FEB") then l_mo := 02
					elseif l_mmm.same_string ("MAR") then l_mo := 03
					elseif l_mmm.same_string ("APR") then l_mo := 04
					elseif l_mmm.same_string ("MAY") then l_mo := 05
					elseif l_mmm.same_string ("JUN") then l_mo := 06
					elseif l_mmm.same_string ("JUL") then l_mo := 07
					elseif l_mmm.same_string ("AUG") then l_mo := 08
					elseif l_mmm.same_string ("SEP") then l_mo := 09
					elseif l_mmm.same_string ("OCT") then l_mo := 10
					elseif l_mmm.same_string ("NOV") then l_mo := 11
					elseif l_mmm.same_string ("DEC") then l_mo := 12
					else err := True
					end
				else
					err := True
				end
			end

				--| blanks or '-'
			if s[i] = '-' then
				i := i + 1
			else
				from until i > n or else not s[i].is_space  loop i := i + 1 end
			end

				--| yyyy
			if not err then

				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.count = 4 or t.count = 2 and t.is_integer end
					l_yyyy := t.to_integer
					if t.count = 2 then
						-- RFC 850
						l_yyyy := 1900 + l_yyyy
					end
				else
					err := True
				end
			end

				--| blank						
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| [0]hh:
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 and s[i] = ':' then
					check t.count = 2 and t.is_integer end
					l_hh := t.to_integer
					i := i + 1
				else
					err := True
				end
			end

				--| [0]mi:
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 and s[i] = ':' then
					check t.count = 2 and t.is_integer end
					l_mi := t.to_integer
					i := i + 1
				else
					err := True
				end
			end
				--| [0]ss
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.count = 2 and t.is_integer end
					l_ss := t.to_integer
				else
					err := True
				end
			end

				--| .ff2
			if not err and s[i] = '.' then
					--| .ff2
				i := i + 1
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.is_integer end
					l_ff2 := t.to_integer
				else
					err := True
				end
			end

			if not err then
				from until i > n or else not s[i].is_space  loop i := i + 1 end
				t.wipe_out
				from until i > n or else not s[i].is_alpha loop
					t.extend (s[i].as_upper)
					i := i + 1
				end
				if
					t.same_string ("GMT") 		-- for instance: GMT+0002
					or t.same_string ("UTC")  	-- for instance: UTC+0002
					or t.is_empty 				-- for instance: +0002
				then
					from until i > n or else not s[i].is_space  loop i := i + 1 end
					if i <= n then
						t.wipe_out
						if s[i] = '+' then
							t.extend (s[i])
						elseif s[i] = '-' then
							t.extend (s[i])
						else
							err := True
						end
						if not err then
							i := i + 1
							from until i > n or else not s[i].is_space  loop i := i + 1 end
							from until i > n or else not s[i].is_digit loop
								t.extend (s[i].as_upper)
								i := i + 1
							end
							l_gmt_offset := t.to_integer * 60
							if i <= n and s[i] = ':' then
								i := i + 1
								t.wipe_out
								from until i > n or else not s[i].is_digit loop
									t.extend (s[i].as_upper)
									i := i + 1
								end
								l_gmt_offset := l_gmt_offset + l_gmt_offset.sign * t.to_integer
							end
						end
					end
				else
					err := True
				end
			end

			if not err then
				check
					valid_yyyy: 0 < l_yyyy
					valid_dd: 0 < l_dd and l_dd <= 31
					valid_mo: 0 < l_mo and l_mo <= 12
					valid_hh: 0 <= l_hh and l_hh <= 23
					valid_mi: 0 <= l_mi and l_mi <= 59
					valid_ss: 0 <= l_ss and l_ss <= 59
				end
				create Result.make (l_yyyy, l_mo, l_dd, l_hh, l_mi, l_ss)
				if l_gmt_offset /= 0 then
					Result.minute_add (- l_gmt_offset)
				end
			else
				-- Void is better than wrong date.
			end
		end

	ansi_c_string_to_date_time (s: READABLE_STRING_GENERAL): detachable DATE_TIME
			-- ANSI C date from `s` string representation using the RFC 1123
			--       asctime-date = wkday SP date3 SP time SP 4DIGIT
			--       date3        = month SP ( 2DIGIT | ( SP 1DIGIT ))
			--                      ; month day (e.g., Jun  2)
			--       time         = 2DIGIT ":" 2DIGIT ":" 2DIGIT
			--                      ; 00:00:00 - 23:59:59
			--       wkday        = "Mon" | "Tue" | "Wed"
			--                    | "Thu" | "Fri" | "Sat" | "Sun"
			--       month        = "Jan" | "Feb" | "Mar" | "Apr"
			--                    | "May" | "Jun" | "Jul" | "Aug"
			--                    | "Sep" | "Oct" | "Nov" | "Dec"			
			--| Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format
		note
			EIS: "name=RFC2616", "protocol=URI", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html"
		local
			t: STRING_32
			l_ddd, l_mmm: detachable STRING_32
			l_dd, l_yyyy, l_hh, l_mi, l_ss, l_ff2: INTEGER
			l_mo: INTEGER
			l_gmt_offset: INTEGER -- minutes
			i, n: INTEGER
			err: BOOLEAN
		do
			i := 1
			n := s.count
			create t.make (4)

				-- Skip blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| ddd
			t.wipe_out
			from until i > n or else not s[i].is_alpha loop
				t.extend (s[i])
				i := i + 1
			end
			if i <= n and t.count >= 3 then -- Accept full day string
				l_ddd := t.as_lower
			else
				err := True
			end

				--| blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| mmm
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_alpha loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count >= 3 then
					l_mmm := t.as_upper
					if l_mmm.count > 3 then
							-- Tolerant to full month name ..
						l_mmm.keep_head (3)
					end
					if     l_mmm.same_string_general ("JAN") then l_mo := 01
					elseif l_mmm.same_string_general ("FEB") then l_mo := 02
					elseif l_mmm.same_string_general ("MAR") then l_mo := 03
					elseif l_mmm.same_string_general ("APR") then l_mo := 04
					elseif l_mmm.same_string_general ("MAY") then l_mo := 05
					elseif l_mmm.same_string_general ("JUN") then l_mo := 06
					elseif l_mmm.same_string_general ("JUL") then l_mo := 07
					elseif l_mmm.same_string_general ("AUG") then l_mo := 08
					elseif l_mmm.same_string_general ("SEP") then l_mo := 09
					elseif l_mmm.same_string_general ("OCT") then l_mo := 10
					elseif l_mmm.same_string_general ("NOV") then l_mo := 11
					elseif l_mmm.same_string_general ("DEC") then l_mo := 12
					else err := True
					end
				else
					err := True
				end
			end

				--| blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| dd
			if not err and i <= n then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.is_integer end
					l_dd := t.to_integer
				else
					err := True
				end
			else
				err := True
			end

				--| blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| [0]hh:
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 and s[i] = ':' then
					check t.count = 2 and t.is_integer end
					l_hh := t.to_integer
					i := i + 1
				else
					err := True
				end
			end

				--| [0]mi:
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 and s[i] = ':' then
					check t.count = 2 and t.is_integer end
					l_mi := t.to_integer
					i := i + 1
				else
					err := True
				end
			end
				--| [0]ss
			if not err then
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.count = 2 and t.is_integer end
					l_ss := t.to_integer
				else
					err := True
				end
			end

				--| .ff2
			if not err and s[i] = '.' then
					--| .ff2
				i := i + 1
				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if i <= n and t.count > 0 then
					check t.is_integer end
					l_ff2 := t.to_integer
				else
					err := True
				end
			end

				--| blanks
			from until i > n or else not s[i].is_space  loop i := i + 1 end

				--| yyyy
			if not err then

				t.wipe_out
				from until i > n or else not s[i].is_digit loop
					t.extend (s[i])
					i := i + 1
				end
				if t.count > 0 then
					check t.count = 4 or t.count = 2 and t.is_integer end
					l_yyyy := t.to_integer
					if t.count = 2 then
						-- RFC 850
						l_yyyy := 1900 + l_yyyy
					end
				else
					err := True
				end
			end

				--| blank						
			from until i > n or else not s[i].is_space  loop i := i + 1 end

			if i <= n and not err then
				from until i > n or else not s[i].is_space  loop i := i + 1 end
				t.wipe_out
				from until i > n or else not s[i].is_alpha loop
					t.extend (s[i].as_upper)
					i := i + 1
				end
				if t.same_string ("GMT") or t.same_string ("UTC") then
					from until i > n or else not s[i].is_space  loop i := i + 1 end
					if i <= n then
						t.wipe_out
						if s[i] = '+' then
							t.extend (s[i])
						elseif s[i] = '-' then
							t.extend (s[i])
						else
							err := True
						end
						if not err then
							i := i + 1
							from until i > n or else not s[i].is_space  loop i := i + 1 end
							from until i > n or else not s[i].is_digit loop
								t.extend (s[i].as_upper)
								i := i + 1
							end
							l_gmt_offset := t.to_integer * 60
							if i <= n and s[i] = ':' then
								i := i + 1
								t.wipe_out
								from until i > n or else not s[i].is_digit loop
									t.extend (s[i].as_upper)
									i := i + 1
								end
								l_gmt_offset := l_gmt_offset + l_gmt_offset.sign * t.to_integer
							end
						end
					end
				else
					err := True
				end
			end

			if not err then
				check
					valid_yyyy: 0 < l_yyyy
					valid_dd: 0 < l_dd and l_dd <= 31
					valid_mo: 0 < l_mo and l_mo <= 12
					valid_hh: 0 <= l_hh and l_hh <= 23
					valid_mi: 0 <= l_mi and l_mi <= 59
					valid_ss: 0 <= l_ss and l_ss <= 59
				end
				create Result.make (l_yyyy, l_mo, l_dd, l_hh, l_mi, l_ss)
				if l_gmt_offset /= 0 then
					Result.minute_add (- l_gmt_offset)
				end
			else
				-- Void is better than wrong date.
			end
		end

	rfc3339_string_to_date_time (s: READABLE_STRING_GENERAL): detachable DATE_TIME
			--| 1985-04-12T23:20:50.52Z
			--| 1996-12-19T16:39:57-08:00  = 1996-12-20T00:39:57Z
			--|
		note
			EIS: "name=RFC3339", "protocol=URI", "src=https://tools.ietf.org/html/rfc3339"
		local
			y,mo,d,h,mi,sec, frac_sec: INTEGER
			l_off_h, l_off_mi: INTEGER
			tmp: READABLE_STRING_GENERAL
			i, j, k, pos: INTEGER
			err: BOOLEAN
		do
			if s /= Void then
				pos := s.index_of ('T', 1)
				if pos > 0 then
					i := 1
					j := s.index_of ('-', i)
					if j > i and j < pos then
						y := s.substring (i, j - 1).to_integer
						i := j + 1
						j := s.index_of ('-', i)
						if j > i and j < pos then
							mo := s.substring (i, j - 1).to_integer
							d := s.substring (j + 1, pos - 1).to_integer
						else
							err := True
						end
					else
						err := True
					end
					i := pos + 1
					j := s.index_of (':', i)
					if j > i then
						h := s.substring (i, j - 1).to_integer
						i := j + 1
						j := s.index_of (':', i)
						if j > i then
							mi := s.substring (i, j - 1).to_integer
							from
								k := j + 1
							until
								k > s.count
								or s[k].is_alpha
								or s[k] = '+'
								or s[k] = '-'
							loop
								k := k + 1
							end
							tmp := s.substring (j + 1, k - 1)
							j := tmp.index_of ('.', 1)
							if j > 0 then
								sec := tmp.head (j - 1).to_integer
								frac_sec := tmp.substring (j + 1, tmp.count).to_integer
							else
								sec := tmp.to_integer
							end
							if k <= s.count then
								if s[k] = '+' then
									tmp := s.substring (k + 1, s.count)
									j := tmp.index_of (':', 1)
									if j > 0 then
										l_off_h := - tmp.head (j - 1).to_integer
										l_off_mi := - tmp.substring (j + 1, tmp.count).to_integer
									else
										l_off_h := - tmp.to_integer
									end
								elseif s[k] = '-' then
									tmp := s.substring (k + 1, s.count)
									j := tmp.index_of (':', 1)
									if j > 0 then
										l_off_h := + tmp.head (j - 1).to_integer
										l_off_mi := + tmp.substring (j + 1, tmp.count).to_integer
									else
										l_off_h := + tmp.to_integer
									end
								elseif s[k] = 'Z' then
									-- Done
								else
								end
							end
						else
							err := True
						end
					else
						err := True
					end
					if not err then
						create Result.make (y, mo, d, h, mi, sec)
						if frac_sec /= 0 then
							Result.set_fractionals (frac_sec)
							Result.time.set_fractionals (frac_sec)
						end
						if l_off_h /= 0 then
							Result.hour_add (l_off_h)
						end
						if l_off_mi /= 0 then
							Result.minute_add (l_off_mi)
						end
					end
				end
			end
		end

invariant

note
	copyright: "2011-2020, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
