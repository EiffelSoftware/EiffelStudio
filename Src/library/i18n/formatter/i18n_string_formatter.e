indexing
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

feature -- Initialization

	default_create is
			-- Create with default escape character
		do
			escape_character := '$'
		ensure then
			default_escape_character_set: escape_character = '$'
		end

	make_with_escape_character (a_escape_character: CHARACTER) is
			-- Create with `a_escape_character' as escape_character
		do
			escape_character := a_escape_character
		ensure
			escape_character_set: escape_character = a_escape_character
		end

feature -- Utility

	format_string (a_string: STRING_32; args_tuple: TUPLE): STRING_32 is
			-- sobstiture in `a_string' items in `args_tuple'
		require
			a_string_exists: a_string /= Void
			args_tuple_exists: args_tuple /= Void
			valid_arguments: valid_arguments (args_tuple)
			reasonable_number_of_arguments: args_tuple.count <= {INTEGER_32}.Max_value
			correct_number_of_arguments: required_arguments (a_string) <= args_tuple.count
		local
			l_list: LIST[STRING_32]
			i : INTEGER
			l_string: STRING_32
			test: STRING_GENERAL
		do
			l_list := a_string.split (escape_character)
			create Result.make_empty
			from
					-- Append first string to Result
				l_list.start
				Result.append (l_list.item)
				l_list.forth
			until
				l_list.after
			loop
				if l_list.item.is_empty then
						-- It wasn't a escape_character
					Result.append(escape_character.out)
				else
						-- it's possibly an escape_character
					from
						i := 1
						l_string := l_list.item.substring(i,i)
					until
						i > l_list.item.count or not l_string.is_integer
					loop	--extract the number
						i := i + 1
						l_string := l_list.item.substring(i,i)
					end
					l_string := l_list.item.substring(1,i-1)
					if l_string.is_integer then
							-- It was en escape character

							--FIXME!!! HACK because 'out' in ANY possibly gives a STRING_8 and this is not so good for STRING_32
						test ?= args_tuple.item(l_string.to_integer)
						if test /= Void then
							Result.append (test.as_string_32)
						else
							Result.append (args_tuple.item(l_string.to_integer).out)
						end

						Result.append (l_list.item.substring(i,l_list.item.count).twin)
					else
							-- It should not be conseidered as escape character
						Result.append (escape_character.out)
						Result.append (l_list.item)
					end
				end
				l_list.forth
			end
		ensure
			result_exists: Result /= Void
--			no_more_escape_characters: required_arguments (Result) = 0
		end

feature -- Check functions

	valid_arguments (a_tuple: TUPLE) : BOOLEAN is
			-- are al argument valid (/= Void)?
		require
			a_tuple_exists: a_tuple /= Void
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

	required_arguments (a_string: STRING_32): INTEGER is
			-- how many argumnents does `a_string' require?
		require
			a_string_exists: a_string /= Void
		local
			l_list: LIST[STRING_32]
			i : INTEGER
			l_string: STRING_32
		do
			l_list := a_string.split (escape_character)
			Result := 0
			from
				l_list.start
				l_list.forth
			until
				l_list.after
			loop
				if not l_list.item.is_empty then
					from
						i := 1
						l_string := l_list.item.substring(i,i)
					until
						i > l_list.item.count or not l_string.is_integer
					loop	--extract the number
						i := i + 1
						l_string := l_list.item.substring(i,i)
					end
					l_string := l_list.item.substring(1,i-1)
					Result := Result.max (l_string.to_integer)
				end
				l_list.forth
			end
		ensure
			Correct_result: a_string.has_substring (Result.out)
		end

feature -- Values

	escape_character : CHARACTER;

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
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
