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
			-- Also replace all '%N' characters with '%''N'
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
				elseif string.item (counter) = '%N' then
					Result.append_string ("%%N")
				else
					Result.append_character (string.item (counter))
				end
				counter := counter + 1
			end
		ensure
			Adjusted_size_correct: Result.count = string.count + string.occurrences ('%%') + string.occurrences ('"') + string.occurrences ('%N')
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
		
	name_and_type_from_object (an_object: GB_OBJECT): STRING is
			-- `Result' is name and type of object as STRING.
		require
			object_not_void: an_object /= Void
		local
			displayed_name: STRING
		do
			if an_object.output_name.is_empty and an_object.name.is_empty then
				Result := an_object.type.substring (4, an_object.type.count)
			else		
					-- Decide which name to use. If the output name is longer,
					-- it means that we are editing tha name, and the output name should
					-- be displayed.
				if an_object.output_name.count > an_object.name.count then
					displayed_name := an_object.output_name
				else
					displayed_name := an_object.name
				end
				Result := displayed_name + ": " + an_object.type.substring (4, an_object.type.count)
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	replace_final_class_name_comment (class_text, old_name, new_name: STRING) is
			-- Replace instance of `old_name' with `new_name' when located in `clas_text'
			-- after the final "end".
		require
			class_text_not_void: class_text /= Void
			old_name_not_void: old_name /= Void
			new_name_not_void: new_name /= Void
		local
			reversed: STRING
			sub_index: INTEGER
			index_of_old_name: INTEGER
		do
			reversed := clone (class_text)
			reversed.mirror
			sub_index := reversed.substring_index ("dne", 1)
			index_of_old_name := class_text.substring_index (old_name, class_text.count - sub_index)
			class_text.replace_substring (new_name, index_of_old_name, index_of_old_name + old_name.count - 1)
		ensure
			count_changed_accordingly: old class_text.count = class_text.count + new_name.count - old_name.count
		end

end -- class GB_GENERAL_UTILITIES
