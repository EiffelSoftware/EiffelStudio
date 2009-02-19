note
	description: "Class that provides functions to format a number according to information in an I18N_NUMERIC_INFO"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_VALUE_FORMATTER

create
	make

feature -- Initialization

	make (a_numeric_info: I18N_NUMERIC_INFO)
			-- create value formatter according to
			-- values in `a_numeric_info'
		require
			a_numeric_info_exists: a_numeric_info /= Void
		do
			decimal_separator := a_numeric_info.value_decimal_separator
			numbers_after_decimal_separator := a_numeric_info.value_numbers_after_decimal_separator
			group_separator := a_numeric_info.value_group_separator
			grouping := a_numeric_info.value_grouping
			positive_sign := a_numeric_info.value_positive_sign
			negative_sign := a_numeric_info.value_negative_sign
		end

feature -- Integer Formatting functions

	format_integer_8 (a_integer_8: INTEGER_8): STRING_32
		do
			if a_integer_8 < 0 then
				create Result.make_from_string (negative_sign + format_integer_part (a_integer_8.abs.out))
			else
				create Result.make_from_string (positive_sign + format_integer_part (a_integer_8.abs.out))
			end
		ensure
			Result_exists: Result /= Void
		end

	format_integer_16 (a_integer_16: INTEGER_16): STRING_32
		do
			if a_integer_16 < 0 then
				create Result.make_from_string (negative_sign + format_integer_part (a_integer_16.abs.out))
			else
				create Result.make_from_string (positive_sign + format_integer_part (a_integer_16.abs.out))
			end
		ensure
			Result_exists: Result /= Void
		end

	format_integer_32 (a_integer_32: INTEGER_32): STRING_32
		do
			if a_integer_32 < 0 then
				create Result.make_from_string (negative_sign + format_integer_part (a_integer_32.abs.out))
			else
				create Result.make_from_string (positive_sign + format_integer_part (a_integer_32.abs.out))
			end
		ensure
			Result_exists: Result /= Void
		end

	format_integer_64 (a_integer_64: INTEGER_64): STRING_32
		do
			if a_integer_64 < 0 then
				create Result.make_from_string (negative_sign + format_integer_part (a_integer_64.abs.out))
			else
				create Result.make_from_string (positive_sign + format_integer_part (a_integer_64.abs.out))
			end
		ensure
			Result_exists: Result /= Void
		end

feature -- Real formatting functions		

	format_real_32 (a_real_32: REAL_32): STRING_32
		local
			sign: STRING_32
			integer_part,
			fractional_part: INTEGER
		do
			if a_real_32.sign < 0 then
				sign := negative_sign
			else
				sign := positive_sign
			end
			integer_part := a_real_32.truncated_to_integer
			fractional_part := ((a_real_32 - integer_part) * 10^numbers_after_decimal_separator).rounded
			create Result.make_from_string (sign +
											format_integer_part (integer_part.abs.out) +
											decimal_separator +
											format_real_part (fractional_part.abs.out))
		ensure
			Result_exists: Result /= Void
		end

	format_real_64 (a_real_64: REAL_64): STRING_32
		local
			sign: STRING_32
			integer_part,
			fractional_part: INTEGER
		do
			if a_real_64.sign < 0 then
				sign := negative_sign
			else
				sign := positive_sign
			end
			integer_part := a_real_64.truncated_to_integer
			fractional_part := ((a_real_64 - integer_part) * 10^numbers_after_decimal_separator).rounded
			create Result.make_from_string (sign +
											format_integer_part (integer_part.abs.out) +
											decimal_separator +
											format_real_part (fractional_part.abs.out))
		ensure
			Result_exists: Result /= Void
		end


feature {NONE} -- Informations

	decimal_separator: STRING_32

	numbers_after_decimal_separator: INTEGER

	group_separator: STRING_32
			-- separator character for thousands
			--(groups of three digits)

	positive_sign: STRING_32
	negative_sign: STRING_32

	grouping: ARRAY[INTEGER]
			-- how the value are grouped

feature {NONE} -- Implementation

	format_integer_part (a_string: STRING_32): STRING_32
			-- group the `a_string' according the rules in `grouping'
		require
			a_string_exists: a_string /= Void
			is_integer: a_string.is_integer
		local
			i,pos: INTEGER
		do
			create Result.make_empty
			from
				i := grouping.lower
				pos := a_string.count
			variant
				 grouping.upper - i + 1
			until
				i > grouping.upper or pos < 1
			loop
				if grouping.item (i) > 0 then
						-- Current item is the number of digits that comprise the current group.
					if pos - grouping.item (i) > 0 then
							-- there are enougth elements for a new group
						Result.prepend (a_string.substring (pos - grouping.item (i) + 1, pos))
						Result.prepend (group_separator)
						pos := pos-grouping.item (i)
					else
							--run out of digits, append rest and finish
						Result.prepend (a_string.substring (1, pos))
						pos := 0
					end
				elseif i - 1 >= grouping.lower then
						-- The previous element has to be repeatedly used for the remainder of the digits.
					from
					variant
						pos
					until
						pos < 1	-- no more digits
					loop
						if pos - grouping.item (i - 1) > 0 then
							-- there are enougth elements for a new group
							Result.prepend (a_string.substring (pos - grouping.item (i - 1) + 1, pos))
							Result.prepend (group_separator)
							pos := pos - grouping.item (i - 1)
						else
								--run out of digits, append rest and finish
							Result.prepend (a_string.substring (1, pos))
							pos := 0
						end
					end
					i := grouping.upper -- to terminate loop
				else	-- grouping.item (i) <= 0 and i-1 < grouping.lower
						-- i.e. no valid grouping array. Append rest to result and finish
					Result.prepend (a_string.substring (1, pos))
					i := grouping.upper -- to terminate loop
				end
				i := i + 1
			end
		ensure
			Result_exists: Result /= Void
		end

	format_real_part (a_string: STRING_32): STRING_32
			--
		require
			a_string_exists: a_string /= Void
			is_integer: a_string.is_integer
		do
			if a_string.is_equal ("0") then
					-- real part is equal 0
				create Result.make_filled ('0', numbers_after_decimal_separator)
			else
				create Result.make_from_string (a_string.substring (1, numbers_after_decimal_separator))
			end
		ensure
			Result_exists: Result /= Void
		end

invariant
	decimal_separator_exists: decimal_separator /= Void
	reasonable_numbers_after_decimal_separator: numbers_after_decimal_separator >= 0
	group_separator_exists: group_separator  /= Void
	valid_grouping: grouping /= Void and then grouping.count > 0

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
