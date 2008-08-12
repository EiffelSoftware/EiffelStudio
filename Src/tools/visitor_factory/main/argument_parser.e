indexing
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
	ARGUMENT_OPTION_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{ANY} execute, successful
		end

	IAPPLICATION_PARAMETERS
		rename
			is_readable as successful
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize argument parser
		do
			make_parser (False, False)
			set_use_separated_switch_values (True)
			set_show_switch_arguments_inline (True)
			display_usage_on_error := True
		end

feature -- Access

	included_files: LIST [STRING] is
			-- Included file/folder paths passed via command line
		once
			Result := options_values_of_name (include_switch)
		end

	exclude_expressions: LIST [STRING] is
			-- Exclude file/folder expressions passed via command line
		once
			Result := options_values_of_name (exclude_switch)
		end

	class_name: STRING is
			-- Output class name
		once
			Result := option_of_name (class_name_switch).value
		end

	user_data_class_name: STRING is
			-- User data class name
		once
			Result := option_of_name (user_data_switch).value
		end

	use_user_data: BOOLEAN is
			-- Inidicates if a user data class name was passed via command line
		once
			Result := has_option (user_data_switch)
		end

	recurse_directories: BOOLEAN is
			-- Inidicates if user specified to recursively scan included directories
		once
			Result := has_option (recurse_switch)
		end

	generate_stub: BOOLEAN is
			-- Indiciates if a stub class file should be generated
		once
			Result := has_option (stub_switch)
		end

	generate_interface: BOOLEAN is
			-- Indiciates if a interface class file should be generated
		once
			Result := has_option (interface_switch) or else not has_option (stub_switch)
		end

	generate_process_routines: BOOLEAN is
		once
			Result := has_option (routines_switch)
		end

feature -- Status report

	has_class_name: BOOLEAN is
			-- Inidicates if a class name was passed via command line
		once
			Result := has_option (class_name_switch)
		end

feature {NONE} -- Usage

	name: STRING = "Eiffel Class Visitor Generator"
			-- Full name of application

	version: STRING is
			-- Version number of application
		once
			create Result.make (5)
			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version)
		end

	loose_argument_name: STRING = "folder"
			-- Name of lose argument, used in usage information

	loose_argument_description: STRING = "Location to search in for Eiffel classes"
			-- Description of lose argument, used in usage information

	loose_argument_type: STRING = "a folder"
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"


feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		do
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

	include_switch: STRING = "i"
	exclude_switch: STRING = "ex"
	class_name_switch: STRING = "n"
	user_data_switch: STRING = "ud"
	recurse_switch: STRING = "r"
	stub_switch: STRING = "stub"
	interface_switch: STRING = "interface"
	routines_switch: STRING = "routines"

;indexing
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
