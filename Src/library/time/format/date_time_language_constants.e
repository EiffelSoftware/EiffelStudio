indexing
	description: "Language settings"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATE_TIME_LANGUAGE_CONSTANTS

feature

	name: STRING is
			-- Language
		deferred
		end

	days_text: ARRAY [STRING] is
			-- Array of days in short format.
		deferred
		end

	months_text: ARRAY [STRING] is
			-- Array of monthes in short format.
		deferred
		end

	long_days_text: ARRAY [STRING] is
			-- Array of days in long format.
		deferred
		end

	long_months_text: ARRAY [STRING] is
			-- Array of monthes in long format.
		deferred
		end

	default_format_string: STRING is 
			-- Standard output of the date and time.
		deferred
		end

	date_default_format_string: STRING is 
			-- Standard output of the date.
		deferred
		end		

	time_default_format_string: STRING is 
			-- Standard output of the time.
		deferred
		end

end -- class DATE_TIME_LANGUAGE_CONSTANTS


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

