indexing
	description: "A light weight argument parser for simple application command line argument configurations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LITE_PARSER

feature -- Access

	frozen option_values: LIST [OPTION] is
			-- Option values parsed via command line
		require
			parsed: parsed
		once
			Result := internal_option_values
		ensure
			result_attached: Result /= Void
		end

	frozen values: LIST [STRING] is
			-- List of values without options
		require
			accepts_loose_arguments: accepts_loose_arguments
			parsed: parsed
		once
			Result := internal_values
		ensure
			result_attached: Result /= Void
		end

	frozen error_messages: ARRAYED_LIST [STRING] is
			-- Last error messages generated, if any
		once
			create Result.make (0)
		end

feature -- Query

	options_of_name (a_name: STRING): LIST [OPTION] is
			-- Retrieves a list of options, passed by user, by name
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			parsed: parsed
		local
			l_options: like option_values
			l_cursor: CURSOR
			l_cs: like case_sensitive
			l_result: ARRAYED_LIST [OPTION]
			l_opt: OPTION
			l_equal: BOOLEAN
		do
			l_options := option_values
			if not l_options.is_empty then
				create l_result.make (1)

				l_cs := case_sensitive
				l_cursor := l_options.cursor
				from l_options.start until l_options.after loop
					l_opt := l_options.item
					if l_cs then
						l_equal := l_opt.name.is_equal (a_name)
					else
						l_equal := l_opt.name.is_case_insensitive_equal (a_name)
					end
					if l_equal then
						l_result.extend (l_opt)
					end
					l_options.forth
				end
				l_options.go_to (l_cursor)
			else
				create l_result.make (0)
			end
			check l_result_attached: l_result /= Void end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

feature -- Status Report

	case_sensitive: BOOLEAN
			-- Indicates if parser is case sensitive and will match options by case

	accepts_loose_arguments: BOOLEAN
			-- Indicates if arguments without option prefixes are accepted

	suppress_logo: BOOLEAN
			-- Should logo be suppressed?

	display_help: BOOLEAN
			-- Should usage message be displayed?

	parsed: BOOLEAN
			-- Indicates of a parse has been performed

	successful: BOOLEAN is
			-- Indicates if parsing completed without errors
		do
			Result := error_messages.is_empty
		ensure
			error_messages_is_empty: Result implies error_messages.is_empty
		end

feature {NONE} -- Status Report

	display_usage_on_error: BOOLEAN
			-- Indicates if usage should be shown on an error

	frozen has_available_options: BOOLEAN is
			-- Indicates if there are options available
		do
			Result := not available_switches.is_empty
		end

feature -- Basic Operations

	execute (a_agent: PROCEDURE [ANY, TUPLE]) is
			-- Execute application using `a_agent', if all arguments are valid.
		require
			a_agent_attached: a_agent /= Void
		local
			l_options: like option_values
		do
			if not suppress_logo then
				display_logo
			end

			parse_arguments
			if successful then
				if display_help then
					display_usage
				else
					l_options := option_values
					if option_values.is_empty or option_values.count = 1 and suppress_logo then
						execute_noop (a_agent)
					else
						a_agent.call ([])
					end
				end
			else
				display_errors
				if display_usage_on_error then
					display_usage
				end
			end
		end

feature {NONE} -- Basic Operations

	execute_noop (a_agent: PROCEDURE [ANY, TUPLE]) is
			-- Executes `a_agent' when no arguments of any worth are passed.
		require
			a_agent_attached: a_agent /= Void
			option_values_is_empty: option_values.is_empty or option_values.count = 1 and suppress_logo
		do
			display_usage
		end

