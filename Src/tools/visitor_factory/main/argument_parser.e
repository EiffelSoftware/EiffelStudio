note
	description: "[
		Used to parse command line arguments of Eiffel Visitor Factory Tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_single_parser
		end

	IAPPLICATION_PARAMETERS
		rename
			is_readable as is_successful
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_single_parser (False, False)
			set_is_using_separated_switch_values (True)
			set_is_showing_argument_usage_inline (True)
			set_is_usage_displayed_on_error (False)
			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

feature -- Access

	included_files: LIST [STRING]
			-- <Precursor>
		once
			Result := options_values_of_name (include_switch)
		end

	exclude_expressions: LIST [STRING]
			-- <Precursor>
		once
			Result := options_values_of_name (exclude_switch)
		end

	class_name: STRING
			-- <Precursor>
		once
			Result := option_of_name (class_name_switch).value
		end

	user_data_class_name: STRING
			-- <Precursor>
		once
			Result := option_of_name (user_data_switch).value
		end

	use_user_data: BOOLEAN
			-- <Precursor>
		once
			Result := has_option (user_data_switch)
		end

	recurse_directories: BOOLEAN
			-- <Precursor>
		once
			Result := has_option (recurse_switch)
		end

	generate_stub: BOOLEAN
			-- <Precursor>
		once
			Result := has_option (stub_switch)
		end

	generate_interface: BOOLEAN
			-- <Precursor>
		once
			Result := has_option (interface_switch) or else not has_option (stub_switch)
		end

	generate_process_routines: BOOLEAN
			-- <Precursor>
		once
			Result := has_option (routines_switch)
		end

feature -- Status report

	has_class_name: BOOLEAN
			-- <Precursor>
		once
			Result := has_option (class_name_switch)
		end

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 1985-2021. All Rights Reserved."
			-- <Precursor>

	name: STRING = "Eiffel Class Visitor Generator"
			--  <Precursor>

	version: STRING
			--  <Precursor>
		once
			create Result.make (5)
			Result.append_integer ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append ((create {EIFFEL_CONSTANTS}).two_digit_minimum_minor_version)
		end

	non_switched_argument_name: STRING = "folder"
			--  <Precursor>

	non_switched_argument_description: attached STRING = "Location to search in for Eiffel classes"
			--  <Precursor>

	non_switched_argument_type: STRING = "a folder"
			--  <Precursor>


feature {NONE} -- Switches

	switches: attached ARRAYED_LIST [attached ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (include_switch, "Include a file or directory for generation of a visitor class.%NSpecify no includes takes the current directory.", True, True, "expression", "A RegEx representing files or folders to include.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (recurse_switch, "Forces all included directories to be recursively scanned for classes", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (exclude_switch, "Exclude regular expression for files or directories to exclude.", True, True, "expression", "A RegEx representing files or folders to exclude.", False))
			Result.extend (create {ARGUMENT_EIFFEL_CLASS_SWITCH}.make (class_name_switch, "Eiffel class name to give the generated class.", True, False, "name", "An Eiffel class name", False))
			Result.extend (create {ARGUMENT_EIFFEL_CLASS_SWITCH}.make (user_data_switch, "Specifies visitor should be passed a piece of user data.", True, False, "name", "An Eiffel class name the user data should conform to", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (stub_switch, "Use to generate a stub visitor only.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (interface_switch, "Use to generate an interface visitor only.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (routines_switch, "Use to generate `process' routines in visited classes.", True, False))
		end

feature {NONE} -- Switch names

	include_switch: attached STRING = "i|include"
	exclude_switch: attached STRING = "e|exclude"
	class_name_switch: attached STRING = "n|class-name"
	user_data_switch: attached STRING = "u|user-data"
	recurse_switch: attached STRING = "r|recursive"
	stub_switch: attached STRING = "s|stub"
	interface_switch: attached STRING = "t|interface"
	routines_switch: attached STRING = "o|routines"

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

end -- class {ARGUMENT_PARSER}
