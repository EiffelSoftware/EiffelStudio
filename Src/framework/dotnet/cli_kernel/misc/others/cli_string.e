note
	description: "Summary description for {CLI_STRING}."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_STRING

inherit
	NATIVE_STRING
		rename
			make_from_pointer as make_by_pointer,
			unit_size as character_size,
			unit_count as count,
			string as string_32
		redefine
			character_size
		end

	STRING_HANDLER
		undefine
			is_equal
		end

create
	make,
	make_empty,
	make_from_path,
	make_by_pointer,
	make_by_pointer_and_count,
	make_with_newline_conversion,
	share_from_pointer,
	share_from_pointer_and_count

feature --{NONE} -- Initialization

	make_from_path (a_path: PATH)
			-- Make a C string from `a_path'.
		do
			managed_data := a_path.to_pointer
			count := (managed_data.count - character_size) // character_size
		end

	make_by_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- Make a copy of first `a_length' byte of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
			a_length_valid: (a_length \\ character_size) = 0
		do
			count := a_length // character_size
			create managed_data.make (a_length + character_size)
			managed_data.item.memory_copy (a_ptr, a_length)
		end

	make_with_newline_conversion (a_string: READABLE_STRING_GENERAL)
			-- Make a C string from `a_string' guaranteeing that all newline (linefeed) characters '%N'
			-- are prepended with a carriage return character '%R'.
		do
			make_empty (a_string.count)
			set_string_with_newline_conversion (a_string)
		end

feature {NONE} -- Initialization

	share_from_pointer (a_ptr: POINTER)
			-- New instance sharing `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			share_from_pointer_and_count (a_ptr, buffer_length (a_ptr))
		end

	share_from_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- New instance sharing `a_ptr' of `a_length' byte.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
			a_length_valid: (a_length \\ character_size) = 0
		do
			count := a_length // character_size
			create managed_data.share_from_pointer (a_ptr, a_length + character_size)
		end

