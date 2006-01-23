indexing
	description: "Values of date"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	access: date

class DATE_VALUE

inherit
	DATE_MEASUREMENT
	
	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

feature -- Access

	day: INTEGER is
			-- Day of the current object
		do
			Result := ordered_compact_date & day_mask
		end

	month: INTEGER is
			-- Month of the current object
		do
			Result := (ordered_compact_date & month_mask) |>> month_shift
		end

	year: INTEGER is
			-- Year of the current object 
		do
			Result := ((ordered_compact_date & year_mask) |>> year_shift) & 0x0000FFFF
		end

	compact_date: INTEGER is
			-- Day, month and year coded.
		obsolete
			"Use `ordered_compact_date' instead. But be careful in your update %
			%since `compact_date' and `ordered_compact_date' do not have the same %
			%encoding."
		do
			Result := year | (month |<< 16) | (day |<< 24)
		end

	ordered_compact_date: INTEGER
			-- Year, month, day coded for fast comparison between dates.
			
feature -- Element change

	set_date (y, m, d: INTEGER) is
			-- Set `year' with `y', `month' with `m' and `day' with `d'.
		local
			l_date: like ordered_compact_date
		do
				-- Same as 
			l_date := l_date & day_mask.bit_not
			l_date := l_date | d

			l_date := l_date & month_mask.bit_not
			l_date := l_date | (m |<< month_shift)

			l_date := l_date & year_mask.bit_not
			l_date := l_date | (y |<< year_shift)
			
			ordered_compact_date := l_date
		end

	set_day (d: INTEGER) is
			-- Set `day' to `d'.
		local
			l_date: like ordered_compact_date
		do
			l_date := ordered_compact_date
			l_date := l_date & day_mask.bit_not
			l_date := l_date | d
			ordered_compact_date := l_date
		end

	set_month (m: INTEGER) is
			-- Set `month' to `m'.
		local
			l_date: like ordered_compact_date
		do
			l_date := ordered_compact_date
			l_date := l_date & month_mask.bit_not
			l_date := l_date | (m |<< month_shift)
			ordered_compact_date := l_date
		end
	
	set_year (y: INTEGER) is
			-- Set `year' to `y'.
		local
			l_date: like ordered_compact_date
		do
			l_date := ordered_compact_date
			l_date := l_date & year_mask.bit_not
			l_date := l_date | (y |<< year_shift)
			ordered_compact_date := l_date
		end

	set_internal_compact_date (a_compact_date: like compact_date) is
			-- Set `a_compact_date' to `compact_date'.
		obsolete
			"Use `ordered_compact_date' instead. But be careful in your update %
			%since `compact_date' and `ordered_compact_date' do not have the same %
			%encoding."
		do
			set_private_internal_compact_date (a_compact_date)
		ensure
			compact_date_set: year | (month |<< 16) | (day |<< 24) = a_compact_date
		end

	set_internal_ordered_compact_date (a_ordered_compact_date: like ordered_compact_date) is
			-- Set `a_ordered_compact_date' to `ordered_compact_date'.
		do
			ordered_compact_date := a_ordered_compact_date
		ensure
			ordered_compact_date_set: ordered_compact_date = a_ordered_compact_date
		end

feature -- Correction

	correct_mismatch is
			-- Attempt to correct object mismatch using `mismatch_information'.
		local
			l_compact_date: INTEGER_REF
		do
				-- In version 5.3 and earlier, we were storing `compact_date' not
				-- `ordered_compact_date', so now we are retrieving a `compact_date'
				-- and we need to convert its value to `ordered_compact_date'.
			l_compact_date ?= Mismatch_information.item (compact_date_attribute_name)
			if l_compact_date /= Void then
				set_private_internal_compact_date (l_compact_date.item)
			else
					-- Does not seem to be the old version, we raise an exception
				Precursor {MISMATCH_CORRECTOR}
			end
		end
		
feature {NONE} -- Implementation

	day_mask: INTEGER is 0x000000FF
	month_mask: INTEGER is 0x0000FF00
	year_mask: INTEGER is 0xFFFF0000
			-- Mask used to extract/set `year', `month' and `day'.
			
	year_shift: INTEGER is 16
	month_shift: INTEGER is 8
	day_shift: INTEGER is 0
			-- Shift needed to extract/set `year', `month' and `day'.

	compact_date_attribute_name: STRING is "compact_date"
			-- Name of `compacte_date' attribute in 5.3 and older version.

	set_private_internal_compact_date (a_compact_date: like compact_date) is
			-- Set `a_compact_date' to `compact_date'.
		do
			set_date (
				a_compact_date & 0x000FFFF,
				(a_compact_date & 0x00FF0000) |>> 16,
				((a_compact_date & 0xFF000000) |>> 24) & 0x000000FF)
		ensure
			compact_date_set: year | (month |<< 16) | (day |<< 24) = a_compact_date
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




end -- class DATE_VALUE