feature {NONE} -- Parsing

	frozen parse_arguments is
			-- Parses command line arguments and sets `option_values' and `values'.
			-- Note: Upon and error `success' and `last_error_message' will be set.
		require
			not_parsed: not parsed
		local
			l_switches: like available_switches
			l_option: STRING
			l_value: STRING
			l_switch: SWITCH
			l_value_switch: VALUE_SWITCH
			l_validator: SWITCH_VALUE_VALIDATOR
			l_prefixes: like switch_prefixes
			l_args: ARRAY [STRING]
			l_upper: INTEGER
			l_permit_loose: like accepts_loose_arguments
			l_cs: like case_sensitive
			l_match: BOOLEAN
			l_options: like internal_option_values
			l_values: like internal_values
			l_err: BOOLEAN
			l_arg: STRING
			i, j: INTEGER
		do
			create l_options.make (0)
			create l_values.make (0)
			internal_option_values := l_options
			internal_values := l_values

				-- Set parsed so we can access certain functions
			parsed := True

			l_args := arguments.argument_array
			if not l_args.is_empty then
				l_switches := available_switches
				l_prefixes := switch_prefixes
				l_permit_loose := accepts_loose_arguments
				l_cs := case_sensitive

					-- Iterate arguments
				from
					i := 1
					l_upper := l_args.upper
				until i > l_upper loop
					l_arg := l_args[i]
					if l_prefixes.has (l_arg.item (1)) then

							-- Indicates a switch option
						if l_arg.count > 1 then
							l_err := False
							l_value := Void
							l_option := l_arg.substring (2, l_arg.count)

							j := l_option.index_of (switch_value_qualifer, 1)
							if j > 0 then
								if j = 1 then
									add_template_error (invalid_switch_error, [ellipse_text (l_arg)])
									l_err := True
								else
									l_value := l_option.substring (j + 1, l_option.count)
									l_option := l_option.substring (1, j - 1)
								end
							end

							if not l_err then
								if not l_cs then
									l_option.to_lower
								end

									-- Attempt to find a matching switch
								l_match := False
								from l_switches.start until l_switches.after or l_match loop
									l_switch := l_switches.item
									if l_cs then
										l_match := l_switch.name.is_equal (l_option)
									else
										l_match := l_switch.lower_case_name.is_equal (l_option)
									end
									l_switches.forth
								end

								if l_match then
										-- Match found, now check it.
									check l_switch_attached: l_switch /= Void end
									if options_of_name (l_option).is_empty or l_switch.allow_multiple then
											-- Single occurance or multiple occurances permitted
										l_value_switch ?= l_switch
										if l_value_switch /= Void then
											if l_value /= Void and then not l_value.is_empty then
													-- Now validate option
												l_validator := l_value_switch.value_validator
												l_validator.validate_value (l_value)
												if l_validator.is_option_valid then
														-- Create user option
													internal_option_values.extend (create {OPTION}.make_with_value (l_option, l_value))
												else
													add_template_error (invalid_switch_value, [ellipse_text (l_value)])
												end
											elseif not l_value_switch.is_value_optional then
												add_template_error (require_switch_value, [l_option])
											else
													-- Create user option
												internal_option_values.extend (create {OPTION}.make (l_option))
											end
										elseif l_value /= Void then
											add_template_error (non_value_switch, [l_option])
										else
												-- Create user option
											internal_option_values.extend (create {OPTION}.make (l_option))
										end
									else
										add_template_error (multiple_switch_error, [l_option])
									end
								else
									add_template_error (unreconized_switch_error, [ellipse_text (l_arg)])
								end
							end
						else
							add_template_error (invalid_switch_error, [ellipse_text (l_arg)])
						end
					elseif l_permit_loose then
						if not l_arg.is_empty then
								-- Create loose option
							internal_values.extend (l_arg)
						else
							add_template_error (invalid_switch_error, [ellipse_text (l_arg)])
						end
					else
						add_template_error (invalid_switch_error, [ellipse_text (l_arg)])
					end
					i := i + 1
				end
			end

			if successful then
				post_process_arguments
			end
			parsed := successful
		ensure
			parsed: successful implies parsed
		end

feature {NONE} -- Post Processing

	post_process_arguments is
			-- A chance to evaluate all set arguments for validity can conformance.
			-- Set an error if an switch or value does not adhear to any custom rules.
		do
			suppress_logo := not options_of_name (nologo_switch).is_empty
			display_help := not options_of_name (help_switch).is_empty
		end

