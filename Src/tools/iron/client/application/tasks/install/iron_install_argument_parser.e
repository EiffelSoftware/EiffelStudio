note
	description: "[
			Summary description for {IRON_ARGUMENTS_PARSER}.
			
			
				iron list 						: List of available packages, i.e. packages that have been installed
												: as well as packages available from the Iron server.
				iron list --installed 			: List of installed packages.
				iron install package_name 		: Install a package.
				iron install -f package_file 	: Install a package from a file.
				iron remove package_name 		: Remove a package.
				iron search package_name 		: Search for a package.
				iron info package_name 			: Information about a package.

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_INSTALL_ARGUMENT_PARSER

inherit
	IRON_ARGUMENT_MULTI_PARSER

	IRON_INSTALL_ARGUMENTS

create
	make

feature -- Access

	installing_all: BOOLEAN
			-- Install all available packages?
		do
			Result := has_option (all_switch)
		end

	setup_execution_enabled: BOOLEAN
			-- Allowing execution of scripts during installation?
			-- Default is True
		do
			if has_option (setup_execution_ignored_switch) then
				Result := has_option (setup_execution_enabled_switch)
			else
				Result := True
			end
		end

	ignoring_cache: BOOLEAN
			-- <Precursor>
		do
			Result := has_option (no_cache_switch)
		end

	dependencies_included: BOOLEAN
			-- <Precursor>
		do
			if has_option (dep_excluded_switch) then
				Result := not has_option (dep_included_switch)
			else
				Result := True
			end
		end

	resources: LIST [IMMUTABLE_STRING_32]
		once
			create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (values.count)
			across
				values as c
			loop
				Result.force (create {IMMUTABLE_STRING_32}.make_from_string (c.item))
			end
		end

	files: LIST [IMMUTABLE_STRING_32]
		once
			if
				has_option (file_switch) and then
				attached options_values_of_name (file_switch)  as l_values
			then
				create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (l_values.count)
				across
					l_values as c
				loop
					Result.force (create {IMMUTABLE_STRING_32}.make_from_string (c.item))
				end
			else
				create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (0)
			end
		end

	for_ecf_file: detachable PATH
		once
			if
				has_option (for_ecf_switch) and then
				attached option_of_name (for_ecf_switch) as l_ecf
			then
				create Result.make_from_string (l_ecf.value)
			end
		end

	target_name: detachable READABLE_STRING_32
		once
			if
				has_option (target_switch) and then
				attached option_of_name (target_switch) as tgt
			then
				Result := tgt.value
			end
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "package_reference")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Package name, id, uri or full url")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "string")
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_SWITCH}.make (file_switch, "Package file", True, True))
			Result.extend (create {ARGUMENT_SWITCH}.make (all_switch, "Install all available packages", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (no_cache_switch, "Ignore cache and always download iron package?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (dep_included_switch, "Also install the package dependencies?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (dep_excluded_switch, "Ignore the package dependencies?", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (for_ecf_switch, "Install package used by the Eiffel Configuration File passed as argument.", True, False, "ecf_file", "ECF file", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (target_switch, "Optional target information to precise value passed with --ecf option", True, False, "target_name", "ECF target name", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (setup_execution_enabled_switch, "Enable execution of package installation setup? (Default:enabled)", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (setup_execution_ignored_switch, "Ignore execution of package installation setup?", True, False))
			fill_argument_switches (Result)
			add_simulation_switch (Result)
			add_batch_interactive_switch (Result)
		end

	file_switch: STRING = "f|file"
	for_ecf_switch: STRING = "ecf"
	target_switch: STRING = "target"
	all_switch: STRING = "a|all"
	no_cache_switch: STRING = "no_cache"
	setup_execution_enabled_switch: STRING = "s|setup"
	setup_execution_ignored_switch: STRING = "S|ignore_setup"

	dep_included_switch: STRING = "d|include_dependencies"
	dep_excluded_switch: STRING = "D|no_dependency"

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
