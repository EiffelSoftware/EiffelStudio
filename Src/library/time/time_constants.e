indexing
	description: "Universal constants of time in a day"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: time

class TIME_CONSTANTS inherit

	TIME_UTILITY
		export
			{NONE} all
		end

feature -- Access

	Seconds_in_minute: INTEGER is 60
			-- Number of seconds in a minute
			
	Seconds_in_hour: INTEGER is 3600
			-- Number of seconds in an hour
			
	Seconds_in_day: INTEGER is 86400; 
			-- Number of seconds in an hour 
			 
	Minutes_in_hour: INTEGER is 60
			-- Number of minutes in an hour
			
	Hours_in_day: INTEGER is 24
			-- Number of hours in a day

	time_default_format_string: STRING is
			-- Default output format for times
		do
			Result := date_time_tools.time_default_format_string
		end
	
end -- class TIME_CONSTANTS


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

