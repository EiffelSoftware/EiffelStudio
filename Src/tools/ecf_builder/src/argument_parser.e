note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_parser
		redefine
			post_process_arguments
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_parser (False)
		end

	post_process_arguments
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
						add_error ("Please provide the " +  root_info_switch + " value for application target")
					end
					if is_testing_target and root_info /= Void then
						add_error ("Root info settings are ignored for Testing target")
					end
					if is_testing_target and is_console_application then
						add_error ("Console application settings are ignored for Testing target")
					end
				end
			end
		end

feature -- Access

	copyright: STRING
			-- <Precursor>
		do
			Result := "Copyright Eiffel Software 2011-2023. All Rights Reserved."
		end

	clusters: detachable LIST [STRING]
			-- List of clusters
		require
			is_successful: is_successful
		once
			if
				has_option (clusters_switch) and then
				attached options_of_name (clusters_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	tests_clusters: detachable LIST [STRING]
			-- List of clusters
		require
			is_successful: is_successful
		once
			if
				has_option (tests_switch) and then
				attached options_of_name (tests_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	libraries: detachable LIST [STRING]
			-- List of libraries
		require
			is_successful: is_successful
		once
			if
				has_option (libraries_switch) and then
				attached options_of_name (libraries_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	is_library_target: BOOLEAN

	is_application_target: BOOLEAN

	is_testing_target: BOOLEAN

	target_name: STRING
		do
			if has_option (target_name_switch) and then attached option_of_name (target_name_switch) as o and then o.has_value then
				Result := o.value
			else
				if attached parent_dirname as n then
					Result := n
				else
					if is_library_target then
						Result := "LIBRARY_NAME"
					elseif is_application_target then
						Result := "APPLICATION_NAME"
					elseif is_testing_target then
						Result := "TESTING_NAME"
					else
						Result := "TARGET_NAME"
					end
				end
			end
		end

	base_directory: STRING
		do
			if has_option (dir_switch) and then attached option_of_name (dir_switch) as o and then o.has_value then
				Result := o.value
			else
				Result := current_working_directory -- Current working directory
			end
		end

	uuid: STRING
		local
			uf: UUID_GENERATOR
		do
			if
				has_option (uuid_switch) and then
				attached option_of_name ("uuid") as o and then o.has_value
			then
				Result := o.value
			else
				create uf
				Result := uf.generate_uuid.out
			end
		end

	syntax_mode: STRING
		do
			if has_option (syntax_switch) and then attached option_of_name (syntax_switch) as o and then o.has_value then
				Result := o.value
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
				Result := o.value
			end
			if has_option (thread_switch) and then attached option_of_name (thread_switch) then
				check Result = Void end
				Result := "thread"
			end
			if has_option (scoop_switch) and then attached option_of_name (scoop_switch) then
				check Result = Void end
				Result := "scoop"
			end
		end

	executable_name: detachable STRING
		do
			if has_option (executable_name_switch) and then attached option_of_name (executable_name_switch) as o and then o.has_value then
				Result := o.value
			end
		end

	root_info: detachable TUPLE [cluster: detachable STRING; class_name: STRING; feature_name: STRING]
		do
			if has_option (root_info_switch) and then attached option_of_name (root_info_switch) as o and then o.has_value then
				if attached o.value.split ('.') as lst then
					if lst.count = 3 then
						lst.start
						Result := [lst.first, "", ""]
						lst.forth
						Result.class_name := lst.item
						lst.forth
						Result.feature_name := lst.item
					elseif lst.count = 2 then
						lst.start
						Result := [Void, lst.first, ""]
						lst.forth
						Result.feature_name := lst.item
					end
				end
			end
		end

	is_console_application: BOOLEAN
		do
			Result := has_option (console_application_switch)
		end

	force_enabled: BOOLEAN
		do
			Result := has_option (force_switch)
		end

feature {NONE} -- Usage

	non_switched_argument_name: STRING = "unused"
			--  <Precursor>

	non_switched_argument_description: STRING = "unused"
			--  <Precursor>

	non_switched_argument_type: STRING = "unused"
			--  <Precursor>

	name: STRING
		once
			Result := {APPLICATION_CONSTANTS}.executable_name
		end

	version: attached STRING
			--  <Precursor>
		once
			create Result.make (5)
			Result.append_natural_16 ({APPLICATION_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_natural_16 ({APPLICATION_CONSTANTS}.minor_version)
		end

feature {NONE} -- Switches

	switches: attached ARRAYED_LIST [attached ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (14)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (libraries_switch, "Libraries", True, True, libraries_switch, "Library to include", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (clusters_switch, "Clusters", True, True, clusters_switch, "Cluster to include", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (tests_switch, "Tests clusters", True, True, tests_switch, "Tests cluster to include", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (dir_switch, "Directory", True, False, dir_switch, "Base directory", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (uuid_switch, "UUID", True, False, uuid_switch, "UUID value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (target_name_switch, "Target name", True, False, target_name_switch, "Eiffel target name", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (syntax_switch, "Syntax mode", True, False, syntax_switch, "Syntax mode: obsolete, transitional, default=standard, provisional", False))

			Result.extend (create {ARGUMENT_SWITCH}.make (library_target_switch, "This is a library configuration file", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (application_target_switch, "This is an application configuration file", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (testing_target_switch, "This is an testing configuration file", True, False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (executable_name_switch, "Executable name", True, False, executable_name_switch, "Executable name (without extension)", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (root_info_switch, "Root info: cluster.class.feature", True, False, root_info_switch, "Root cluster.class.name information (cluster is optional)", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (console_application_switch, "Console application mode", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (concurrency_switch, "Concurrency mode", True, False, concurrency_switch, "Concurrency mode: default=none, thread, scoop", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (thread_switch, "Concurrency mode = thread", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (scoop_switch, "Concurrency mode = SCOOP", True, False))

			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Force operation", True, False))
		end


	force_switch: STRING = "f|force"

	library_target_switch: STRING = "library"
	application_target_switch: STRING = "application"
	testing_target_switch: STRING ="testing"

	thread_switch: STRING = "thread"
	scoop_switch: STRING = "scoop"

	console_application_switch: STRING = "console"

	tests_switch: STRING = "t|tests"
	clusters_switch: STRING = "c|clusters"
	libraries_switch: STRING = "l|libraries"
	dir_switch: STRING = "d|dir"
	target_name_switch: STRING = "n|name"

	executable_name_switch: STRING = "executable_name"
	root_info_switch: STRING = "root_info"

	uuid_switch: STRING = "uuid"
	concurrency_switch: STRING = "concurrency"
	syntax_switch: STRING = "syntax"

feature {NONE} -- Implementation

	exec_env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

	current_working_directory: STRING
		do
			Result := exec_env.current_working_directory
		end

	parent_dirname: detachable STRING
		local
			p,q: INTEGER
		do
			Result := current_working_directory
			p := (Result.last_index_of ('\', Result.count)).max (Result.last_index_of ('/', Result.count))
			if p > 0 then
				if p < Result.count then
					q := p + 1
					p := Result.count
				else
					q := (Result.last_index_of ('\', p - 1)).max (Result.last_index_of ('/', p - 1))
				end
			end
			if p > 0 and q > 0 then
				Result := Result.substring (q, p)
			end
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
