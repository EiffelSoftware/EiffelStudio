indexing
	description: "Facility routines to check the validity of DATE_TIMEs"
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DATE_TIME_VALIDITY_CHECKER inherit

	DATE_VALIDITY_CHECKER
		export
			{NONE} all
		end

	TIME_VALIDITY_CHECKER
		export
			{NONE} all
		end

feature -- Preconditions

	date_time_valid (s: STRING; code_string: STRING): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE_TIME
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			Result := code.precise and code.correspond (s) and then
				code.is_date_time (s)
		end

	date_time_valid_with_base (s: STRING; code_string: STRING;
					base: INTEGER): BOOLEAN is
			-- Is the code_string enough precise
			-- To create an instance of type DATE_TIME
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
			Result := code.precise and code.correspond (s) and then
				code.is_date_time (s)
		end

	is_correct_date_time (y, mo, d, h, mi: INTEGER; s: DOUBLE;
					 	  twelve_hour_scale: BOOLEAN): BOOLEAN is
			-- Is date-time specified by `y', `mo', `d', `h', `mi', `s'
			-- correct?
			-- `twelve_hour_scale' specifies if the hour range is 1 - 12
			-- (if True) or 0 - 23 (if False).
		do
			Result := is_correct_date (y, mo, d) and 
				is_correct_time (h, mi, s, twelve_hour_scale)
		end

end -- class DATE_TIME_VALIDITY_CHECKER

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
