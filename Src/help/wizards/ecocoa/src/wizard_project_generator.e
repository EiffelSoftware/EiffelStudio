note
	description	: "Object to generate a project."
	author		: "Daniel Furrer <danie.furrer@gmail.com>"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR

create
	make

feature -- Basic Operations

	generate_code
			-- Generate the code for a new cocoa-application project
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			project_name_lowercase: STRING
			project_location: FILE_NAME
			ace_location: FILE_NAME
			tuple2: TUPLE [STRING, STRING]
			a_string: STRING
			a_string2: STRING
		do
				-- cached variables
			project_name_lowercase := wizard_information.project_name.as_lower
			create project_location.make_from_string (wizard_information.project_location)

				-- Update the ace file location.
			create ace_location.make_from_string (wizard_information.project_location)
			ace_location.set_file_name (project_name_lowercase + ".ecf")
			wizard_information.set_ace_location (ace_location)

			create map_list.make
			add_common_parameters (map_list)

			from_template_to_project (wizard_resources_path, "application.e",			project_location, "application.e", map_list)
		end

	tuple_from_file_content (an_index: STRING; a_content_file: STRING): TUPLE [STRING, STRING]
		local
			file_content: STRING
			file: RAW_FILE
			file_name: FILE_NAME
		do
			create file_name.make_from_string (wizard_resources_path)
			file_name.set_file_name (a_content_file)

			create file.make_open_read (file_name)
			file.read_stream (file.count)

			file_content := file.last_string.twin
			file_content.replace_substring_all ("%R%N", "%N")

			create Result
			Result.put (an_index, 1)
			Result.put (file_content, 2)

			file.close
		end

	empty_tuple (an_index: STRING): TUPLE [STRING, STRING]
		do
			create Result
			Result.put (an_index, 1)
			Result.put ("", 2)
		end

feature {NONE} -- Access

	target_files: TRAVERSABLE [STRING_GENERAL]
			-- <Precursor>
		local
			r: ARRAYED_LIST [STRING_GENERAL]
		do
			create r.make_from_array (<<
				"application.e"
			>>)
			Result := r
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
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

end -- class WIZARD_PROJECT_GENERATOR
