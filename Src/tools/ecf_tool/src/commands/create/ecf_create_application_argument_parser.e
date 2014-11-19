note
	description: "Summary description for {ECF_CREATE_APPLICATION_ARGUMENT_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_CREATE_APPLICATION_ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_single_parser
		redefine
			post_process_arguments,
			sub_system_name
		end

	ECF_CREATE_APPLICATION_ARGUMENTS

	APPLICATION_COMMAND_ARGUMENT_PARSER

	SHARED_EXECUTION_ENVIRONMENT

create
	make,
	make_with_source

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_single_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

	make_with_source (src: ARGUMENT_SOURCE)
			-- Initialize argument parser
		do
			make
			set_argument_source (src)
		end

feature {NONE} -- Argument operation

	post_process_arguments
		local
			ut: FILE_UTILITIES
		do
			Precursor
			if is_successful then
				is_application_target := has_option (application_target_switch)
				is_library_target := has_option (library_target_switch)
				is_testing_target := has_option (testing_target_switch)
				if is_application_target xor is_library_target xor is_testing_target then
				else
					add_error ("Either Application xor Library xor Test")
				end
				if is_successful then
					if is_library_target and attached concurrency then
						add_error ("Concurrency settings are ignored for library target")
					end
					if not is_application_target and attached executable_name then
						add_error ("Executable name settings are ignored for non application target")
					end
					if is_application_target and root_info = Void then
						add_error ("Please provide the entry point with --application CLASS_NAME.creation_name")
					end
					if is_testing_target and root_info /= Void then
						add_error ("Root info settings are ignored for Testing target")
					end
					if is_testing_target and is_console_application then
						add_error ("Console application settings are ignored for Testing target")
					end
					if not ut.directory_path_exists (base_location) then
						add_error ({STRING_32} "Directory %"" + base_location.name + "%" does not exist, please create it before.")
					end
				end
			end
		end

feature -- Access

	is_library_target: BOOLEAN

	is_application_target: BOOLEAN

	is_testing_target: BOOLEAN

	clusters: detachable LIST [STRING_32]
			-- List of clusters
		once
			if
				has_option (clusters_switch) and then
				attached options_of_name (clusters_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING_32]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	tests_clusters: detachable LIST [STRING_32]
			-- List of clusters
		once
			if
				has_option (tests_switch) and then
				attached options_of_name (tests_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING_32]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	libraries: detachable LIST [STRING_32]
			-- List of libraries
		once
			if
				has_option (libraries_switch) and then
				attached options_of_name (libraries_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING_32]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	target_name: STRING
		local
			p: PATH
		do
			if has_option (target_name_switch) and then attached option_of_name (target_name_switch) as o and then o.has_value then
				Result := to_string_8 (o.value)
			else
				p := base_location

				if attached p.entry as e then
						-- FIXME: find smart name computation
					Result := to_string_8 (e.name)
				else
					Result := to_string_8 (p.name)
