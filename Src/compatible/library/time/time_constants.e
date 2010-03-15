note
	description: "Universal constants of time in a day"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: time

class TIME_CONSTANTS

inherit
	TIME_UTILITY
		export
			{NONE} mod, div
		end

feature -- Access

	Seconds_in_minute: INTEGER = 60
			-- Number of seconds in a minute

	Seconds_in_hour: INTEGER = 3600
			-- Number of seconds in an hour

	Seconds_in_day: INTEGER = 86400;
			-- Number of seconds in an hour

	Minutes_in_hour: INTEGER = 60
			-- Number of minutes in an hour

	Hours_in_day: INTEGER = 24
			-- Number of hours in a day

	time_default_format_string: STRING
			-- Default output format for times
		do
			Result := date_time_tools.time_default_format_string
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TIME_CONSTANTS



