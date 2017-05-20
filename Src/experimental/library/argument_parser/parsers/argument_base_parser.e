note
	description: "A base argument parser for simple application command line argument configurations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_BASE_PARSER

obsolete
	"Use the new library with Unicode argument support at $ISE_LIBRARY/library/runtime/process/arg_parser. [2012-12-20]"

feature {NONE} -- Initialization

	make (a_cs: like is_case_sensitive; a_allow_non_switched: like is_allowing_non_switched_arguments; a_non_switch_required: like is_non_switch_argument_required)
			-- Initialize the base parser options.
			--
			-- `a_cs': True if the switches are treated with case-sensitive; False otherwise.
			-- `a_allow_non_switched': True if non-switched arguments are accepted by the parser; False otherwise.
			-- `a_non_switch_required': True to require a non-switched argument; False otherwise.
		require
			not_a_non_switch_required: not a_allow_non_switched implies not a_non_switch_required
		do
			initialize_defaults
			is_case_sensitive := a_cs
			is_allowing_non_switched_arguments := a_allow_non_switched
			is_non_switch_argument_required := a_non_switch_required
		ensure
			is_case_sensitive_set: is_case_sensitive = a_cs
			is_allowing_non_switched_arguments_set: is_allowing_non_switched_arguments = a_allow_non_switched
			is_non_switch_argument_required_set: is_non_switch_argument_required = a_non_switch_required
		end

	initialize_defaults
			-- Initializes the default settings for the argument parser
		do
			is_using_builtin_switches := True
			is_case_sensitive := True
			is_allowing_non_switched_arguments := True
			is_non_switch_argument_required := False
			is_showing_argument_usage_inline := True
			is_using_separated_switch_values := True
			is_usage_displayed_on_error := False

			create internal_option_values.make (0)
			create internal_values.make (0)

			create {ARGUMENT_DEFAULT_VALIDATOR} non_switched_argument_validator
		end

feature -- Access

	frozen application_base: STRING
			-- The base location of application.
		do
			Result := argument_source.application_base
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			no_trailing_separator: Result.item (Result.count) /= operating_environment.directory_separator
		end

	frozen values: LIST [STRING]
			-- List of arguments values that were not qualified with a switch (aka loose arguments).
		do
			Result := internal_values
		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: not Result.there_exists (agent {STRING}.is_empty)
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

	frozen option_values: LIST [ARGUMENT_OPTION]
			-- Option values parsed via command line, these do not include the loose arguments. See `values'.
		do
			Result := internal_option_values
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

	frozen error_messages: ARRAYED_LIST [STRING]
			-- Any error messages generated during parse and validation, if any.
		once
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: not Result.there_exists (agent {STRING}.is_empty)
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

feature {NONE} -- Access

	frozen system_name: STRING
			-- Retrieves system executable name.
		local
			l_path: STRING
			i: INTEGER
		do
			l_path := argument_source.application
			if l_path /= Void and then not l_path.is_empty then
				i := l_path.last_index_of (operating_environment.directory_separator, l_path.count)
				if i > 0 then
					Result := l_path.substring (i + 1, l_path.count)
				else
					Result := l_path
				end
			else
				Result := default_system_name
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen arguments: ARRAY [STRING]
			-- The list of actual arguments, which takes into account compounded arguments when using
			-- Unix-style switches.
			-- Compunded switches are those single character switches, when `is_using_unix_switch_style' is True,
			-- that are joined, such as -abcde, where a, b, c, d and e are switches.
		local
			l_args: ARRAY [STRING]
			l_result: ARRAYED_LIST [STRING]
			l_arg: STRING
			l_next_arg: detachable STRING
			l_prefixes: like switch_prefixes
			l_use_separated_switched: BOOLEAN
			i, l_count: INTEGER
			j, nb: INTEGER
		do
			if is_using_unix_switch_style then
					-- When using the Unix style switch we can uss
				l_args := argument_source.arguments
				create l_result.make (l_args.count)

				l_prefixes := switch_prefixes
				l_use_separated_switched := is_using_separated_switch_values
				from
					i := 1
					l_count := l_args.count
				until
					i > l_count
				loop
					l_arg := l_args[i]
					if l_arg.count > 2 then
						if l_prefixes.has (l_arg.item (1)) and not l_prefixes.has (l_arg.item (2)) then
								-- This means the argument is a single prefix switched (Unix style uses two (--) for full
								-- words and one (-) for shortcuts, which can be compounded.)
							if l_use_separated_switched then
								nb := l_arg.count
							else
								nb := l_arg.index_of (switch_value_qualifer, 2)
								if nb = 0 then
									nb := l_arg.count
								else
									nb := nb.min (l_arg.count)
								end
							end

							from j := 2 until j > nb loop
								l_next_arg := Void

								if not l_use_separated_switched then
										-- We have to peek to ensure if switch value qualified that the last switch is associated
										-- with the value.
									if j < nb then
											-- Peek, because there is space.
										if l_arg.item (j + 1) = switch_value_qualifer then
											create l_next_arg.make (1 + (nb - j))
											l_next_arg.append_character (l_prefixes[1])
											l_next_arg.append (l_arg.substring (j, l_arg.count))

												-- Exit loop
											j := nb
										end
									end
								end

								if l_next_arg = Void then
										-- There was no added argument.
									if l_use_separated_switched or else l_arg.item (j) /= switch_value_qualifer then
										create l_next_arg.make (2)
										l_next_arg.append_character (l_prefixes[1])
										l_next_arg.append_character (l_arg.item (j))
									end
								end

								if l_next_arg /= Void then
									l_result.extend (l_next_arg)
								end

								j := j + 1
							end
						else
							l_result.extend (l_arg)
						end
					else
						l_result.extend (l_arg)
					end
					i := i + 1
				end

				create Result.make_filled ("", 1, l_result.count)
				from l_result.start until l_result.after loop
					Result.put (l_result.item_for_iteration, l_result.index)
					l_result.forth
				end
			else
				Result := argument_source.arguments
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.array_contains_attached_items (Result)
		end

	frozen argument_source: ARGUMENT_SOURCE assign set_argument_source
			-- Access to the arguments via a source object.
		local
			l_result: like internal_argument_source
		do
			l_result := internal_argument_source
			if l_result = Void then
				Result := new_argument_source
				internal_argument_source := Result
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = argument_source
		end

	non_switched_argument_validator: ARGUMENT_VALUE_VALIDATOR assign set_non_switched_argument_validator
			-- Validator used to validate any non-switched arguments.

feature {NONE} -- Element change

	set_argument_source (a_source: like argument_source)
			-- Sets an alternative argument source object for fetching the arguments.
			--
			-- `a_source': The source object to use to fetch the arguments for the application.
		require
			a_source_attached: a_source /= Void
			not_has_parsed: not has_parsed
		do
			internal_argument_source := a_source
		ensure
			argument_source_set: argument_source ~ a_source
		end

	set_non_switched_argument_validator (a_validator: like non_switched_argument_validator)
			-- Sets the non-switched argument validator.
			--
			-- `a_validator': The validator to set for the non-switched argument.
		require
			a_validator_attached: a_validator /= Void
			accepts_non_switched_arguments: is_allowing_non_switched_arguments
		do
			non_switched_argument_validator := a_validator
		ensure
			non_switched_argument_validator_set: non_switched_argument_validator = a_validator
		end

feature {NONE} -- Measurement

	max_columns: NATURAL
			-- Maximum columns to display in the terminal
		once
			Result := {ARGUMENT_EXTERNALS}.c_get_term_columns.as_natural_32
			if Result = 0 then
				Result := {INTEGER_32}.max_value.as_natural_32
			else
				if {PLATFORM}.is_windows then
						-- Negate a single column because of Windows soft-wrapping behavior causes an extra line
						-- break when a line is the exact length of the terminal width.
					Result := Result - 1
				end
				Result := Result.max (25)
			end
		ensure
			result_reasonable: Result >= 25
		end

feature -- Status report

	is_successful: BOOLEAN
			-- Indicates if parsing completed without errors.
		do
			Result := has_parsed and error_messages.is_empty
		ensure
			error_messages_is_empty: Result implies has_parsed and then error_messages.is_empty
		end

	is_using_separated_switch_values: BOOLEAN assign set_is_using_separated_switch_values
			-- Indicates if switch values are separated from their switch and not
			-- qualified using a ':' (by default)

	is_showing_argument_usage_inline: BOOLEAN assign set_is_showing_argument_usage_inline
			-- Indiciate if argument switch value descriptions should be shown inline
			-- with the argument description

	is_usage_verbose: BOOLEAN assign set_is_usage_verbose
			-- Indicates if the usage information should be verbose.

	is_usage_displayed_on_error: BOOLEAN assign set_is_usage_displayed_on_error
			-- Indicates if usage should be shown on an error.

	has_executed: BOOLEAN
			-- Indiciate if execution has occurred (a call to `execute').

	frozen has_non_switched_argument: BOOLEAN
			-- Determines if one or more non-switch qualified arguments were specified in the command-line arguments.
		do
			Result := has_parsed and then not values.is_empty
		ensure
			result_true: Result = (has_parsed and then not values.is_empty)
		end

	frozen has_option (a_name: READABLE_STRING_8): BOOLEAN
			-- Determines if switch option was specified in the command-line arguments.
			--
			-- `a_name': The name of the switch to check existence for.
			-- `Result': True if the command line specified the given switch; False otherwise.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := has_parsed and then internal_option_of_name (a_name) /= Void
		ensure
			result_true: Result = (has_parsed and then internal_option_of_name (a_name) /= Void)
		end

