indexing
	description: "Universal constants of time in a day"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	TIME_CONSTANTS

inherit
	TIME_UTILITY

feature -- Access

	Seconds_in_minute: INTEGER is 60;
			-- Number of seconds in a minute
			
	Seconds_in_hour: INTEGER is 3600;
			-- Number of seconds in an hour
			
	Seconds_in_day: INTEGER is 86400; 
			-- Number of seconds in an hour 
			 
	Minutes_in_hour: INTEGER is 60;
			-- Number of minutes in an hour
			
	Hours_in_day: INTEGER is 24;
			-- Number of hours in a day
			
end -- class TIME_CONSTANTS


--|---------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|---------------------------------------------------------------
