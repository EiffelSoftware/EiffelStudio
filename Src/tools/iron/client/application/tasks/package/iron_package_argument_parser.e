note
	description: "[
			Summary description for {IRON_PACKAGE_ARGUMENT_PARSER}.
						
				iron package {create|modify|archive} --user username --pwd password --repository http://iron.eiffel.com/7.3/ --data data_file
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_ARGUMENT_PARSER

inherit
	IRON_ARGUMENT_SINGLE_PARSER
		rename
			make as make_parser
		end

	IRON_PACKAGE_ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make (a_task: IRON_TASK)
			-- Initialize argument parser
		do
			task := a_task
			make_parser (False, False)
			set_argument_source (a_task.argument_source)
			is_using_builtin_switches := not is_verbose_switch_used
--			set_is_using_separated_switch_values (False)
--			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

	task: IRON_TASK

feature -- Access

	username: detachable IMMUTABLE_STRING_32
		do
			if
				has_option (username_switch) and then
				attached option_of_name (username_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	password: detachable IMMUTABLE_STRING_32
		do
			if
				has_option (password_switch) and then
				attached option_of_name (password_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	package_name: detachable IMMUTABLE_STRING_32
		do
			if
				has_option (package_name_switch) and then
				attached option_of_name (package_name_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	package_description: detachable IMMUTABLE_STRING_32
		do
			if
				has_option (package_description_switch) and then
				attached option_of_name (package_description_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	package_archive_file: detachable PATH
		do
			if
				has_option (package_archive_file_switch) and then
				attached option_of_name (package_archive_file_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	package_archive_source: detachable PATH
		do
			if
				has_option (package_archive_source_switch) and then
				attached option_of_name (package_archive_source_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	is_create: BOOLEAN
		do
			if attached operation as op then
				Result := op.is_case_insensitive_equal ("create")
			end
		end

	is_update: BOOLEAN
		do
			if attached operation as op then
				Result := op.is_case_insensitive_equal ("update")
			end
		end

	is_archive: BOOLEAN
		do
			if attached operation as op then
				Result := op.is_case_insensitive_equal ("archive")
			end
		end

	is_delete: BOOLEAN
		do
			if attached operation as op then
				Result := op.is_case_insensitive_equal ("delete")
			end
		end

	data_file: detachable PATH
		do
			if
				has_option (data_switch) and then
				attached option_of_name (data_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

	operation: detachable IMMUTABLE_STRING_32
		do
			if has_non_switched_argument then
				Result := value
			end
		end

	repository: detachable IMMUTABLE_STRING_32
		do
			if
				has_option (repo_switch) and then
				attached option_of_name (repo_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

feature {NONE} -- Usage

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({IRON_CONSTANTS}.executable_name + " " + task.name)
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "operation")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Operations: create, update, delete, list ..")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "action")
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (12)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (username_switch, "Username", False, False, "username", "required username", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (password_switch, "Password", False, False, "password", "required password", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (repo_switch, "Repository", True, False, "url", "Repository url including the version", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (data_switch, "Data file", True, False, "file", "File describing the data (check documentation for the format)", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_name_switch, "Package name", True, False, "name", "package name, override value from 'data file'", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_description_switch, "Package description", True, False, "description", "package description, override value from 'data file'", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_archive_file_switch, "Package archive file", True, False, "path-to-archive", "archive file, override value from 'data file'", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_archive_source_switch, "Package archive source", True, False, "folder", "Source folder used to build the archive, override value from 'data file'", False))
			add_verbose_switch (Result)
			add_simulation_switch (Result)
			add_batch_interactive_switch (Result)
		end

	username_switch: STRING = "u|username"
	password_switch: STRING = "p|password"
	repo_switch: STRING = "r|repository"
	data_switch: STRING = "d|data"

	package_name_switch: STRING = "package-name"
	package_description_switch: STRING = "package-description"
	package_archive_file_switch: STRING = "package-archive-file"
	package_archive_source_switch: STRING = "package-archive-source"

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
