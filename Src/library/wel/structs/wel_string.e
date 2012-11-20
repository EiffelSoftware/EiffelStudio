note
	description: "A low-level string class to convert Eiffel strings to Win32 unicode strings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRING

inherit
	STRING_HANDLER
		redefine
			is_equal
		end

	NATIVE_STRING_HANDLER
		redefine
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

	make (a_string: READABLE_STRING_GENERAL)
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			make_empty (a_string.count)
			set_string (a_string)
		end

	make_from_path (a_path: PATH)
			-- Make a C string from `a_path'.
		do
			managed_data := a_path.to_pointer
			count := (managed_data.count - character_size) // character_size
		end

	make_empty (a_length: INTEGER)
			-- Make an empty C string of `a_length' characters.
			-- C memory area is not initialized.
		require
			a_length_positive: a_length >= 0
		do
			create managed_data.make ((a_length + 1) * character_size)
			count := 0
		end

	make_by_pointer (a_ptr: POINTER)
			-- Make a copy of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			make_by_pointer_and_count (a_ptr, buffer_length (a_ptr))
		end

	make_by_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- Make a copy of first `a_length' byte of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
			a_length_valid: (a_length \\ {WEL_STRING}.character_size) = 0
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
			a_length_valid: (a_length \\ {WEL_STRING}.character_size) = 0
		do
			count := a_length // character_size
			create managed_data.share_from_pointer (a_ptr, a_length + character_size)
		end

feature -- Access

	substring (start_pos, end_pos: INTEGER): STRING_32
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos'.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= (capacity // character_size)
		local
			l_count: INTEGER
		do
			l_count := end_pos - start_pos + 1
			create Result.make (l_count)
			Result.set_count (l_count)
			read_substring_into (Result, start_pos, end_pos)
		ensure
			susbstring_not_void: Result /= Void
		end

	substring_8 (start_pos, end_pos: INTEGER): STRING_8
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos'. Truncated to STRING_8.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= (capacity // character_size)
		local
			l_count: INTEGER
		do
			l_count := end_pos - start_pos + 1
			create Result.make (l_count)
			Result.set_count (l_count)
			read_substring_into (Result, start_pos, end_pos)
		ensure
			susbstring_not_void: Result /= Void
		end

	string: STRING_32
			-- Eiffel string, ignoring `count'. Reads until a null character is being read.
		do
			Result := substring (1, string_length (item))
		ensure
			string_not_void: Result /= Void
		end

	string_8: STRING_8
			-- Eiffel string, ignoring `count'. Reads until a null character is being read.
			-- Truncated to STRING_8.
		do
			Result := substring_8 (1, string_length (item))
		ensure
			string_not_void: Result /= Void
		end

	string_discarding_carriage_return: STRING_32
			-- Eiffel string, ignoring `count' and discarding carriage return '%R' characters. Reads until a null character is read.
		local
			l_data: like managed_data
			i, j, nb: INTEGER
			l_code, l_carriage_return_code: NATURAL_32
		do
			from
				j := 1
				nb := string_length (item)
				l_data := managed_data
				l_carriage_return_code := ('%R').natural_32_code
				create Result.make (nb)
				Result.set_count (nb)
			until
				i = nb
			loop
				l_code := l_data.read_natural_16 (i * character_size)
				if l_code /= l_carriage_return_code then
					Result.put_code (l_code, j)
					j := j + 1
				end
				i := i + 1
			end
			Result.set_count (j - 1)
		end

	read_substring_into (a_string: STRING_GENERAL; start_pos, end_pos: INTEGER)
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos' into `a_string'.
		require
			a_string_not_void: a_string /= Void
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= (capacity // character_size)
			a_string_large_enough: a_string.count >= end_pos - start_pos + 1
		local
			l_data: like managed_data
			i, nb: INTEGER
		do
			from
				i := start_pos - 1
				nb := end_pos
				l_data := managed_data
			until
				i = nb
			loop
				a_string.put_code (l_data.read_natural_16 (i * character_size), i + 1)
				i := i + 1
			end
		end

	read_string_into (a_string: STRING_GENERAL)
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos' into `a_string' replacing any
			-- existing characters.
		require
			a_string_not_void: a_string /= Void
			a_string_large_enough: a_string.count >= count
		do
			read_substring_into (a_string, 1, count)
		end

	item: POINTER
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
		end

	managed_data: MANAGED_POINTER
			-- Hold data of Current.

	null_separated_strings: LIST [STRING_32]
			-- Retrieve all string contained in `item'. Strings are
			-- NULL separared inside `item'.
		local
			current_string: STRING_32
			current_pos: POINTER
			l_str: WEL_STRING
		do
			from
				create {ARRAYED_LIST [STRING_32]} Result.make (5)
				current_pos := item
				create l_str.share_from_pointer (current_pos)
				current_string := l_str.string
			until
				current_string.is_empty
			loop
				Result.extend (current_string)
				current_pos := current_pos + (current_string.count + 1) * character_size
				l_str.set_shared_from_pointer (current_pos)
				current_string := l_str.string
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
				l_ptr := l_ptr + (l_count + 1) * character_size
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
			Result := string.split (' ')
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	capacity: INTEGER
			-- Number of bytes in Current.
		do
			Result := managed_data.count
		end

	character_capacity: INTEGER
			-- Number of characters in Current.
		do
			Result := managed_data.count // character_size
		end

	bytes_count: INTEGER
			-- Number of bytes which makes up Current.
		do
			Result := count * character_size
		ensure
			bytes_count_non_negative: Result >= 0
		end

	count: INTEGER
			-- Number of characters in Current.

	length: INTEGER
			-- Synonym for `count'.
		do
			Result := count
		ensure
			length_not_negative: Result >= 0
		end

	frozen character_size: INTEGER
			-- Number of bytes occupied by a TCHAR.
		external
			"C macro use <tchar.h>"
		alias
			"sizeof(TCHAR)"
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is content of string identical to content of string `other'?
		do
			Result := item.is_equal (other.item)
		end

feature -- Element change

	set_shared_from_pointer (a_ptr: POINTER)
			-- New instance sharing `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			set_shared_from_pointer_and_count (a_ptr, buffer_length (a_ptr))
		end

	set_shared_from_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- New instance sharing `a_ptr' of `a_length' byte.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
			a_length_valid: (a_length \\ {WEL_STRING}.character_size) = 0
		do
			count := a_length // character_size
			if not managed_data.is_shared then
				create managed_data.share_from_pointer (a_ptr, a_length + character_size)
			else
				managed_data.set_from_pointer (a_ptr, a_length + character_size)
			end
		end

	set_string (a_string: READABLE_STRING_GENERAL)
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			set_substring (a_string, 1, a_string.count)
		end

	set_substring (a_string: READABLE_STRING_GENERAL; start_pos, end_pos: INTEGER)
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_pos_small_enough: end_pos <= a_string.count
		local
			u: UTF_CONVERTER
		do
				-- Convert substring to UTF-16 with a terminating zero.
			u.utf_32_substring_to_utf_16_0_pointer (a_string, start_pos, end_pos, managed_data)
			count := end_pos - start_pos + 1
		end

	set_string_with_newline_conversion (a_string: READABLE_STRING_GENERAL)
			-- Make a C string from `a_string' guaranteeing that all newline (linefeed) characters '%N'
			-- are prepended with a carriage return character '%R'.
		require
			a_string_not_void: a_string /= Void
		local
			i, j, nb, l_count, l_new_size, l_character_size: INTEGER
			l_managed_data: like managed_data
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

			l_character_size := character_size

				-- Create managed pointer and set count.
			l_new_size := (nb + l_count + 1) * l_character_size
			if l_managed_data.count < l_new_size then
				l_managed_data.resize (l_new_size)
			end

			if l_count > 0 then
					-- Replace all found occurrences with '%R%N'.
				from
					i := 2
					j := 0
						-- Handle case if %N is at first index.
					if a_string.code (1) = ('%N').natural_32_code then
						l_managed_data.put_natural_16 (('%R').code.to_natural_16, j * l_character_size)
						j := j + 1
					end
					l_managed_data.put_natural_16 (a_string.code (1).to_natural_16, j * l_character_size)
				until
					i > nb
				loop
					if
						a_string.code (i) = ('%N').natural_32_code and then a_string.code (i - 1) /= ('%R').natural_32_code
					then
						j := j + 1
						l_managed_data.put_natural_16 (('%R').code.to_natural_16, j * l_character_size)
					end
					j := j + 1
					l_managed_data.put_natural_16 (a_string.code (i).to_natural_16, j * l_character_size)
					i := i + 1
				end
			else
					-- No conversion necessary so we copy the data straight in to the buffer.
				from
					i := 0
				until
					i = nb
				loop
					l_managed_data.put_natural_16 (a_string.code (i + 1).to_natural_16, i * l_character_size)
					i := i + 1
				end
			end
				-- Set null character at the end.
			l_managed_data.put_natural_16 (0, l_new_size - l_character_size)
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

	initialize
			-- Fill Current with zeros.
		obsolete
			"Use `fill_blank' instead."
		do
			fill_blank
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `0'
		end

	initialize_with_character (a_character: CHARACTER)
			-- Fill current with `a_character'.
		obsolete
			"Use `fill_value (a_character.code.to_integer_8)' instead"
		do
			fill_value (a_character.code.to_integer_8)
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `a_value'			
		end

feature -- Status report

	to_integer: INTEGER
			-- Converts `item' to an integer.
		obsolete
			"Use `item' instead to ensure portability between 32 and 64 bits version of Windows."
		do
			Result := item.to_integer_32
		end

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
		local
			l_length: NATURAL_64
		do
			l_length := c_strlen (a_ptr)
			if l_length <= {INTEGER_32}.max_value.to_natural_64 then
				Result := l_length.to_integer_32
			else
				Result := {INTEGER_32}.max_value
			end
		end

	c_strlen (ptr: POINTER): NATURAL_64
			-- Number of characters in `ptr'.
		external
			"C macro signature (wchar_t *): EIF_INTEGER use <tchar.h>"
		alias
			"_tcslen"
		end

invariant
	managed_data_not_void: managed_data /= Void
	count_not_negative: count >= 0
	bytes_count_valid: (bytes_count \\ character_size) = 0

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
