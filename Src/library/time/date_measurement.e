indexing
	description: "Date Measurement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class DATE_MEASUREMENT inherit

	DATE_CONSTANTS

feature -- Access

	day: INTEGER is
			-- Number of days associated with current object
		deferred
		end

	month: INTEGER is
			-- Number of monthes associated with current object
		deferred
		end
	 
	year: INTEGER is
			-- Number of years associated with current object
		deferred
		end

feature -- Element change

	set_date (y, m, d: INTEGER) is
			-- Set `year' with `y', `month' with `m' and `day' with `d'.
		require
			d_large_enough: d >= 1
			m_large_enough: m >= 1
			m_small_enough: m <= Months_in_year
			d_small_enough: d <= days_in_i_th_month (m, y)
		deferred
		ensure
			day_set: day = d
			month_set: month = m
			year_set: year = y
		end

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATE_MEASUREMENT

