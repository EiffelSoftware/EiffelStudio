indexing
	description: "Values of date"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date

class DATE_VALUE

inherit
	DATE_MEASUREMENT
		
feature -- Access

	day: INTEGER is
			-- Day of the current object
		do
			Result := ((compact_date & day_mask) |>> day_shift) & 0x000000FF
		end

	month: INTEGER is
			-- Month of the current object
		do
			Result := (compact_date & month_mask) |>> month_shift
		end

	year: INTEGER is
			-- Year of the current object 
		do
			Result := compact_date & year_mask
		end

	compact_date: INTEGER
			-- Day, month and year coded.

feature -- Element change

	set_day (d: INTEGER) is
			-- Set `day' to `d'.
		do
			compact_date := compact_date & day_mask.bit_not
			compact_date := compact_date | (d |<< day_shift)
		end

	set_month (m: INTEGER) is
			-- Set `month' to `m'.
		do
			compact_date := compact_date & month_mask.bit_not
			compact_date := compact_date | (m |<< month_shift)
		end
	
	set_year (y: INTEGER) is
			-- Set `year' to `y'.
		do
			compact_date := compact_date & year_mask.bit_not
			compact_date := compact_date | y
		end

feature {NONE} -- Implementation

	day_mask: INTEGER is 0xFF000000
	month_mask: INTEGER is 0x00FF0000
	year_mask: INTEGER is 0x0000FFFF
			-- Mask used to extract/set `day', `month' and `year'.
			
	day_shift: INTEGER is 24
	month_shift: INTEGER is 16
			-- Shift needed to extract/set `day' and `month'.

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
