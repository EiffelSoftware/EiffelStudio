indexing

	description:
		"Formatter for non-integral numbers";

	copyright: "See notice at end of class";
	names: format_double;
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_DOUBLE

inherit
	FORMAT_INTEGER
		rename 
			make as set_defaults,
			separate as separate_integral,
			formatted as fm_formatted
		export {NONE}
			fm_formatted
		redefine
			comma_separate,
			underscore_separate,
			remove_separator
		end;

	DOUBLE_MATH
		export {NONE}
			all
			end

creation
	make

feature -- Initialization

	make (w,d: INTEGER) is
		require 
			reasonable_field: w >= 1
			reasonable_decimals: d <= w
		do
			set_defaults (w)
			decimals := d
			decimal := '.'
		ensure 
			blank_fill: fill_character = ' '
			show_sign_negative: show_sign_negative
			no_separator: no_separator
			width_set: width = w
			right_justified: right_justified
			leading_sign: leading_sign
			decimals_set: decimals = d
			decimal_point: decimal = '.'
		end

feature -- Access

	after_decimal_separate : BOOLEAN
			-- Use separators after the decimal?

	decimals: INTEGER
			-- Number of digits after the decimal point.

	zero_not_shown: BOOLEAN
			-- Show 0.5 as .5 or 0.5?

	decimal: CHARACTER
			-- What is used for the decimal

feature -- Status setting

	point_decimal is
			-- Use . as the decimal point.
		do
			decimal := '.'
		ensure
			decimal = '.'
		end

	comma_decimal is
			-- Use , as the decimal point.
		do
			decimal := ','
		ensure
			decimal = ','
		end

	set_decimals (d :INTEGER) is
			-- `d' decimals to be displayed.
		require
			d <= width
		do
			decimals := d
		ensure
			decimals = d
		end

	separate_after_decimal is
			-- Use separators after the decimal.
		do
			after_decimal_separate := true
		ensure
			after_decimal_separate
		end

	no_separate_after_decimal is
			-- Do not use separators after the decimal.
		do
			after_decimal_separate := false
		ensure
			not after_decimal_separate
		end

	underscore_separate is
			-- Set the separator to be underscore.
		do
			separator := '_'
			separate_after_decimal
		ensure then
			after_decimal_separate
		end

	comma_separate is
			-- Set the separator to be comma.
		do
			separator := ','
			separate_after_decimal
		ensure then
			after_decimal_separate
		end

	remove_separator is
			-- Remove the separator.
		do
			separator := '%U'
			no_separate_after_decimal
		ensure then
			not after_decimal_separate
		end


	show_zero is
			-- Show 0.5 as 0.5 .
		do
			zero_not_shown := false
		ensure
			not zero_not_shown
		end 

	hide_zero is
			-- Show 0.5 as .5 .
		do
			zero_not_shown := true
		ensure
			zero_not_shown
		end

feature -- Conversion

	formatted (d : DOUBLE): STRING is
			-- Format `d'.
		local
			sign : INTEGER
			integral, fraction: DOUBLE
			ints, fracs: STRING
		do
			if d < 0 then
				sign := -1
				integral := -floor (d)
				fraction := floor ((d - floor (d)) * 10^(decimals+1))
			elseif d > 0 then
				sign := 1
				integral := floor (d)
				fraction := floor ((d - floor (d)) * 10^(decimals+1))
			end
			if not no_separator then
				ints := separate_integral (integral.out)
				if after_decimal_separate then
					fracs := separate_fraction (pad_fraction(fraction))
				else
					fracs := pad_fraction (fraction)
				end
			else
				ints := clone (integral.out)
				fracs := pad_fraction (fraction)
			end
			!!Result.make (width)
			if integral /= 0 or else not zero_not_shown then
				Result.append (ints)
			end
			Result.extend (decimal)
			if decimals > 0 then
				Result.append (fracs)
			end
			if not ignore_sign then 
				Result := process_sign (Result, sign)
			 end
			if justification /= No_justification and then Result.count < width then	
				Result := justify (Result)
			end
		ensure
			exists: Result /= Void
			correct_width: Result.count >= width
		end

feature {NONE} -- Implementation

	pad_fraction (f: DOUBLE): STRING is
			-- Stretch or shrink `f' to length `decimals' .
		do
			Result := (f+5).out
			Result.head (Result.count - 1)
			if Result.count > decimals then
				Result := Result.substring (1, decimals)
			else
				from
				until
					Result.count = decimals
				loop
					Result.extend ('0')
				end
			end
		ensure
			Result.count = decimals
		end

	separate_fraction (s : STRING): STRING is
			-- Apply separators to the fraction.
		require
			efficiency: separator /= '%U'
		local
			count, sep_length: INTEGER
		do
			from
				count := 1
				!!Result.make (width)
			until
				count > s.count - 3
			loop
				from
					sep_length := 0
				until
					sep_length = 3
				loop
					Result.extend (s.item (count))
					count := count + 1
					sep_length := sep_length + 1
				end
				Result.extend (separator)
			end
			from
			until
				count > s.count
			loop
				Result.extend (s.item (count))
				count := count + 1
			end
		end -- separate_fraction

invariant
	separate_all: no_separator implies not after_decimal_separate

end -- class FORMAT_REAL
--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
