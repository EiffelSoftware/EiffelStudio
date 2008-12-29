note
	description: "Class that provides some common padding features for formatting"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