feature {NONE} -- Status report

	is_case_sensitive: BOOLEAN
			-- Indicates if parser is case sensitive and will match options by case.

	is_using_builtin_switches: BOOLEAN
			-- Indicates if built-in application switches should be added to the argument options.

	is_allowing_non_switched_arguments: BOOLEAN
			-- Indicates if arguments without switches prefixes are allowed by the parser.

	is_non_switch_argument_required: BOOLEAN
			-- Indicate if at least one non-switched argument is required.

	is_logo_information_suppressed: BOOLEAN
			-- Should logo be suppressed?

	is_help_usage_displayed: BOOLEAN
			-- Should usage message be displayed?

	is_using_unix_switch_style: BOOLEAN
			-- Indicates if the Unix command switch style is being used by the application switches.
			--| Note: Redefine to force use of Unix long name switches.
		local
			l_switches: like switches
			l_cursor: CURSOR
		once
			l_switches := switches
			l_cursor := l_switches.cursor
			from l_switches.start until l_switches.after or Result loop
				Result := l_switches.item.has_short_name
				l_switches.forth
			end
			l_switches.go_to (l_cursor)
		end

	frozen has_available_options: BOOLEAN
			-- Indicates if there are options available
		do
			Result := not available_switches.is_empty
		end

	frozen has_visible_available_options: BOOLEAN
			-- Indicates if there are options available
		do
			Result := not available_visible_switches.is_empty
		end

	has_parsed: BOOLEAN
			-- Indicates of a parse has been performed.

	has_switch (a_name: READABLE_STRING_8): BOOLEAN
			-- Determines if a switch exists.
			--
			-- `a_name': The name of the switch to determine existence for.
			-- `Result': True if the switch exists; False otherwise.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_switches: like available_switches
			l_cs: like is_case_sensitive
			l_cursor: CURSOR
			l_name: READABLE_STRING_8
			l_match_name: READABLE_STRING_8
		do
			l_switches := available_switches
			l_cursor := l_switches.cursor
			l_cs := is_case_sensitive
			if l_cs then
				l_match_name := a_name
			else
				l_match_name := a_name.as_lower
			end
			from
				l_switches.start
			until
				l_switches.after or Result
			loop
				if l_cs then
					l_name := l_switches.item.id
				else
					l_name := l_switches.item.lower_case_id
				end
				Result := l_match_name ~ l_name
				l_switches.forth
			end
			l_switches.go_to (l_cursor)
		ensure
			available_switches_unmoved: available_switches.cursor ~ old available_switches.cursor
		end

feature -- Status Setting

	set_is_using_separated_switch_values (a_use: like is_using_separated_switch_values)
			-- Sets parser's state to indicate if the user's input should use whitespace to separate
			-- switches from their argument values.
			--
			-- `a_use': True to use whitespace separators; False to use the default separated character.
		require
			not_has_executed: not has_executed
		do
			is_using_separated_switch_values := a_use
		ensure
			is_using_separated_switch_values_set: is_using_separated_switch_values = a_use
		end

	set_is_showing_argument_usage_inline (a_show: like is_showing_argument_usage_inline)
			-- Sets usage formatter to display the switch arguments inline with the switch usage description.
			--
			-- `a_show': True show arguments in line; False to display the arguments after the usage.
		require
			not_has_executed: not has_executed
		do
			is_showing_argument_usage_inline := a_show
		ensure
			is_showing_argument_usage_inline_set: is_showing_argument_usage_inline = a_show
		end

	set_is_usage_verbose (a_verbose: like is_usage_verbose)
			-- Sets usage formatter to display a much information as possible.
			--
			-- `a_verbose': True to display verbose usage; False otherwise.
		require
			not_has_executed: not has_executed
		do
			is_usage_verbose := a_verbose
		ensure
			is_usage_verbose_set: is_usage_verbose = a_verbose
		end

	set_is_usage_displayed_on_error (a_display: like is_usage_displayed_on_error)
			-- Sets usage formatter to display the help information when an error occurs in parsing or
			-- validation.
			--
			-- `a_display': True to display the usage on error; False otherwise.
		require
			not_has_executed: not has_executed
		do
			is_usage_displayed_on_error := a_display
		ensure
			is_usage_displayed_on_error_set: is_usage_displayed_on_error = a_display
		end

