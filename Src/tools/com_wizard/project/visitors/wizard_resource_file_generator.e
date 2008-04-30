indexing
	description: "Resource file generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RESOURCE_FILE_GENERATOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
			{ANY} client
			{ANY} server
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	ANY

feature -- Access

	Resource_file_extension: STRING is ".rc"
			-- Resource file extension

feature -- Basic operations

	generate (a_folder: STRING) is
			-- Generate resource file in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_string: STRING
			a_file: PLAIN_TEXT_FILE
		do
			create a_string.make (500)
			a_string.append (environment.destination_folder)
			a_string.append (a_folder)
			a_string.append_character (Directory_separator)
			a_string.append (Resource_file_name)
			create a_file.make_create_read_write (a_string)
			a_file.put_string (generated_resource_file)
			a_file.close
		end

	Generated_resource_file: STRING is
			-- Resource file content
		local
			str_buffer: STRING
		do
			create Result.make (100)
			Result.append ("1 typelib ")
			Result.append (Double_quote)

			str_buffer := environment.type_library_file_name.twin
			str_buffer.replace_substring_all ("%H", "%H%H")

			Result.append (str_buffer)
			Result.append (Double_quote)
		end

	Resource_file_name: STRING is
			-- Resource file name
		do
			create Result.make (100)
			Result.append (environment.project_name)
			Result.append (Resource_file_extension)
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
end -- class WIZARD_RESOURCE_FILE_GENERATOR


