indexing
	description: "time value in a day"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	TIME_VALUE

inherit
	TIME_CONSTANTS

creation

feature -- Access 

	hour: INTEGER is
			-- Hour of the current time
		do
			Result := c_hour (compact_time);
		end
	
	minute: INTEGER is
			-- Minute of the current time
		do
			Result := c_minute (compact_time);
		end
	
	second: INTEGER is
			-- Second of the current time
		do
			Result := c_second (compact_time);
		end;

	fractionnal_second: DOUBLE 
			-- Fractionnal part of `fine_second'

	compact_time: INTEGER 
			-- Hour, minute, second coded.

	fine_second: DOUBLE is
			-- Representation of second with decimals 
 		do
			Result := second + fractionnal_second;
		end

	milli_second: INTEGER is 
			-- Millisecond of the current time
		do 
			Result := (fractionnal_second * 1000).truncated_to_integer 
		end;

	micro_second: INTEGER is 
			-- Microsecond of the current time
		do 
			Result := (fractionnal_second * 1_000_000).truncated_to_integer;
			Result := Result \\ 1000
		end; 
 
	nano_second: INTEGER is 
			-- Nanosecond of the current time
		do 
			Result := (fractionnal_second * 1_000_000_000).truncated_to_integer;
			Result := Result \\ 1000
		end; 
 
feature {NONE} -- Externals

	c_hour (c_t: INTEGER): INTEGER is
		external
			"C"
		end

	c_minute (c_t: INTEGER): INTEGER is
		external
			"C"
		end

	c_second (c_t: INTEGER): INTEGER is
		external
			"C"
		end

end -- class TIME_VALUE


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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


