indexing
	description: "English settings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
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
				
			>>
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
			>>
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
				
			>>
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
			>>
			Result.compare_objects
		end

	date_default_format_string: STRING is "[0]mm/[0]dd/yyyy"

	time_default_format_string: STRING is "hh12:[0]mi:[0]ss.ff3 AM"

	default_format_string: STRING is "[0]mm/[0]dd/yyyy hh12:[0]mi:[0]ss.ff3 AM";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATE_TIME_TOOLS 


