indexing
	description: "Time Measurable Units"
	date: "$Date$"
	revision: "$Revision$"

deferred class TIME_MEASUREMENT inherit

	TIME_CONSTANTS

feature -- Access

	hour: INTEGER is
		-- Number of hours associated with current object
		deferred
		end
	

	minute: INTEGER is
		-- Number of minutes associated with current object
		deferred
		end
	 
	second: INTEGER is
		-- Number of seconds associated with current object.
		deferred
		end
	
	fine_second: DOUBLE is
		-- Number of fine seconds associated with current object
		deferred
		end
	 
feature -- Settings

	set_second (s: INTEGER) is 
			-- Set `second' to `s'.
		require 
			s_large_enough: s >= 0; 
			s_small_enough: s < Seconds_in_minute 
		deferred
		ensure 
			second_set: second = s 
		end

	set_fine_second (s: DOUBLE) is 
			-- Set `fine_second' to `s'
		require 
			s_large_enough: s >= 0; 
			s_small_enough: s < Seconds_in_minute
		deferred
		ensure
			fine_second_set: fine_second = s
		end

	set_fractionals (f: DOUBLE) is
			-- Set `fractional_second' to `f'.
		require
			f_large_enough: f >= 0
			f_small_enough: f < 1 
		deferred
		ensure
			second_same: second = old second
		end	

	set_minute (m: INTEGER) is 
			-- Set `minute' to `m'.
		require 
			m_large_enough: m >= 0 
			m_small_enough: m < Minutes_in_hour 
		deferred
		ensure 
			minute_set: minute = m 
		end

	set_hour (h: INTEGER) is 
			-- Set `hour' to `h'.
		require 
			h_large_enough: h >= 0; 
			h_small_enough: h < Hours_in_day 
		deferred 
		ensure 
			hour_set: hour = h 
		end

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

end -- class TIME_MEASUREMENT
