indexing
	description: "Facility routines to check the validity of a DATE_TIME_CODE" 
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	CODE_VALIDITY_CHECKER

feature -- Preconditions

	is_code (s: STRING): BOOLEAN is
			-- Is the string a code?
		require
			s_exists: s /= Void
		do
			Result := is_colon (s) or
			is_comma (s) or is_day (s) or
			is_day0 (s) or is_day_text (s) or
			is_dot (s) or is_fractional_second (s) or
			is_hour (s) or is_hour0 (s) or
			is_hour12 (s) or is_meridiem (s) or
			is_minus (s) or is_minute (s) or
			is_minute0 (s) or is_month (s) or
			is_month0 (s) or is_month_text (s) or
			is_second (s) or is_second0 (s) or
			is_slash (s) or is_space (s) or
			is_year2 (s) or is_year4 (s)
		end

	is_day (s: STRING): BOOLEAN is
			-- Is the code a day-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("dd")
		end

	is_day0 (s: STRING): BOOLEAN is
			-- Is the code a day-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("[0]dd")
		end

	is_day_text (s: STRING): BOOLEAN is
			-- Is the code a day-text?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("ddd")
		end

	is_year4 (s: STRING): BOOLEAN is
			-- Is the code a year-numeric 
			-- On 4 figures?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("yyyy")
		end


	is_year2 (s: STRING): BOOLEAN is
			-- Is the code a year-numeric 
			-- On 2 figures?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("yy")
		end


	is_month (s: STRING): BOOLEAN is
			-- Is the code a month-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("mm")
		end


	is_month0 (s: STRING): BOOLEAN is
			-- Is the code a month-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("[0]mm")
		end


	is_month_text (s: STRING): BOOLEAN is
			-- Is the code a month-text?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("mmm")
		end


	is_hour (s: STRING): BOOLEAN is
			-- Is the code a 24-hour-clock-scale?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("hh")
		end


	is_hour0 (s: STRING): BOOLEAN is
			-- Is the code a 24-hour-clock-scale
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("[0]hh")
		end


	is_hour12 (s: STRING): BOOLEAN is
			-- Is the code a 12-hour-clock-scale?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("hh12")
		end


	is_minute (s: STRING): BOOLEAN is
			-- Is the code a minute-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("mi")
		end


	is_minute0 (s: STRING): BOOLEAN is
			-- Is the code a minute-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("[0]mi")
		end


	is_second (s: STRING): BOOLEAN is
			-- Is the code a second-numeric?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("ss")
		end


	is_second0 (s: STRING): BOOLEAN is
			-- Is the code a second-numeric
			-- Padded with zero?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("[0]ss")
		end


	is_fractional_second (s: STRING): BOOLEAN is
			-- Is the code a fractional-second 
			-- With precision to n figures?
		require
			s_exists: s /= Void
		local
			substrg, substrg2: STRING
		do
			substrg := s.substring (1, 2)
			substrg2 := s.substring (3, s.count)
			Result := substrg.is_equal ("ff") and substrg2.is_integer
		end

	is_colon (s: STRING): BOOLEAN is
			-- Is the code a separator-colomn?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal (":")
		end


	is_slash (s: STRING): BOOLEAN is
			-- Is the code a separator-slash?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("/")
		end


	is_minus (s: STRING): BOOLEAN is
			-- Is the code a separator-minus?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal ("-")
		end


	is_comma (s: STRING): BOOLEAN is
			-- Is the code a separator-coma?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal (",")
		end


	is_space (s: STRING): BOOLEAN is
			-- Is the code a separator-space?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal (" ")
		end


	is_dot (s: STRING): BOOLEAN is
			-- Is the code a separator-dot?
		require
			s_exists: s /= Void
		do
			Result := s.is_equal (".")
		end

	is_separator (s: STRING): BOOLEAN is
			-- Is the code a seperator?
		require
			s_exists: s /= Void
		do
			Result := is_slash (s) or else is_colon (s) or else
				is_minus (s) or else is_comma (s) or else is_space (s) or else
				is_dot (s)
		end

	is_meridiem (s: STRING): BOOLEAN is
			-- Is the code a meridiem notation?
		require
			s_exists: s /= Void
		local
			tmp: STRING
		do
			tmp := clone (s)
			tmp.to_upper
			Result := tmp.is_equal ("AM") or tmp.is_equal ("PM")
		end

end -- class CODE_VALIDITY_CHECKER


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

