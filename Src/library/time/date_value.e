indexing
	description: "Values of date"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date

class DATE_VALUE inherit

	DATE_MEASUREMENT
		
feature -- Access

	day: INTEGER is
			-- Day of the current object
		do
			Result := c_day (compact_date)
		end

	month: INTEGER is
			-- Month of the current object
		do
			Result := c_month (compact_date)
		end

	year: INTEGER is
			-- Year of the current object 
		do
			Result := c_year (compact_date)
		end

	compact_date: INTEGER
			-- Day, month and year coded.

feature -- Element change

	set_day (d: INTEGER) is
			-- Set `day' to `d'.
		do
			c_set_day (d, $compact_date)
		end

	
	set_month (m: INTEGER) is
			-- Set `month' to `m'.
		do
			c_set_month (m, $compact_date)
		end
	
	set_year (y: INTEGER) is
			-- Set `year' to `y'.
		do
			c_set_year (y, $compact_date)
		end

feature {NONE} -- External

	c_day (c_d: INTEGER): INTEGER is
		external
			"C"
		end

	c_month (c_d: INTEGER): INTEGER is
		external
			"C"
		end

	c_year (c_d: INTEGER): INTEGER is
		external
			"C"
		end

	c_set_day (d: INTEGER; c_d: POINTER) is
			-- Initialize the day in `compact_date'.
		external
			"C"
		end

	c_set_month (m: INTEGER; c_d: POINTER) is
			-- Initialize the month in `compact_date'.
		external
			"C"
		end

	c_set_year (y: INTEGER; c_d: POINTER) is
			-- Initialize the year in `compact_date'.
		external
			"C"
		end

end -- class DATE_VALUE



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

