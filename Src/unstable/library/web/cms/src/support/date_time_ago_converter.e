note
	description: "Summary description for {DATE_TIME_AGO_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DATE_TIME_AGO_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		local
			dt_now, dt_now_utc: DATE_TIME
			l_duration: DATE_TIME_DURATION --like {DATE_TIME}.relative_duration
		do
			create dt_now.make_now
			create dt_now_utc.make_now_utc

			l_duration := dt_now_utc.relative_duration (dt_now)
			utc_offset := l_duration.hour

			smart_date_kind := smart_date_duration_kind
		end

feature -- Access

	append_date_to (a_text: READABLE_STRING_GENERAL; a_utc_date_time: detachable DATE_TIME; a_output: STRING_GENERAL)
		require
			valid_smart_date_kind: smart_date_kind > 0 implies valid_smart_date_kind (smart_date_kind)
		do
			if a_utc_date_time /= Void then
				inspect smart_date_kind
				when Smart_date_duration_kind then
					a_output.append (smart_date_duration (a_utc_date_time))
				when Smart_date_short_kind then
					a_output.append (short_date (a_utc_date_time))
				else
					if attached date_time_format as l_format then
						a_output.append (formatted_date_time (timezoned_date_time (a_utc_date_time), l_format))
					else
						a_output.append (a_text)
					end
				end
			else
				a_output.append (a_text)
			end
		end

	date_time_format: detachable STRING

	utc_offset: INTEGER
	utc_offset_minute: INTEGER

	smart_date_kind: INTEGER

feature -- Constants

	smart_date_none_kind: INTEGER = 0

	smart_date_duration_kind: INTEGER = 1

	smart_date_short_kind: INTEGER = 2

--	smart_date_none_kind_string: STRING = "none"

--	smart_date_duration_kind_string: STRING = "duration"

--	smart_date_short_kind_string: STRING = "short date"

	valid_smart_date_kind (k: INTEGER): BOOLEAN
		do
			inspect
				k
			when
				smart_date_none_kind,
				smart_date_duration_kind,
				smart_date_short_kind
			then
				Result := True
			else
			end
		end

feature -- Output

	formatted_date_time (a_date_time: DATE_TIME; a_date_time_format: STRING): STRING_8
		local
			y,m,d,h,mn,sec: INTEGER
			s: STRING
			c: CHARACTER
			i: INTEGER
		do
			create Result.make (a_date_time_format.count)
			from
				i := 1
				m := a_date_time.month
				y := a_date_time.year
				d := a_date_time.day
				h := a_date_time.hour
				mn := a_date_time.minute
				sec := a_date_time.second
			until
				i > a_date_time_format.count
			loop
				c := a_date_time_format[i]
				inspect c
				when 'Y' then Result.append_integer (y)
				when 'y' then
					s := y.out
					s.keep_tail (2)
					Result.append_string (s)
				when 'm' then
					if m < 10 then
						Result.append_integer (0)
					end
					Result.append_integer (m)
				when 'n' then Result.append_integer (m)
				when 'M' then
					s := a_date_time.months_text [m].string
					s.to_lower; s.put (s.item (1).as_upper, 1); Result.append_string (s)
				when 'F' then
					s := a_date_time.long_months_text [m].string
					s.to_lower; s.put (s.item (1).as_upper, 1); Result.append_string (s)
				when 'D' then
					s := a_date_time.days_text [a_date_time.date.day_of_the_week].string
					s.to_lower; s.put (s.item (1).as_upper, 1); Result.append_string (s)
				when 'l' then
					s := a_date_time.long_days_text [a_date_time.date.day_of_the_week].string
					s.to_lower; s.put (s.item (1).as_upper, 1); Result.append_string (s)

				when 'd' then
					if d < 10 then
						Result.append_integer (0)
					end
					Result.append_integer (d)
				when 'j' then
					Result.append_integer (d)
