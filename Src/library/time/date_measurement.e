indexing
	description: "Date Measurement"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATE_MEASUREMENT

inherit
	DATE_CONSTANTS

feature -- Access

	day: INTEGER is deferred end
		-- Number of days associated with current object.

	month: INTEGER is deferred end
		-- Number of monthes associated with current object.

	year: INTEGER is deferred end
		-- Number of years associated with current object.

feature -- Element change

	set_day (d: INTEGER) is
			-- Set `day' to `d'.
		require
			d_large_enough: d >= 1
			d_small_enough: d <= days_in_month
		deferred
		ensure
			day_set: day = d
		end

	set_month (m: INTEGER) is
			-- Set `month' to `m'.
			-- `day' must be small enough.
		require
			m_large_enough: m >= 1
			m_small_enough: m <= Months_in_year
			d_small_enough: day <= days_in_i_th_month (m, year)
		deferred
		ensure
			month_set: month = m
		end
	
	set_year (y: INTEGER) is
			-- Set `year' to `y'.
		require
			can_not_cut_29th_feb: day <= days_in_i_th_month (month, y)
		deferred
		ensure
			year_set: year = y
		end

feature -- Status Report

	days_in_month: INTEGER is
			-- Number of days in month 'month'.
		do
			Result := days_in_i_th_month (month, year)
		ensure
			positive_result: Result > 0
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

end -- class DATE_MEASUREMENT