feature {NONE} -- Query

	option_of_name (a_name: READABLE_STRING_8): detachable ARGUMENT_OPTION
			-- Retrieves the first switch-qualified option, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve an options for.
			-- `Result': An option passed via the command line or Void if the switch option was not found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		do
			if attached internal_option_of_name (a_name) as l_result then
				Result := l_result
			end
		end

	options_of_name (a_name: READABLE_STRING_8): LIST [ARGUMENT_OPTION]
			-- Retrieves a list of switch-qualified options, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve a list of options for.
			-- `Result': A list of options passed via the command line.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: like option_values
			l_cursor: CURSOR
			l_cs: like is_case_sensitive
			l_result: ARRAYED_LIST [ARGUMENT_OPTION]
			l_opt: ARGUMENT_OPTION
			l_equal: BOOLEAN
		do
			l_options := option_values
			if not l_options.is_empty then
				create l_result.make (1)

				l_cs := is_case_sensitive
				l_cursor := l_options.cursor
				from l_options.start until l_options.after loop
					l_opt := l_options.item
					if l_cs then
						l_equal := l_opt.switch.id ~ a_name
					else
						l_equal := l_opt.switch.id.is_case_insensitive_equal (a_name)
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
			Result := l_result
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

	options_values_of_name (a_name: READABLE_STRING_8): LIST [STRING]
			-- Retrieves a list of switch-qualified option values, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve a list of options for.
			-- `Result': A list of options values passed via the command line.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: like options_of_name
			l_result: ARRAYED_LIST [STRING]
		do
			if has_option (a_name) then
				l_options := options_of_name (a_name)
				create l_result.make (l_options.count)
				l_result.compare_objects
				if not l_options.is_empty then
					l_options.do_all (agent (ia_list: ARRAYED_LIST [STRING]; ia_option: ARGUMENT_OPTION)
						require
							ia_list_attached: ia_list /= Void
							ia_option_attached: ia_option /= Void
						do
							if ia_option.has_value then
								ia_list.extend (ia_option.value)
							end
						ensure
							ia_list_has_a_path: ia_option.has_value implies ia_list.has (ia_option.value)
						end (l_result, ?)
					)
				end
			else
				create l_result.make (0)
				l_result.compare_objects
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
			result_contains_attached_valid_items: not Result.there_exists (agent {STRING}.is_empty)
		end

	unique_options_values_of_name (a_name: READABLE_STRING_8; a_ignore_case: BOOLEAN): LIST [STRING]
			-- Retrieves a list of unique switch-qualified option values, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve a list of options for.
			-- `a_ignore_case': True to ignore cases differences when determining uniqueness; False otherwise.
			-- `Result': A list of options values passed via the command line.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: like options_of_name
			l_option: ARGUMENT_OPTION
			l_result: ARRAYED_LIST [STRING]
			l_value: STRING
			l_comp_list: ARRAYED_LIST [STRING]
			l_comp_value: STRING
		do
			l_options := options_of_name (a_name)
			create l_result.make (l_options.count)
			create l_comp_list.make (l_options.count)
			l_comp_list.compare_objects
			if not l_options.is_empty then
				from l_options.start until l_options.after loop
					l_option := l_options.item
					if l_option.has_value then
						l_value := l_option.value
						if a_ignore_case then
							l_comp_value := l_value.as_lower
						else
							l_comp_value := l_value
						end
						if not l_comp_list.has (l_comp_value) then
							l_result.extend (l_value)
							l_comp_list.extend (l_comp_value)
						end
					end
					l_options.forth
				end
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
			result_contains_valid_items: not Result.there_exists (agent {STRING}.is_empty)
		end

	switch_of_name (a_name: READABLE_STRING_8): ARGUMENT_SWITCH
			-- Retrieves a argument switch using its textual name.
			--
			-- `a_name': The name of the switch to retrieve.
			-- `Result': The associated argument switch of Void if non could be found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_switch_a_name: has_switch (a_name)
		local
			l_switches: like available_switches
			l_cs: BOOLEAN
			l_cursor: CURSOR
			l_name: STRING
			l_match_name: STRING
			l_found: BOOLEAN
		do
			l_switches := available_switches
			l_cursor := l_switches.cursor

			l_cs := is_case_sensitive
			if l_cs then
				l_match_name := a_name
			else
				l_match_name := a_name.as_lower
			end
			from l_switches.start until l_switches.after or l_found loop
				if l_cs then
					l_name := l_switches.item.id
				else
					l_name := l_switches.item.lower_case_id
				end
				l_found := l_match_name ~ l_name
				if not l_found then
					l_switches.forth
				end
			end
			Result := l_switches.item
			l_switches.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
			available_switches_unmoved: available_switches.cursor ~ old available_switches.cursor
			result_is_requsted_switch: Result.id ~ a_name
		end

feature {NONE} -- Helpers

	frozen string_formatter: STRING_FORMATTER
			-- Access to a shared string formatter.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Basic Operations

	execute (a_action: PROCEDURE [detachable TUPLE])
			-- Main entry point, which parses the supplied command line arguments and then executes the
			-- supplied action if parsing an argument validation was successful.
			--
			-- `a_action': The action to call to start the application when the arguments have been parsed
			--             and validated.
		require
			a_action_attached: a_action /= Void
			not_has_executed: not has_executed
		local
			l_options: like option_values
		do
			parse_arguments

			if is_successful then
				if {PLATFORM}.is_windows and then not is_logo_information_suppressed then
					display_logo
				end

				if is_help_usage_displayed then
					display_usage
				else
					if has_switch (version_switch) and then has_option (version_switch) then
							-- Version information has been requested.
						display_version
					else
						l_options := option_values
						if option_values.is_empty and values.is_empty then
							execute_noop (a_action)
						else
							a_action.call (Void)
						end
					end
				end
			else
				if has_switch (nologo_switch) and then not is_logo_information_suppressed then
					display_logo
				end
				if is_usage_displayed_on_error then
					display_usage
				end
				display_errors
			end
			has_executed := True
		ensure
			has_executed: has_executed
		end

feature {NONE} -- Basic Operations

	execute_noop (a_action: PROCEDURE [detachable TUPLE])
			-- Executes an action when no arguments of any worth are passed.
			--
			-- `a_action': The action to call once the current parser has validated it can accept no
			--             arguments.
		require
			a_action_attached: a_action /= Void
			option_values_is_empty: option_values.is_empty and values.is_empty
		do
			if is_allowing_non_switched_arguments and is_non_switch_argument_required then
				display_usage
			else
				a_action.call (Void)
			end
		end

feature {NONE} -- Parsing

	frozen parse_arguments
			-- Parses command line arguments and sets `option_values' and `values'.
			-- Note: Upon and error `success' and `last_error_message' will be set.
		require
			not_has_parsed: not has_parsed
		local
			l_switches: like available_switches
			l_use_separated: like is_using_separated_switch_values
			l_last_switch: detachable ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_option: STRING
			l_value: detachable STRING
			l_switch: detachable ARGUMENT_SWITCH
			l_match_switch: detachable ARGUMENT_SWITCH
			l_prefixes: like switch_prefixes
			l_args: like arguments
			l_upper: INTEGER
			l_cs: like is_case_sensitive
			l_match: BOOLEAN
			l_options: like internal_option_values
			l_values: like internal_values
			l_err: BOOLEAN
			l_arg: STRING
			l_use_long_name: BOOLEAN
			l_stop_processing: BOOLEAN
			l_count: INTEGER
			i, j, k: INTEGER
		do
			internal_option_values.wipe_out
			internal_values.wipe_out

			l_options := internal_option_values
			l_values := internal_values

				-- Set parsed so we can access certain functions
			has_parsed := True

			l_args := arguments
			if l_args.count >= 1 then
				l_switches := available_switches
				l_prefixes := switch_prefixes
				l_cs := is_case_sensitive
				l_use_separated := is_using_separated_switch_values

					-- Iterate arguments
				from
					i := 1
					l_upper := l_args.count
				until i > l_upper loop
					check
						l_last_switch_unattached: not l_use_separated implies l_last_switch = Void
					end
					l_arg := l_args[i]
					if not l_stop_processing and then not l_arg.is_empty and then l_arg.count > 1 and then l_prefixes.has (l_arg.item (1)) then
						if l_arg.count > 2 and then l_prefixes.has (l_arg.item (2)) then
							l_option := l_arg.substring (3, l_arg.count)
							l_use_long_name := True
						else
							if l_arg.count = 2 and then l_arg.same_string_general ("--") then
									-- The user specified just a double switch qualifer (--), which means we ignore all future option processing.
								l_stop_processing := True
								l_option := l_arg
							else
								l_option := l_arg.substring (2, l_arg.count)
							end
							l_use_long_name := False
						end

							-- Indicates a switch option
						if not l_stop_processing then
							l_last_switch := Void
							if not l_option.is_empty then
								l_err := False
								l_value := Void

								if not l_use_separated then
									j := l_option.index_of (switch_value_qualifer, 1)
									if j > 0 then
										if j = 1 then
											add_template_error (e_invalid_switch_error, [ellipse_text (l_arg)])
											l_err := True
										else
											l_value := l_option.substring (j + 1, l_option.count)
											l_option := l_option.substring (1, j - 1)
										end
									end
								end

								if not l_err then
									if not l_cs then
										l_option.to_lower
									end

										-- Attempt to find a matching switch
									l_match_switch := Void
									l_match := False
									l_cursor := l_switches.cursor
									from l_switches.start until l_switches.after or l_match loop
										l_switch := l_switches.item
										if l_use_long_name then
											if l_cs then
												l_match := l_switch.long_name ~ l_option
											else
												l_match := l_switch.long_name.is_case_insensitive_equal (l_option)
											end
										else
											if l_cs then
												l_match := l_switch.name ~ l_option
											else
												l_match := l_switch.name.is_case_insensitive_equal (l_option)
											end
										end
										if l_match then
											l_match_switch := l_switch
										end
										l_switches.forth
									end

									if not l_match and not l_use_long_name then
											-- Check if switch is actually a list of concatenated short switches
										from
											k := 1
											l_count := l_option.count
										until
											k > l_count
										loop
											l_match := False
											from l_switches.start until l_switches.after or l_match loop
												l_switch := l_switches.item
												if l_switch.has_short_name then
													if l_cs then
														l_match := l_switch.short_name ~ l_option.item (k)
													else
														l_match := l_switch.short_name.as_lower ~ l_option.item (k)
													end
													if l_match and k < l_count then
															-- if matches and we are not processing the last item
														internal_option_values.extend (l_switch.new_option)
													end
												end

												l_switches.forth
											end
											k := k + 1
										end

										if l_match then
												-- Last item can be a value switch
											l_match_switch := l_switch
										end
									end
									l_switches.go_to (l_cursor)

									if l_match then
										if l_switch /= Void then
											if l_value /= Void and then not l_value.is_empty and then attached {ARGUMENT_VALUE_SWITCH} l_match_switch as l_value_switch then
												internal_option_values.extend (l_value_switch.new_value_option (l_value))
											else
													-- Create user option
												internal_option_values.extend (l_switch.new_option)
											end
										else
											check l_switch_attached: False end
										end
										if l_use_separated then
											l_last_switch := l_switch
										end
									else
										add_template_error (e_unrecognized_switch_error, [ellipse_text (l_arg)])
									end
								end
							else
								add_template_error (e_invalid_switch_error, [ellipse_text (l_arg)])
							end
						end
					else
						if attached {ARGUMENT_VALUE_SWITCH} l_last_switch as l_last_value_switch then
							check
								not_internal_option_values_is_empty: not internal_option_values.is_empty
								same_name: internal_option_values.last.switch.id ~ l_last_value_switch.id
							end
							internal_option_values.finish
							if l_arg /= Void and then not l_arg.is_empty then
								internal_option_values.replace (l_last_value_switch.new_value_option (l_arg))
							end
						else
							if not l_arg.is_empty then
									-- Create non-switched option
								internal_values.extend (l_arg)
							else
								add_template_error (e_invalid_switch_error, [ellipse_text (l_arg)])
							end
						end
						l_last_switch := Void
					end
					i := i + 1
				end
			end

			if is_successful then
				if not has_option (help_switch) then
					validate_arguments
					if is_successful then
						post_process_arguments
					end
				else
					is_help_usage_displayed := True
				end
			end
			has_parsed := is_successful
		ensure
			has_parsed: is_successful implies has_parsed
		end

