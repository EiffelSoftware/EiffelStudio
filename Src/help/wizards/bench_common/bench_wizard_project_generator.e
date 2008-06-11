indexing
	description	: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_PROJECT_GENERATOR

inherit
	WIZARD_SHARED
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_wizard_information: WIZARD_INFORMATION) is
			-- Initialize the project generator with information `a_wizard_information'.
		do
			wizard_information := a_wizard_information
		end

feature -- Basic Operations

	generate_code is
			-- Generate code for the project.
		deferred
		end

feature {NONE} -- Implementation

	copy_file (name, extension, destination: STRING) is
			-- Copy Class whose name is 'name'
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: RAW_FILE
			s: STRING
		do
			create f1.make_from_string (wizard_resources_path)
			f_name := f1.twin
			f_name.extend (name)
			f_name.add_extension (extension)
			create fi.make_open_read (f_name)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close
			create f_name.make_from_string (destination)
			f_name.extend (name)
			f_name.add_extension (extension)
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close
		end

	from_template_to_project (template_path, template_name, resource_path, resource_name: STRING; map_list: LINKED_LIST [TUPLE [STRING, STRING]]) is
			-- Take a template_name (name of the file) and its template_path
			-- Then change the FL Tag with strings according to the map_list
			-- Copy the modified template in a new file resource_name in the resource_path.
		local
			tup: TUPLE [STRING, STRING]
			s, s1, s2: STRING
			fi: PLAIN_TEXT_FILE
			f_name: FILE_NAME
			f_n1: FILE_NAME
		do
			create f_n1.make_from_string (template_path)
			f_n1.set_file_name (template_name)
			create fi.make_open_read (f_n1)
			fi.read_stream (fi.count)
			s:= fi.last_string.twin
			if map_list /= Void then
				from
					map_list.start
				until
					map_list.after
				loop
					tup:= map_list.item
					s1 ?= tup.item (1)
					s2 ?= tup.item (2)
					if s1 /= Void and s2 /= Void then
						s.replace_substring_all (s1, s2)
					end
					map_list.forth
				end
			end
			fi.close
			create f_name.make_from_string (resource_path)
			f_name.set_file_name (resource_name)
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close
		end

	add_common_parameters (map_list: LINKED_LIST [TUPLE [STRING, STRING]]) is
			-- Add the common parameters to the replacement pattern.
		local
			current_time: DATE_TIME
			tuple: TUPLE [STRING, STRING]
			project_name: STRING
			project_name_lowercase: STRING
			project_name_uppercase: STRING
			l_uuid: UUID_GENERATOR
		do
				-- Add the project name.
			project_name := wizard_information.project_name
			create tuple
			tuple.put ("${FL_PROJECT_NAME}", 1)
			tuple.put (project_name, 2)
			map_list.extend (tuple)

				-- Add the project name (in uppercase)
			project_name_uppercase := project_name.as_upper
			create tuple
			tuple.put ("${FL_PROJECT_NAME_UPPERCASE}", 1)
			tuple.put (project_name_uppercase, 2)
			map_list.extend (tuple)

				-- Add the project name (in lowercase)
			project_name_lowercase := project_name.as_lower
			create tuple
			tuple.put ("${FL_PROJECT_NAME_LOWERCASE}", 1)
			tuple.put (project_name_lowercase, 2)
			map_list.extend (tuple)

				-- Add the project location
			create tuple
			tuple.put ("${FL_LOCATION}", 1)
			tuple.put (wizard_information.project_location, 2)
			map_list.extend (tuple)

				-- Add UUID for project
			create l_uuid
			create tuple
			tuple.put ("${FL_UUID}", 1)
			tuple.put (l_uuid.generate_uuid.out, 2)
			map_list.extend (tuple)

				-- Add the date for indexing clause.
			create current_time.make_now
			create tuple
			tuple.put ("${FL_DATE}", 1)
			tuple.put (
				"$Date: "+current_time.year.out+"/"+current_time.month.out+"/"+current_time.day.out+" "+
				current_time.hour.out+":"+current_time.minute.out+":"+current_time.second.out+" $", 2)
			map_list.extend (tuple)
		end

feature {NONE} -- Implementation / private attributes

	wizard_information: WIZARD_INFORMATION;
			-- Information about the project to generate.

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
end -- class WIZARD_PROJECT_GENERATOR

