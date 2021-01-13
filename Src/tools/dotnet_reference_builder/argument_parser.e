note
	description: "[
		Application's argument parser.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_parser
		export
			{ANY} execute
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
		end

feature -- Access

	assemblies: ARRAYED_LIST [STRING]
			-- List of passed assemblies
		once
			create Result.make (0)
			across values as l_item loop
				Result.extend (l_item.item.as_string_8)
			end
		ensure
			result_attached: Result /= Void
		end

	include_paths: ARRAYED_LIST [STRING]
			-- Specified list of lookup paths
		once
			create Result.make (0)
			across unique_options_values_of_name (include_switch, True) as l_item loop
				Result.extend (l_item.item.as_string_8)
			end
		ensure
			result_attached: Result /= Void
		end

	ecf_file: STRING
			-- Location of an *.ecf file to modify
		require
			modify_ecf_file: modify_ecf_file
		once
			Result := option_of_name (ecf_switch).value.as_string_8
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	ecf_targets_file: ARRAYED_LIST [STRING]
			-- Location of an *.ecf file to modify
		require
			modify_ecf_file: modify_ecf_file
		once
			create Result.make (0)
			across unique_options_values_of_name (target_switch, False) as l_item loop
				Result.extend (l_item.item.as_string_8)
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature -- Status report

	use_assembly_locations: BOOLEAN
			-- Indiciates if assembly paths should be used as lookup paths
		once
			Result := not has_option (do_not_use_assembly_paths_switch)
		end

	modify_ecf_file: BOOLEAN
			-- Indicate if modification should be made to ecf file
		once
			Result := has_option (ecf_switch)
		end

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 1985-2021. All Rights Reserved."
			-- <Precursor>

	name: STRING = ".NET Reference Builder"
			-- Full name of application

	version: attached STRING
			-- Version number of application
		once
			Result := (({SYSTEM_OBJECT})[Current]).get_type.assembly.get_name.version.to_string
		end

	switches: ARRAYED_LIST [attached ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
			-- (export status {NONE})
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (include_switch, "Path to use to look up dependent assembly reference.", True, True, "path", "A path to a folder on disk containing assembly references.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (do_not_use_assembly_paths_switch, "Indicates not use the specified assemblies' locations as reference lookup paths.", True, False))
			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (ecf_switch, "Optional location of an *.ecf file to generate references into.", True, False, "file", "Full path to an *.ecf file to modify.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (target_switch, "Optional target(s) in ecf to add assemblies to.", True, True, "target", "name of ecf file target", False))
		end

	non_switched_argument_name: STRING = "assembly"
			-- Name of lose argument, used in usage information

	non_switched_argument_description: STRING = "An assembly to build flat references list for."
			-- Description of lose argument, used in usage information

	non_switched_argument_type: STRING = "An Assembly"
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"

feature {NONE} -- Constants

	do_not_use_assembly_paths_switch: STRING = "na"
	include_switch: STRING = "i"
	ecf_switch: STRING = "ecf"
	target_switch: STRING = "t";
			-- Switches

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class {ARGUMENT_PARSER}
