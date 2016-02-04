note
	description: "Object to generate a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR
		redefine
			generate_code
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Basic Operations

	generate_code
			-- Generate the code for a new vision2-application project
		local
			map_list: HASH_TABLE [STRING_32, STRING]
			project_name_lowercase: STRING_32
			project_location: PATH
			ace_location: PATH
			root_class_name_lowercase: STRING_32
		do
			Precursor
				-- cached variables
			project_name_lowercase := wizard_information.project_name.as_lower
			project_location := wizard_information.project_location

				-- Update the ace file location.
			ace_location := project_location.extended (project_name_lowercase + Config_extension)
			wizard_information.set_ace_location (ace_location)

			create map_list.make (10)
			add_common_parameters (map_list)
				-- Add the project type
			map_list.force (wizard_information.application_type, application_type_template)

				-- Add the root class name
			root_class_name_lowercase := wizard_information.root_class_name.as_lower
			if not root_class_name_lowercase.same_string_general (None_class) then
				map_list.force (wizard_information.root_class_name, Root_class_name_template)

					-- Add the creation routine name
				map_list.force (wizard_information.creation_routine_name, Creation_routine_name_template)
				map_list.force ({STRING_32} "", all_classes_template)
			else
				map_list.force ({STRING_32} "ROOT_CLASS", Root_class_name_template)

					-- Add the creation routine name
				map_list.force ({STRING_32} "make", Creation_routine_name_template)
				map_list.force ({STRING_32} "all_classes=%"true%"", all_classes_template)
			end

				-- Add console application (yes\no)
			if wizard_information.console_application then
				map_list.force ({STRING_32} "true", Console_application)
			else
				map_list.force ({STRING_32} "false", Console_application)
			end

				-- Add target clr version
			if not wizard_information.is_most_recent_clr_version then
				map_list.force ({STRING_32} "<setting name=%"msil_clr_version%" value=%"" + wizard_information.clr_version + "%"/>", clr_version_template)
			else
				map_list.force ({STRING_32} "", clr_version_template)
			end

				-- Generation
			if not root_class_name_lowercase.same_string_general (None_class) then
				from_template_to_project (wizard_resources_path, Application_template_filename,	project_location, root_class_name_lowercase + Eiffel_extension, map_list)
			end
			from_template_to_project (wizard_resources_path, Ace_template_filename, project_location, project_name_lowercase + Config_extension, map_list)
		end

feature {NONE} -- Access

	target_files: TRAVERSABLE [STRING_GENERAL]
			-- All target files that will be created during generation
		local
			r: ARRAYED_LIST [STRING_GENERAL]
			root_class_name_lowercase: STRING
		do
			create r.make_from_array (<<
				wizard_information.project_name.as_lower + Config_extension
			>>)
			Result := r
			root_class_name_lowercase := wizard_information.root_class_name.as_lower
			if not root_class_name_lowercase.is_equal (None_class) then
				r.extend (root_class_name_lowercase + Eiffel_extension)
			end
		end

feature {NONE} -- Constants

	Application_type_template: STRING = "${FL_APPLICATION_TYPE}"
			-- String to be replaced by the chosen application type

	Root_class_name_template: STRING = "${FL_ROOT_CLASS_NAME}"
			-- String to be replaced by the chosen root class name

	Creation_routine_name_template: STRING = "${FL_CREATION_ROUTINE_NAME}"
			-- String to be replaced by the chosen creation routine name

	Console_application: STRING = "${FL_CONSOLE_APPLICATION}"
			-- String to be replaced by yes or no.

	clr_version_template: STRING = "${FL_CLR_VERSION}"
			-- String to be replaced by the chosen version of CLR

	all_classes_template: STRING = "${FL_ALL_CLASSES}"
			-- String to be replaced if NONE is root class.

	Config_extension: STRING = ".ecf"
			-- Ace files extension

	Eiffel_extension: STRING = ".e"
			-- Eiffel classes extension

	Ace_template_filename: STRING_32 = "template_config.ecf"
			-- Filename of the Ace file template used to automatically generate Ace files for .NET applications

	Application_template_filename: STRING_32 = "template_application.e"
			-- Filename of the template used to automatically generate a root class for .NET applications

	None_class: STRING = "none"
			-- `NONE' class

	Comma: STRING = ",";
			-- Comma

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
