indexing
	description: "time value in a day"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	TIME_VALUE

inherit

	TIME_MEASUREMENT
		
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

	fractional_second: DOUBLE 
			-- Fractional part of `fine_second'

	compact_time: INTEGER 
			-- Hour, minute, second coded.

	fine_second: DOUBLE is
			-- Representation of second with decimals 
 		do
			Result := second + fractional_second;
		end

	milli_second: INTEGER is 
			-- Millisecond of the current time
		do 
			Result := (fractional_second * 1000).truncated_to_integer 
		end;

	micro_second: INTEGER is 
			-- Microsecond of the current time
		do 
			Result := (fractional_second * 1_000_000).truncated_to_integer;
			Result := Result \\ 1000
		end; 
 
	nano_second: INTEGER is 
			-- Nanosecond of the current time
		do 
			Result := (fractional_second * 1_000_000_000).truncated_to_integer;
			Result := Result \\ 1000
		end 
 
feature -- Element change 
 
	set_second (s: INTEGER) is 
			-- Set `second' to `s'.
		do 
			c_set_second (s, $compact_time)
		end

	set_fine_second (s: DOUBLE) is 
			-- Set `fine_second' to `s'
		local
			s_tmp: INTEGER 
		do 
			s_tmp := s.truncated_to_integer
			fractional_second := s - s_tmp
			set_second (s_tmp)
		end

	set_fractionals (f: DOUBLE) is
			-- Set `fractional_second' to `f'.
		do
			fractional_second := f
		end

	set_minute (m: INTEGER) is 
			-- Set `minute' to `m'.
		do 
			c_set_minute (m, $compact_time) 
		end

	set_hour (h: INTEGER) is 
			-- Set `hour' to `h'.
		do 
			c_set_hour (h, $compact_time)
		end

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

	c_set_hour (h:INTEGER; c_t: POINTER) is
		external
			"C"
		end;

	c_set_minute (h:INTEGER; c_t: POINTER) is
		external
			"C"
		end;

	c_set_second (h:INTEGER;c_t: POINTER) is
		external
			"C"
		end;

end -- class TIME_VALUE


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


