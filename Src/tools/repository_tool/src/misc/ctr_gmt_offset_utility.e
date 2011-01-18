note
	description: "Summary description for {CTR_GMT_OFFSET_UTILITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_GMT_OFFSET_UTILITY

feature -- Access

	gmt_offset: TUPLE [negative: BOOLEAN; hour: INTEGER; minute: INTEGER]
		local
			l_duration: DATE_TIME_DURATION
			h,m, l_step: INTEGER
		do
			l_duration := (create {DATE_TIME}.make_now).relative_duration (create {DATE_TIME}.make_now_utc)
			l_step := +1
			h := l_duration.hour
			m := l_duration.minute

			if h /= 0 then
				if h < 0 then
					l_step := -1
				end
			elseif m < 0 then
				l_step := -1
			end
--			h := h.abs
--			m := m.abs

			if l_duration.second > 45 then
				m := m + l_step
				if l_step > 0 and m = 60 then
					h := h + l_step
					m := 0
				elseif l_step < 0 and m = 0 then
					h := h + l_step
				end
			end

			Result := [l_step = -1 , h.abs, m.abs]
		end

	gmt_offset_string: STRING
		local
			t: like gmt_offset
		do
			t := gmt_offset
			if t.negative then
				Result := "-"
			else
				Result := "+"
			end
			Result.append_integer (t.hour)
			if t.minute > 0 then
				Result.append_character (':')
				Result.append_integer (t.minute)
			end
		end

end