feature {NONE} -- Post Processing

	post_process_arguments
			-- A chance to evaluate all set arguments for validity can conformance.
			-- Set an error if an switch or value does not adhear to any custom rules.
		require
			is_successful: is_successful
			has_parsed: has_parsed
		do
			is_logo_information_suppressed := (not has_switch (nologo_switch) or else has_option (nologo_switch)) or else has_option (version_switch)
			is_help_usage_displayed := has_option (help_switch)
		end

feature {NONE} -- Validation

	validate_arguments
			-- Validates arguments to ensure they are configured correctly.
		require
			has_parsed: has_parsed
		local
			l_switches: like available_switches
			l_options: detachable like options_of_name
			l_switch_groups: like switch_groups
			l_switch_appurtenances: like switch_dependencies
			l_cursor: CURSOR
			l_ocursor: CURSOR
			l_switch: ARGUMENT_SWITCH
			l_value: STRING
			l_validator: ARGUMENT_VALUE_VALIDATOR
			l_succ: BOOLEAN
		do
			l_switch_groups := switch_groups
			if not l_switch_groups.is_empty then
				l_switch_groups := valid_switch_groups
				if l_switch_groups.is_empty then
					add_error (e_switch_group_unrecognized_error)
				end
			end
			l_switch_appurtenances := switch_dependencies
			if not l_switch_appurtenances.is_empty then
				if not option_values.is_empty then
					validate_switch_appurtenances
				end
			end
			if not l_switch_groups.is_empty then
					-- Validate applicable non-switched arguments
				validate_non_switched_arguments (l_switch_groups)
			end

			l_switches := available_switches
			l_cursor := l_switches.cursor
			from l_switches.start until l_switches.after loop
				l_succ := True
				l_switch := l_switches.item
				if has_option (l_switch.id) then
					l_options := options_of_name (l_switch.id)
				else
					l_options := Void
				end

					-- Check optional
				if not l_switch.optional and then l_options = Void and then l_switch_groups.is_empty and l_switch_appurtenances.is_empty then
					add_template_error (e_missing_switch_error, [l_switch.name])
				elseif l_options /= Void and then not l_options.is_empty then
						-- Check multiple
					if not l_switch.allow_multiple and l_options.count > 1 then
						add_template_error (e_multiple_switch_error, [l_switch.name])
					end

					l_ocursor := l_options.cursor

					if attached {ARGUMENT_VALUE_SWITCH} l_switch as l_val_switch then
						if not l_val_switch.is_value_optional then
								-- Check argument exists
							from l_options.start until l_options.after loop
								if not l_options.item.has_value then
									add_template_error (e_require_switch_value, [l_val_switch.name, l_val_switch.arg_name])
									l_succ := False
								end
								l_options.forth
							end
						end
						if l_succ then
								-- Check argument is valid
							l_validator := l_val_switch.value_validator
							from l_options.start until l_options.after loop
								if not l_val_switch.is_value_optional then
									l_value := l_options.item.value
									l_validator.validate (l_value)
									if not l_validator.is_option_valid then
										add_template_error (e_invalid_switch_value_with_reason, [ellipse_text (l_value), l_switch.name, l_validator.reason])
									end
								end
								l_options.forth
							end
						end
					else

							-- Check regular switches do not have values
						from l_options.start until l_options.after loop
							if l_options.item.has_value then
								add_template_error (e_non_value_switch, [l_switch.name])
							end
							l_options.forth
						end
					end
					l_options.go_to (l_ocursor)
				end
				l_switches.forth
			end
			l_switches.go_to (l_cursor)
		ensure
			switches_unmoved: available_switches.cursor ~ old available_switches.cursor
			option_values_unmoved: option_values.cursor ~ old option_values.cursor
			values_unmoved: values.cursor ~ old values.cursor
		end

	validate_non_switched_arguments (a_groups: LIST [ARGUMENT_GROUP])
			-- Validates non-switched arguments for groups.
			--
			-- `a_groups': The group of arguments to validate.
		require
			a_groups_attached: a_groups /= Void
			a_groups_contains_attached_items: assertions.sequence_contains_attached_items (a_groups)
			has_parsed: has_parsed
		local
			l_validator: like non_switched_argument_validator
			l_values: like values
			l_cursor: CURSOR
		do
			l_values := values
			if not l_values.is_empty then
				if not is_allowing_non_switched_arguments then
					add_error (e_non_switched_argument_specified_error)
				end
				if is_allowing_non_switched_arguments then
					l_validator := non_switched_argument_validator
					if l_validator /= Void then
						l_cursor := l_values.cursor
						from l_values.start until l_values.after loop
							l_validator.validate (l_values.item)
							if not l_validator.is_option_valid then
								add_template_error (e_invalid_non_switched_value_with_reason, [l_values.item, l_validator.reason])
							end
							l_values.forth
						end
						l_values.go_to (l_cursor)
					end
				end
			end
		ensure
			values_unmoved: values.cursor ~ old values.cursor
		end

	validate_switch_appurtenances
			-- Validate all switch appurtenances to ensure a specified switch has all its dependencies.
		require
			has_parsed: has_parsed
			not_option_values_is_empty: not option_values.is_empty
		local
			l_dependencies: like switch_dependencies
			l_switch: ARGUMENT_SWITCH
			l_options: like option_values
			l_option: ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_upper, i: INTEGER
		do
			l_dependencies := switch_dependencies
			l_options := option_values

			l_cursor := l_options.cursor
			from l_options.start until l_options.after loop
				l_option := l_options.item.switch
				if l_dependencies.has (l_option) then
					if attached l_dependencies [l_option] as l_switches then
						from
							i := l_switches.lower
							l_upper := l_switches.upper
						until
							i > l_upper
						loop
							l_switch := l_switches [i]
							if not l_switch.optional then
								if not l_switch.is_special and then not has_option (l_switch.id) then
									add_template_error (e_missing_switch_dependency_error, [l_option.name, l_switch.name])
								end
							end
							i := i + 1
						end
					else
						check l_dependencies_has_l_option: True end
					end
				end
				l_options.forth
			end
			l_options.go_to (l_cursor)
		ensure
			switch_dependencies_unmoved: switch_dependencies.cursor ~ old switch_dependencies.cursor
			option_values_unmoved: option_values.cursor ~ old option_values.cursor
		end

	frozen valid_switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Validate all switch groups to ensure argument configuration is correct.
			-- Note: Only switches are checked. This is to ensure full errors can be reported
			--       regarding non-switched arguments.
		require
			has_parsed: has_parsed
			switch_groups_attached: switch_groups /= Void
		local
			l_extend_groups: like expanded_switch_groups
			l_options: like option_values
			l_switch: ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_valid: BOOLEAN
			l_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
		do
			l_extend_groups := expanded_switch_groups.twin

				-- Check specified switches for a valid group match
			l_options := option_values
			l_cursor := l_options.cursor
			from l_options.start until l_options.after loop
				from l_extend_groups.start until l_extend_groups.is_empty or l_extend_groups.after loop
					l_switch := l_options.item.switch
					if not l_switch.is_special and then not l_extend_groups.item.switches.has (l_switch) then
						l_extend_groups.remove
					else
						l_extend_groups.forth
					end
				end
				l_options.forth
			end
			l_options.go_to (l_cursor)

			if not l_extend_groups.is_empty then
					-- Check optional
				from l_extend_groups.start until l_extend_groups.after loop
					from
						l_switches := l_extend_groups.item.switches
						l_cursor := l_switches.cursor
						l_switches.start
						l_valid := True
					until
						l_switches.after or not l_valid
					loop
						l_switch := l_switches.item_for_iteration
						if l_switch /= Void then
							l_valid := l_switch.optional or else has_option (l_switch.id)
						end
						l_switches.forth
					end
					if not l_valid then
						l_extend_groups.remove
					else
						l_extend_groups.forth
					end
				end
			end

			Result := l_extend_groups
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

	frozen expanded_switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Expanded set of switch groups based on `switch_groups' and `switch_appurtenances'.
		require
			has_parsed: has_parsed
			switch_groups_attached: switch_groups /= Void
		local
			l_groups: detachable like switch_groups
			l_cursor: CURSOR
		do
				-- Create extend switch groups
			l_groups := switch_groups
			if l_groups /= Void then
				create Result.make (l_groups.count)
				l_cursor := l_groups.cursor
				from l_groups.start until l_groups.after loop
					Result.extend (expand_switch_group (l_groups.item))
					l_groups.forth
				end
				l_groups.go_to (l_cursor)
				check
					matching_counts: Result.count = l_groups.count
				end
			else
				create Result.make (0)
			end
		ensure
			result_attached: Result /= Void
			result_contains_attahced_items: assertions.sequence_contains_attached_items (Result)
			result_count_equal: Result.count = switch_groups.count
			switch_groups_unmoved: switch_groups.cursor ~ old switch_groups.cursor
		end

	frozen expand_switch_group (a_group: ARGUMENT_GROUP): ARGUMENT_GROUP
			-- Expands a group of switch `a_group' to include any item associated appurtenance switches.
			--
			-- `a_group': A group to expand.
			-- `Result': The expanded group of switches.
		require
			a_group_attached: a_group /= Void
		local
			l_group_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			l_switch_dependencies: like switch_dependencies
			l_switch: ARGUMENT_SWITCH
			l_upper, i: INTEGER
		do
			l_group_switches := a_group.switches.twin
			l_switch_dependencies := switch_dependencies
			if not l_switch_dependencies.is_empty then
				from l_group_switches.start until l_group_switches.after loop
					l_switch := l_group_switches.item
					if attached l_switch_dependencies [l_switch] as l_appurtenances then
						from
							i := l_appurtenances.lower
							l_upper := l_appurtenances.upper
						until
							i > l_upper
						loop
							l_switch := l_appurtenances[i]
							if not l_group_switches.has (l_switch) then
								l_group_switches.extend (l_switch)
								check
									not_l_group_switches_after: not l_group_switches.after
								end
							end
							i := i + 1
						end
					end
					l_group_switches.forth
				end
			end

			if a_group.is_hidden then
				create Result.make (l_group_switches, a_group.is_allowing_non_switched_arguments)
			else
				create Result.make_hidden (l_group_switches, a_group.is_allowing_non_switched_arguments)
			end
		ensure
			result_attached: Result /= Void
			result_is_allowing_non_switched_arguments: Result.is_allowing_non_switched_arguments = a_group.is_allowing_non_switched_arguments
		end

feature {NONE} -- Error Handling

	add_error (a_msg: READABLE_STRING_GENERAL)
			-- Adds a parse error.
			--
			-- `a_msg': The message to log as an error.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			error_messages.extend (a_msg.as_string_8)
		ensure
			error_messages_extended: error_messages.has (a_msg.as_string_8)
		end

	add_template_error (a_tmpl: READABLE_STRING_GENERAL; a_contexts: TUPLE)
			-- Adds a parse error base on a template specification.
			-- Note: See {STRING_FORMATTER}.`format'.
			--
			-- `a_tmpl': A template message to log as an error.
			-- `a_contexts': A list of arguments to use to replace the token in the template.
		require
			a_tmpl_attached: a_tmpl /= Void
			not_a_tmpl_is_empty: not a_tmpl.is_empty
			a_contexts_attached: a_contexts /= Void
			not_a_contexts_is_empty: not a_contexts.is_empty
		do
			add_error ((create {STRING_FORMATTER}).format (a_tmpl, a_contexts))
		ensure
			error_messages_extended: error_messages.count = old error_messages.count + 1
		end

feature {NONE} -- Output

	display_usage
			-- Displays usage information.
		local
			l_cfgs: like command_option_configurations
			l_ext: like extended_usage
			l_name: like system_name
			l_cfg: STRING
			l_cursor: CURSOR
		do
			l_name := system_name
			io.put_string (once "USAGE: %N")

			l_cfgs := command_option_configurations
			if not l_cfgs.is_empty then
				l_cursor := l_cfgs.cursor
				from l_cfgs.start until l_cfgs.after loop
					io.put_string (tab_string)
					io.put_string (l_name)
					io.put_character (' ')
					l_cfg := l_cfgs.item
					l_cfg.replace_substring_all ("%N", "%N" + create {STRING}.make_filled (' ', l_name.count + 1))
					io.put_string (l_cfg)
					if not l_cfgs.islast then
						io.new_line
					end
					l_cfgs.forth
				end
				l_cfgs.go_to (l_cursor)
			else
				io.put_string (tab_string)
				io.put_string (l_name)
			end

			if has_visible_available_options then
				io.new_line
				display_options
			end

				-- List the extended usage.
			l_ext := extended_usage
			if not l_ext.is_empty then
				io.new_line
				io.put_string (l_ext)
			end
			io.new_line
		end

	display_logo
			-- Displays copyright information.
		do
			io.put_string (name)
			io.put_string (" - Version: ")
			io.put_string (version)
			if not copyright.is_empty then
				io.new_line
				io.put_string (copyright)
			end
			io.new_line
			io.new_line
		end

	display_version
			-- Displays version information
		do
				-- Only display the version information if it was not already displayed			
			io.put_string (name)
			io.put_string (" version ")
			io.put_string (version)
			if not copyright.is_empty then
				io.new_line
				io.put_string (copyright)
			end
			io.new_line
		end

	display_errors
			-- Displays any parse/validation related error messages.
		require
			not_is_successful: not is_successful
		local
			l_errors: like error_messages
			l_cursor: CURSOR
			l_error: STRING
			l_tab_string: STRING
		do
			create l_tab_string.make (10)
			l_tab_string.append ("%N")
			l_tab_string.append (tab_string)
			l_tab_string.append ("  ")

			l_errors := error_messages
			l_cursor := l_errors.cursor
			io.error.put_string (string_formatter.format ("{1} error(s) occurred.%N", [error_messages.count]))
			from l_errors.start until l_errors.after loop
				io.error.put_string (tab_string)
				io.error.put_string ("> ")

				l_error := format_terminal_text (l_errors.item, tab_string.count.as_natural_8 + 2)
				io.error.put_string (l_error)
				io.error.new_line
				l_errors.forth
			end
			l_errors.go_to (l_cursor)
			io.error.new_line
		ensure
			error_messages_unmoved: error_messages.cursor ~ old error_messages.cursor
		end

	display_options
			-- Displays configurable options.
		require
			has_visible_available_options: has_visible_available_options
		local
			l_prefixes: like switch_prefixes
			l_prefix: STRING
			l_def_prefix: CHARACTER
			l_cursor: CURSOR
			l_switches: like available_switches
			l_switch: ARGUMENT_SWITCH
			l_value_switch: ARGUMENT_VALUE_SWITCH
			l_value_switches: ARRAYED_LIST [ARGUMENT_VALUE_SWITCH]
			l_padding: INTEGER
			l_max_len: INTEGER
			l_name: STRING
			l_arg_name: STRING
			l_desc: STRING
			l_arg_desc: STRING
			l_added_args: ARRAYED_LIST [STRING]
			l_inline_args: like is_showing_argument_usage_inline
			l_count: INTEGER
			i: INTEGER
		do
			io.put_string ("%NOPTIONS:%N")

			create l_value_switches.make (0)

				-- Output prefix option qualifiers
			l_prefixes := switch_prefixes
			l_def_prefix := l_prefixes[1]
			if l_prefixes.count > 1 then
				create l_prefix.make ((l_prefixes.count * 5) + 2)
				from
					i := l_prefixes.lower
					l_count := l_prefixes.upper
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
				io.put_string (tab_string)
				io.put_string ("Options ")
				if is_case_sensitive then
					io.put_string ("are case-sensitive and ")
				end
				io.put_string ("should be prefixed with: ")
				io.put_string (l_prefix)
				io.new_line
				io.new_line
			end

			l_switches := available_visible_switches

				-- Retrieve option max length for alignment
			l_cursor := l_switches.cursor
			from l_switches.start until l_switches.after loop
				l_switch := l_switches.item
				if not l_switch.is_hidden then
					if is_using_unix_switch_style or else l_switch.has_short_name then
						l_max_len := l_max_len.max (l_switch.long_name.count + 5)
					else
						l_max_len := l_max_len.max (l_switch.long_name.count + 1)
					end
				end
				l_switches.forth
			end

			l_inline_args := is_showing_argument_usage_inline

				-- Output available options			
			from l_switches.start until l_switches.after loop
				l_switch := l_switches.item
				if attached {ARGUMENT_VALUE_SWITCH} l_switch as l_value_switch_1 then
					l_value_switches.extend (l_value_switch_1)
				end

				if l_switch.has_short_name then
					l_arg_name := l_def_prefix.out + l_switch.short_name.out + " " + l_def_prefix.out + l_def_prefix.out + l_switch.long_name
				elseif is_using_unix_switch_style then
					l_arg_name := "   " + l_def_prefix.out + l_def_prefix.out + l_switch.long_name
				else
					l_arg_name := l_def_prefix.out + l_switch.long_name
				end
				if l_max_len > l_arg_name.count then
					create l_name.make_filled (' ', l_max_len - l_arg_name.count)
				else
					create l_name.make_empty
				end
				l_name.insert_string (l_arg_name, 1)

				create l_desc.make (256)
				l_desc.append (l_switch.description)
				if l_switch.optional then
					l_desc.append (once " (Optional)")
				end
				l_padding := l_name.count + tab_string.count + 2
				l_desc := format_terminal_text (l_desc, l_padding.as_natural_8)
				if l_inline_args and then attached {ARGUMENT_VALUE_SWITCH} l_switch as l_value_switch_2 then
					l_arg_name := l_value_switch_2.arg_name
					l_desc.append_character ('%N')
					l_desc.append (create {STRING}.make_filled (' ', l_padding))
					l_desc.append_character ('<')
					l_desc.append (l_arg_name)
					l_desc.append (once ">: ")
					create l_arg_desc.make (32)
					if l_value_switch_2.is_value_optional then
						l_arg_desc.append (once "(Optional) ")
					end
					l_arg_desc.append (l_value_switch_2.arg_description)
					l_arg_desc := format_terminal_text (l_arg_desc, (l_padding + l_arg_name.count + 4).as_natural_8)
					l_desc.append (l_arg_desc)
				end

				io.put_string (tab_string)
				io.put_string (l_name)
				io.put_string (once ": ")
				io.put_string (l_desc)
				io.new_line
				l_switches.forth
			end
			l_switches.go_to (l_cursor)

			if not l_inline_args and then not l_value_switches.is_empty then
				io.put_string ("%NARGUMENTS:%N")

				create l_added_args.make (l_value_switches.count)
				l_added_args.compare_objects

				l_max_len := 0
				from l_value_switches.start until l_value_switches.after loop
					l_name := l_value_switches.item.arg_name
					l_max_len := l_max_len.max (l_name.count)
					l_value_switches.forth
				end

				from l_value_switches.start until l_value_switches.after loop
					l_value_switch := l_value_switches.item

					l_arg_name := l_value_switch.arg_name
					if not l_added_args.has (l_arg_name) then
						if l_max_len > l_arg_name.count then
							create l_name.make_filled (' ', l_max_len - l_arg_name.count)
						else
							create l_name.make_empty
						end
						l_name.insert_character ('<', 1)
						l_name.insert_string (l_arg_name, 2)
						l_name.insert_character ('>', l_arg_name.count + 2)

						l_desc := format_terminal_text (l_value_switch.arg_description, (l_arg_name.count + tab_string.count + 4).as_natural_8)
						io.put_string (tab_string)
						io.put_string (l_name)
						io.put_string (once ": ")
						io.put_string (l_desc)
						io.new_line

						l_added_args.extend (l_arg_name)
					end
					l_value_switches.forth
				end
			end
		end

feature {NONE} -- Usage

	name: STRING
			-- Full name of application.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	version: STRING
			-- Version number of application.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	copyright: STRING
			-- Copyright information.
			-- Not used if empty.
		deferred
		ensure
			result_attached: Result /= Void
		end

	frozen command_option_configurations: ARRAYED_LIST [STRING]
			-- Command line option configuration string (to display in usage).
		local
			l_groups: like switch_groups
			l_group: ARGUMENT_GROUP
			l_cfg: like command_option_group_configuration
			l_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			l_switch: ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_empty_groups: BOOLEAN
		once
			create Result.make (10)
			Result.compare_objects

			l_groups := switch_groups
			l_empty_groups := l_groups.is_empty
			if not l_empty_groups then
				l_empty_groups := l_groups.for_all (agent {ARGUMENT_GROUP}.is_hidden)
			end
			if l_empty_groups then
				l_switches := available_visible_switches
				l_cfg := command_option_group_configuration (l_switches, is_allowing_non_switched_arguments, is_non_switch_argument_required, True, l_switches)
				if not l_cfg.is_empty then
					Result.extend (l_cfg)
				end
			else
				Result.resize (1024)
				l_cursor := l_groups.cursor
				from l_groups.start until l_groups.after loop
					l_group := l_groups.item
					if not l_group.is_hidden then
						l_switches := l_group.switches
							-- Add nologo switch, if not already added

						if has_switch (nologo_switch) then
								-- Extend the nologo switch to all groups, for force validation when used
							l_switch := switch_of_name (nologo_switch)
							if not l_switches.has (l_switch) then
								l_switches.extend (l_switch)
							end
						end

						l_cfg := command_option_group_configuration (l_switches, is_allowing_non_switched_arguments and l_group.is_allowing_non_switched_arguments, True, True, l_switches)
						if not l_cfg.is_empty and then not Result.has (l_cfg) then
								-- With exclusion of hidden options command line groups may look the same.
							Result.extend (l_cfg)
						end
					end
					l_groups.forth
				end
				l_groups.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
			result_contains_valid_items: not Result.there_exists (agent {STRING}.is_empty)
			available_switches_unmoved: available_switches.cursor ~ old available_switches.cursor
			switch_groups_unmoved: switch_groups.cursor ~ old switch_groups.cursor
		end

	command_option_group_configuration (a_group: LIST [ARGUMENT_SWITCH]; a_show_non_switch: BOOLEAN; a_non_switch_required: BOOLEAN; a_add_appurtenances: BOOLEAN; a_src_group: LIST [ARGUMENT_SWITCH]): STRING
			-- Command line option configuration string (to display in usage) for a specific group of options.
		require
			a_group_attached: a_group /= Void
			a_group_contains_attached_items: assertions.sequence_contains_attached_items (a_group)
			a_src_group_attached: a_src_group /= Void
			a_group_equals_a_src_group: a_add_appurtenances implies a_group = a_src_group
			a_src_group_contains_attached_items: assertions.sequence_contains_attached_items (a_src_group)
		local
			l_dependencies: like switch_dependencies
			l_dependent_list: ARRAYED_LIST [ARGUMENT_SWITCH]
			l_use_separated: like is_using_separated_switch_values
			l_verbose: BOOLEAN
			l_unix_style: BOOLEAN
			l_cursor: CURSOR
			l_switch: ARGUMENT_SWITCH
			l_cfg: like command_option_group_configuration
			l_prefix: CHARACTER
			l_opt: BOOLEAN
			l_opt_val: BOOLEAN
			l_add_switch: BOOLEAN
			i, l_upper: INTEGER
		do
			if not a_group.is_empty then
				l_dependencies := switch_dependencies
				l_prefix := switch_prefixes[1]
				l_use_separated := is_using_separated_switch_values
				l_verbose := is_usage_verbose
				l_unix_style := is_using_unix_switch_style
				create Result.make  (a_group.count * 12)

				l_cursor := a_group.cursor
				from a_group.start until a_group.after loop
					l_switch := a_group.item
					l_opt := l_switch.optional
					if l_switch.id /~ help_switch and not l_switch.is_hidden then
						l_add_switch := not a_add_appurtenances implies (not a_src_group.has (l_switch) or l_switch.optional)
						if l_add_switch then
							if l_opt then
								Result.append_character ('[')
							end
							Result.append_character (l_prefix)
							if l_verbose then
								if l_unix_style then
									Result.append_character (l_prefix)
								end
								Result.append (l_switch.long_name)
							else
								Result.append (l_switch.name)
							end

							if attached {ARGUMENT_VALUE_SWITCH} l_switch as l_val_switch then
								l_opt_val := l_val_switch.is_value_optional
								if l_opt_val then
									Result.append_character ('[')
								end
								if l_use_separated then
									Result.append (" <")
								else
									Result.append_character (switch_value_qualifer)
									Result.append_character ('<')
								end
								Result.append (l_val_switch.arg_name)
								Result.append_character ('>')
								if l_opt_val then
									Result.append_character (']')
								end
							end
								-- Add appurenances switches
							if
								l_dependencies /= Void and then
								l_dependencies.has (l_switch)
							then
								if attached l_dependencies [l_switch] as l_dependent_switches then
									if not l_dependent_switches.is_empty then
										create l_dependent_list.make (l_dependent_switches.count)
										from
											i := 1
											l_upper := l_dependent_switches.upper
										until
											i > l_upper
										loop
											if attached l_dependent_switches.item (i) as l_dependency then
												l_dependent_list.extend (l_dependency)
											end
											i := i + 1
										end

										l_cfg := command_option_group_configuration (l_dependent_list, False, False, False, a_src_group)
										if not l_cfg.is_empty then
											Result.append_character (' ')
											Result.append (l_cfg)
										end
									end
								else
									check l_dependencies_has_l_switch: False end
								end
							end
							if l_switch.allow_multiple then
								Result.append (" [")
								Result.append_character (l_prefix)
								Result.append (l_switch.name)
								Result.append ("...]")
							end
							if l_opt then
								Result.append_character (']')
							end
							if not a_group.islast then
								Result.append_character (' ')
							end
						end

					end
					a_group.forth
				end
				a_group.go_to (l_cursor)
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
			a_group_unmoved: a_group.cursor ~ old a_group.cursor
		end

	frozen format_terminal_text (a_text: STRING; a_left_padding: NATURAL_8): STRING
			-- Formats the text for display on a terminal so that it is correctly wrapped..
			--
			-- `a_text': The text to format.
			-- `a_left_padding': Padding, in columns, the description will be indented by.
			-- `Result': A formatted text to fit the terminal.
		require
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
		local
			l_columns: INTEGER
			l_lines: LIST [STRING]
			l_padding: STRING
			i: INTEGER
		do
			l_lines := a_text.split ('%N')
			l_columns := max_columns.as_integer_32 - a_left_padding

				-- The lines need to be justified.
			create l_padding.make_filled (' ', a_left_padding)
			create Result.make (a_text.count + (l_lines.count * (a_left_padding + 1)))
			from l_lines.start until l_lines.after loop
				if attached l_lines.item as l_line then
					if not Result.is_empty then
						Result.append_character ('%N')
						Result.append (l_padding)
					end

					if l_line.count > l_columns then
							-- The line is too long, trim it
						from
							i := l_line.count.min (l_columns)
						until
							i = 0 or else l_line.item (i).is_space or else l_line.item (i) = '-'
						loop
							i := i - 1
						end
						if i = 0 then
								-- No whitespace found.
							i := l_columns
						end

						Result.append (l_line.substring (1, i))
						l_line.keep_tail (l_line.count - i)
						l_line.left_adjust
					else
							-- The line is within the maximum bounds.
						Result.append (l_line)
						l_line.wipe_out
					end
					if l_line.is_empty then
						l_lines.forth
					end
				else
					l_lines.forth
				end
			end

		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	extended_usage: STRING
			-- Retrieces extended configuration information.
			--|Redefine in subclass.
		once
			create Result.make_empty
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Switches

	nologo_switch: STRING
			-- Supress copyright information switch.
		once
			Result := "nologo"
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ nologo_switch
		end

	help_switch: STRING
			-- Display usage information switch.
		once
			if is_using_unix_switch_style then
				if {PLATFORM}.is_windows then
					Result := "?|help"
				else
					Result := "h|help"
				end
			else
				if {PLATFORM}.is_windows then
					Result := "?"
				else
					Result := "help"
				end
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ help_switch
		end

	version_switch: STRING
			-- Version information switch.
		once
			if is_using_unix_switch_style then
				Result := "v|version"
			else
				Result := "version"
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result ~ version_switch
		end

	available_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of available switch.
		local
			l_switches: like switches
			l_switch: ARGUMENT_SWITCH
		once
			l_switches := switches
			if l_switches /= Void then
				create Result.make (3 + l_switches.count)
				Result.append (l_switches)
			else
				create Result.make (3)
			end

			create l_switch.make (help_switch, "Display usage information.", True, False)
			l_switch.set_is_special
			Result.extend (l_switch)

			if is_using_builtin_switches then
				create l_switch.make (version_switch, "Displays version information.", True, False)
				l_switch.set_is_special
				Result.extend (l_switch)
				if {PLATFORM}.is_windows then
					create l_switch.make (nologo_switch, "Supresses copyright information.", True, False)
					l_switch.set_is_special
					Result.extend (l_switch)
				end
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = available_switches

			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

	frozen available_visible_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of available visible (not hidden) switch.
		local
			l_switches: like available_switches
			l_switch: ARGUMENT_SWITCH
			l_cursor: CURSOR
		once
			if has_available_options then
				l_switches := available_switches
				create Result.make (l_switches.count)
				l_cursor := l_switches.cursor
				from l_switches.start until l_switches.after loop
					l_switch := l_switches.item
					if not l_switch.is_hidden then
						Result.extend (l_switch)
					end
					l_switches.forth
				end
				l_switches.go_to (l_cursor)
			else
				create Result.make (0)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = available_visible_switches

			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a set of switch used for a specific application.
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
			result_consistent: Result = switches
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Valid switch grouping.
		once
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result)
			result_consistent: Result = switch_groups
		end

	switch_dependencies: HASH_TABLE [ARRAY [ARGUMENT_SWITCH], ARGUMENT_SWITCH]
			-- Switch appurtenances (dependencies).
			-- Note: Switch appurtenances are implictly added to a group where a switch is present.
		once
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_contains_attached_keys: assertions.array_contains_attached_items (Result.current_keys)
			result_contains_attached_items: assertions.sequence_contains_attached_items (Result.linear_representation)
			result_consistent: Result = switch_dependencies
		end