feature {NONE} -- Error Handling

	add_error (a_msg: STRING) is
			-- Adds a parse error.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
			not_error_messages_has_a_msg: not error_messages.has (a_msg)
		do
			error_messages.extend (a_msg)
		ensure
			error_messages_extended: error_messages.has (a_msg)
		end

	add_template_error (a_tmpl: STRING; a_contexts: TUPLE) is
			-- Adds a parse error base on a template specification.
			-- Note: See {STRING_FORMATTER}.`format'.
		require
			a_tmpl_not_void: a_tmpl /= Void
			not_a_tmpl_is_empty: not a_tmpl.is_empty
			a_contexts_not_void: a_contexts /= Void
			not_a_contexts_is_empty: not a_contexts.is_empty
		do
			add_error ((create {STRING_FORMATTER}).format (a_tmpl, a_contexts))
		ensure
			error_messages_extended: error_messages.count = old error_messages.count + 1
		end

feature {NONE} -- Output

	frozen display_usage is
			-- Displays usage information
		local
			l_name: like name
			l_copy: like copyright
			l_ver: like version
			l_logo: STRING
			l_cfg: like command_option_configuration
		do
			io.put_string (once "USAGE: %N   ")
			io.put_string (system_name)

			l_cfg := command_option_configuration
			if l_cfg /= Void then
				io.put_character (' ')
				io.put_string  (l_cfg)
			end
			io.new_line

			if has_available_options then
				display_options
			end
			display_extended_usage
		end

	frozen display_logo is
			-- Displays copyright information
		local
			l_name: like name
			l_copy: like copyright
			l_ver: like version
			l_logo: STRING
		do
			l_name := name
			l_copy := copyright
			l_ver := version

			create l_logo.make (l_name.count + l_copy.count + l_ver.count + 13)
			l_logo.append (l_name)
			l_logo.append (" (Version: ")
			l_logo.append (l_ver)
			l_logo.append (")%N")
			l_logo.append (l_copy)
			io.put_string (l_logo)
			io.new_line
			io.new_line
		end

	display_errors is
			-- Displays any parse related error messages
		require
			not_successful: not successful
		local
			l_errors: like error_messages
			l_cursor: CURSOR
		do
			l_errors := error_messages
			l_cursor := l_errors.cursor
			io.put_string (string_formatter.format ("{1} error(s) occurred.%N", [error_messages.count]))
			from l_errors.start until l_errors.after loop
				io.put_string ("   > ")
				io.put_string (l_errors.item)
				io.new_line
				l_errors.forth
			end
			l_errors.go_to (l_cursor)
			io.new_line
		ensure
			error_messages_unmoved: error_messages.cursor.is_equal (old error_messages.cursor)
		end

	frozen display_options is
			-- Displays configurable options
		require
			has_available_options: has_available_options
		local
			l_nl: STRING
			l_tabbed_nl: STRING
			l_keys: ARRAY [STRING]
			l_max_len: INTEGER
			l_options: like available_switches
			l_cursor: CURSOR
			l_opt: SWITCH
			l_name: STRING
			l_desc: STRING
			l_prefixes: like switch_prefixes
			l_prefix: STRING
			l_def_prefix: CHARACTER
			l_count: INTEGER
			i: INTEGER
		do
			io.put_string ("%NOPTIONS:%N")

				-- Output prefix option qualifiers
			l_prefixes := switch_prefixes
			if l_prefixes.count > 1 then
				create l_prefix.make ((l_prefixes.count * 5) + 2)
				from
					i := 1
					l_count := l_prefixes.count
				until i > l_count loop
					if i > 1 then
						if i < l_count then
							l_prefix.append (once ", ")
						else
							l_prefix.append (once " or ")
						end
					end
					l_prefix.append_character ('%'')
					l_prefix.append_character (l_prefixes[i])
					l_prefix.append_character ('%'')
					i := i + 1
				end
				io.put_string ("   Options should be prefixed with: ")
				io.put_string (l_prefix)
				io.new_line
			end

			l_options := available_switches
			l_nl := "%N"

				-- Retrieve option max length for alignment
			l_cursor := l_options.cursor
			from l_options.start until l_options.after loop
				l_name := l_options.item.name
				l_max_len := l_max_len.max (l_name.count)
				l_options.forth
			end

			create l_tabbed_nl.make_filled (' ', l_nl.count + 2 + l_max_len)
			l_tabbed_nl.insert (l_nl, 1)

			l_def_prefix := switch_prefixes[1]

				-- Output available options			
			from l_options.start until l_options.after loop
				l_opt := l_options.item

				l_name := l_opt.name
				if l_max_len > l_name.count then
					create l_name.make_filled (' ', l_max_len - l_name.count)
				else
					create l_name.make_empty
				end
				l_name.insert_string (l_opt.name, 1)

				l_desc := l_opt.description.twin
				l_desc.replace_substring_all (l_nl, l_tabbed_nl)

				io.put_string (once "   ")
				io.put_character (l_def_prefix)
				io.put_string (l_name)
				io.put_string (once ": ")
				io.put_string (l_desc)
				io.new_line
				l_options.forth
			end
			l_options.go_to (l_cursor)

			io.new_line
			io.new_line
		ensure
			available_options_unmoved: old available_switches /= Void implies available_switches.cursor.is_equal (old available_switches.cursor)
		end

	display_extended_usage is
			-- Displays extended configuration information
			-- Redefine in subclass.
		do
				--| Nothing to do here.	
		end

feature {NONE} -- Usage

	name: STRING is
			-- Full name of application
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	version: STRING is
			-- Version number of application
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	copyright: STRING is
			-- Copyright information
		once
			Result := "Copyright Eiffel Software 1985-2006 . All Rights Reserved."
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	command_option_configuration: STRING is
			-- Command line option configuration string (to display in usage)
		once
			Result := "<option> [<option> [...]]"
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {NONE} -- Switches

	nologo_switch: STRING is "nologo"
			-- Supress copyright information switch

	help_switch: STRING is "?"
			-- Display usage information switch

	available_switches: ARRAYED_LIST [SWITCH] is
			-- Retrieve a list of available switch
			-- Key: Option name
			-- Value: Option description
		do
			create Result.make (2)
			Result.extend (create {SWITCH}.make (nologo_switch, "Supresses copyright information.", False))
			Result.extend (create {SWITCH}.make (help_switch, "Display usage information.", False))
			Result.compare_objects
		ensure
			result_compares_objects: Result.object_comparison
		end

feature {NONE} -- Formatting

	frozen ellipse_text (a_str: STRING): STRING is
			-- If `a_str' is bigger than `ellipse_threshold'
		require
			a_str_attached: a_str /= Void
			not_a_str_is_empty: not a_str.is_empty
		do
			Result :=string_formatter.ellipse (a_str, ellipse_threshold)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_ellipsed: Result.count <= ellipse_threshold
		end

	ellipse_threshold: NATURAL_8 is 15
			-- Maximum number of characters before ellipses (...) are used
			-- to trim a region of text.

