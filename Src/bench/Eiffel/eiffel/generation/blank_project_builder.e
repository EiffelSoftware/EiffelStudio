indexing
	description	: "Performs the creation of a blank project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BLANK_PROJECT_BUILDER

inherit
	EB_ERROR_MANAGER

	EIFFEL_ENV
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (a_system_name, a_root_class_name, a_root_cluster_name, a_root_feature_name: STRING; a_project_directory: STRING) is
			-- Set up the blank ace builder to work with a system named
			-- `a_system_name' and a project located in `a_project_directory'.
			-- `a_root_class_name', `a_root_cluster_name' and `a_root_feature_name' are the root attribute names.
		do
			system_name := a_system_name
			root_class_name := a_root_class_name
			root_cluster_name := a_root_cluster_name
			root_feature_name := a_root_feature_name
			project_directory := a_project_directory

				-- Create the pathname of the ace file
			create ace_filename.make_from_string (project_directory)
			ace_filename.set_file_name (system_name.as_lower)
			ace_filename.add_extension (config_extension)

				-- Create the pathname of the root class.
			create root_class_filename.make_from_string (project_directory)
			root_class_filename.set_file_name (a_root_class_name.as_lower)
			root_class_filename.add_extension (eiffel_extension)
		end

feature -- Access

	ace_filename: FILE_NAME
			-- Filename of the ace file for this project.

	root_class_filename: FILE_NAME
			-- Filename of the root class file for this project.

feature -- Basic operations.

	create_blank_project is
			-- Create the default ace file and the default root class
		local
			ace_file_content: STRING
		do
				-- Create the ace file
			ace_file_content := default_config_file_contents
			process_ace_file_content (ace_file_content)
			save_ace_file_content (ace_file_content)

				-- Create the root class file
			create_root_class
		end

feature {NONE} -- Implementation

	process_ace_file_content (contents: STRING) is
			-- Process `contents': Fill in the blank with `system_name' and `project_directory'.
		require
			valid_contents: contents /= Void and then not contents.is_empty
			valid_system_name: system_name /= Void and then not system_name.is_empty
			valid_project_directory: project_directory /= Void and then not project_directory.is_empty
		do
			contents.replace_substring_all ("$system_name", system_name)
			contents.replace_substring_all ("$root_class_name", root_class_name)
			contents.replace_substring_all ("$root_class_feature", root_feature_name)
			contents.replace_substring_all ("$root_cluster_name", root_cluster_name)
			contents.replace_substring_all ("$root_cluster_location", project_directory)
		end

	save_ace_file_content (contents: STRING) is
			-- Save the ace file `content' in the filename `ace_filename'.
		require
			valid_contents: contents /= Void
		local
			new_file: PLAIN_TEXT_FILE
			char: CHARACTER
		do
			create new_file.make (ace_filename)
				-- Create the ace file and save the content in it.
			new_file.open_write
			if not contents.is_empty then
				contents.replace_substring_all ("%R", "")
				new_file.put_string (contents)
				char := contents.item (contents.count)
				if Platform_constants.is_unix and
					then char /= '%N' and
					then char /= '%R'
						-- Add a carriage return like vi if there's none at
						-- the end
				then
					new_file.put_new_line
				end
			end
			new_file.close
		rescue
			add_error_message (
				"Unable to create or overwrite the ace file '"+ace_filename+"'%N%
				%Check your write permissions in this directory")
		end

	default_config_file_contents: STRING is
			-- Contents of the default ace file
		local
			a_file: RAW_FILE
		do
			create a_file.make (Default_config_name)
			a_file.open_read
			a_file.read_stream (a_file.count)
			a_file.close
			Result := a_file.last_string
		rescue
			add_error_message (
				"Unable to read the template ace file '"+Default_config_name+"'%N%
				%Check that the file exists and that you are allowed to read it.")
		end

	create_root_class is
			-- Create the file named `root_class_filename' and flush the content
			-- of the default root class in it.
		local
			new_class: PLAIN_TEXT_FILE
		do
			create new_class.make (root_class_filename)
			if not new_class.exists then
				new_class.open_write
				new_class.put_string (
					"indexing%N%
					%%Tdescription%T: %"System's root class%"%N%
					%%Tnote%T%T: %"Initial version automatically generated%"%N%
					%%N%
					%class%N%
					%%T" + root_class_name + "%N%
					%%N%
					%create%N%
					%%T" + root_feature_name + "%N%
					%%N%
					%feature -- Initialization%N%
					%%N%
					%%T" + root_feature_name + " is%N%
					%%T%T%T-- Creation procedure.%N%
					%%T%Tdo%N%
					%%T%T%T--| Add your code here%N%
					%%T%Tend%N%
					%%Nend -- class " + root_class_name + "%
					%%N")
				new_class.close
			end
		rescue
			add_error_message (
				"Unable to create the root class file '"+root_class_filename+"'%N%
				%Check your write permissions on this file and on this directory")
		end

feature {NONE} -- Private attributes

	system_name: STRING
			-- Name of the system of the project to build.

	root_class_name: STRING
			-- Name of the system of the project to build.

	root_cluster_name: STRING
			-- Name of the system of the project to build.

	root_feature_name: STRING
			-- Name of the system of the project to build.

	project_directory: STRING;
			-- Location of the project to build.

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

end -- class BLANK_PROJECT_BUILDER
