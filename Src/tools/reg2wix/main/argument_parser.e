note
	description: "[
		reg2wix command line argument parser.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		end

	IREG2WIX_OPTIONS
		rename
			can_query_options as is_successful
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize command line argument parser
		do
			make_multi_parser (False, True)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
		end

feature -- Access

	reg_files: LINEAR [STRING]
			-- List of registry files to process
		do
			Result := values
		end

	output_file_name: STRING
			-- Optional output file name
		do
			Result := options_values_of_name (out_switch).first
		end

feature -- Status report

	use_output_file_name: BOOLEAN
			-- Indicate if `output_file_name' should be used
		do
			Result := has_option (out_switch)
		end

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 1985-2024. All Rights Reserved."
			-- <Precursor>

	name: attached STRING = "Registry File to WiX Conversion Tool"
			-- <Precursor>

	version: attached STRING = "3.1"
			-- <Precursor>

	non_switched_argument_name: attached STRING = "RegFile"
			-- <Precursor>

	non_switched_argument_description: attached STRING = "A Windows registry file."
			-- <Precursor>

	non_switched_argument_type: attached STRING = "Registry file"
			-- <Precursor>

feature {NONE} -- Switches

	switches: attached ARRAYED_LIST [attached ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
			-- (export status {NONE})
		do
			create Result.make (1)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (out_switch, "An output file name for the generated WiX document.", True, False, "File", "Output file name.", False))
		end

	out_switch: attached STRING = "out"
			-- Command line switches

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