feature {NONE} -- Implementation

	frozen system_name: STRING is
			-- Retrieves system name
		local
			l_path: STRING
			i: INTEGER
		do
			l_path := arguments.argument (0)
			if l_path /= Void and then not l_path.is_empty then
				i := l_path.last_index_of (op_env.directory_separator, l_path.count)
				if i > 0 then
					Result := l_path.substring (i + 1, l_path.count)
				else
					Result := l_path
				end
			else
				Result := default_system_name
			end
		end

	frozen arguments: ARGUMENTS is
			-- Access to raw arguments
		once
			create Result
		end

	frozen op_env: OPERATING_ENVIRONMENT is
			-- Access to operating environment
		once
			create Result
		end

	frozen string_formatter: STRING_FORMATTER is
			-- Access to general purpose string formatter
		once
			create Result
		end

feature {NONE} -- Constants

	switch_prefixes: ARRAY [CHARACTER] is
			-- Prefixes used to indicate a command line switch
		do
			Result := <<'-', '/'>>
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	switch_value_qualifer: CHARACTER is ':'
			-- Character used to separate an switch from it's value

	default_system_name: STRING is "app"
			-- Default application name

feature {NONE} -- Error Constants

	invalid_switch_error: STRING is "The switch '{1}' is invalid."
	unreconized_switch_error: STRING is "Unreconsized swtich '{1}'."
	invalid_switch_value: STRING is "'{1}' is an invalid option for switch '{2}'."
	require_switch_value: STRING is "Switch '{1}' requires a paired value."
	multiple_switch_error: STRING is "Switch '{1}' can only be used once."
	non_value_switch: STRING is "Switch '{1}' should not have any value paired with it."

feature {NONE} -- Internal Implementation Cache

	internal_option_values: ARRAYED_LIST [OPTION]
			-- Mutable, unprotected verion of `option_values'

	internal_values: ARRAYED_LIST [STRING]
			-- Mutable, unprotected version of `values'

invariant
	internal_option_values_attached: parsed implies internal_option_values /= Void
	internal_values_attached: parsed implies internal_values /= Void
	parsed_means_successful: parsed implies successful

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

end -- class {LITE_PARSER}
