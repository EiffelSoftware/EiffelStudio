indexing
	description: "A low-level string class to solve some garbage %
		%collector problems (object move). The end-user must not use %
		%this class. Use class STRING instead."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRING

inherit
	C_STRING

create
	make,
	make_empty,
	make_by_pointer,
	share_from_pointer,
	share_from_pointer_and_count

feature -- Access

	null_separated_strings: LINKED_LIST [STRING] is
			-- Retrieve all string contained in `item'. Strings are
			-- NULL separared inside `item'.
		local
			current_string: STRING
			current_pos: POINTER
		do
			from
				create Result.make
				current_pos := item
				create current_string.make_from_c (current_pos)
			until
				current_string.is_empty
			loop
				Result.extend (current_string)
				current_pos := current_pos + current_string.count + 1
				create current_string.make_from_c (current_pos)
			end
		ensure
			result_not_void: Result /= Void
		end

	space_separated_strings: LINKED_LIST [STRING] is
			-- Retrieve all string contained in `item'. Strings are
			-- space-separared inside `item'.
		local
			curr_space: INTEGER
			next_space: INTEGER
			long_string: STRING
		do
			create long_string.make_from_c (item)
			create Result.make

				-- Add each "word" of the long_string to the Result-list
			from
				curr_space := 1
				next_space := long_string.index_of (' ',curr_space)
			until
				next_space = 0
			loop
				Result.extend (long_string.substring (curr_space, next_space - 1))
				curr_space := next_space + 1
				next_space := long_string.index_of (' ',curr_space)
			end
				-- No space left, extract the last string: from the last space until
				-- the end of the string.
			Result.extend (long_string.substring (curr_space, long_string.count))
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	length: INTEGER is
			-- Synonym for `count'.
		do
			Result := count
		ensure
			length_not_negative: Result >= 0
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

feature -- Element change

	set_null_character (offset: INTEGER) is
			-- Set `%U' at `offset' position of `Current'.
			-- First position being  at `0' index.
		require
			valid_offset: offset >= 0 and offset < capacity
		do
			managed_data.put_integer_8 (0, offset)
		ensure
			string_set: managed_data.read_integer_8 (offset) = 0
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

