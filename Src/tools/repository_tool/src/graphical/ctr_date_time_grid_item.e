note
	description: "Summary description for {CTR_DATE_TIME_GRID_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_DATE_TIME_GRID_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			data
		end

create
	make_with_text_and_date

feature {NONE} -- Initialization

	make_with_text_and_date (a_text: STRING_GENERAL; a_date: detachable DATE_TIME; a_smart_date_enabled: BOOLEAN; a_date_time_format: detachable STRING)
		do
			date_time := a_date
			date_time_format := a_date_time_format
			smart_date_enabled := a_smart_date_enabled
			data := a_text
			make_with_text (text_for_date (a_text, a_date, a_smart_date_enabled, a_date_time_format))
			pointer_enter_actions.extend (agent refresh)
		end

feature -- Access

	data: STRING_GENERAL
		-- Arbitrary user data may be stored here.

	date_time: detachable DATE_TIME
			-- Associated date time

	smart_date_enabled: BOOLEAN
			-- Smart date output enabled

	date_time_format: detachable STRING
			-- Date time format

feature -- Basic operation

	refresh
		do
			set_text (text_for_date (data, date_time, smart_date_enabled, date_time_format))
		end

feature {NONE} -- Interface text

	formatted_date_time (a_date_time: DATE_TIME; a_date_time_format: attached like date_time_format): STRING_GENERAL
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
					s := a_date_time.months_text [m]
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)
				when 'F' then
					s := a_date_time.long_months_text [m]
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)
				when 'D' then
					s := a_date_time.days_text [a_date_time.date.day_of_the_week]
					s.to_lower; s.put (s.item (1).as_upper, 1); s32.append_string (s)
				when 'l' then
					s := a_date_time.long_days_text [a_date_time.date.day_of_the_week]
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
					if c = 'G' and h < 10 then
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

	text_for_date (a_text: STRING_GENERAL; a_date_time: detachable DATE_TIME; a_smart_date_enabled: BOOLEAN; a_date_time_format: like date_time_format): STRING_GENERAL
		local
			l_now: DATE_TIME
			l_duration: DATE_TIME_DURATION --like {DATE_TIME}.relative_duration
			y,m,d,h,mn,sec: INTEGER
			s32: STRING_32
			s: STRING
			c: CHARACTER_32
			i: INTEGER
		do
			if a_date_time /= Void then
				if a_smart_date_enabled then
					create l_now.make_now_utc
					l_duration := l_now.relative_duration (a_date_time)
					d := l_duration.date.day
					if d = 0 then
						h := l_duration.time.hour
						if h > 0 then
							Result := h.out + " hours ago"
						else
							m := l_duration.time.minute
							if m = 0 then
								Result := l_duration.time.second.out + " seconds ago"
							else
								Result := m.out + " minutes ago"
							end
						end
					elseif d < 7 then
						Result := d.out + " days"
						h := l_duration.time.hour
						if h > 0 then
							Result.append (" and " + h.out + " hours")
						end
						Result.append (" ago")
					else
						if a_date_time_format /= Void then
							Result := formatted_date_time (a_date_time, a_date_time_format)
						else
							Result := a_date_time.out
						end
					end
				else
					if a_date_time_format /= Void then
						Result := formatted_date_time (a_date_time, a_date_time_format)
					else
						Result := a_text -- a_date_time.out
					end
				end
			else
				Result := a_text
			end
		end

end
