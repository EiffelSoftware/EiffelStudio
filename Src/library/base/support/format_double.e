class FORMAT_DOUBLE
	-- Given a double and a series of details produce formatted strings.

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
		ensure 
			blank_fill: fill_character = ' '
			show_sign_negative: show_sign_negative
			no_separator: no_separator
			width_set: width = w
			right_justified: right_justified
			leading_sign: leading_sign
			decimals_set: decimals = d
		end

feature -- Access

	after_decimal_separate : BOOLEAN
			-- Use separators after the decimal?

	decimals: INTEGER
			-- Number of digits after the decimal point.

feature -- Status setting

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
			Result.append (ints)
			Result.append (".")
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
			Result := f.out
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
