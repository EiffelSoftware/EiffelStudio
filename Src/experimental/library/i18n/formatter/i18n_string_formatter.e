note
	description: "Class that provides a feature to replace tokens in a string by provided values"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_STRING_FORMATTER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_escape_character

feature {NONE} -- Initialization

	default_create
			-- Initialize with default escape character '$'.
		do
			escape_character := '$'
		ensure then
			default_escape_character_set: escape_character = '$'
		end

	make_with_escape_character (a_escape_character: CHARACTER)
			-- Initialize with `a_escape_character' as escape_character
			--
			-- `a_escape_character': Character used to escape replacement tokens
		do
			escape_character := a_escape_character
		ensure
			escape_character_set: escape_character = a_escape_character
		end

feature -- Access

	escape_character: CHARACTER
			-- Character used to escape replacement tokens

feature -- Element Change

	set_escape_character (a_character: like escape_character)
			-- Set `escape_character' with `a_character'.
			--
			-- `a_character': Character used to escape replacement tokens
		do
			escape_character := a_character
		ensure
			escape_character_set: escape_character = a_character
		end

feature -- Basic operations

	formatted_string (a_string: READABLE_STRING_GENERAL; args_tuple: TUPLE): STRING_32
			-- String which has it's tokens replaced by given values
			--
			-- The string given can have token placeholders. The placeholder has
			-- the form `a_escape_charater' followed by the tuple index.
			--
			-- `a_string': Original string with possible token placeholders
			-- `args_tuple': Values which will be replaced in the placeholders
			-- `Result': String which has token placeholders replaced with values
		require
			a_string_not_void: a_string /= Void
			args_tuple_not_void: args_tuple /= Void
			valid_arguments: valid_arguments (args_tuple)
		local
			i, j : INTEGER
			l_code, l_ncode, l_escape_code: NATURAL_32
			l_count, l_position: INTEGER
		do
			create Result.make_empty
			l_count := a_string.count
			l_escape_code := escape_character.natural_32_code
			from
				i := 1
				l_count := a_string.count
			until
				i > l_count
			loop
				l_code := a_string.code (i)
					-- Found escape character and at least there is following character.
				if i + 1 <= l_count and then l_code = l_escape_code then
					from
						j := i + 1
						l_ncode := a_string.code (j)
						l_position := 0
					until
						j > l_count or else not l_ncode.is_valid_character_8_code or else not l_ncode.to_character_8.is_digit
					loop
						l_position := l_ncode.to_character_8.out.to_integer + l_position * 10
						j := j + 1
						if j <= l_count then
							l_ncode := a_string.code (j)
						end
					end
						-- Found a position
					if l_position > 0 then

						if args_tuple.valid_index (l_position) and then attached args_tuple.item (l_position) as l_object then
							if attached {READABLE_STRING_GENERAL} l_object as test then
								Result.append_string_general (test)
							elseif attached {separate READABLE_STRING_GENERAL} l_object as test then
								Result.append_string_general (create {STRING_32}.make_from_separate (test))
							else
								Result.append_string_general (out_from_separate_any (l_object))
							end
						else
								-- Report an error here if needed later.
								-- Because the position is not found in the tuple
								-- We append the original characters back.
							Result.append_string_general (a_string.substring (i, j - 1))
						end
						i := j
					else
						Result.append_code (l_code)
						i := i + 1
					end
				else
					Result.append_code (l_code)
					i := i + 1
				end
			end
		ensure
			result_exists: Result /= Void
		end

feature -- Check functions

	valid_arguments (a_tuple: TUPLE) : BOOLEAN
			-- Are all values in the tuple non-void?
		require
			a_tuple_not_void: a_tuple /= Void
		local
			i : INTEGER
		do
			from
				Result := True
				i := 1
			until
				i > a_tuple.count or not Result
			loop
				Result := Result and a_tuple.item (i) /= Void
				i := i + 1
			end
		end

	required_arguments (a_string: READABLE_STRING_GENERAL): INTEGER
			-- The number of arguments which `a_string' needs to have replaced
		require
			a_string_not_void: a_string /= Void
		local
			l_list: LIST [STRING_32]
			l_list_item: STRING_32
			i : INTEGER
			l_string: STRING_32
		do
			l_list := a_string.as_string_32.split (escape_character)
			Result := 0
			from
				l_list.start
				l_list.forth
			until
				l_list.after
			loop
				l_list_item := l_list.item
				if not l_list_item.is_empty then
					from
						i := 1
						l_string := l_list_item.substring (i, i)
					until
						i > l_list_item.count or not l_string.is_integer
					loop	--extract the number
						i := i + 1
						l_string := l_list_item.substring (i, i)
					end
					l_string := l_list_item.substring (1, i-1)
					Result := Result.max (l_string.to_integer)
				end
				l_list.forth
			end
		ensure
			result_not_negative: Result >= 0
			result_correct: a_string.as_string_32.has_substring (escape_character.out + Result.out)
		end

feature {NONE} -- Implementation

	out_from_separate_any (a_any: separate ANY): STRING
			-- Out from separate any object
		do
			create Result.make_from_separate (a_any.out)
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
