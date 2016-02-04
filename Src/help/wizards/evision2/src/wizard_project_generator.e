note
	description: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR
		redefine
			generate_code
		end

create
	make

feature -- Basic Operations

	generate_code
			-- Generate the code for a new vision2-application project
		local
			map_list: HASH_TABLE [STRING_32, STRING]
			project_name_lowercase: STRING_32
			project_location: PATH
			a_string: STRING
			a_string2: STRING
		do
			Precursor
				-- cached variables
			project_name_lowercase := wizard_information.project_name.as_lower
			project_location := wizard_information.project_location

				-- Update the ace file location.
			wizard_information.set_ace_location (wizard_information.project_location.extended (project_name_lowercase + ".ecf"))

			create map_list.make (5)
			add_common_parameters (map_list)

			if wizard_information.has_menu_bar then
				map_list.force (string_from_file_content ("template_menubar_add.e"), "${FL_MENUBAR_ADD}")
				map_list.force (string_from_file_content ("template_menubar_create.e"), "${FL_MENUBAR_CREATE}")
				a_string := string_from_file_content ("template_menubar_init.e")
				if wizard_information.has_about_dialog then
					a_string2 := string_from_file_content ("template_menu_help_about_add.e")
				else
					a_string2 := {STRING_32} ""
				end
				a_string.replace_substring_all ("${FL_HELP_ABOUT_ADD}", a_string2)

				map_list.force (a_string, "${FL_MENUBAR_INIT}")
			else
				map_list.force ({STRING_32} "", "${FL_MENUBAR_ADD}")
				map_list.force ({STRING_32} "", "${FL_MENUBAR_CREATE}")
				map_list.force ({STRING_32} "", "${FL_MENUBAR_INIT}")
			end

			if wizard_information.has_status_bar then
				map_list.force (string_from_file_content ("template_statusbar_add.e"), "${FL_STATUSBAR_ADD}")
				map_list.force (string_from_file_content ("template_statusbar_create.e"), "${FL_STATUSBAR_CREATE}")
				map_list.force (string_from_file_content ("template_statusbar_init.e"), "${FL_STATUSBAR_INIT}")
			else
				map_list.force ({STRING_32} "", "${FL_STATUSBAR_ADD}")
				map_list.force ({STRING_32} "", "${FL_STATUSBAR_CREATE}")
				map_list.force ({STRING_32} "", "${FL_STATUSBAR_INIT}")
			end

			if wizard_information.has_tool_bar then
				map_list.force (string_from_file_content ("template_toolbar_add.e"), "${FL_TOOLBAR_ADD}")
				map_list.force (string_from_file_content ("template_toolbar_create.e"), "${FL_TOOLBAR_CREATE}")
				map_list.force (string_from_file_content ("template_toolbar_init.e"), "${FL_TOOLBAR_INIT}")
			else
				map_list.force ({STRING_32} "", "${FL_TOOLBAR_ADD}")
				map_list.force ({STRING_32} "", "${FL_TOOLBAR_CREATE}")
				map_list.force ({STRING_32} "", "${FL_TOOLBAR_INIT}")
			end

			if wizard_information.has_about_dialog then
				map_list.force (string_from_file_content ("template_aboutdialog_init.e"), "${FL_ABOUTDIALOG_INIT}")
			else
				map_list.force ({STRING_32} "", "${FL_ABOUTDIALOG_INIT}")
			end

			from_template_to_project (wizard_resources_path, "template_main_window.e", project_location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, "interface_names.e", project_location, "interface_names.e", map_list)
			from_template_to_project (wizard_resources_path, "about_dialog.e", project_location, "about_dialog.e", map_list)
			if wizard_information.is_scoop then
				from_template_to_project (wizard_resources_path, "template_config-scoop.ecf", project_location, project_name_lowercase + ".ecf", map_list)
			else
				from_template_to_project (wizard_resources_path, "template_config.ecf", project_location, project_name_lowercase + ".ecf", map_list)
			end
			from_template_to_project (wizard_resources_path, "application.e", project_location, "application.e", map_list)

			if wizard_information.has_tool_bar then
				copy_file ("new.png", project_location)
				copy_file ("open.png", project_location)
				copy_file ("save.png", project_location)
			end
		end

	string_from_file_content (a_content_file: STRING_32): STRING_32
		local
			file: RAW_FILE
		do
			create file.make_with_path (wizard_resources_path.extended (a_content_file))
			file.open_read
			file.read_stream (file.count)

			create Result.make (file.last_string.count)
			Result.append_string_general (file.last_string)
			Result.replace_substring_all ({STRING_32} "%R%N", {STRING_32} "%N")

			file.close
		end

feature {NONE} -- Access

	target_files: TRAVERSABLE [STRING_GENERAL]
			-- <Precursor>
		local
			r: ARRAYED_LIST [STRING_GENERAL]
		do
			create r.make_from_array (<<
				"main_window.e",
				"interface_names.e",
				"about_dialog.e",
				wizard_information.project_name.as_lower + ".ecf",
				"application.e"
			>>)
			Result := r
			if wizard_information.has_tool_bar then
				r.extend ("new.png")
				r.extend ("open.png")
				r.extend ("save.png")
			end
		end

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
