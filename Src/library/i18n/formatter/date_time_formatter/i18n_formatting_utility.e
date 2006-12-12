indexing
	description: "Class that provides some common padding features for formatting"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class I18N_FORMATTING_UTILITY

feature -- Pad

	pad_with_0_left (a_integer, length: INTEGER_32): STRING_32
			-- add `0' on the left of `a_integer', so that it has
			-- a length of `length'
		require
			valid_length: length > 0
			a_integer_not_to_large: a_integer < (10 ^ (length + 1) - 1)
		do
			Result := pad_left (a_integer, length, '0')
		ensure
			correct_length: Result.count = length
		end

	pad_with_0_right (a_integer, length: INTEGER_32): STRING_32
			-- add `0' on the right of `a_integer', so that it has
			-- a length of `length'
		require
			valid_length: length > 0
			a_integer_not_to_large: a_integer < (10 ^ (length + 1) - 1)
		do
			Result := pad_right (a_integer, length, '0')
		ensure
			correct_length: Result.count = length
		end

	pad_with_space_left (a_integer, length: INTEGER_32): STRING_32
			-- add spaces on the right of `a_integer', so that it has
			-- a length of `length'
		require
			valid_length: length > 0
			a_integer_not_to_large: a_integer < (10 ^ (length + 1) - 1)
		do
			Result := pad_left (a_integer, length, ' ')
		ensure
			correct_length: Result.count = length
		end

	pad_with_space_right (a_integer, length: INTEGER_32): STRING_32
			-- add spaces on the left of `a_integer', so that it has
			-- a length of `length'
		require
			valid_length: length > 0
			a_integer_not_to_large: a_integer < (10 ^ (length + 1) - 1)

		do
			Result := pad_right (a_integer, length, ' ')
		ensure
			correct_length: Result.count = length
		end

feature {NONE} -- Implementation

	pad_left (a_integer, length: INTEGER_32; padder: CHARACTER_8): STRING_32
			-- Add `padder' to the left of `a_integer' to that the result has
			-- a length of `length'
		require
			valid_length: length > 0
			a_integer_not_to_large: a_integer < (10 ^ (length + 1) - 1)
		local
			l_string: STRING_32
		do
			Result := a_integer.out
			if Result.count < length then
				create l_string.make_filled (padder, length - Result.count)
				Result.prepend (l_string)
			end
		ensure
			correct_length: Result.count = length
		end

	pad_right (a_integer, length: INTEGER_32; padder: CHARACTER_8): STRING_32
			-- Add `padder' to the right of `a_integer' to that the result has
			-- a lenght of `length'
		require
			valid_length: length > 0
			a_integer_not_to_large: a_integer < (10 ^ (length + 1) - 1)
		local
			l_string: STRING_32
		do
			Result := a_integer.out
			if Result.count < length then
				create l_string.make_filled (padder, length - Result.count)
				Result.append (l_string)
			end
		ensure
			correct_length: Result.count = length
		end

end
