indexing
	description: "Argument parser for parser benchmark test application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		export
			{NONE} all
			{APPLICATION} execute
		redefine
			execute_noop
		end

create
	make

feature {NONE} -- Access

	name: STRING = "Eiffel Parser SpeedMark"
			-- Application name

	version: STRING = "1.0.0.0"
			-- Application version

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Argument switches
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_SWITCH}.make (null_switch, "Test parser using AST_NULL_FACTORY%N(exclude when using -all.)", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (basic_switch, "Test parser using AST_FACTORY%N(exclude when using -all.)", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (lite_switch, "Test parser using AST_ROUNDTRIP_LIGHT_FACTORY%N(exclude when using -all.)", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (roundtrip_switch, "Test parser using AST_ROUNDTRIP_FACTORY%N(exclude when using -all.)", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (all_switch, "Test parser using all factories.", True, False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (location_switch, "Location of a file or directory to test parser with.", True, False, "location", "A file or directory to parse contents of.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Should location be recursively searched?", True, False))
			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make_with_range (error_switch, "Number of times the same file should be parsed to remove fuzzyness%N(default is 5.)", True, False, "count", "Number of parses to perform to retrieve mean parsed time.", False, 1, {NATURAL_8}.max_value))
			Result.extend (create {ARGUMENT_SWITCH}.make (frozen_switch, "Indicates to include frozen parser tests.", True, False))
		end

feature -- Status Report

	process_null_factory: BOOLEAN
			-- Indicates if AST_NULL_FACTORY should be tested.
		once
			Result := proces_all_factories xor has_option (null_switch)
		end

	process_basic_factory: BOOLEAN
			-- Indicates if AST_FACTORY should be tested.
		once
			Result := proces_all_factories xor has_option (basic_switch)
		end

	process_lite_factory: BOOLEAN
			-- Indicates if AST_ROUNDTRIP_LIGHT_FACTORY should be tested.
		once
			Result := proces_all_factories xor has_option (lite_switch)
		end

	process_roundtrip_factory: BOOLEAN
			-- Indicates if AST_ROUNDTRIP_FACTORY should be tested.
		once
			Result := proces_all_factories xor has_option (roundtrip_switch)
		end

	proces_all_factories: BOOLEAN
			-- Indicates if all AST_FACTORYs should be tested.
		once
			Result := has_option (all_switch)
		end

	test_frozen: BOOLEAN
			-- Indicates if frozen parser should be tested
		once
			Result := has_option (frozen_switch)
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
			result_attached: Result /= Void
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

	execute_noop (a_agent: PROCEDURE [ANY, TUPLE]) is
			-- Executes `a_agent' when no arguments of any worth are passed.
		do
			display_usage
		end

feature {NONE} -- Switch names

	null_switch: STRING = "null"
	basic_switch: STRING = "basic"
	lite_switch: STRING = "lite"
	roundtrip_switch: STRING = "roundtrip"
	all_switch: STRING = "all"
			-- Factory switches

	location_switch: STRING = "l"
	recursive_switch: STRING = "r"
			-- Location switches

	error_switch: STRING = "e"
	frozen_switch: STRING = "f";
			-- Test related switches


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class {ARGUMENT_PARSER}
