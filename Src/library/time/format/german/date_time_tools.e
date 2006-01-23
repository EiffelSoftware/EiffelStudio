indexing
	description: "German settings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	DATE_TIME_TOOLS	

inherit 	
	DATE_TIME_LANGUAGE_CONSTANTS

feature 

	name: STRING is "German"

	days_text: ARRAY [STRING] is
		once
			Result := <<
				"SON",
				"MON",
				"DIE",
				"MIT",
				"DON",
				"FRE",
				"SAM"
				
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
				"MAI",
				"JUN",
				"JUL",
				"AUG",
				"SEP",
				"OCT",
				"NOV",
				"DEZ"
			>>
			Result.compare_objects
		end

	long_days_text: ARRAY [STRING] is
		once
			Result := <<
				"SONNTAG",
				"MONTAG",
				"DIENSTAG",
				"MITTWOCH",
				"DONNERSTAG",
				"FREITAG",
				"SAMSTAG"
				
			>>
			Result.compare_objects
		end

	long_months_text: ARRAY [STRING] is
		once
			Result := <<
				"JANUAR",
				"FEBRUAR",
				"MARZ",
				"APRIL",
				"MAI",
				"JUNI",
				"JULI",
				"AUGUST",
				"SEPTEMBER",
				"OCTOBER",
				"NOVEMBER",
				"DEZEMBER"
			>>
			Result.compare_objects
		end

	date_default_format_string: STRING is "[0]dd/[0]mm/yyyy"

	time_default_format_string: STRING is "[0]hh:[0]mi:[0]ss.ff3"

	default_format_string: STRING is "[0]dd/[0]mm/yyyy [0]hh:[0]mi:[0]ss.ff3";

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