--					if is_library_target then
--						Result := "LIBRARY_NAME"
--					elseif is_application_target then
--						Result := "APPLICATION_NAME"
--					elseif is_testing_target then
--						Result := "TESTING_NAME"
--					else
--						Result := "TARGET_NAME"
--					end
				end
			end
		end

	base_location: PATH
			-- Location for new project.
			-- if no information is provided, use current working path.
		do
			if values.count = 1 and then attached values.first as v and then not v.is_whitespace then
				create Result.make_from_string (v)
			else
				Result := execution_environment.current_working_path
			end
		end

	uuid: STRING
			-- UUID for the new .ecf .
			-- either new one, or passed by argument.
		local
			uf: UUID_GENERATOR
		do
			if
				has_option (uuid_switch) and then
				attached option_of_name ("uuid") as o and then o.has_value
			then
				Result := to_string_8 (o.value)
			else
				create uf
				Result := uf.generate_uuid.out
			end
		end

	syntax_mode: STRING
		do
			if has_option (syntax_switch) and then attached option_of_name (syntax_switch) as o and then o.has_value then
				Result := to_string_8 (o.value)
			else
				Result := "standard"
			end
		end

	concurrency: detachable STRING
		do
			if
				has_option (concurrency_switch) and then
				attached option_of_name (concurrency_switch) as o and then o.has_value
			then
				Result := to_string_8 (o.value)
			end
			if has_option (thread_switch) and then attached option_of_name (thread_switch) then
				Result := "thread"
			end
			if has_option (scoop_switch) and then attached option_of_name (scoop_switch) then
				Result := "scoop"
			end
		end

	executable_name: detachable STRING
		do
			if has_option (executable_name_switch) and then attached option_of_name (executable_name_switch) as o and then o.has_value then
				Result := to_string_8 (o.value)
			end
		end

	root_info: detachable TUPLE [cluster: detachable STRING; class_name: STRING; feature_name: STRING]
		local
			l_cluster, l_classname, l_featurename: detachable STRING
		do
			if has_option (application_target_switch) and then attached option_of_name (application_target_switch) as o then
				if o.has_value then
					if attached o.value.split ('.') as lst then
						if lst.count = 3 then
							lst.start
							l_cluster := to_string_8 (lst.first)
							lst.forth
							l_classname := to_string_8 (lst.item)
							lst.forth
							l_featurename := to_string_8 (lst.item)
						elseif lst.count = 2 then
							lst.start
							l_classname := to_string_8 (lst.item)
							lst.forth
							l_featurename := to_string_8 (lst.item)
						end
					end
				end
				if l_classname = Void then
					if is_application_target then
						l_classname := "APPLICATION_" + target_name.as_upper
						l_featurename := "make"
					else
						l_classname := "ANY"
						l_featurename := "default_create"
					end
				end

				if l_classname /= Void and l_featurename /= Void then
					Result := [l_cluster, l_classname, l_featurename]
				end
			end
		end

	is_console_application: BOOLEAN
		do
			Result := has_option (console_application_switch)
		end

	execution_forced: BOOLEAN
		once
			Result := has_option (force_switch)
		end

	verbose: BOOLEAN
		once
			Result := has_option (verbose_switch)
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "path")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "directory for target")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "directory")
		end

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({ECF_CREATE_COMMAND}.default_name)
		end

	sub_system_name: detachable IMMUTABLE_STRING_32
			-- Sub system name
			-- (from ARGUMENT_BASE_PARSER)
			-- (export status {NONE})
		do
			Result := name
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (12)

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (libraries_switch, "Libraries", True, True, libraries_switch, "Library to include", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (clusters_switch, "Clusters", True, True, clusters_switch, "Cluster to include", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (tests_switch, "Tests clusters", True, True, tests_switch, "Tests cluster to include", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (uuid_switch, "UUID", True, False, uuid_switch, "UUID value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (target_name_switch, "Target name", True, False, target_name_switch, "Eiffel target name", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (syntax_switch, "Syntax mode", True, False, syntax_switch, "Syntax mode: obsolete, transitional, default=standard, provisional", False))

			Result.extend (create {ARGUMENT_SWITCH}.make (library_target_switch, "This is a library configuration file", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (application_target_switch, "This is an application configuration file", True, False, "Entry point", "Root cluster.CLASS_NAME.creation_name information (cluster is optional)", True))
			Result.extend (create {ARGUMENT_SWITCH}.make (testing_target_switch, "This is an testing configuration file", True, False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (executable_name_switch, "Executable name", True, False, executable_name_switch, "Executable name (without extension)", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (console_application_switch, "Console application mode", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (concurrency_switch, "Concurrency mode", True, False, concurrency_switch, "Concurrency mode: default=none, thread, scoop", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (thread_switch, "Concurrency mode = thread", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (scoop_switch, "Concurrency mode = SCOOP", True, False))

			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Force execution without any confirmation", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output", True, False))

		end

	library_target_switch: STRING = "library"
	application_target_switch: STRING = "application"
	testing_target_switch: STRING ="testing"

	thread_switch: STRING = "thread"
	scoop_switch: STRING = "scoop"

	console_application_switch: STRING = "console"

	tests_switch: STRING = "t|add_test"
	clusters_switch: STRING = "c|add_cluster"
	libraries_switch: STRING = "l|add_library"
	dir_switch: STRING = "d|dir"
	target_name_switch: STRING = "n|name"

	executable_name_switch: STRING = "executable_name"

	uuid_switch: STRING = "uuid"
	concurrency_switch: STRING = "concurrency"
	syntax_switch: STRING = "syntax"

	force_switch: STRING = "f|force"
	verbose_switch: STRING = "v|verbose"

feature {NONE} -- Implementation

	to_string_8 (s: READABLE_STRING_GENERAL): STRING_8
		local
			utf: UTF_CONVERTER
		do
			if s.is_valid_as_string_8 then
				Result := s.as_string_8
			else
				Result := utf.escaped_utf_32_string_to_utf_8_string_8 (s)
			end
		end

	parent_location_of (p: PATH): PATH
		do
			Result := p.parent
		end

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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

