indexing
	description: "Objects that some very general purpose facilities used in Build2"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERAL_UTILITIES

feature -- Basic operations

	list_from_single_spaced_values (string: STRING): ARRAYED_LIST [INTEGER] is
			-- `Result' is all values contained in `string' which is of the form "1 101 150 35".
			-- `string' must be single spaced.
		local
			last_space, counter: INTEGER
		do
			create Result.make (0)
			last_space := 1
			from
				counter := 1
			until
				counter > string.count
			loop
				if string @ counter = ' ' then
					check
						only_one_space_per_value: string @ (counter + 1) /= ' '
					end
					Result.extend ((string.substring (last_space, counter - 1)).to_integer)
					last_space := counter + 1
				elseif counter = string.count then
					Result.extend ((string.substring (last_space, counter)).to_integer)
				end
				counter := counter + 1
			end
		end
		
	single_spaced_values_from_list (list: ARRAYED_LIST [INTEGER]): STRING is
			-- `Result' is single spaced string representation of `list'.
		local
			counter: INTEGER
		do
			create Result.make (0)
			from
				counter := 1
			until
				counter > list.count
			loop
				Result.append_string ((list @ counter).out)
				if counter < list.count then
					Result.extend (' ')
				end
				counter := counter + 1
			end
		end
		
	remove_leading_and_trailing_spaces (string: STRING): STRING is
			-- Remove leading and trailing spaces from `string'.
			-- i.e. "   a_string   " becomes "a_string"
		require
			string_not_void: string /= Void
		do
			Result := string
			Result.prune_all_trailing (' ')
			Result.prune_all_leading (' ')
		ensure
			Result_not_void: Result /= Void
		end
		
	escape_special_characters (string: STRING): STRING is
			-- Replace all occurances of '"' amd '%' in `string' with
			-- an escaped version (%N prepended for each).
		require
			string_not_void: string /= Void
		local
			counter: INTEGER
		do
			from
				counter := 1
				Result := ""
			until
				counter > string.count
			loop
				if string.item (counter) = '%%' or string.item (counter) = '"' then
					Result.append_string ("%%" + string.item (counter).out)
				else
					Result.append_character (string.item (counter))
				end
				counter := counter + 1
			end
		ensure
			Adjusted_size_correct: Result.count = string.count + string.occurrences ('%%') + string.occurrences ('"')
		end
		
	directory_of_file (file_name: STRING): STRING is
			-- `Result' is directory path of `file_name'.
			-- `file_name' must include full path to file.
			-- This will work on Linx and Windows, but not VMS.
		require
			is_path: file_name.out.occurrences (operating_environment.directory_separator) > 0
		do
			Result := file_name.substring (1, (file_name.out.last_index_of (operating_environment.directory_separator, file_name.out.count)) - 1)
		ensure
			Result_not_void: Result /= Void
		end
		
		
end -- class GB_GENERAL_UTILITIES
