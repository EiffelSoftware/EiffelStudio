note
	description: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BENCH_WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_CONSTANTS

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

	is_scoop_supported: BOOLEAN
			-- Does current wizard support SCOOP-capable projects?
		local
			f: FILE_UTILITIES
		do
			Result := f.file_path_exists (wizard_resources_path.extended ("template_config-scoop.ecf"))
		end

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

	has_error: BOOLEAN
			-- Is there an error when generating a project?
		do
			Result := attached error
		end

	error: detachable TUPLE [title, message: READABLE_STRING_GENERAL]
			-- An error during generation (if any).

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
		do
			error := Void
		end

feature {NONE} -- Implementation

	copy_file (name: STRING_32; destination: PATH)
			-- Copy Class with file name 'name' to `destination'.
		require
			name /= Void
			is_target_file: target_files.has (name)
		local
			u: FILE_UTILITIES
		do
			u.copy_file_path (wizard_resources_path.extended (name), destination.extended (name))
		end

	from_template_to_project (template_path: PATH; template_name: STRING_32; resource_path: PATH; resource_name: STRING_32; map_list: HASH_TABLE [STRING_32, STRING_8])
			-- Take a template_name (name of the file) and its template_path
			-- Then change the FL Tag with strings according to the map_list
			-- Copy the modified template in a new file resource_name in the resource_path.
		require
			is_target_file: target_files.has (resource_name)
		local
			p: PATH
			s: STRING
			fi: PLAIN_TEXT_FILE
			u: UTF_CONVERTER
			is_retried: BOOLEAN
			was_error: BOOLEAN
		do
			if not is_retried then
				p := template_path.extended (template_name)
				if attached error then
					was_error := True
				else
					error := [bench_interface_names.t_file_read_error, bench_interface_names.m_file_read_error (p.name)]
				end
				create fi.make_with_path (p)
				fi.open_read
				fi.read_stream (fi.count)
				s:= fi.last_string.twin
				if map_list /= Void then
					from
						map_list.start
					until
						map_list.after
					loop
						s.replace_substring_all (map_list.key_for_iteration, u.string_32_to_utf_8_string_8 (map_list.item_for_iteration))
						map_list.forth
					end
				end
				fi.close
				p := resource_path.extended (resource_name)
				if not was_error then
					error := [bench_interface_names.t_file_write_error, bench_interface_names.m_file_write_error (p.name)]
				end
				create fi.make_with_path (p)
				fi.open_write
				fi.put_string (s)
				fi.close
				if not was_error then
					error := Void
				end
			end
		rescue
			is_retried := True
			retry
		end

	add_common_parameters (map_list: HASH_TABLE [STRING_32, STRING])
			-- Add the common parameters to the replacement pattern.
		local
			current_time: DATE_TIME
			project_name: STRING_32
			project_name_lowercase: STRING_32
			project_name_uppercase: STRING_32
			l_uuid: UUID_GENERATOR
		do
				-- Add the project name.
			project_name := wizard_information.project_name
			map_list.force (project_name, "${FL_PROJECT_NAME}")

				-- Add the project name (in uppercase)
			project_name_uppercase := project_name.as_upper
			map_list.force (project_name_uppercase, "${FL_PROJECT_NAME_UPPERCASE}")

				-- Add the project name (in lowercase)
			project_name_lowercase := project_name.as_lower
			map_list.force (project_name_lowercase, "${FL_PROJECT_NAME_LOWERCASE}")

				-- Add the project location
			map_list.force (wizard_information.project_location.name, "${FL_LOCATION}")

				-- Add UUID for project
			create l_uuid
			map_list.force (l_uuid.generate_uuid.out.as_string_32, "${FL_UUID}")

				-- Add the date for indexing clause.
			create current_time.make_now
			map_list.force (
				{STRING_32} "$Date: "+current_time.year.out+"/"+current_time.month.out+"/"+current_time.day.out+" "+
				current_time.hour.out+":"+current_time.minute.out+":"+current_time.second.out+" $", "${FL_DATE}")
		end

feature {NONE} -- Implementation / private attributes

	wizard_information: WIZARD_INFORMATION;
			-- Information about the project to generate.

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
