indexing
	description: "Objects that provide useful functions for naming."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NAMING_UTILITIES

feature -- Basic operations

	valid_class_name (a_name: STRING): BOOLEAN is
			-- Check that name `class_name' is a valid class name.
		local
			cn: STRING
			cchar: CHARACTER
			i: INTEGER
		do
			Result := True
			cn := a_name
			if not cn.is_empty then
				if cn = void or else not (cn @ 1).is_alpha then
					Result := False
				else
					from
						i := 2
					until
						i > cn.count or not Result
					loop
						cchar := (cn @ i)
						Result := cchar.is_alpha or cchar.is_digit or cchar = '_'
						i := i + 1
					end
				end
			else
				Result := False
			end
		end


	unique_name_from_array (existing_names: ARRAYED_LIST [STRING]; hint_name: STRING): STRING is
			-- `Result' is a STRING guaranteed not to be contained in `existing_names',
			-- which is the value of `hint_name' with an underscore and a number appended to it.
			-- The algorithm used does not guarantee that this is the first available number.
		require
			existing_names_not_void: existing_names /= Void
			hint_name_not_void: hint_name /= Void
		local
			names: ARRAYED_LIST [STRING]
			matches: INTEGER
			hint_name_lower, item_lower: STRING
			suggested_result: STRING
		do
			hint_name_lower := hint_name
			hint_name_lower.to_lower
				-- We clone `existing_names' so when we compare references, we
				-- do not affect the list that was passed in.
			names := existing_names.twin
			names.compare_objects
			from
				names.start
			until
				names.off
			loop
				item_lower := names.item
				item_lower.to_lower
					-- This converts the list names to lower case.
					-- This is essential for "not has" used at end of this feature.
				names.replace (item_lower)
				if item_lower.count > hint_name_lower.count and
					item_lower.substring (1, hint_name_lower.count).is_equal (hint_name_lower) then
					matches := matches + 1	
				end
				names.forth
			end
				-- Increase matches for initial suggested name.
			matches := matches + 1
			
			suggested_result := hint_name_lower + "_" + matches.out
			if names.has (suggested_result) then
				from
				until
					not names.has (suggested_result)
				loop
					matches := matches + 1
					suggested_result := hint_name_lower + "_" + matches.out
				end
				Result := suggested_result
			else
				Result := suggested_result
			end
				-- Unable to provide a postcondition, so we have a check instead.
			check
				Result_is_uniqe_name: not names.has (Result)
			end
		end
		
	unique_name_from_hash_table (existing_names: HASH_TABLE [STRING, STRING]; hint_name: STRING): STRING is
			-- `Result' is a STRING guaranteed not to exist in `existing_names', based on `hint_name.
		require
			existing_names_not_void: existing_names /= Void
			hint_name_not_void: hint_name /= Void
		local
			counter: INTEGER
		do
			from
				counter := 1
				Result := hint_name
			until
				not existing_names.has (Result)
			loop
				Result := hint_name + "_" + counter.out
				counter := counter + 1
			end
				-- Unable to provide a postcondition, so we have a check instead.
			check
				Result_is_uniqe_name: not existing_names.has (Result)
			end
		end
		

	undo_last_character (text_field: EV_TEXT_FIELD) is
			-- Remove last character added to `text_field'.
			-- Dependent on caret position, so this should be called
			-- immediately after the change, and before anything modifies
			-- the caret position.
			-- The change_actions of `text_field' are blocked.
		local
			current_caret_position: INTEGER
		do
			current_caret_position := text_field.caret_position
				text_field.change_actions.block
					-- We must handle three different cases in order to restore the text if an
					-- invalid character was received.
				if current_caret_position = text_field.text.count + 1 then
					text_field.set_text (text_field.text.substring (1, text_field.text.count - 1))
					text_field.set_caret_position (current_caret_position - 1)
				elseif current_caret_position = 2 then
					text_field.set_text (text_field.text.substring (2, text_field.text.count))	
					text_field.set_caret_position (1)
				else
					text_field.set_text (text_field.text.substring (1, current_caret_position - 2) + text_field.text.substring (current_caret_position, text_field.text.count))
					text_field.set_caret_position (current_caret_position - 1)
				end
				text_field.change_actions.resume
		end
		
	pixmap_file_title_to_constant_name (file_title: STRING): STRING is
			-- Convert `file_title' which is the title of a file on disk
			-- to a prompted name for a constant value.
		require
			file_title_not_void: file_title /= Void
		do
			Result := file_title.twin
			Result.replace_substring_all (" ", "_")
			Result.replace_substring_all (".", "_")
			Result := Result.as_lower
		ensure
			result_not_void: Result /= Void
		end
		
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_NAMING_UTILITIES
