indexing
	description	: "[
		Warning when a source file could not be copied to its target.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	definition: "VICF = could not Copy File"
	date: "$Date$"
	revision: "$Revision$"

class
	VICF

inherit
	WARNING

create
	make
	
feature {NONE} -- Initialization

	make (a_source_file_name: like source_file_name; a_target_file_name: like target_file_name) is
			-- 
		require
			non_void_source_file_name: a_source_file_name /= Void
			valid_source_file_name: not a_source_file_name.is_empty
			non_void_target_file_name: a_target_file_name /= Void
			valid_target_file_name: not a_target_file_name.is_empty
		local
			l_file: RAW_FILE
		do
			source_file_name := a_source_file_name.twin
			target_file_name := a_target_file_name.twin
			create l_file.make (source_file_name)
			if not l_file.exists then
				is_missing_source := True
			else
				is_unreadable_source := not l_file.is_readable
			end
		ensure
			source_file_name_set: a_source_file_name.is_equal (source_file_name)
			target_file_name_set: a_target_file_name.is_equal (target_file_name)
		end

feature -- Properties

	code: STRING is "VICF"
		-- Error code
	
	source_file_name: STRING
			-- Source file to copy from
			
	target_file_name: STRING
			-- Target attempted to copy to
			
	is_missing_source: BOOLEAN
			-- indicates that warning is due to a missing source file
			
	is_unreadable_source: BOOLEAN
			-- indicates that warning to due to an unreadable source file

	file_name: STRING is
			-- No associated file name
		do
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
			st.add_string ("Reason: ")
			st.add_string (retrieve_reason)
			st.add_new_line
			st.add_string ("Source file name: ")
			st.add_string (source_file_name)
			st.add_new_line
			st.add_string ("Target file name: ")
			st.add_string (target_file_name)
			st.add_new_line
		end
		
feature {NONE} -- Implementation

	retrieve_reason: STRING is
			-- retrieves reason for warning
		do
			if is_missing_source then
				Result := "The source file could not be found."
			elseif is_unreadable_source then
				Result := "The source file is not a readable file."
			else
				Result := "The source file could not be copied to the target location."
			end
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

invariant
	non_void_source_file_name: source_file_name /= Void
	valid_source_file_name: not source_file_name.is_empty
	non_void_target_file_name: target_file_name /= Void
	valid_target_file_name: not target_file_name.is_empty
			
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

end -- class VICF
