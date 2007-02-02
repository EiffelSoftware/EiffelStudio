indexing
	description: "[
		Argument parser use to parse and expose user options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ARGUMENT_PARSER

inherit
	SYSTEM_OBJECT

	ARGUMENT_SINGLE_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{ANY} execute, successful
		redefine
			display_logo
		end

	I_OPTIONS
		rename
			can_read_options as successful
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize parser
		do
			make_parser (False, False,  True)
			set_show_switch_arguments_inline (True)
			set_loose_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

feature -- Access

	frozen directory: SYSTEM_STRING
			-- Full path to start directory to scan for directories files
		local
			l_dir: DIRECTORY_INFO
		once
			Result := user_directory
			create l_dir.make (Result)
			Result := l_dir.full_name
		end

	frozen user_directory: SYSTEM_STRING
			-- Start directory to scan for directories files, specified by the user.
		local
			l_dir: DIRECTORY_INFO
		once
			if has_loose_argument then
				Result := values.first
			else
				Result := {ENVIRONMENT}.current_directory
			end
		end

	frozen generate_single_file_components: BOOLEAN
			-- Indicates if components should contain only one file
		once
			Result := has_option (one_file_per_component_switch)
		end

	frozen use_semantic_names: BOOLEAN
			-- Indicates if semantic, verbal names should be generated for components, directories or files
		once
			Result := has_option (verbal_name_generation_semantics_switch)
		end

	frozen semantic_name_prefix: SYSTEM_STRING
			-- The user specified semantic name prefix
		once
			Result := option_of_name (verbal_name_generation_semantics_switch).value
		end

	frozen include_subdirectories: BOOLEAN
			-- Indicates if all subdirectories and files should be included.
		once
			Result := has_option (recursive_switch)
		end

	frozen directory_alias: SYSTEM_STRING
			-- The user specified directory alias
		once
			if has_option (directory_alias_switch) then
				Result := option_of_name (directory_alias_switch).value
			else
				Result := user_directory
			end
		end

	frozen disk_id: NATURAL_8
			-- The user specified media disk id
		local
			l_opt: ARGUMENT_NATURAL_OPTION
		once
			Result := 1
			l_opt ?= option_of_name (disk_id_switch)
			if l_opt /= Void then
				if l_opt.has_value then
					Result := l_opt.natural_8_value
				end
			end
		end

	frozen file_include_pattern: REGEX is
			-- Pattern to use to include files
		local
			l_buffer: STRING
		once
			create l_buffer.make (100)
			options_values_of_name (file_include_pattern_switch).do_all (agent (a_item: STRING; a_buffer: STRING)
				do
					if not a_buffer.is_empty then
						a_buffer.append_character ('|')
					end
					a_buffer.append (a_item)
				end (?, l_buffer))
			create Result.make (l_buffer)
		end

	frozen file_excluded_pattern: REGEX is
			-- Pattern to use to exclude files
		local
			l_buffer: STRING
		once
			create l_buffer.make (100)
			options_values_of_name (file_exclude_pattern_switch).do_all (agent (a_item: STRING; a_buffer: STRING)
				do
					if not a_buffer.is_empty then
						a_buffer.append_character ('|')
					end
					a_buffer.append (a_item)
				end (?, l_buffer))
			create Result.make (l_buffer)
		end

	frozen directory_include_pattern: REGEX is
			-- Pattern to use to include directories
		local
			l_buffer: STRING
		once
			create l_buffer.make (100)
			options_values_of_name (directory_include_pattern_switch).do_all (agent (a_item: STRING; a_buffer: STRING)
				do
					if not a_buffer.is_empty then
						a_buffer.append_character ('|')
					end
					a_buffer.append (a_item)
				end (?, l_buffer))
			create Result.make (l_buffer)
		end

	frozen directory_excluded_pattern: REGEX is
			-- Pattern to use to exnclude directories
		local
			l_buffer: STRING
		once
			create l_buffer.make (100)
			options_values_of_name (directory_exclude_pattern_switch).do_all (agent (a_item: STRING; a_buffer: STRING)
				do
					if not a_buffer.is_empty then
						a_buffer.append_character ('|')
					end
					a_buffer.append (a_item)
				end (?, l_buffer))
			create Result.make (l_buffer)
		end

	frozen use_exclude_pattern_priority: BOOLEAN is
			-- Indicates if the exclude pattern should take priority over the include pattern
		do
			Result := has_option (exclude_pattern_priority_switch)
		end

	frozen for_merge_modules: BOOLEAN
			-- Indicates if the content is to be generated for use with merge modules
		once
			Result := has_option (merge_module_switch)
		end

