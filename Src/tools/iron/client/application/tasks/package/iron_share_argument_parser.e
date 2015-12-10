note
	description: "[
			Summary description for {IRON_SHARE_ARGUMENT_PARSER}.
						
				iron package {create|update|delete} --user username --pwd password --repository http://iron.eiffel.com/13.11 --data data_file
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SHARE_ARGUMENT_PARSER

inherit
	IRON_ARGUMENT_SINGLE_PARSER
		redefine
			validate_arguments
		end

	IRON_SHARE_ARGUMENTS

create
	make

feature {NONE} -- Validation

	validate_arguments
			-- <Precursor>
		do
			Precursor
			if has_option (username_switch) and has_option (password_switch) then
			elseif has_option (configuration_file_switch) then
			else
				add_error ("Missing username, password , or configuration file.")
			end
		end

feature -- Access

	configuration_file: detachable PATH
			-- <Precursor>
		do
			if
				has_option (configuration_file_switch) and then
				attached option_of_name (configuration_file_switch) as opt
			then
				create Result.make_from_string (opt.value)
			end
		end

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

	package_file: detachable PATH
			-- <Precursor>
		do
			if
				has_option (package_file_switch) and then
				attached option_of_name (package_file_switch) as opt
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

	package_title: detachable IMMUTABLE_STRING_32
		do
			if
				has_option (package_title_switch) and then
				attached option_of_name (package_title_switch) as opt
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

	package_indexes: detachable ARRAYED_LIST [IMMUTABLE_STRING_32]
		do
			if has_option (package_index_switch) and then
				attached options_values_of_name (package_index_switch) as lst
			then
				Result := lst
			end
		end

	is_forcing: BOOLEAN
		do
			Result := has_option (force_switch)
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
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (username_switch, "Username", True, False, "username", "required username", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (password_switch, "Password", True, False, "password", "required password", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (repo_switch, "Repository", True, False, "url", "Repository url including the version", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (configuration_file_switch, "Configuration file location", True, False, "location", "location of configuration file that may set 'username,password,repository' (.ini syntax)", False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (data_switch, "Data file", True, False, "file", "File describing the data (check documentation for the format)", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_file_switch, "Iron package location", True, False, "path to package.iron", "package location, override existing value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_name_switch, "Package name", True, False, "name", "package name, override existing value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_title_switch, "Package title", True, False, "name", "package title, override existing value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_description_switch, "Package description", True, False, "description", "package description, override existing value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_archive_file_switch, "Package archive file", True, False, "path-to-archive", "archive file, override existing value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_archive_source_switch, "Package archive source", True, False, "folder", "Source folder used to build the archive, override existing value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (package_index_switch, "Associated package path (c.f full iron URI)", True, True, "path", "relative path from repository url", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Force operations (such as upload again the archive, ...)", True, True))
			fill_argument_switches (Result)
			add_simulation_switch (Result)
			add_batch_interactive_switch (Result)
		end

	configuration_file_switch: STRING = "config"
	username_switch: STRING = "u|username"
	password_switch: STRING = "p|password"
	repo_switch: STRING = "r|repository"
	data_switch: STRING = "d|data"
	force_switch: STRING = "f|force"

	package_file_switch: STRING = "package"
	package_name_switch: STRING = "package-name"
	package_title_switch: STRING = "package-title"
	package_description_switch: STRING = "package-description"
	package_archive_file_switch: STRING = "package-archive-file"
	package_archive_source_switch: STRING = "package-archive-source"
	package_index_switch: STRING = "index"

;note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
