indexing
	description: "Facility routines to check the validity of TIMEs" 
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TIME_VALIDITY_CHECKER inherit

	TIME_CONSTANTS
		export
			{NONE} all
		end

	TIME_VALUE
		export
			{NONE} all
		end

feature -- Preconditions

	time_valid (s: STRING; code_string: STRING): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type TIME
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			Result := code.precise_time and code.correspond (s) and then 
				code.is_time (s)
		end

	compact_time_valid (c_t: INTEGER): BOOLEAN is
		require
			c_t_not_void: c_t /= Void
		local
			h, m, s: INTEGER
		do
			h := c_hour (c_t)
			m := c_minute (c_t)
			s := c_second (c_t)
			Result := (h >= 0 and h < Hours_in_day and
			m >= 0 and m < Minutes_in_hour and
			s >= 0 and s < Seconds_in_minute)	
		end

	Is_correct_time (h, m: INTEGER; s: DOUBLE): BOOLEAN is
			-- Is time represented by `h', `m', and `s' correct?
		do
			Result := h >= 0 and h < Hours_in_day and then m >= 0 and
				m < Minutes_in_hour and then s >= 0 and s < Seconds_in_minute
		end

end -- class TIME_VALIDITY_CHECKER

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
