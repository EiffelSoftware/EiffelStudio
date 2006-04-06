indexing
	description: "A low-level string class to convert Eiffel strings to Win32 unicode strings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRING

inherit
	STRING_HANDLER

create
	make,
	make_empty,
	make_by_pointer,
	make_by_pointer_and_count,
	share_from_pointer,
	share_from_pointer_and_count

feature --{NONE} -- Initialization

	make (a_string: STRING_GENERAL) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			make_empty (a_string.count)
			set_string (a_string)
		end

	make_empty (a_length: INTEGER) is
			-- Make an empty C string of `a_length' characters.
			-- C memory area is not initialized.
		require
			a_length_positive: a_length >= 0
		do
			create managed_data.make ((a_length + 1) * character_size)
			count := 0
		end

	make_by_pointer (a_ptr: POINTER) is
			-- Make a copy of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			make_by_pointer_and_count (a_ptr, buffer_length (a_ptr))
		end

	make_by_pointer_and_count (a_ptr: POINTER; a_length: INTEGER) is
			-- Make a copy of first `a_length' byte of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
		do
			count := a_length // character_size
			create managed_data.make (a_length + character_size)
			managed_data.item.memory_copy (a_ptr, a_length)
		end

feature -- Initialization

	share_from_pointer (a_ptr: POINTER) is
			-- New instance sharing `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			share_from_pointer_and_count (a_ptr, buffer_length (a_ptr))
		end

	share_from_pointer_and_count (a_ptr: POINTER; a_length: INTEGER) is
			-- New instance sharing `a_ptr' of `a_length' byte.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
		do
			count := a_length // character_size
			if managed_data = Void or else not managed_data.is_shared then
				create managed_data.share_from_pointer (a_ptr, a_length + character_size)
			else
				managed_data.set_from_pointer (a_ptr, a_length + character_size)
			end
		end

feature -- Access

	substring (start_pos, end_pos: INTEGER): STRING_32 is
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

	string: STRING_32 is
			-- Eiffel string, ignoring `count'. Reads until a null character is being read.
		do
			Result := substring (1, c_strlen (item))
		ensure
			string_not_void: Result /= Void
		end

	read_substring_into (a_string: STRING_GENERAL; start_pos, end_pos: INTEGER) is
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

	read_string_into (a_string: STRING_GENERAL) is
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos' into `a_string' replacing any
			-- existing characters.
		require
			a_string_not_void: a_string /= Void
			a_string_large_enough: a_string.count >= count
		do
			read_substring_into (a_string, 1, count)
		end

	item: POINTER is
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
		end

	managed_data: MANAGED_POINTER
			-- Hold data of Current.

	null_separated_strings: LIST [STRING_32] is
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
				current_pos := current_pos + current_string.count + 1
				l_str.share_from_pointer (current_pos)
				current_string := l_str.string
			end
		ensure
			result_not_void: Result /= Void
		end

	space_separated_strings: LIST [STRING_32] is
			-- Retrieve all string contained in `item'. Strings are
			-- space-separared inside `item'.
		do
			Result := string.split (' ')
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	capacity: INTEGER is
			-- Number of characters in Current.
		do
			Result := managed_data.count
		end

	bytes_count: INTEGER is
			-- Number of bytes which makes up Current.
		do
			Result := count * character_size
		ensure
			bytes_count_non_negative: Result >= 0
		end

	count: INTEGER
			-- Number of characters in Current.

	length: INTEGER is
			-- Synonym for `count'.
		do
			Result := count
		ensure
			length_not_negative: Result >= 0
		end

	character_size: INTEGER is
			-- Number of bytes occupied by a TCHAR.
		external
			"C inline use <tchar.h>"
		alias
			"sizeof(TCHAR)"
		end

feature -- Element change

	set_string (a_string: STRING_GENERAL) is
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			set_substring (a_string, 1, a_string.count)
		end

	set_substring (a_string: STRING_GENERAL; start_pos, end_pos: INTEGER) is
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_pos_small_enough: end_pos <= a_string.count
		local
			i, nb: INTEGER
			new_size: INTEGER
		do
			nb := end_pos - start_pos + 1
			count := nb

			new_size := (nb + 1) * character_size

			if managed_data.count < new_size  then
				managed_data.resize (new_size)
			end

			from
				i := 0
			until
				i = nb
			loop
				managed_data.put_natural_16 (a_string.code (i + start_pos).to_natural_16, i * character_size)
				i := i +  1
			end
			managed_data.put_natural_16 (0, new_size - character_size)
		end

	set_count (a_count: INTEGER) is
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

	fill_blank is
			-- Fill Current with zeros.
		do
			fill_value (0)
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `0'
		end

	fill_value (a_value: INTEGER_8) is
			-- Fill Current with `a_value'.
		do
			managed_data.item.memory_set (a_value, managed_data.count)
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `a_value'
		end

	set_null_character (offset: INTEGER) is
			-- Set `%U' at `offset' position of `Current'.
			-- First position being  at `0' index.
		require
			valid_offset: offset >= 0 and offset <= (capacity // character_size)
		do
			managed_data.put_integer_16 (0, offset)
		ensure
			string_set: managed_data.read_integer_16 (offset) = 0
		end

	set_size_in_string (n: INTEGER) is
			-- Set two first bytes of string pointed by `item' to
			-- value represented by `n' in a two bytes representation.
		require
			valid_size: n > 0
			small_enough: n <= {INTEGER_16}.Max_value
		do
			managed_data.put_integer_16 (n.to_integer_16, 0)
		end

	initialize is
			-- Fill Current with zeros.
		obsolete
			"Use `fill_blank' instead."
		do
			fill_blank
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `0'
		end

	initialize_with_character (a_character: CHARACTER) is
			-- Fill current with `a_character'.
		obsolete
			"Use `fill_value (a_character.code.to_integer_8)' instead"
		do
			fill_value (a_character.code.to_integer_8)
		ensure
			-- all_values: For every `i' in 1..`count', `item' (`i') = `a_value'			
		end

feature -- Status report

	to_integer: INTEGER is
			-- Converts `item' to an integer.
		obsolete
			"Use `item' instead to ensure portability between 32 and 64 bits version of Windows."
		do
			Result := item.to_integer_32
		end

	exists: BOOLEAN is True
			-- `item' is always valid.

feature {NONE} -- Implementation

	buffer_length (ptr: POINTER): INTEGER is
			-- Number of bytes to hold `ptr'.
		do
			Result := c_strlen (ptr) * character_size
		end

	c_strlen (ptr: POINTER): INTEGER is
			-- Number of characters in `ptr'.
		external
			"C inline use <tchar.h>"
		alias
			"_tcslen ((wchar_t *) $ptr)"
		end

invariant
	managed_data_not_void: managed_data /= Void
	count_not_negative: count >= 0

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




end -- class WEL_STRING

