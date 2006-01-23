indexing
	description: "Language settings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class DATE_TIME_LANGUAGE_CONSTANTS


