note
	description: "Summary description for {CTR_DATE_OUTPUT_UTILITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_DATE_TIME_UTILITY

feature -- Constants

	smart_date_none_kind: INTEGER = 0

	smart_date_duration_kind: INTEGER = 1

	smart_date_short_kind: INTEGER = 2

	smart_date_none_kind_string: STRING = "none"

	smart_date_duration_kind_string: STRING = "duration"

	smart_date_short_kind_string: STRING = "short date"

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

	formatted_date_time (a_date_time: DATE_TIME; a_date_time_format: STRING): STRING_GENERAL
		local
			y,m,d,h,mn,sec: INTEGER
			s32: STRING_32
			s: STRING
			c: CHARACTER_32
			i: INTEGER
		do
			create s32.make (a_date_time_format.count)
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
				when 'Y' then s32.append_integer (y)
				when 'y' then
					s := y.out
					s.keep_tail (2)
					s32.append_string (s)
				when 'm' then
					if m < 10 then
						s32.append_integer (0)
					end
					s32.append_integer (m)
				when 'n' then s32.append_integer (m)
				when 'M' then
					s := a_date_time.months_text [m].string
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)
				when 'F' then
					s := a_date_time.long_months_text [m].string
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)
				when 'D' then
					s := a_date_time.days_text [a_date_time.date.day_of_the_week].string
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)
				when 'l' then
					s := a_date_time.long_days_text [a_date_time.date.day_of_the_week].string
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)

				when 'd' then
					if d < 10 then
						s32.append_integer (0)
					end
					s32.append_integer (d)
				when 'j' then
					s32.append_integer (d)
--							when 'z' then s32.append_integer (a_date_time.date.*year)
				when 'a' then
					if h >= 12 then
						s32.append_character ('p'); s32.append_character ('m')
					else
						s32.append_character ('a'); s32.append_character ('m')
					end
				when 'A' then
					if h >= 12 then
						s32.append_character ('P'); s32.append_character ('M')
					else
						s32.append_character ('A'); s32.append_character ('M')
					end
				when 'g','h' then
					if h >= 12 then
						if c = 'h' and h - 12 < 10 then
							s32.append_integer (0)
						end
						s32.append_integer (h - 12)
					else
						if c = 'h' and h < 10 then
							s32.append_integer (0)
						end
						s32.append_integer (h)
					end
				when 'G', 'H' then
					if c = 'H' and h < 10 then
						s32.append_integer (0)
					end
					s32.append_integer (h)
				when 'i' then
					if mn < 10 then
						s32.append_integer (0)
					end
					s32.append_integer (mn)
				when 's' then
					if sec < 10 then
						s32.append_integer (0)
					end
					s32.append_integer (sec)
				when 'u' then
					s32.append_double (a_date_time.fine_second) -- CHECK result ...
				when 'w' then s32.append_integer (a_date_time.date.day_of_the_week - 1)
				when 'W' then s32.append_integer (a_date_time.date.week_of_year)
				when 'L' then
					if a_date_time.is_leap_year (y) then
						s32.append_integer (1)
					else
						s32.append_integer (0)
					end
				when '\' then
					if i < a_date_time_format.count then
						i := i + 1
						s32.append_character (a_date_time_format[i])
					else
						s32.append_character ('\')
					end
				else
					s32.append_character (c)
				end
				i := i + 1
			end
			Result := s32
		end

	timezoned_date_time (a_gmt_date_time: DATE_TIME; a_gmt_offset: INTEGER; a_gmt_offset_minute: INTEGER): DATE_TIME
		do
			if a_gmt_offset /= 0 or a_gmt_offset_minute /= 0 then
				Result := a_gmt_date_time.deep_twin
				Result.hour_add (a_gmt_offset)
				Result.minute_add (a_gmt_offset_minute)
			else
				Result := a_gmt_date_time
			end
		end

	text_for_date (a_text: STRING_GENERAL; a_gmt_date_time: detachable DATE_TIME; a_smart_date_kind: INTEGER; a_date_time_format: detachable STRING;
			a_gmt_offset: INTEGER; a_gmt_offset_minute: INTEGER): STRING_GENERAL
		require
			valid_smart_date_kind: a_smart_date_kind > 0 implies valid_smart_date_kind (a_smart_date_kind)
		do
			if a_gmt_date_time /= Void then
				inspect a_smart_date_kind
				when Smart_date_duration_kind then
					Result := smart_date_duration (a_gmt_date_time, a_date_time_format, a_gmt_offset, a_gmt_offset_minute)
				when Smart_date_short_kind then
					Result := short_date (a_gmt_date_time, a_date_time_format, a_gmt_offset, a_gmt_offset_minute)
				else
					if a_date_time_format /= Void then
						Result := formatted_date_time (timezoned_date_time (a_gmt_date_time, a_gmt_offset, a_gmt_offset_minute), a_date_time_format)
					else
						Result := a_text
					end
				end
			else
				Result := a_text
			end
		end

	short_date (a_gmt_date_time: DATE_TIME; a_date_time_format: detachable STRING;
			a_gmt_offset: INTEGER; a_gmt_offset_minute: INTEGER): STRING_GENERAL
		local
			l_date_time: DATE_TIME
			l_now: DATE
			cy,cm,cd,y,m,d,h,i: INTEGER
			s: STRING
			l_duration: DATE_TIME_DURATION --like {DATE_TIME}.relative_duration
		do
			create l_date_time.make_now_utc
			l_duration := l_date_time.relative_duration (a_gmt_date_time)

			create l_now.make_now
			cy := l_now.year
			cm := l_now.month
			cd := l_now.day

			l_date_time := timezoned_date_time (a_gmt_date_time, a_gmt_offset, a_gmt_offset_minute)
			y := l_date_time.date.year
			m := l_date_time.date.month
			d := l_date_time.date.day

			if cy /= y then
				if a_date_time_format /= Void then
					Result := formatted_date_time (l_date_time, a_date_time_format)
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


	smart_date_duration (a_gmt_date_time: DATE_TIME; a_date_time_format: detachable STRING;
			a_gmt_offset: INTEGER; a_gmt_offset_minute: INTEGER): STRING_GENERAL
		local
			l_date_time: DATE_TIME
			l_now: DATE_TIME
			l_duration: DATE_TIME_DURATION --like {DATE_TIME}.relative_duration
			l_duration_time: TIME_DURATION --like {DATE_TIME_DURATION}.time
			y,m,w,d,h,i: INTEGER
			w_now,w_gmt: INTEGER
			l_s_code: NATURAL_32
			l_space_ago_string: STRING
		do
			l_s_code := ('s').natural_32_code
			l_space_ago_string := " ago"
			create l_now.make_now_utc
			l_duration := l_now.relative_duration (a_gmt_date_time)
			y := l_duration.date.year
			m := l_duration.date.month
			d := l_duration.date.day
			w_now := l_now.date.week_of_year
			w_gmt := a_gmt_date_time.date.week_of_year
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
				if w = 1 and then w_now = w_gmt + 1 then
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
				if w_now /= w_gmt then
					Result := "last week"
				else
					l_duration_time := l_duration.time
					if d = 1 then
						Result := "yesturday"
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
				l_date_time := timezoned_date_time (a_gmt_date_time, a_gmt_offset, a_gmt_offset_minute)
				if a_date_time_format /= Void then
					Result := formatted_date_time (l_date_time, a_date_time_format)
				else
					Result := l_date_time.out
				end
			end
		end

end
