indexing
	description: "English settings";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATE_TIME_TOOLS	

inherit 	
	DATE_TIME_LANGUAGE_CONSTANTS

feature 

	name: STRING is "English"

	days_text: ARRAY [STRING] is
		once
			Result := <<
				"SUN",
				"MON",
				"TUE",
				"WED",
				"THU",
				"FRI",
				"SAT"
				
			>>;
			Result.compare_objects
		end

	months_text: ARRAY [STRING] is
		once
			Result := <<
				"JAN",
				"FEB",
				"MAR",
				"APR",
				"MAY",
				"JUN",
				"JUL",
				"AUG",
				"SEP",
				"OCT",
				"NOV",
				"DEC"
			>>;
			Result.compare_objects
		end

	long_days_text: ARRAY [STRING] is
		once
			Result := <<
				"SUNDAY",
				"MONDAY",
				"TUESDAY",
				"WEDNESDAY",
				"THURSDAY",
				"FRIDAY",
				"SATURDAY"
				
			>>;
			Result.compare_objects
		end

	long_months_text: ARRAY [STRING] is
		once
			Result := <<
				"JANUARY",
				"FEBRUARY",
				"MARCH",
				"APRIL",
				"MAY",
				"JUNE",
				"JULY",
				"AUGUST",
				"SEPTEMBER",
				"OCTOBER",
				"NOVEMBER",
				"DECEMBER"
			>>;
			Result.compare_objects
		end

	date_default_format_string: STRING is "[0]mm/[0]dd/yyyy"

	time_default_format_string: STRING is "hh12:[0]mi:[0]ss.ff3"

	default_format_string: STRING is "[0]mm/[0]dd/yyyy hh12:[0]mi:[0]ss.ff3"

end -- class DATE_TIME_TOOLS 

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
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