feature -- Status report

	frozen has_semantic_name_prefix: BOOLEAN
			-- Indicates if user specified a semantic name prefix
		once
			Result := has_option (verbal_name_generation_semantics_switch)
			if Result then
				Result := option_of_name (verbal_name_generation_semantics_switch).has_value
			end
		end

	frozen use_directory_alias: BOOLEAN
			-- Indicates if user specified a directory alias
		once
			Result := True
		end

	frozen use_disk_id: BOOLEAN
			-- Indicates if user specified a disk id
		once
			Result := has_option (disk_id_switch)
		end

	frozen use_file_include_pattern: BOOLEAN
			-- Indicates if a file include pattern should be used.
		once
			Result := has_option (file_include_pattern_switch)
		end

	frozen use_file_exclude_pattern: BOOLEAN
			-- Indicates if a file exclude pattern should be used.
		once
			Result := has_option (file_exclude_pattern_switch)
		end

	frozen use_directory_include_pattern: BOOLEAN
			-- Indicates if a directory include pattern should be used.
		once
			Result := has_option (directory_include_pattern_switch)
		end

	frozen use_directory_exclude_pattern: BOOLEAN
			-- Indicates if a directory exclude pattern should be used.
		once
			Result := has_option (directory_exclude_pattern_switch)
		end

feature {NONE} -- Usage

	name: STRING = "Hallow, Windows Installer Xml v3.0 Tool"
			-- Full name of application

	version: STRING
			-- Version number of application
		once
			Result := {ASSEMBLY}.get_executing_assembly.get_name.version.to_string
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
			-- (export status {NONE})
		do
			create Result.make (8)
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Recursively include all subdirectories and files.", True, False))
			Result.extend (create {ARGUMENT_REGEX_SWITCH}.make (file_include_pattern_switch, "Regular expression to include select files.", True, True, "expr", "A Microsoft .NET regular expression.", False))
			Result.extend (create {ARGUMENT_REGEX_SWITCH}.make (file_exclude_pattern_switch, "Regular expression to exclude select files.", True, True, "expr", "A Microsoft .NET regular expression.", False))
			Result.extend (create {ARGUMENT_REGEX_SWITCH}.make (directory_include_pattern_switch, "Regular expression to include select directories.", True, True, "expr", "A Microsoft .NET regular expression.", False))
			Result.extend (create {ARGUMENT_REGEX_SWITCH}.make (directory_exclude_pattern_switch, "Regular expression to exclude select directories.", True, True, "expr", "A Microsoft .NET regular expression.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (exclude_pattern_priority_switch, "Gives the exclude pattern priority over th include pattern when matching.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (one_file_per_component_switch, "Use to force a single 'File' element to be generated per 'Component'.", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (verbal_name_generation_semantics_switch, "Generates semantic 'Name' attribute values for 'Component', 'Directory' and 'File' elements.", True, False, "prefix", "Semantic name prefix string", True))
			Result.extend (create {ARGUMENT_SWITCH}.make (merge_module_switch, "Use to force generator to respect that the content is destined for a merge module (creates shorter Ids.)", True, False))
			Result.extend (create {ARGUMENT_NATURAL_SWITCH}.make_with_range (disk_id_switch, "Use to specify the 'DiskId' to package component files into, '1' is the default.", True, False, "id", "An ID corresponding to a 'Media' ID.", False, 1, {NATURAL_8}.max_value))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (directory_alias_switch, "Use to specify a directory alias to use when generating paths.", True, False, "alias", "A directory path alias", False))
		end

	loose_argument_name: STRING = "directory"
			-- Name of lose argument, used in usage information

	loose_argument_description: STRING = "Directory to scan for files."
			-- Description of lose argument, used in usage information

	loose_argument_type: STRING = "A directory"
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"

feature {NONE} -- Output

	display_logo is
			-- Displays copyright information
		do
			if successful then
				if not display_help then
					{SYSTEM_CONSOLE}.write_line ("<?xml version=%"1.0%" encoding=%"utf-8%"?>")
					{SYSTEM_CONSOLE}.write_line ("<!--")
					{SYSTEM_CONSOLE}.write_line
				end
				Precursor {ARGUMENT_SINGLE_PARSER}
				if not display_help then
					{SYSTEM_CONSOLE}.write_line ("-->")
				end
			else
				Precursor {ARGUMENT_SINGLE_PARSER}
			end
		end

feature {NONE} -- Switch names

	one_file_per_component_switch: STRING = "s"
	recursive_switch: STRING = "r"
	directory_alias_switch: STRING = "a"
	verbal_name_generation_semantics_switch: STRING = "n"
	disk_id_switch: STRING = "k"
	file_include_pattern_switch: STRING = "fi"
	file_exclude_pattern_switch: STRING = "fe"
	directory_include_pattern_switch: STRING = "di"
	directory_exclude_pattern_switch: STRING = "de"
	exclude_pattern_priority_switch: STRING = "ep+"
	merge_module_switch: STRING = "m"

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
