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
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_cs: like case_sensitive; a_usage_on_error: like display_usage_on_error) is
			-- Initializes argument parser
		do
			Precursor {ARGUMENT_OPTION_PARSER} (a_cs, a_usage_on_error)
			set_use_separated_switch_values (True)
			set_show_switch_arguments_inline (True)
		end

feature -- Access

	location: STRING is
			-- Location specified by user, via command line
		require
			successful: successful
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
			successful: successful
		once
			Result := has_option (generate_only_switch)
		end

	force_32bit_code_generation: BOOLEAN is
			-- Indicates if 32 bit code should be generated
		require
			successful: successful
		once
			Result := has_option (x86_switch)
		end

	max_processors: NATURAL_8 is
			-- Maximum number of processors to utilize
		require
			successful: successful
			has_max_processors: has_max_processors
		local
			l_value: ARGUMENT_NATURAL_OPTION
		once
			l_value ?= option_of_name (nproc_switch)
			Result := l_value.natural_8_value
		ensure
			result_positive: Result > 0
		end

	use_low_priority_mode: BOOLEAN is
			-- Indicates if finish_freezing should execute in low priority mode.
		require
			successful: successful
		once
			Result := has_option (low_priority_switch)
		end

	is_for_library: BOOLEAN is
			-- Is `finish_freezing' launched to compile the C code for an Eiffel library?
		require
			successful: successful
		do
			Result := has_option (library_switch)
		end

feature -- Query

	has_location: BOOLEAN is
			-- Indicates if user specified a location
		require
			successful: successful
		once
			Result := has_option (location_switch)
		end

	has_max_processors: BOOLEAN is
			-- Indicates if user specified a number of processors
		require
			successful: successful
		once
			Result := has_option (nproc_switch)
		end

feature {NONE} -- Usage

	name: STRING is
			-- Full name of application
		once
			Result := "Eiffel C/C++ Compilation Tool"
		end

	version: STRING is
			-- Version number of application
		once
			Result := {EIFFEL_ENV}.major_version.out + "." + {EIFFEL_ENV}.minor_version.out
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH] is
			-- Retrieve a list of switch used for a specific application
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

	location_switch: STRING is "location"
	generate_only_switch: STRING is "generate_only"
	library_switch: STRING is "library"
	nproc_switch: STRING is "nproc"
	x86_switch: STRING is "x86"
	low_priority_switch: STRING is "low"
			-- Argument switches

	silent_switch: STRING is "silent";
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
