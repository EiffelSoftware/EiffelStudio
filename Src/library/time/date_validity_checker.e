indexing
	description: "Facility routines to check the validity of DATEs"
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DATE_VALIDITY_CHECKER inherit

	DATE_CONSTANTS
		export
			{NONE} all
		end

	DATE_VALUE
		export
			{NONE} all
		end

feature -- Preconditions

	date_valid (s: STRING; code_string: STRING): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			Result := code.precise_date and code.correspond (s) and then
				code.is_date (s)
		end

	date_valid_with_base (s: STRING; code_string: STRING; 
							base: INTEGER): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to `code_string'?
			-- Use base century `base'.
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			code.set_base_century (base)
			Result := code.precise_date and code.correspond (s) and then
				code.is_date (s)
		end

	date_valid_default (s: STRING): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to 
			-- `date_default_format_string'?
		require
			s_exists: s /= Void
		do
			Result := date_valid (s, date_default_format_string)
		end	

	date_valid_default_with_base (s: STRING; base: INTEGER): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to 
			-- `date_default_format_string'?
			-- Use base century `base'.
		require
			s_exists: s /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
		do
			Result := date_valid_with_base (s, date_default_format_string, base)
		end	

	compact_date_valid (c_d: INTEGER): BOOLEAN is
			-- Is compact date `c_d' valid?
		local
			y, m, d: INTEGER
		do
			y := c_year (c_d)
			m := c_month (c_d)
			d := c_day (c_d)
			Result := (m >= 1 and m <= Months_in_year and
			d >= 1 and d <= days_in_i_th_month (m, y) and
			y <= 65535)
		end

	is_correct_date (y, m, d: INTEGER): BOOLEAN is
			-- Is date specified by `y', `m', and `d' a correct date?
		do
			Result := m >= 1 and m <= Months_in_year and then d >= 1 and 
				d <= days_in_i_th_month (m, y) and then y >= 0
		end

end -- class DATE_VALIDITY_CHECKER


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

