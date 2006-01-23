indexing
	description: "Objects that some very general purpose facilities used in Build2"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERAL_UTILITIES

feature -- Basic operations

	list_from_single_spaced_values (string: STRING): ARRAYED_LIST [INTEGER] is
			-- `Result' is all values contained in `string' which is of the form "1 101 150 35".
			-- `string' must be single spaced.
		require
			string_not_void: string /= Void
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
		ensure
			result_not_void: Result /= Void
		end
		
	single_spaced_values_from_list (list: ARRAYED_LIST [INTEGER]): STRING is
			-- `Result' is single spaced string representation of `list'.
		require
			list_not_void: list /= Void
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
		ensure
			result_not_void: Result /= Void
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
			result_not_void: Result /= Void
			adjusted_size_correct: Result.count = string.count + string.occurrences ('%%') + string.occurrences ('"') + string.occurrences ('%N')
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
			l_type: STRING
		do
			l_type := an_object.actual_type
			if an_object.output_name.is_empty then
				Result := l_type 
			else		
				Result := an_object.output_name + ": " + l_type
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
			reversed := class_text.twin
			reversed.mirror
			sub_index := reversed.substring_index ("dne", 1)
			index_of_old_name := class_text.substring_index (old_name, class_text.count - sub_index)
			if index_of_old_name /= 0 then
				class_text.replace_substring (new_name, index_of_old_name, index_of_old_name + old_name.count - 1)
			end
		ensure
			count_changed_accordingly: old class_text.count = class_text.count + old_name.count - new_name.count
		end
		
	integer_truncated (original, truncation: INTEGER): INTEGER is
			-- Truncate `original' to `truncation'.
			-- For example, if `original' is 453 and `truncation' is 100, return 400.
		do
			Result := (original // truncation) * truncation
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_GENERAL_UTILITIES
