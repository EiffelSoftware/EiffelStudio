indexing
	description: "Argument parser for lite eiffel compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{ANY} is_successful, execute, system_name
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize argument parser
		do
			make_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
			set_is_using_separated_switch_values (True)
			set_is_showing_argument_usage_inline (True)
		end

feature -- Access

	configuration_file: STRING is
			-- Eiffel compiler configuration file
		require
			successful: is_successful
		do
			Result := values.first
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	target: STRING is
		require
			successful: is_successful
		local
			l_opt: ARGUMENT_OPTION
		do
			l_opt := option_of_name (target_switch)
			if l_opt /= Void then
				Result := l_opt.value
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	project_location: STRING is
			-- Location to compile Eiffel project in
		require
			successful: is_successful
		local
			l_opt: ARGUMENT_OPTION
		do
			l_opt := option_of_name (location_switch)
			if l_opt /= Void then
				Result := l_opt.value
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	optimized_options: OPTIMIZED_ARGUMENT_OPTION
			-- Optimized argument options
		require
			successful: is_successful
			optimize: optimize
		do
			Result ?= option_of_name (finalize_switch)
		ensure
			result_attached: Result /= Void
		end

	project_alias: STRING
			-- Project alias name (hidden switch value)
		require
			successful: is_successful
		local
			l_opt: ARGUMENT_OPTION
		do
			l_opt := option_of_name (alias_switch)
			if l_opt /= Void then
				Result := l_opt.value
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature -- Status report

	precompile: BOOLEAN is
			-- Indiciates if compiler should precompile project
		require
			successful: is_successful
		once
			Result := has_option (precomp_switch)
		end

	optimize: BOOLEAN is
			-- Indiciates if compiler should generate optimized code
		require
			successful: is_successful
		once
			Result := has_option (finalize_switch)
		end

	force_lookup: BOOLEAN is
			-- Indiciates if compiler should re-examine directory structures for new/removed classes
		require
			successful: is_successful
		once
			Result := has_option (force_switch)
		end

	freeze_code: BOOLEAN is
			-- Indiciates if compiler should freeze melted code
		require
			successful: is_successful
		once
			Result := has_option (freeze_switch)
		end

	compile_c_code: BOOLEAN is
			-- Indiciates if compiler should trigger compiliation of the C code, after
			-- a successful Eifel compilation
		require
			successful: is_successful
		once
			Result := has_option (c_compile_switch)
		end

	configuration_settings: HASH_TABLE [STRING, STRING] is
			-- Table of override configuration settings
			-- Key: Setting nane
			-- Value: Value
		require
			successful: is_successful
		local
			l_options: LIST [ARGUMENT_OPTION]
			l_option: ARGUMENT_PROPERTY_OPTION
			l_cursor: CURSOR
		once
			l_options := options_of_name (set_switch)
			create Result.make (l_options.count)
			if not l_options.is_empty then
				l_cursor := l_options.cursor
				from l_options.start until l_options.after loop
					l_option ?= l_options.item
					if l_option /= Void then
						if l_option.has_property_name and l_option.has_value then
							Result.force (l_option.property_value, l_option.property_name)
						end
					end
					l_options.forth
				end
				l_options.go_to (l_cursor)
			end
		end

	clean_project: BOOLEAN is
			-- Indiciates if compiler should delete the previous project compiled information
			-- before compiling.
		require
			successful: is_successful
		once
			Result := has_option (clean_switch)
		end

	interactive_mode: BOOLEAN is
			-- Indiciates if compiler should interacte with user
		require
			successful: is_successful
		once
			Result := has_option (interactive_switch)
		end

	verbose_output: BOOLEAN is
			-- Indiciates if compiler should display verbose information on compiler output
		require
			successful: is_successful
		once
			Result := has_option (verbose_switch)
		end

