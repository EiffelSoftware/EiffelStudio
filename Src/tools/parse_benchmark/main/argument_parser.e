note
	description: "Argument parser for parser benchmark test application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		redefine
			execute_noop
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_option_parser (False)
		end

feature {NONE} -- Access

	copyright: STRING = "Copyright Eiffel Software 1985-2024. All Rights Reserved."
			-- <Precursor>

	name: STRING = "Eiffel Parser SpeedMark"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			create Result.make (5)
			Result.append_integer ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append ((create {EIFFEL_CONSTANTS}).two_digit_minimum_minor_version)
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (factory_switch, "Type of factory", False, True, "Type of factory", "One of null, basic, lite, roundtrip or all", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (parser_level_switch, "Type of parser%N(default is standard)", True, True, "Type of parser", "One of obsolete, transitional, standard, or provisional", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (location_switch, "Location of a file or directory to test parser with.", True, False, "location", "A file or directory to parse contents of.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Should location be recursively searched?", True, False))
			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make_with_range (error_switch, "Number of times the same file should be parsed to remove fuzzyness%N(default is 5.)", True, False, "count", "Number of parses to perform to retrieve mean parsed time.", False, 1, {NATURAL_8}.max_value))
				-- Parser does not work using file names.
			Result.extend (create {ARGUMENT_SWITCH}.make (disk_access_switch, "Includes parser file loading times.", True, False))
		end

feature -- Status Report

	process_standard_syntax: BOOLEAN
			-- Indicates standard syntax is to be used
		once
			Result := options_values_of_name (parser_level_switch).has ("standard") or else
				options_values_of_name (parser_level_switch).is_empty
		end

	process_provisional_syntax: BOOLEAN
			-- Indicates transitional syntax is to be used
		once
			Result := options_values_of_name (parser_level_switch).has ("provisional")
		end

	process_transitional_syntax: BOOLEAN
			-- Indicates transitional syntax is to be used
		once
			Result := options_values_of_name (parser_level_switch).has ("transitional")
		end

	process_obsolete_syntax: BOOLEAN
			-- Indicates obsolete syntax is to be used
		once
			Result := options_values_of_name (parser_level_switch).has ("obsolete")
		end

	process_null_factory: BOOLEAN
			-- Indicates if AST_NULL_FACTORY should be tested.
		once
			Result := proces_all_factories or options_values_of_name (factory_switch).has ("null")
		end

	process_basic_factory: BOOLEAN
			-- Indicates if AST_FACTORY should be tested.
		once
			Result := proces_all_factories or options_values_of_name (factory_switch).has ("basic")
		end

	process_lite_factory: BOOLEAN
			-- Indicates if AST_ROUNDTRIP_LIGHT_FACTORY should be tested.
		once
			Result := proces_all_factories or options_values_of_name (factory_switch).has ("lite")

		end

	process_roundtrip_factory: BOOLEAN
			-- Indicates if AST_ROUNDTRIP_FACTORY should be tested.
		once
			Result := proces_all_factories or options_values_of_name (factory_switch).has ("roundtrip")

		end

	proces_all_factories: BOOLEAN
			-- Indicates if all AST_FACTORYs should be tested.
		once
			Result := options_values_of_name (factory_switch).has ("all")

		end

	test_disk_access: BOOLEAN
			-- Indicates if parser should load the file
		once
			Result := has_option (disk_access_switch)
		end

	use_file_location: BOOLEAN
			-- Indicates if `location' represents a file
		local
			l_file: RAW_FILE
		once
			create l_file.make (location)
			Result := not l_file.is_directory and not l_file.is_device
		ensure
			result_not_directory: Result /= (create {DIRECTORY}.make (location)).exists
		end

feature -- Access

	location: STRING
			-- Location of files to use
		once
			if has_option (location_switch) then
				Result := option_of_name (location_switch).value
			else
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
		ensure
			location_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make (Result)).exists or (create {DIRECTORY}.make (Result)).exists
		end

	recursive_lookup: BOOLEAN
			-- Indicates if a location should be recursively examined
		once
			Result := has_option (recursive_switch)
		end

	error_count: NATURAL_8
			-- Error parse count
		once
			if has_option (error_switch) then
				Result := option_of_name (error_switch).value.to_natural_8
			else
				Result := 5
			end
		end

feature {NONE} -- Basic Operations

	execute_noop (a_agent: PROCEDURE)
			-- <Precursor>
		do
			display_usage
		end

feature {NONE} -- Switch names

	factory_switch: STRING = "f|factory"
	parser_level_switch: STRING = "s|syntax_level"
			-- Factory switch

	location_switch: STRING = "l|location"
	recursive_switch: STRING = "r|recursive"
			-- Location switches

	error_switch: STRING = "e|error"
	disk_access_switch: STRING = "d|disk-access"
			-- Test related switches


;note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