feature {NONE} -- Temporary

	frozen assertions: attached ASSERTION_HELPER
			-- Temporary
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Formatting

	frozen ellipse_text (a_str: READABLE_STRING_8): STRING
			-- Ellipses a string if it exceeds `ellipse_threshold' in length.
			--
			-- `a_str': The original string to ellipse.
			-- `Result': The ellipses string.
		require
			a_str_attached: a_str /= Void
		do
			if not a_str.is_empty then
				Result := string_formatter.ellipse (a_str, ellipse_threshold)
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not a_str.is_empty implies not Result.is_empty
			result_ellipsed: Result.count <= ellipse_threshold
		end

	ellipse_threshold: NATURAL_8 = 255
			-- Maximum number of characters before ellipses (...) are used
			-- to trim a region of text.

feature {NONE} -- Factory

	new_argument_source: ARGUMENT_SOURCE
			-- Creates a new default argument source object for the parser
		do
			create {ARGUMENT_TERMINAL_SOURCE} Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	switch_prefixes: ARRAY [CHARACTER]
			-- Prefixes used to indicate a command line switch.
		once
			if {PLATFORM}.is_windows then
				Result := <<'-', '/'>>
			else
				Result := <<'-'>>
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_printable_items: Result.for_all (agent (ia_item: CHARACTER): BOOLEAN
				do
					Result := ia_item.is_printable
				end)
		end

	switch_value_qualifer: CHARACTER
			-- Character used to separate an switch from it's value.
		require
			not_is_using_separated_switch_values: not is_using_separated_switch_values
		once
			Result := ':'
		ensure
			result_is_printable: Result.is_printable
			result_not_is_id_character: not Result.is_alpha_numeric and Result /= '_'
		end

	default_system_name: STRING = "app"
			-- Default application name.

	tab_string: STRING = "   "
			-- Tab indent string.

feature {NONE} -- Internationalization

	e_invalid_switch_error: STRING = "The switch '{1}' is invalid."
	e_unrecognized_switch_error: STRING = "Unrecognized switch '{1}'."
	e_invalid_switch_value: STRING = "'{1}' is an invalid option for switch '{2}'."
	e_require_switch_value: STRING = "Switch '{1}' requires a paired value '{2}'."
	e_multiple_switch_error: STRING = "Switch '{1}' can only be used once."
	e_non_value_switch: STRING = "Switch '{1}' should not have any value paired with it."
	e_missing_switch_error: STRING = "Switch '{1}' was not specified."
	e_non_switched_argument_specified_error: STRING = "Arguments without a switch prefix are not valid arguments."
	e_multiple_non_switched_argument_specified_error: STRING = "Only one argument without a switch prefix can be passed."
	e_switch_group_unrecognized_error: STRING = "The specified switches are not in a valid configuration."
	e_missing_switch_dependency_error: STRING = "Switch '{1}' require the switch '{2}' be specified also."
	e_invalid_switch_value_with_reason: STRING = "'{1}' is an invalid option for switch '{2}'.%N{3}"
	e_invalid_non_switched_value_with_reason: STRING = "'{1}' is an invalid option.%N{2}"

	e_unreconized_switch_error: STRING
		obsolete
			"Use e_unrecognized_switch_error which corrects the typo [2017-05-31]"
		once
			Result := e_unrecognized_switch_error
		end

	e_switch_group_unreconized_error: STRING
		obsolete
			"Use e_switch_group_unrecognized_error which corrects the typo [2017-05-31]"
		once
			Result := e_switch_group_unrecognized_error
		end

feature {NONE} -- Implementation: Query

	internal_option_of_name (a_name: READABLE_STRING_8): detachable ARGUMENT_OPTION
			-- Retrieves the first switch-qualified option, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve an options for.
			-- `Result': An option passed via the command line or Void if the switch option was not found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: like option_values
			l_cursor: CURSOR
			l_cs: like is_case_sensitive
			l_opt: ARGUMENT_OPTION
			l_equal: BOOLEAN
		do
			l_options := option_values
			if not l_options.is_empty then
				l_cs := is_case_sensitive
				l_cursor := l_options.cursor
				from l_options.start until l_options.after or Result /= Void loop
					l_opt := l_options.item
					if l_cs then
						l_equal := a_name ~ l_opt.switch.id
					else
						l_equal := a_name.is_case_insensitive_equal (l_opt.switch.id)
					end
					if l_equal then
						Result := l_opt
					end
					l_options.forth
				end
				l_options.go_to (l_cursor)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_option_values: ARRAYED_LIST [ARGUMENT_OPTION]
			-- Mutable, unprotected verion of `option_values'

	internal_values: ARRAYED_LIST [STRING]
			-- Mutable, unprotected version of `values'

	internal_argument_source: detachable like argument_source
			-- Cached version of `arugment_source'.
			-- Note: Do not use directly!

invariant
	not_is_non_switch_argument_required: not is_allowing_non_switched_arguments implies not is_non_switch_argument_required
	is_successful_means_has_parsed: is_successful implies has_parsed

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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

end

