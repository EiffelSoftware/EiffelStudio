note
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

	day: INTEGER
			-- Day of the current object
		do
			Result := ordered_compact_date & day_mask
		end

	month: INTEGER
			-- Month of the current object
		do
			Result := (ordered_compact_date & month_mask) |>> month_shift
		end

	year: INTEGER
			-- Year of the current object
		do
			Result := ((ordered_compact_date & year_mask) |>> year_shift) & 0x0000FFFF
		end

	ordered_compact_date: INTEGER
			-- Year, month, day coded for fast comparison between dates.

feature -- Element change

	set_date (y, m, d: INTEGER)
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

	set_day (d: INTEGER)
			-- Set `day' to `d'.
		local
			l_date: like ordered_compact_date
		do
			l_date := ordered_compact_date
			l_date := l_date & day_mask.bit_not
			l_date := l_date | d
			ordered_compact_date := l_date
		end

	set_month (m: INTEGER)
			-- Set `month' to `m'.
		local
			l_date: like ordered_compact_date
		do
			l_date := ordered_compact_date
			l_date := l_date & month_mask.bit_not
			l_date := l_date | (m |<< month_shift)
			ordered_compact_date := l_date
		end

	set_year (y: INTEGER)
			-- Set `year' to `y'.
		local
			l_date: like ordered_compact_date
		do
			l_date := ordered_compact_date
			l_date := l_date & year_mask.bit_not
			l_date := l_date | (y |<< year_shift)
			ordered_compact_date := l_date
		end

	set_internal_ordered_compact_date (a_ordered_compact_date: like ordered_compact_date)
			-- Set `a_ordered_compact_date' to `ordered_compact_date'.
		do
			ordered_compact_date := a_ordered_compact_date
		ensure
			ordered_compact_date_set: ordered_compact_date = a_ordered_compact_date
		end

feature -- Correction

	correct_mismatch
			-- Attempt to correct object mismatch using `mismatch_information'.
		do
				-- In version 5.3 and earlier, we were storing `compact_date' not
				-- `ordered_compact_date', so now we are retrieving a `compact_date'
				-- and we need to convert its value to `ordered_compact_date'.
			if attached {INTEGER_REF} Mismatch_information.item (compact_date_attribute_name) as l_compact_date then
				set_private_internal_compact_date (l_compact_date.item)
			else
					-- Does not seem to be the old version, we raise an exception
				Precursor {MISMATCH_CORRECTOR}
			end
		end

feature {NONE} -- Implementation

	day_mask: INTEGER = 0x000000FF
	month_mask: INTEGER = 0x0000FF00
	year_mask: INTEGER = 0xFFFF0000
			-- Mask used to extract/set `year', `month' and `day'.

	year_shift: INTEGER = 16
	month_shift: INTEGER = 8
	day_shift: INTEGER = 0
			-- Shift needed to extract/set `year', `month' and `day'.

	compact_date_attribute_name: STRING_8 = "compact_date"
			-- Name of `compacte_date' attribute in 5.3 and older version.

	set_private_internal_compact_date (a_compact_date: INTEGER)
			-- Set `a_compact_date' to `compact_date'.
		do
				-- TODO: Remove the feature when there are no callers anymore. [2020-05-31]
			set_date (
				a_compact_date & 0x000FFFF,
				(a_compact_date & 0x00FF0000) |>> 16,
				((a_compact_date & 0xFF000000) |>> 24) & 0x000000FF)
		ensure
			compact_date_set: year | (month |<< 16) | (day |<< 24) = a_compact_date
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