--							when 'z' then Result.append_integer (a_date_time.date.*year)
				when 'a' then
					if h >= 12 then
						Result.append_character ('p'); Result.append_character ('m')
					else
						Result.append_character ('a'); Result.append_character ('m')
					end
				when 'A' then
					if h >= 12 then
						Result.append_character ('P'); Result.append_character ('M')
					else
						Result.append_character ('A'); Result.append_character ('M')
					end
				when 'g','h' then
					if h >= 12 then
						if c = 'h' and h - 12 < 10 then
							Result.append_integer (0)
						end
						Result.append_integer (h - 12)
					else
						if c = 'h' and h < 10 then
							Result.append_integer (0)
						end
						Result.append_integer (h)
					end
				when 'G', 'H' then
					if c = 'H' and h < 10 then
						Result.append_integer (0)
					end
					Result.append_integer (h)
				when 'i' then
					if mn < 10 then
						Result.append_integer (0)
					end
					Result.append_integer (mn)
				when 's' then
					if sec < 10 then
						Result.append_integer (0)
					end
					Result.append_integer (sec)
				when 'u' then
					Result.append_double (a_date_time.fine_second) -- CHECK result ...
				when 'w' then Result.append_integer (a_date_time.date.day_of_the_week - 1)
				when 'W' then Result.append_integer (a_date_time.date.week_of_year)
				when 'L' then
					if a_date_time.is_leap_year (y) then
						Result.append_integer (1)
					else
						Result.append_integer (0)
					end
				when '\' then
					if i < a_date_time_format.count then
						i := i + 1
						Result.append_character (a_date_time_format[i])
					else
						Result.append_character ('\')
					end
				else
					Result.append_character (c)
				end
				i := i + 1
			end
		end

	timezoned_date_time (a_utc_date_time: DATE_TIME): DATE_TIME
		do
			if utc_offset /= 0 or utc_offset_minute /= 0 then
				Result := a_utc_date_time.deep_twin
				Result.hour_add (utc_offset)
				Result.minute_add (utc_offset_minute)
			else
				Result := a_utc_date_time
			end
		end

	short_date (a_utc_date_time: DATE_TIME): STRING_8
		local
			l_date_time: DATE_TIME
			l_now: DATE
			cy,cm,cd,y,m,d,h,i: INTEGER
			s: STRING
			l_duration: DATE_TIME_DURATION --like {DATE_TIME}.relative_duration
		do
			create l_date_time.make_now_utc
			l_duration := l_date_time.relative_duration (a_utc_date_time)

			create l_now.make_now
			cy := l_now.year
			cm := l_now.month
			cd := l_now.day

			l_date_time := timezoned_date_time (a_utc_date_time)
			y := l_date_time.date.year
			m := l_date_time.date.month
			d := l_date_time.date.day

			if cy /= y then
				if attached date_time_format as l_format then
					Result := formatted_date_time (l_date_time, l_format)
				else
					Result := d.out + "/" + m.out + "/" + y.out
				end
			elseif cm /= m then
				s := l_date_time.months_text [m].string
				s.to_lower; s.put (s.item (1).as_upper, 1)
				Result := s
				Result.append (" ")
				Result.append (d.out)
			elseif cd /= d then
				s := l_date_time.months_text [m].string
				s.to_lower; s.put (s.item (1).as_upper, 1)
				Result := s
				Result.append (" ")
				Result.append (d.out)
				if l_duration.day < 7 then
					s := l_date_time.days_text [l_date_time.date.day_of_the_week].string
					s.to_lower; s.put (s.item (1).as_upper, 1)
					Result.append (" - " + s)
				end
			else
				check cd = d and cy = y and cm = m end
				h := l_date_time.time.hour
				i := l_date_time.time.minute
				if h < 10 then
					Result := "0" + h.out
				else
					Result := h.out
				end
				Result.append (":")
				if i < 10 then
					Result.append ("0")
				end
				Result.append (i.out)
			end
		end


	smart_date_duration (a_utc_date_time: DATE_TIME): STRING_8
		local
			l_date_time: DATE_TIME
			l_now: DATE_TIME
			l_duration: DATE_TIME_DURATION --like {DATE_TIME}.relative_duration
			l_duration_time: TIME_DURATION --like {DATE_TIME_DURATION}.time
			y,m,w,d,h,i: INTEGER
			w_now,w_utc: INTEGER
			l_s_code: NATURAL_32
			l_space_ago_string: STRING
		do
			l_s_code := ('s').natural_32_code
			l_space_ago_string := " ago"
			create l_now.make_now_utc
			l_duration := l_now.relative_duration (a_utc_date_time)
			y := l_duration.date.year
			m := l_duration.date.month
			d := l_duration.date.day
			w_now := l_now.date.week_of_year
			w_utc := a_utc_date_time.date.week_of_year
			if y > 0 then
				if y = 1 then
					Result := "last year"
				else
					Result := y.out + " years"
--							if m > 0 then
--								Result.append (" and " + m.out + " month")
--								if m > 1 then
--									Result.append_code (l_s_code)
--								end
--							end
					Result.append (l_space_ago_string)
				end
			elseif m > 0 then
				if m = 1 then
					Result := "last month"
				else
					Result := m.out + " months"
--							if d > 0 then
--								Result.append (" and " + d.out + " day")
--								if d > 1 then
--									Result.append_code (l_s_code)
--								end
--							end
					Result.append (l_space_ago_string)
				end
			elseif d >= 7 then
				w := d // 7
				if w = 1 and then w_now = w_utc + 1 then
					Result := "last week"
				else

					Result := (w+1).out + " weeks"
--							if d > 7 then
--								Result.append (" and " + (d - 7).out + " day")
--								if d - 7 > 1 then
--									Result.append_code (l_s_code)
--								end
--							end
					Result.append (l_space_ago_string)
				end
			elseif d > 0 then
				if w_now /= w_utc then
					Result := "last week"
				else
					l_duration_time := l_duration.time
					if d = 1 then
						Result := "yesterday"
					else
						Result := d.out + " days"
	--							if d = 1 then
	--								h := l_duration_time.hour
	--								if h > 0 then
	--									Result.append (" and " + h.out + " hour")
	--									if h > 1 then
	--										Result.append_code (l_s_code)
	--									end
	--								end
	--							end
						Result.append (l_space_ago_string)
					end
				end
			elseif d = 0 then
				l_duration_time := l_duration.time
				h := l_duration_time.hour
				if h > 0 then
					if h = 1 then
						Result := "last hour"
					else
						Result := h.out + " hours"
						Result.append (l_space_ago_string)
					end
				else
					i := l_duration_time.minute
					if i = 0 then
						Result := l_duration_time.second.out + " second"
						if l_duration_time.second > 1 then
							Result.append_code (l_s_code)
						end
					else
						Result := i.out + " minute"
						if i > 1 then
							Result.append_code (l_s_code)
						end
					end
					Result.append (l_space_ago_string)
				end
			else
				l_date_time := timezoned_date_time (a_utc_date_time)
				if attached date_time_format as l_format then
					Result := formatted_date_time (l_date_time, l_format)
				else
					Result := l_date_time.out
				end
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
