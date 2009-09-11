note
	description	: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
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
			-- Generate code for the project.
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			project_name_lowercase: STRING
			project_location: STRING
			source_prefix: STRING
		do
			if wizard_information.dialog_application then
				map_list := map_for_dialog
				source_prefix := "dialog"
			else
				map_list := map_for_frame
				source_prefix := "frame"
			end
			map_list.extend (["${FL_MAIN_CLASS}", "MAIN_WINDOW"])
			add_common_parameters (map_list)
				-- Cached variables
			project_name_lowercase := wizard_information.project_name.as_lower
			project_location := wizard_information.project_location

			from_template_to_project (wizard_resources_path, "template_config.ecf", 					project_location, project_name_lowercase + ".ecf", map_list)
			from_template_to_project (wizard_resources_path, "root_template.e", 			project_location, "root_class.e", map_list)
			from_template_to_project (wizard_resources_path, source_prefix + "_main_window.e", 		project_location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, source_prefix + "_template.rc", 			project_location, project_name_lowercase + ".rc", map_list)
			from_template_to_project (wizard_resources_path, source_prefix + "_resource.h", 			project_location, "resource.h", map_list)
			from_template_to_project (wizard_resources_path, source_prefix + "_application_ids.e", 	project_location, "application_ids.e", map_list)
			copy_icon
			wizard_information.set_ace_location (project_location + "\" + project_name_lowercase + ".ecf")
		end

feature {NONE} -- Access

	target_files: TRAVERSABLE [STRING_GENERAL]
			-- <Precursor>
		local
			project_name_lowercase: STRING
		do
			project_name_lowercase := wizard_information.project_name.as_lower
			create {ARRAYED_LIST [STRING_GENERAL]} Result.make_from_array (<<
				project_name_lowercase + ".ecf",
				"root_class.e",
				"main_window.e",
				project_name_lowercase + ".rc",
				"resource.h",
				"application_ids.e",
				project_name_lowercase + ".ico"
			>>)
		end

feature {NONE} -- Implementation

	map_for_dialog: LINKED_LIST [TUPLE [STRING, STRING]]
			-- Mapping for a new dialog-application project
		local
			main_dialog_id: STRING
		do
			create Result.make
			Result.extend (["${FL_APPLICATION_TYPE}", "WEL_MAIN_DIALOG"])

			create main_dialog_id.make (0)
			main_dialog_id.append (wizard_information.project_name)
			main_dialog_id.to_lower
			main_dialog_id.prepend ("Idd_")
			main_dialog_id.append ("_dialog")
			Result.extend (["${FL_CREATION}", "make_by_id (" + main_dialog_id + ")"])
		end


	map_for_frame: LINKED_LIST [TUPLE [STRING, STRING]]
			-- Mapping for a new frame-application project
		do
				-- Create the replacement strings.
			create Result.make
			Result.extend (["${FL_ICON_NAME}", wizard_information.project_name.as_lower + ".ico"])
			Result.extend (["${FL_APPLICATION_TYPE}", "WEL_FRAME_WINDOW"])
		end

	copy_icon
			-- Copy the icon
		local
			fi: RAW_FILE
			s: STRING
			project_name_lowercase: STRING
		do
			project_name_lowercase := wizard_information.project_name.as_lower

			create fi.make_open_read (wizard_information.icon_location)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close

			create fi.make_open_write (wizard_information.project_location + "\" + project_name_lowercase + ".ico")
			fi.put_string (s)
			fi.close
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
