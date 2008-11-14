indexing
	description: "Finish freezing's argument parser"
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
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes argument parser.
		do
			make_option_parser (not {PLATFORM}.is_windows)
		end

feature -- Access

	location: STRING is
			-- Location specified by user, via command line
		require
			is_successful: is_successful
			has_location: has_location
		local
			l_opt: ARGUMENT_OPTION
		once
			l_opt := option_of_name (location_switch)
			if l_opt /= Void then
				Result := l_opt.value
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	generate_only: BOOLEAN is
			-- Indicates if only a make file should be generated
		require
			is_successful: is_successful
		once
			Result := has_option (generate_only_switch)
		end

	force_32bit_code_generation: BOOLEAN is
			-- Indicates if 32 bit code should be generated
		require
			is_successful: is_successful
		once
			Result := has_option (x86_switch)
		end

	max_processors: NATURAL_8 is
			-- Maximum number of processors to utilize
		require
			is_successful: is_successful
			has_max_processors: has_max_processors
		once
			if {l_value: ARGUMENT_NATURAL_OPTION} option_of_name (nproc_switch) then
				Result := l_value.natural_8_value
			else
				check False end
			end
		ensure
			result_positive: Result > 0
		end

	use_low_priority_mode: BOOLEAN is
			-- Indicates if finish_freezing should execute in low priority mode.
		require
			is_successful: is_successful
		once
			Result := has_option (low_priority_switch)
		end

	is_for_library: BOOLEAN is
			-- Is `finish_freezing' launched to compile the C code for an Eiffel library?
		require
			is_successful: is_successful
		do
			Result := has_option (library_switch)
		end

feature -- Query

	has_location: BOOLEAN is
			-- Indicates if user specified a location
		require
			is_successful: is_successful
		once
			Result := has_option (location_switch)
		end

	has_max_processors: BOOLEAN is
			-- Indicates if user specified a number of processors
		require
			is_successful: is_successful
		once
			Result := has_option (nproc_switch)
		end

feature {NONE} -- Usage

	name: !STRING = "Eiffel C/C++ Compilation Tool"
			-- <Precursor>

	version: !STRING
			-- <Precursor>
		once
			create Result.make (3)
			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version)
		end

	switches: !ARRAYED_LIST [!ARGUMENT_SWITCH] is
			-- <Precursor>
		once
			create Result.make (4)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (location_switch, "Alternative location to compile C code in.", True, False, "directory", "Location to compile C code in", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (generate_only_switch, "Informs tool to only generate a Makefile.", True, False))
			Result.extend (create {ARGUMENT_NATURAL_SWITCH}.make_with_range (nproc_switch, "Maximum number of processors to use", True, False, "n", "Number of processors", False, 1, {NATURAL_16}.max_value))
			Result.extend (create {ARGUMENT_SWITCH}.make (low_priority_switch, "Executes finish freezing in low-execution priority mode.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (x86_switch, "Generate 32bit lib DLLs for .NET projects.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (silent_switch, "Suppresses confirmation dialog", True, True))
			Result.extend (create {ARGUMENT_SWITCH}.make (library_switch, "Compiles the C code of an Eiffel library", True, True))
		end

feature {NONE} -- Switches

	location_switch: STRING = "location"
	generate_only_switch: STRING = "generate_only"
	library_switch: STRING = "library"
	nproc_switch: STRING = "nproc"
	x86_switch: STRING = "x86"
	low_priority_switch: STRING = "low"
			-- Argument switches

	silent_switch: STRING = "silent";
			-- Obsolete switch be kept for backward compatibility

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

end -- class {ARGUMENT_PARSER}
