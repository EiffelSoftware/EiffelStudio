note
	description	: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_PROJECT_GENERATOR

inherit
	ANY

	WIZARD_SHARED
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_wizard_information: WIZARD_INFORMATION)
			-- Initialize the project generator with information `a_wizard_information'.
		do
			wizard_information := a_wizard_information
		end

feature -- Status report

	existing_target_files: TRAVERSABLE [STRING_GENERAL]
			-- Files that exist in the target directory
		local
			r: ARRAYED_LIST [STRING_GENERAL]
		do
			create r.make (0)
			Result := r
			target_files.do_all (
				agent (n: STRING_GENERAL; s: SEQUENCE [STRING_GENERAL])
					local
						u: FILE_UTILITIES
					do
						if u.file_path_exists (wizard_information.project_location.extended (n)) then
							s.extend (n)
						end
					end
				(?, r)
			)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	target_files: TRAVERSABLE [STRING_GENERAL]
			-- All target files that will be created during generation
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Basic Operations

	generate_code
			-- Generate code for the project.
		deferred
		end

feature {NONE} -- Implementation

	copy_file (name, extension, destination: STRING_32)
			-- Copy Class whose name is 'name'
		require
			name /= Void
			is_target_file: target_files.has (name + "." + extension)
		local
			f_name: PATH
			fi: RAW_FILE
			s: STRING
		do
			create fi.make_with_path (wizard_resource_path.extended (name + {STRING_32} "." + extension))
			fi.open_read
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close
			create f_name.make_from_string (destination)
			create fi.make_with_path (f_name.extended (name + {STRING_32} "." + extension))
			fi.open_write
			fi.put_string (s)
			fi.close
		end

	from_template_to_project (template_path: PATH; template_name: STRING_32; resource_path: PATH; resource_name: STRING_32; map_list: LINKED_LIST [TUPLE [STRING, STRING_32]])
			-- Take a template_name (name of the file) and its template_path
			-- Then change the FL Tag with strings according to the map_list
			-- Copy the modified template in a new file resource_name in the resource_path.
		require
			is_target_file: target_files.has (resource_name)
		local
			tup: TUPLE [s1: STRING; s2: STRING_32]
			s: STRING
			fi: PLAIN_TEXT_FILE
			u: UTF_CONVERTER
		do
			create fi.make_with_path (template_path.extended (template_name))
			fi.open_read
			fi.read_stream (fi.count)
			s:= fi.last_string.twin
			if map_list /= Void then
				from
					map_list.start
				until
					map_list.after
				loop
					tup:= map_list.item
					s.replace_substring_all (tup.s1, u.string_32_to_utf_8_string_8 (tup.s2))
					map_list.forth
				end
			end
			fi.close
			create fi.make_with_path (resource_path.extended (resource_name))
			fi.open_write
			fi.put_string (s)
			fi.close
		end

	add_common_parameters (map_list: LINKED_LIST [TUPLE [STRING, STRING_32]])
			-- Add the common parameters to the replacement pattern.
		local
			current_time: DATE_TIME
			tuple: TUPLE [STRING, STRING_32]
			project_name: STRING_32
			project_name_lowercase: STRING_32
			project_name_uppercase: STRING_32
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
			tuple.put (l_uuid.generate_uuid.out.as_string_32, 2)
			map_list.extend (tuple)

				-- Add the date for indexing clause.
			create current_time.make_now
			create tuple
			tuple.put ("${FL_DATE}", 1)
			tuple.put (
				{STRING_32} "$Date: "+current_time.year.out+"/"+current_time.month.out+"/"+current_time.day.out+" "+
				current_time.hour.out+":"+current_time.minute.out+":"+current_time.second.out+" $", 2)
			map_list.extend (tuple)
		end

feature {NONE} -- Implementation / private attributes

	wizard_information: WIZARD_INFORMATION;
			-- Information about the project to generate.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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


end