feature {NONE} -- Usage

	name: !STRING is
			-- Full name of application
		once
			Result := "Eiffel Compiler Lite Edition"
		end

	version: !STRING is
			-- Version number of application
		once
			Result := "6.4.0"
		end

	non_switched_argument_name: !STRING_8 is
			-- Name of lose argument, used in usage information
		do
			Result := "ecf"
		end

	non_switched_argument_description: !STRING_8 is
			-- Description of loose argument, used in usage information
		do
			Result := "Eiffel compiler configuration file."
		end

	non_switched_argument_type: !STRING_8 is
			-- Type of lose argument, used in usage information.
		do
			Result := "configuration file"
		end

	switches: ARRAYED_LIST [!ARGUMENT_SWITCH] is
			-- Retrieve a list of available switch
		local
			l_optimize_flags: HASH_TABLE [!STRING_8, CHARACTER]
		once
			create l_optimize_flags.make (1)
			l_optimize_flags.put ("Keep assertions", {OPTIMIZED_ARGUMENT_SWITCH}.keep_flag)

			create Result.make (3)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (target_switch, "Specifies the target to compile in the specified configuration file.", True, False, "Target", "A configuration file target", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (precomp_switch, "Precompiles a project for use by another project.", False, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Forces re-examination of directory structures for new or removed classes.", False, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (freeze_switch, "Freezes any melted code.", False, False))
			Result.extend (create {OPTIMIZED_ARGUMENT_SWITCH}.make (finalize_switch, "Optimizes and finalizes code generation.", True, False, "Flags", "Optimization flags.", True, l_optimize_flags, False))
			Result.extend (create {SETTING_ARGUMENT_SWITCH}.make (set_switch, "Overrides or sets a configuration file setting.", True, True, "Setting", "A configuration setting in the form of <setting>=<value>.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (c_compile_switch, "Automatically compiles an C code at the end of an Eiffel compilation.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (clean_switch, "Cleans project before compiling.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (interactive_switch, "When used the compiler will prompt for information when required.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Displays verbose compiler output.", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make_hidden (alias_switch, "Sets a project alias for error reporting.", True, False, "Name", "Project alias name", False))
		end

	switch_groups: ARRAYED_LIST [!ARGUMENT_GROUP] is
			-- Valid switch grouping
		do
			create Result.make (4)

			Result.extend (create {ARGUMENT_GROUP}.make (<<
				switch_of_name (target_switch),
				switch_of_name (finalize_switch),
				switch_of_name (c_compile_switch),
				switch_of_name (set_switch),
				switch_of_name (clean_switch),
				switch_of_name (interactive_switch),
				switch_of_name (alias_switch),
				switch_of_name (verbose_switch)>>, True))

			Result.extend (create {ARGUMENT_GROUP}.make (<<
				switch_of_name (force_switch),
				switch_of_name (target_switch),
				switch_of_name (finalize_switch),
				switch_of_name (c_compile_switch),
				switch_of_name (set_switch),
				switch_of_name (clean_switch),
				switch_of_name (interactive_switch),
				switch_of_name (alias_switch),
				switch_of_name (verbose_switch)>>, True))

			Result.extend (create {ARGUMENT_GROUP}.make (<<
				switch_of_name (freeze_switch),
				switch_of_name (target_switch),
				switch_of_name (finalize_switch),
				switch_of_name (c_compile_switch),
				switch_of_name (set_switch),
				switch_of_name (clean_switch),
				switch_of_name (interactive_switch),
				switch_of_name (alias_switch),
				switch_of_name (verbose_switch)>>, True))

			Result.extend (create {ARGUMENT_GROUP}.make (<<
				switch_of_name (precomp_switch),
				switch_of_name (finalize_switch),
				switch_of_name (c_compile_switch),
				switch_of_name (set_switch),
				switch_of_name (clean_switch),
				switch_of_name (interactive_switch),
				switch_of_name (alias_switch),
				switch_of_name (verbose_switch)>>, True))
		end

feature {NONE} -- Option names

	force_switch: STRING = "force"
	precomp_switch: STRING = "precomp"
	freeze_switch: STRING = "freeze"
	finalize_switch: STRING = "final"
	target_switch: STRING = "target"
	location_switch: STRING = "location"
	clean_switch: STRING = "clean"
	c_compile_switch: STRING = "c_compile"
	verbose_switch: STRING = "verbose"
	set_switch: STRING = "set"
	interactive_switch: STRING = "prompt"
	alias_switch: STRING = "alias"

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