feature -- Access

	string_discarding_carriage_return: STRING_32
			-- Eiffel string, ignoring `count' and discarding carriage return '%R' characters. Reads until a null character is read.
		local
			l_data: like managed_data
			i, j, nb, l_start: INTEGER
			l_code, l_carriage_return_code: NATURAL_32
			u: UTF_CONVERTER
		do
			from
				j := 1
				l_start := 0
				nb := string_length (item)
				l_data := managed_data
				l_carriage_return_code := ('%R').natural_32_code
				create Result.make (nb)
			until
				i = nb
			loop
				l_code := l_data.read_natural_16 (i * character_size)
				if l_code = l_carriage_return_code then
					u.utf_16_0_subpointer_into_escaped_string_32 (l_data, l_start, i - 1, False, Result)
					l_start := i + 1
					j := j + 1
				end
				i := i + 1
			end
			if l_start < nb then
				u.utf_16_0_subpointer_into_escaped_string_32 (l_data, l_start, nb - 1, False, Result)
			end
		end

	read_substring_into (a_string: STRING_32; start_pos, end_pos: INTEGER)
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos' appended into `a_string'.
		require
			a_string_not_void: a_string /= Void
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= (capacity // character_size)
			a_string_large_enough: a_string.count >= end_pos - start_pos + 1
		local
			u: UTF_CONVERTER
		do
			u.utf_16_0_subpointer_into_escaped_string_32 (managed_data,
				start_pos - 1, end_pos - 1, False, a_string)
		end

	read_string_into (a_string: STRING_GENERAL)
			-- Append of all characters of Current to `a_string'.
		require
			a_string_not_void: a_string /= Void
			a_string_large_enough: a_string.count >= count
		local
			l_str: STRING_32
		do
			if attached {STRING_32} a_string as l_string then
				read_substring_into (l_string, 1, count)
			else
					-- Broken implementation as most likely data will be truncated
				create l_str.make (count)
				read_substring_into (l_str, 1, count)
				a_string.append ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_str))
			end
		end

	null_separated_strings: LIST [STRING_32]
			-- Retrieve all string contained in `item'. Strings are
			-- NULL separared inside `item'.
		local
			current_string: STRING_32
			current_pos: POINTER
			l_str: CLI_STRING
		do
			from
				create {ARRAYED_LIST [STRING_32]} Result.make (5)
				current_pos := item
				create l_str.share_from_pointer (current_pos)
				current_string := l_str.string_32
			until
				current_string.is_empty
			loop
				Result.extend (current_string)
				current_pos := current_pos + (current_string.count + 1) * character_size
				l_str.set_shared_from_pointer (current_pos)
				current_string := l_str.string_32
			end
		ensure
			result_not_void: Result /= Void
		end

	null_separated_paths: ARRAYED_LIST [PATH]
			-- Retrieve all paths contained in `item'. Strings are
			-- NULL separared inside `item'.
		local
			l_path: PATH
			l_ptr: POINTER
			l_count: INTEGER
		do
			from
				create Result.make (5)
				l_ptr := item
				create l_path.make_from_pointer (l_ptr)
				l_count := buffer_length (l_ptr)
			until
				l_path.is_empty
			loop
				Result.extend (l_path)
					-- New pointer value is the old one plus buffer length
					-- in bytes of the previous string plus the null terminating
					-- character.
				l_ptr := l_ptr + l_count + character_size
				create l_path.make_from_pointer (l_ptr)
				l_count := buffer_length (l_ptr)
			end
		ensure
			result_not_void: Result /= Void
		end

	space_separated_strings: LIST [STRING_32]
			-- Retrieve all string contained in `item'. Strings are
			-- space-separared inside `item'.
		do
			Result := string_32.split (' ')
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	character_capacity: INTEGER
			-- Number of characters in Current.
		do
			Result := managed_data.count // character_size
		end

	character_size: INTEGER = 2
			-- Size of a code unit.

	unicode_character_count: INTEGER
			-- Size in Unicode character of Current
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_16_characters_count_form_pointer (managed_data, 0, count * character_size)
		end

	occurrences (c: CHARACTER_32): INTEGER
			-- Number of times `c' appears in `string_32'.
		local
			i: INTEGER
			m: like managed_data
			l_code: NATURAL_32
			l_nat1, l_nat2: NATURAL_16
		do
			i := count * character_size
			if i > 0 then
				l_code := c.natural_32_code
				m := managed_data
				if l_code <= 0xFFFF then
						-- Simple case, one to one mapping.
					from
					until
						i = 0
					loop
						i := i - character_size
						if m.read_natural_16 (i) = l_code then
							Result := Result + 1
						end
					end
				else
						-- Character `c' is represented by the surrogate pair (l_nat1, l_nat2).
					from
						l_nat1 := (0xD7C0 + (l_code |>> 10)).to_natural_16
						l_nat2 := (0xDC00 + (l_code & 0x3FF)).to_natural_16
					until
						i <= character_size
					loop
						i := i - character_size
						if m.read_natural_16 (i) = l_nat2 and m.read_natural_16 (i - character_size) = l_nat1 then
							Result := Result + 1
						end
					end
				end
			end
		end

feature -- Element change

	set_string_with_newline_conversion (a_string: READABLE_STRING_GENERAL)
			-- Make a C string from `a_string' guaranteeing that all newline (linefeed) characters '%N'
			-- are prepended with a carriage return character '%R'.
		require
			a_string_not_void: a_string /= Void
		local
			i, j, nb, l_count, l_new_size, l_start: INTEGER
			l_managed_data: like managed_data
			u: UTF_CONVERTER
		do
				-- Count how many occurrences of `%N' not preceded by '%R' we have in `a_string'.
			from
				i := 2
				nb := a_string.count
				if nb > 0 and then a_string.code (1) = ('%N').natural_32_code then
					l_count := 1
				end
			until
				i > nb
			loop
				if
					a_string.code (i) = ('%N').natural_32_code and then a_string.code (i - 1) /= ('%R').natural_32_code
				then
					l_count := l_count + 1
				end
				i := i + 1
			end

				-- Set managed pointer and update count.
			l_managed_data := managed_data
			count := nb + l_count

				-- Create managed pointer and set count.
			l_new_size := (nb + l_count + 1) * character_size
			if l_managed_data.count < l_new_size then
				l_managed_data.resize (l_new_size)
			end

			if l_count > 0 then
					-- Replace all found occurrences with '%R%N'.
				from
						-- `i' will be used to iterate over `a_string'.
					i := 1
						-- `l_start' is the index where substring starts in `a_string'.
					l_start := 1
						-- `j' will be used to let us know where in `l_managed_data' we are.
					j := 0
						-- Handle case if %N is at first index.
					if a_string.code (i) = ('%N').natural_32_code then
						l_managed_data.put_natural_16 (('%R').natural_32_code.to_natural_16, j)
						j := j + character_size
						l_managed_data.put_natural_16 (('%N').natural_32_code.to_natural_16, j)
						j := j + character_size
						l_start := l_start + 1
						i := i + 1
					end
				until
					i > nb
				loop
					if
						a_string.code (i) = ('%N').natural_32_code and then a_string.code (i - 1) /= ('%R').natural_32_code
					then
						u.escaped_utf_32_substring_into_utf_16_0_pointer (a_string, l_start, i - 1, l_managed_data, j, upper_cell)
							-- Calculate the new location where we will insert the NULL character after
							-- inserting %R%N. It 2 characters after `uppel_cell.item' which is already
							-- the location of the NULL character after the convertion to UITF-16.
						j := upper_cell.item + 2 * character_size
							-- Do not forget to resize `l_managed_data' to be sure we have
							-- enough space for the additional %R%N characters. See test#TEST_WEL_STRING.
						if l_managed_data.count < j then
								-- Because `j' represents the location where we would insert the NULL character,
								-- we just need `j + character_size' bytes to hold %R, %N and NULL.
							l_managed_data.resize (j + character_size)
						end
						l_managed_data.put_natural_16 (('%R').natural_32_code.to_natural_16, j - 2 * character_size)
						l_managed_data.put_natural_16 (('%N').natural_32_code.to_natural_16, j - character_size)
						l_start := i + 1
					end
					i := i + 1
				end
				if l_start <= nb then
						-- We need to store the last remaining chunk.
					u.escaped_utf_32_substring_into_utf_16_0_pointer (a_string, l_start, nb, l_managed_data, j, upper_cell)
				else
						-- Set null character at the end.
					l_managed_data.put_natural_16 (0, j)
				end
			else
				set_string (a_string)
			end
		end

	set_count (a_count: INTEGER)
			-- Set `count' with `a_count'.
			-- Note: Current content from index `1' to
			-- `count.min (a_count)' is unchanged.
		require
			a_count_non_negative: a_count >= 0
		local
			new_size: INTEGER
		do
			new_size := (a_count + 1) * character_size
			if managed_data.count < new_size then
				managed_data.resize (new_size)
			end
			count := a_count
		ensure
			count_set: count = a_count
		end

	fill_blank
			-- Fill Current with zeros.
		do
			fill_value (0)
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `0'
		end

	fill_value (a_value: INTEGER_8)
			-- Fill Current with `a_value'.
		do
			managed_data.item.memory_set (a_value, managed_data.count)
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `a_value'
		end

	set_null_character (offset: INTEGER)
			-- Set `%U' at `offset' position of `Current'.
			-- First position being  at `0' index.
		require
			valid_offset: offset >= 0 and offset <= (capacity // character_size)
		do
			managed_data.put_integer_16 (0, offset)
		ensure
			string_set: managed_data.read_integer_16 (offset) = 0
		end

	set_size_in_string (n: INTEGER)
			-- Set two first bytes of string pointed by `item' to
			-- value represented by `n' in a two bytes representation.
		require
			valid_size: n > 0
			small_enough: n <= {INTEGER_16}.Max_value
		do
			managed_data.put_integer_16 (n.to_integer_16, 0)
		end

feature -- Status report

	exists: BOOLEAN = True
			-- `item' is always valid.

feature {NONE} -- Implementation

	buffer_length (a_ptr: POINTER): INTEGER
			-- Size in bytes pointed by `a_ptr', not including the null-terminating character.
		require
			exists: exists
		local
			l_length: NATURAL_64
		do
			l_length := c_strlen (a_ptr) * character_size.to_natural_64
			if l_length <= {INTEGER_32}.max_value.to_natural_64 then
				Result := l_length.to_integer_32
			else
				Result := {INTEGER_32}.max_value
			end
		end

	string_length (a_ptr: POINTER): INTEGER
			-- Size in characters pointed by `a_ptr'.
		require
			exists: exists
		do
			Result := buffer_length (a_ptr) // character_size
		end

	c_strlen (ptr: POINTER): NATURAL_64
			-- Number of characters in `ptr'.
		external
			"C macro signature (const wchar_t *): EIF_INTEGER use <wchar.h>"
		alias
			"wcslen"
		end

invariant
	managed_data_not_void: managed_data /= Void
	count_not_negative: count >= 0
	bytes_count_valid: (bytes_count \\ character_size) = 0

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
