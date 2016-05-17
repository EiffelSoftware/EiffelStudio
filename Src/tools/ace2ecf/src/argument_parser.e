note
	description: "Used to parser command-line arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_args
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize parser
		do
			make_args (False, True)
			set_is_using_separated_switch_values (False)
			is_using_builtin_switches := False
		end

feature -- Access

	is_verbose: BOOLEAN
			-- Indiciates if tool should be run in verbose mode.
		require
			is_successful: is_successful
		do
			Result := has_option (verbose_switch)
		end

	is_batch: BOOLEAN
			-- Indiciates if tool should be run in batch mode.
		require
			is_successful: is_successful
		do
			Result := has_option (batch_switch)
		end

	has_library_conversion: BOOLEAN
			-- Indiciates if tool should be run in batch mode.
		require
			is_successful: is_successful
		do
			Result := has_option (library_conversion_switch)
		end

	output_file_name: detachable PATH
			-- The user specified compiler code to use to establish an environment
		require
			is_successful: is_successful
		do
			if attached option_of_name (output_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		end

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 1985-2016. All Rights Reserved."
			-- <Precursor>

	name: STRING = "Ace file to ECF convertor tool utility"
			-- <Precursor>

	non_switched_argument_name: STRING = "ace_file"
			-- <Precursor>

	non_switched_argument_description: STRING = "Name of Ace file to convert"
			-- <Precursor>

	non_switched_argument_type: STRING = "Ace File"
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
			create Result.make (1)
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (batch_switch, "Stop execution in case of required input.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (library_conversion_switch, "Are some of the well known libraries converted to a library.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (output_switch, "Output name of ECF.", True, False))
		end

feature {NONE} -- Switch names

	verbose_switch: STRING = "v|verbose"
	batch_switch: STRING = "b|batch"
	library_conversion_switch: STRING = "l|library_conversion"
	output_switch: STRING = "o|output"

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
