note
	description: "Common routines used throughout the Wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_ROUTINES

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ANY

feature -- Access

	Temporary_input_file_name: STRING = "Input_File"
			-- Input file

feature -- Basic Operations

	c_to_obj (a_file_name: READABLE_STRING_32): READABLE_STRING_32
			-- Change file name extension from ".c" or ".cpp" to ".obj".
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: is_c_file (create {PATH}.make_from_string (a_file_name))
		do
			Result := a_file_name.head (a_file_name.index_of ('.', 1) - 1) + ".obj"
		ensure
			changed: Result.substring (Result.count - 3, Result.count).is_equal (".obj")
		end

	is_c_file (a_file_name: PATH): BOOLEAN
			-- Is `a_file_name' a valid c/c++ file name?
		do
			Result :=
				a_file_name.has_extension (c_file_extension.tail (c_file_extension.count - 1)) or else
				a_file_name.has_extension (cpp_file_extension.tail (cpp_file_extension.count - 1))
		end

	is_object_file (a_file: PATH): BOOLEAN
			-- Is `a_file' an object (.obj) file?
		do
			Result := a_file.has_extension (object_file_extension.tail (object_file_extension.count - 1))
		end

	is_valid_folder_name (a_folder_name: READABLE_STRING_32): BOOLEAN
			-- Is `a_folder_name' a valid folder name?
		local
			a_directory: DIRECTORY
		do
			create a_directory.make (a_folder_name)
			Result := a_directory.exists
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
