indexing
	description: "Values of time"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: time

class TIME_VALUE inherit

	TIME_MEASUREMENT
		
feature -- Access 

	hour: INTEGER is
			-- Hour of the current time
		do
			Result := (compact_time & hour_mask) |>> hour_shift
		end
	
	minute: INTEGER is
			-- Minute of the current time
		do
			Result := (compact_time & minute_mask) |>> minute_shift
		end
	
	second: INTEGER is
			-- Second of the current time
		do
			Result := compact_time & second_mask
		end

	fractional_second: DOUBLE 
			-- Fractional part of `fine_second'

	compact_time: INTEGER 
			-- Hour, minute, second coded.

	fine_second: DOUBLE is
			-- Representation of second with decimals 
		do
			Result := second + fractional_second
		end

	milli_second: INTEGER is 
			-- Millisecond of the current time
		do 
			Result := (fractional_second * 1000).truncated_to_integer 
		end

	micro_second: INTEGER is 
			-- Microsecond of the current time
		do 
			Result := (fractional_second * 1_000_000).truncated_to_integer
			Result := Result \\ 1000
		end; 

	nano_second: INTEGER is 
			-- Nanosecond of the current time
		do 
			Result := (fractional_second * 1_000_000_000).truncated_to_integer
			Result := Result \\ 1000
		end 

feature -- Element change 

	set_hour (h: INTEGER) is 
			-- Set `hour' to `h'.
		do 
			compact_time := compact_time & hour_mask.bit_not
			compact_time := compact_time | (h |<< hour_shift)
		end

	set_minute (m: INTEGER) is 
			-- Set `minute' to `m'.
		do 
			compact_time := compact_time & minute_mask.bit_not
			compact_time := compact_time | (m |<< minute_shift)
		end

	set_second (s: INTEGER) is 
			-- Set `second' to `s'.
		do 
			compact_time := compact_time & second_mask.bit_not
			compact_time := compact_time | s
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

feature {NONE} -- Implementation

	hour_mask: INTEGER is 0x00FF0000
	minute_mask: INTEGER is 0x0000FF00
	second_mask: INTEGER is 0x000000FF
			-- Mask used to extract/set `hour', `minute' and `second'.
			
	hour_shift: INTEGER is 16
	minute_shift: INTEGER is 8
			-- Shift needed to extract/set `hour' and `minute'.

end -- class TIME_VALUE

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
