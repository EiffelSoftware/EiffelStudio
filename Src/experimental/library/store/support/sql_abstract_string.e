note
	description: "Abstracted string to handle SQL string."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SQL_ABSTRACT_STRING

inherit
	STRING_HANDLER

feature {NONE} -- Initialization

	make (a_string: READABLE_STRING_GENERAL)
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			make_empty (a_string.count)
			set_string (a_string)
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
			make_by_pointer_and_count (a_ptr, c_strlen (a_ptr) * character_size)
		end

	make_by_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- Make a copy of first `a_length' byte of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
		do
			count := a_length // character_size
			create managed_data.make (a_length + character_size)
			managed_data.item.memory_copy (a_ptr, a_length)
		end

	make_shared_from_pointer (a_ptr: POINTER)
			-- New instance sharing `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			make_shared_from_pointer_and_count (a_ptr, c_strlen (a_ptr) * character_size)
		end

	make_shared_from_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- New instance sharing `a_ptr' of `a_length' byte.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
		do
			count := a_length // character_size
			create managed_data.share_from_pointer (a_ptr, a_length + character_size)
		end

	own_from_pointer (a_ptr: POINTER)
			-- New instance using `a_ptr' as memory. Current will free pointed memory
			-- by `a_ptr' when collected.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			own_from_pointer_and_count (a_ptr, c_strlen (a_ptr) * character_size)
		end

	own_from_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- New instance using `a_ptr' as memory. Current will free pointed memory
			-- by `a_ptr' when collected.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
		do
			count := a_length // character_size
			create managed_data.own_from_pointer (a_ptr, a_length)
		end

feature -- Initialization

	set_shared_from_pointer (a_ptr: POINTER)
			-- Share `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			set_shared_from_pointer_and_count (a_ptr, c_strlen (a_ptr) * character_size)
		end

	set_shared_from_pointer_and_count (a_ptr: POINTER; a_length: INTEGER)
			-- Share `a_ptr' of `a_length' byte.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_non_negative: a_length >= 0
		do
			count := a_length // character_size
			if not managed_data.is_shared then
				create managed_data.share_from_pointer (a_ptr, a_length + character_size)
			else
				managed_data.set_from_pointer (a_ptr, a_length + character_size)
			end
		end

feature -- Access

	substring (start_pos, end_pos: INTEGER): STRING_32
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos'.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= capacity
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
			Result := substring (1, count)
		ensure
			string_not_void: Result /= Void
		end

	copy_to_string (a_string: STRING_GENERAL; source_index, destination_index, n: INTEGER)
			-- Copy `n' characters of `Current' from `source_index' position to `a_string' at
			-- `destination_index'. Other characters of `a_string' remain unchanged.
		require
			a_string_not_void: a_string /= Void
			source_index_positive: source_index >= 1
			destination_index_positive: destination_index >= 1
			n_non_negative: n >= 0
			n_is_small_enough_for_source: source_index + (n - 1) <= capacity
			n_is_small_enough_for_destination: destination_index + (n - 1) <= a_string.count
		local
			l_data: like managed_data
			i, j, nb: INTEGER
		do
			from
				i := source_index - 1
				j := destination_index
				nb := source_index + (n - 1)
				l_data := managed_data
			until
				i = nb
			loop
				if character_size = 2 then
					a_string.put_code (l_data.read_natural_16 (i * character_size), j)
				elseif character_size = 1 then
					a_string.put_code (l_data.read_natural_8 (i * character_size), j)
				else
					a_string.put_code (l_data.read_natural_32 (i * character_size), j)
				end
				i := i + 1
				j := j + 1
			end
		end

	read_substring_into (a_string: STRING_GENERAL; start_pos, end_pos: INTEGER)
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos' into `a_string'.
		require
			a_string_not_void: a_string /= Void
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= capacity
			a_string_large_enough: a_string.count >= end_pos - start_pos + 1
		local
			l_data: like managed_data
			i, j: INTEGER
		do
			from
				i := start_pos - 1
				l_data := managed_data
				j := 1
			until
				i > end_pos - 1
			loop
				if character_size = 2 then
					a_string.put_code (l_data.read_natural_16 (i * character_size), j)
				elseif character_size = 1 then
					a_string.put_code (l_data.read_natural_8 (i * character_size), j)
				else
					a_string.put_code (l_data.read_natural_32 (i * character_size), j)
				end
				i := i + 1
				j := j + 1
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

	read_substring_into_character_32_area (a_area: SPECIAL [CHARACTER_32]; start_pos, end_pos: INTEGER)
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos' into `a_area'.
		require
			a_area_not_void: a_area /= Void
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= capacity
			a_area_large_enough: a_area.count >= end_pos - start_pos + 1
		local
			l_data: like managed_data
			i, j, nb: INTEGER
		do
			from
				i := start_pos - 1
				nb := end_pos - start_pos
				l_data := managed_data
			until
				i > nb
			loop
				if character_size = 2 then
					a_area.put (l_data.read_natural_16 (i * character_size).to_character_32, j)
				elseif character_size = 1 then
					a_area.put (l_data.read_natural_8 (i * character_size).to_character_8, j)
				else
					a_area.put (l_data.read_natural_32 (i * character_size).to_character_32, j)
				end

				i := i + 1
				j := j + 1
			end
		ensure
			copied: -- for i in 0..end_pos - start_pos, a_area [i] = Current [i + start_pos]			
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

feature -- Measurement

	capacity: INTEGER
			-- Number of characters in Current.
		do
			Result := managed_data.count // character_size
		end

	bytes_count: INTEGER
			-- Number of bytes represented by the string.
		do
			Result := count * character_size
		end

	count: INTEGER
			-- Number of characters in Current.

	character_size: INTEGER
			-- Size of a character
		deferred
		end

feature -- Element change

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
				if character_size = 2 then
					managed_data.put_natural_16 (a_string.code (i + start_pos).to_natural_16, i * character_size)
				elseif character_size = 1 then
					managed_data.put_natural_8 (a_string.code (i + start_pos).to_natural_8, i * character_size)
				else
					managed_data.put_natural_32 (a_string.code (i + start_pos).to_natural_32, i * character_size)
				end

				i := i +  1
			end
			if character_size = 2 then
				managed_data.put_natural_16 (0, nb * character_size)
			elseif character_size = 1 then
				managed_data.put_natural_8 (0, nb * character_size)
			else
				managed_data.put_natural_32 (0, nb * character_size)
			end
		end

	set_count (a_count: INTEGER)
			-- Set `count' with `a_count'.
			-- Note: Current content from index `1' to
			-- `count.min (a_count)' is unchanged.
		require
			a_count_non_negative: a_count >= 0
		do
			managed_data.resize ((a_count + 1) * character_size)
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

feature {NONE} -- Implementation

	c_strlen (ptr: POINTER): INTEGER
		deferred
		ensure
			is_class: class
		end

invariant
	managed_data_not_void: managed_data /= Void
	count_not_negative: count >= 0

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
