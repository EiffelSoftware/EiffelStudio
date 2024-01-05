note
	description: "[
		Argument parser for the Void-Safe conversion tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		export
			{NONE} all
			{ANY} execute, has_executed, is_successful
		redefine
			switch_groups,
			switch_dependencies
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_multi_parser (False, True)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
			set_is_showing_argument_usage_inline (False)
		end

feature -- Access

	configuration_files: LIST [STRING]
			-- List of configuration files to convert
		require
			is_successful: is_successful
		do
			Result := values
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	is_void_safe: BOOLEAN
			-- Indicates if the application should generate a void-safe configuration file.
		require
			is_successful: is_successful
		do
			Result := has_option (void_safe_option_switch)
		ensure
			has_void_safe_option_switch: Result implies has_option (void_safe_option_switch)
		end

	is_safe_suffix_added: BOOLEAN
			-- Indicates if library references and destination file should be suffixed with a -safe prefix.
		require
			is_successful: is_successful
			is_void_safe: is_void_safe
		do
			Result := has_option (add_safe_suffix_switch)
		ensure
			has_add_safe_suffix_switch: Result implies  has_option (add_safe_suffix_switch)
		end

	is_allow_overwrite: BOOLEAN
			-- Indicates if overwriting existing files, when using the safe extension, is permitted.
		require
			is_successful: is_successful
			is_void_safe: is_void_safe
			is_safe_suffix_added: is_safe_suffix_added
		do
			Result := has_option (replace_switch)
		ensure
			has_replace_switch: Result implies has_option (replace_switch)
		end

	is_non_void_safe: BOOLEAN
			-- Indicates if a void-safe configuration file should be converted to a non-void-safe one.
		require
			is_successful: is_successful
		do
			Result := has_option (non_void_safe_option_switch)
		ensure
			has_non_void_safe_option_switch: Result implies has_option (non_void_safe_option_switch)
		end

feature {NONE} -- Access: Usage

	copyright: STRING = "Copyright Eiffel Software 1985-2024. All Rights Reserved."
			-- <Precursor>

	name: STRING = "Void-Safe Conversion Tool"
			-- <Precursor>

	non_switched_argument_name: STRING = "file"
			-- <Precursor>

	non_switched_argument_description: STRING = "An (E)iffel (C)onfiguration (F)file to convert."
			-- <Precursor>

	non_switched_argument_type: STRING = "Eiffel Configuration File"
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
			create Result.make (2)
			Result.extend (create {ARGUMENT_SWITCH}.make (void_safe_option_switch, "Adds the Void-Safe configuration options to all specified configuration files.", False, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (add_safe_suffix_switch, "Adds the -safe suffix to all references libraries and duplicates the input file to a file with a -safe suffix.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (replace_switch, "Replaces any existing destination file, when the 'add-safe-suffix' is used." , True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (non_void_safe_option_switch, "Removes the Void-Safe configuration options from all specified configuration files.", False, False))
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- <Precursor>
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (void_safe_option_switch)>>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (non_void_safe_option_switch)>>, True))
		end

	switch_dependencies: HASH_TABLE [ARRAY [ARGUMENT_SWITCH], ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.put (<<switch_of_name (add_safe_suffix_switch)>>, switch_of_name (void_safe_option_switch))
			Result.put (<<switch_of_name (replace_switch)>>, switch_of_name (add_safe_suffix_switch))
		end

feature {NONE} -- Switches

	void_safe_option_switch: STRING = "s|void-safe"
	add_safe_suffix_switch: STRING = "a|add-safe-suffix"
	replace_switch: STRING = "r|replace"
	non_void_safe_option_switch: STRING = "n|non-void-safe"

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
