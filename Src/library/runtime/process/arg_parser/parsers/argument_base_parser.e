note
	description: "A base argument parser for simple application command line argument configurations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARGUMENT_BASE_PARSER

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
			-- Initializes the default settings for the argument parser.
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

	frozen application_base: PATH
			-- The base location of application.
		do
			Result := argument_source.application_base
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen values: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- List of arguments values that were not qualified with a switch (aka loose arguments).
		do
			Result := internal_values
		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: ∀ l_c: Result ¦ not l_c.is_empty
		end

	frozen option_values: LIST [ARGUMENT_OPTION]
			-- Option values parsed via command line, these do not include the loose arguments. See `values'.
		do
			Result := internal_option_values
		ensure
			result_attached: Result /= Void
		end

	frozen error_messages: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Any error messages generated during parse and validation, if any.
		once
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: ∀ l_c: Result ¦ not l_c.is_empty
		end

feature {NONE} -- Access

	frozen system_name: IMMUTABLE_STRING_32
			-- Retrieves system executable name.
		do
			if attached argument_source.application.entry as l_entry then
				Result := l_entry.name
			else
				Result := default_system_name
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	sub_system_name: detachable IMMUTABLE_STRING_32
			-- Sub system name.
			--| this can be used in relation with ARGUMENT_STRING_SOURCE for instance
			--| when the real usage is  `system_name foobar' and the rest `...'
			--| and not only `system_name ...' then `sub_system_name' is `foobar'
		do
		end

	frozen arguments: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- The list of actual arguments, which takes into account compounded arguments when using
			-- Unix-style switches.
			-- Compunded switches are those single character switches, when `is_using_unix_switch_style' is True,
			-- that are joined, such as -abcde, where a, b, c, d and e are switches.
		local
			l_args: ARRAYED_LIST [IMMUTABLE_STRING_32]
			l_arg: IMMUTABLE_STRING_32
			l_next_arg: detachable STRING_32
			l_prefixes: like switch_prefixes
			l_use_separated_switched: BOOLEAN
			j, nb: INTEGER
		do
			if is_using_unix_switch_style then
					-- When using the Unix style switch we can uss
				l_args := argument_source.arguments
				create Result.make (l_args.count)

				l_prefixes := switch_prefixes
				l_use_separated_switched := is_using_separated_switch_values
				across
					l_args as a
				loop
					l_arg := a
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

								if
									not l_use_separated_switched and then
										-- We have to peek to ensure if switch value qualified that the last switch is associated
										-- with the value.
									j < nb and then
										-- Peek, because there is space.
									l_arg.item (j + 1) = switch_value_qualifer
								then
									create l_next_arg.make (1 + (nb - j))
									l_next_arg.append_character (l_prefixes [1])
									l_next_arg.append (l_arg.substring (j, l_arg.count))

										-- Exit loop
									j := nb
								end

								if
									l_next_arg = Void and then
										-- There was no added argument.
									(l_use_separated_switched or else l_arg [j] /= switch_value_qualifer)
								then
									create l_next_arg.make (2)
									l_next_arg.append_character (l_prefixes [1])
									l_next_arg.append_character (l_arg [j])
								end

								if l_next_arg /= Void then
									Result.extend (l_next_arg)
								end

								j := j + 1
							end
						else
							Result.extend (l_arg)
						end
					else
						Result.extend (l_arg)
					end
				end
			else
				Result := argument_source.arguments
			end
		ensure
			result_attached: Result /= Void
		end

	frozen argument_source: ARGUMENT_SOURCE assign set_argument_source
			-- Access to the arguments via a source object.
		do
			Result := internal_argument_source
			if not attached Result then
				Result := new_argument_source
				internal_argument_source := Result
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
			-- Maximum columns to display in the terminal.
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
			-- qualified using a ':' (by default).

	is_showing_argument_usage_inline: BOOLEAN assign set_is_showing_argument_usage_inline
			-- Indiciate if argument switch value descriptions should be shown inline
			-- with the argument description.

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

	frozen has_option (a_name: READABLE_STRING_GENERAL): BOOLEAN
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

	is_character_printable (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' printable?
		do
			Result := not a_char.is_character_8 or else a_char.to_character_8.is_printable
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
		once
			Result := ∃ s: switches ¦ s.has_short_name
		end

	frozen has_available_options: BOOLEAN
			-- Indicates if there are options available.
		do
			Result := not available_switches.is_empty
		end

	frozen has_visible_available_options: BOOLEAN
			-- Indicates if there are options available.
		do
			Result := not available_visible_switches.is_empty
		end

	has_parsed: BOOLEAN
			-- Indicates of a parse has been performed.

	has_switch (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if a switch exists.
			--
			-- `a_name': The name of the switch to determine existence for.
			-- `Result': True if the switch exists; False otherwise.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_cs: like is_case_sensitive
		do
			l_cs := is_case_sensitive
			Result :=
				∃ s: available_switches ¦
					if l_cs then
						s.id.same_string_general (a_name)
					else
						s.id.is_case_insensitive_equal_general (a_name)
					end
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

	option_of_name (a_name: READABLE_STRING_GENERAL): detachable ARGUMENT_OPTION
			-- Retrieves the first switch-qualified option, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve an options for.
			-- `Result': An option passed via the command line or Void if the switch option was not found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		do
			Result := internal_option_of_name (a_name)
		end

	options_of_name (a_name: READABLE_STRING_GENERAL): LIST [ARGUMENT_OPTION]
			-- Retrieves a list of switch-qualified options, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve a list of options for.
			-- `Result': A list of options passed via the command line.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_cs: like is_case_sensitive
			l_opt: ARGUMENT_OPTION
		do
			create {ARRAYED_LIST [ARGUMENT_OPTION]} Result.make (0)
			l_cs := is_case_sensitive
			across
				option_values as o
			loop
				l_opt := o
				if
					if l_cs then
						l_opt.switch.id.same_string_general (a_name)
					else
						l_opt.switch.id.is_case_insensitive_equal_general (a_name)
					end
				then
					Result.extend (l_opt)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	options_values_of_name (a_name: READABLE_STRING_GENERAL): ARRAYED_LIST [IMMUTABLE_STRING_32]
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
		do
			if has_option (a_name) then
				l_options := options_of_name (a_name)
				create Result.make (l_options.count)
				Result.compare_objects
				across l_options as l_option loop
					if l_option.has_value then
						Result.extend (l_option.value)
					end
				end
			else
				create Result.make (0)
				Result.compare_objects
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: ∀ l_c: Result ¦ not l_c.is_empty
		end

	unique_options_values_of_name (a_name: READABLE_STRING_GENERAL; a_ignore_case: BOOLEAN): ARRAYED_LIST [IMMUTABLE_STRING_32]
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
			l_value: IMMUTABLE_STRING_32
			l_comp_list: ARRAYED_LIST [IMMUTABLE_STRING_32]
			l_comp_value: IMMUTABLE_STRING_32
		do
			l_options := options_of_name (a_name)
			create Result.make (l_options.count)
			create l_comp_list.make (l_options.count)
			l_comp_list.compare_objects
			across
				l_options as o
			loop
				l_option := o
				if l_option.has_value then
					l_value := l_option.value
					if a_ignore_case then
						l_comp_value := l_value.as_lower
					else
						l_comp_value := l_value
					end
					if not l_comp_list.has (l_comp_value) then
						Result.extend (l_value)
						l_comp_list.extend (l_comp_value)
					end
				end
			end
		ensure
			result_attached: Result /= Void
			result_contains_valid_items: ∀ l_c: Result ¦ not l_c.is_empty
		end

	switch_of_name (a_name: READABLE_STRING_GENERAL): ARGUMENT_SWITCH
			-- Retrieves a argument switch using its textual name.
			--
			-- `a_name': The name of the switch to retrieve.
			-- `Result': The associated argument switch of Void if non could be found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_switch_a_name: has_switch (a_name)
		local
			l_cs: BOOLEAN
		do
			l_cs := is_case_sensitive
			across
				available_switches as s
			until
				attached Result
			loop
				if
					if l_cs then
						s.id.same_string_general (a_name)
					else
						s.id.is_case_insensitive_equal_general (a_name)
					end
				then
					Result := s
				end
			end
			check
				from_precondition_has_switch: attached Result
			then
			end
		ensure
			result_attached: Result /= Void
			available_switches_unmoved: available_switches.cursor ~ old available_switches.cursor
			result_is_requsted_switch: Result.id.same_string_general (a_name)
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
			l_option: IMMUTABLE_STRING_32
			l_value: detachable IMMUTABLE_STRING_32
			l_switch: detachable ARGUMENT_SWITCH
			l_match_switch: detachable ARGUMENT_SWITCH
			l_prefixes: like switch_prefixes
			l_cs: like is_case_sensitive
			l_match: BOOLEAN
			l_err: BOOLEAN
			l_arg: IMMUTABLE_STRING_32
			l_use_long_name: BOOLEAN
			l_stop_processing: BOOLEAN
			l_count: INTEGER
			j, k: INTEGER
		do
			internal_option_values.wipe_out
			internal_values.wipe_out

				-- Set parsed so we can access certain functions
			has_parsed := True

			l_switches := available_switches
			l_prefixes := switch_prefixes
			l_cs := is_case_sensitive
			l_use_separated := is_using_separated_switch_values
			across
				arguments as a
			loop
				check
					l_last_switch_unattached: not l_use_separated implies l_last_switch = Void
				end
				l_arg := a
				if not l_stop_processing and then not l_arg.is_empty and then l_arg.count > 1 and then l_prefixes.has (l_arg.item (1)) then
					if l_arg.count > 2 and then l_prefixes.has (l_arg.item (2)) then
						l_option := l_arg.shared_substring (3, l_arg.count)
						l_use_long_name := True
					else
						if l_arg.count = 2 and then l_arg.same_string_general ("--") then
								-- The user specified just a double switch qualifer (--), which means we ignore all future option processing.
							l_stop_processing := True
							l_option := l_arg
						else
							l_option := l_arg.shared_substring (2, l_arg.count)
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
										l_value := l_option.shared_substring (j + 1, l_option.count)
										l_option := l_option.shared_substring (1, j - 1)
									end
								end
							end

							if not l_err then
								if not l_cs then
									l_option := l_option.as_lower
								end

									-- Attempt to find a matching switch
								l_match_switch := Void
								l_match := False
								across
									l_switches as s
								until
									l_match
								loop
									l_switch := s
									if l_use_long_name then
										if l_cs then
											l_match := l_switch.long_name.same_string (l_option)
										else
											l_match := l_switch.long_name.is_case_insensitive_equal (l_option)
										end
									else
										if l_cs then
											l_match := l_switch.name.same_string (l_option)
										else
											l_match := l_switch.name.is_case_insensitive_equal (l_option)
										end
									end
									if l_match then
										l_match_switch := l_switch
									end
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
										across
											l_switches as s
										until
											l_match
										loop
											l_switch := s
											if l_switch.has_short_name then
												if l_cs then
													l_match := l_switch.short_name = l_option [k]
												else
													l_match := l_switch.short_name.as_lower = l_option [k]
												end
												if l_match and k < l_count then
														-- if matches and we are not processing the last item
													internal_option_values.extend (l_switch.new_option)
												end
											end
										end
										k := k + 1
									end
									if l_match then
											-- Last item can be a value switch
										l_match_switch := l_switch
									end
								end

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
							same_name: internal_option_values.last.switch.id.same_string (l_last_value_switch.id)
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
			l_options: detachable like options_of_name
			l_switch_groups: like switch_groups
			l_switch_appurtenances: like switch_dependencies
			l_switch: ARGUMENT_SWITCH
			l_value: IMMUTABLE_STRING_32
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
			if
				not l_switch_appurtenances.is_empty and then
				not option_values.is_empty
			then
				validate_switch_appurtenances
			end
			if not l_switch_groups.is_empty then
					-- Validate applicable non-switched arguments
				validate_non_switched_arguments (l_switch_groups)
			end

			across
				available_switches as s
			loop
				l_succ := True
				l_switch := s
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
					if not attached {ARGUMENT_VALUE_SWITCH} l_switch as l_val_switch then
							-- Check regular switches do not have values.
						across
							l_options as o
						loop
							if o.has_value then
								add_template_error (e_non_value_switch, [l_switch.name])
							end
						end
					elseif not l_val_switch.is_value_optional then
							-- Check argument exists.
						across
							l_options as o
						loop
							if not o.has_value then
								add_template_error (e_require_switch_value, [l_val_switch.name, l_val_switch.arg_name])
								l_succ := False
							end
						end
						if l_succ then
								-- Check argument is valid
							l_validator := l_val_switch.value_validator
							across
								l_options as o
							loop
								l_value := o.value
								l_validator.validate (l_value)
								if not l_validator.is_option_valid then
									add_template_error (e_invalid_switch_value_with_reason, [ellipse_text (l_value), l_switch.name, l_validator.reason])
								end
							end
						end
					end
				end
			end
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
			has_parsed: has_parsed
		local
			l_validator: like non_switched_argument_validator
			l_values: like values
		do
			l_values := values
			if not l_values.is_empty then
				if is_allowing_non_switched_arguments then
					l_validator := non_switched_argument_validator
					across
						l_values as v
					loop
						l_validator.validate (v)
						if not l_validator.is_option_valid then
							add_template_error (e_invalid_non_switched_value_with_reason, [v, l_validator.reason])
						end
					end
				else
					add_error (e_non_switched_argument_specified_error)
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
			l_option: ARGUMENT_SWITCH
			l_upper, i: INTEGER
		do
			l_dependencies := switch_dependencies
			across
				option_values as o
			loop
				l_option := o.switch
				if l_dependencies.has (l_option) then
					if attached l_dependencies [l_option] as l_switches then
						from
							i := l_switches.lower
							l_upper := l_switches.upper
						until
							i > l_upper
						loop
							l_switch := l_switches [i]
							if
								not l_switch.optional and then
								not l_switch.is_special and then
								not has_option (l_switch.id)
							then
								add_template_error (e_missing_switch_dependency_error, [l_option.name, l_switch.name])
							end
							i := i + 1
						end
					else
						check l_dependencies_has_l_option: True end
					end
				end
			end
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
			l_switch: ARGUMENT_SWITCH
		do
			Result := expanded_switch_groups.twin
				-- Check specified switches for a valid group match.
			across
				option_values as o
			loop
				l_switch := o.switch
				from Result.start until Result.is_empty or Result.after loop
					if not l_switch.is_special and then not Result.item.switches.has (l_switch) then
						Result.remove
					else
						Result.forth
					end
				end
			end
				-- Check optional.
			from Result.start until Result.after loop
				if ∀ s: Result.item.switches ¦ s.optional or else has_option (s.id) then
					Result.forth
				else
					Result.remove
				end
			end
		ensure
			result_attached: Result /= Void
		end

	frozen expanded_switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Expanded set of switch groups based on `switch_groups' and `switch_appurtenances'.
		require
			has_parsed: has_parsed
			switch_groups_attached: switch_groups /= Void
		local
			l_groups: detachable like switch_groups
		do
				-- Create extend switch groups
			l_groups := switch_groups
			create Result.make (l_groups.count)
			across
				l_groups as g
			loop
				Result.extend (expand_switch_group (g))
			end
			check
				matching_counts: Result.count = l_groups.count
			end
		ensure
			result_attached: Result /= Void
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
		do
			l_group_switches := a_group.switches.twin
			l_switch_dependencies := switch_dependencies
			if not l_switch_dependencies.is_empty then
				from l_group_switches.start until l_group_switches.after loop
					l_switch := l_group_switches.item
					if attached l_switch_dependencies [l_switch] as l_appurtenances then
						across
							l_appurtenances as a
						loop
							l_switch := a
							if not l_group_switches.has (l_switch) then
								l_group_switches.extend (l_switch)
								check
									not_l_group_switches_after: not l_group_switches.after
								end
							end
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
			error_messages.extend (a_msg)
		ensure
			error_messages_extended: error_messages.has (a_msg)
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
			add_error ((create {STRING_FORMATTER}).format_unicode (a_tmpl, a_contexts))
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
			l_cfg: STRING_32
		do
			if
				attached sub_system_name as l_sub_system_name and then
				not l_sub_system_name.is_empty
			then
				create l_name.make_from_string (system_name + " " + l_sub_system_name)
			else
				l_name := system_name
			end
			io.put_string_32 ("USAGE: %N")

			l_cfgs := command_option_configurations
			if not l_cfgs.is_empty then
				across
					l_cfgs as c
				loop
					io.put_string_32 (tab_string)
					io.put_string_32 (l_name)
					io.put_string_32 (" ")
					create l_cfg.make_from_string (c)
					l_cfg.replace_substring_all ({STRING_32} "%N", {STRING_32} "%N" + create {STRING_32}.make_filled (' ', l_name.count + 1))
					io.put_string_32 (l_cfg)
					if not @ c.is_last then
						io.new_line
					end
				end
			else
				io.put_string_32 (tab_string)
				io.put_string_32 (l_name)
			end

			if has_visible_available_options then
				io.new_line
				display_options
			end

				-- List the extended usage.
			l_ext := extended_usage
			if not l_ext.is_empty then
				io.new_line
				io.put_string_32 (l_ext)
			end
			io.new_line
		end

	display_logo
			-- Displays copyright information.
		do
			io.put_string_32 (name)
			io.put_string_32 (" - Version: ")
			io.put_string_32 (version)
			if not copyright.is_empty then
				io.new_line
				io.put_string_32 (copyright)
			end
			io.new_line
			io.new_line
		end

	display_version
			-- Displays version information.
		do
				-- Only display the version information if it was not already displayed
			io.put_string_32 (name)
			io.put_string_32 (" version ")
			io.put_string_32 (version)
			if not copyright.is_empty then
				io.new_line
				io.put_string_32 (copyright)
			end
			io.new_line
		end

	display_errors
			-- Displays any parse/validation related error messages.
		require
			not_is_successful: not is_successful
		local
			l_errors: like error_messages
		do
			l_errors := error_messages
			io.error.put_string_32 (string_formatter.format_unicode ("{1} error(s) occurred.%N", [l_errors.count]))
			across
				l_errors as e
			loop
				io.error.put_string_32 (tab_string)
				io.error.put_string_32 ("> ")
				io.error.put_string_32 (format_terminal_text (e, tab_string.count.as_natural_8 + 2))
				io.error.new_line
			end
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
			l_prefix: STRING_32
			l_def_prefix: STRING_32
			l_switches: like available_switches
			l_switch: ARGUMENT_SWITCH
			l_value_switch: ARGUMENT_VALUE_SWITCH
			l_value_switches: ARRAYED_LIST [ARGUMENT_VALUE_SWITCH]
			l_padding: INTEGER
			l_max_len: INTEGER
			l_name: STRING_32
			l_arg_name: STRING_32
			l_desc: STRING_32
			l_arg_desc: STRING_32
			l_immutable: IMMUTABLE_STRING_32
			l_added_args: STRING_TABLE [BOOLEAN]
			l_inline_args: like is_showing_argument_usage_inline
			l_count: INTEGER
			i: INTEGER
		do
			io.put_string_32 ("%NOPTIONS:%N")

			create l_value_switches.make (0)

				-- Output prefix option qualifiers
			l_prefixes := switch_prefixes
			create l_def_prefix.make (1)
			l_def_prefix.append_character (l_prefixes [1])
			if l_prefixes.count > 1 then
				create l_prefix.make ((l_prefixes.count * 5) + 2)
				from
					i := l_prefixes.lower
					l_count := l_prefixes.upper
				until i > l_count loop
					if i > 1 then
						if i < l_count then
							l_prefix.append_string_general (", ")
						else
							l_prefix.append_string_general (" or ")
						end
					end
					l_prefix.append_character ('%'')
					l_prefix.append_character (l_prefixes [i])
					l_prefix.append_character ('%'')
					i := i + 1
				end
				io.put_string_32 (tab_string)
				io.put_string_32 ("Options ")
				if is_case_sensitive then
					io.put_string_32 ("are case-sensitive and ")
				end
				io.put_string_32 ("should be prefixed with: ")
				io.put_string_32 (l_prefix)
				io.new_line
				io.new_line
			end

			l_switches := available_visible_switches

				-- Retrieve option max length for alignment
			across
				l_switches as s
			loop
				l_switch := s
				if not l_switch.is_hidden then
					if is_using_unix_switch_style or else l_switch.has_short_name then
						l_max_len := l_max_len.max (l_switch.long_name.count + 5)
					else
						l_max_len := l_max_len.max (l_switch.long_name.count + 1)
					end
				end
			end

			l_inline_args := is_showing_argument_usage_inline

				-- Output available options

			across
				l_switches as s
			loop
				l_switch := s
				if attached {ARGUMENT_VALUE_SWITCH} l_switch as l_value_switch_1 then
					l_value_switches.extend (l_value_switch_1)
				end

				if l_switch.has_short_name then
					create l_arg_name.make (20)
					l_arg_name.append (l_def_prefix)
					l_arg_name.append_character (l_switch.short_name)
					l_arg_name.append_string_general (" ")
					if is_using_unix_switch_style then
						l_arg_name.append (l_def_prefix) --| "--name" instead of "-name"
					end
					l_arg_name.append (l_def_prefix)
					l_arg_name.append (l_switch.long_name)
				elseif is_using_unix_switch_style then
					l_arg_name := {STRING_32} "   " + l_def_prefix + l_def_prefix + l_switch.long_name
				else
					l_arg_name := l_def_prefix + l_switch.long_name
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
					l_desc.append_string_general (" (Optional)")
				end
				l_padding := l_name.count + tab_string.count + 2
				l_desc := format_terminal_text (l_desc, l_padding.as_natural_8)
				if l_inline_args and then attached {ARGUMENT_VALUE_SWITCH} l_switch as l_value_switch_2 then
					l_desc.append_character ('%N')
					l_desc.append (create {STRING_32}.make_filled (' ', l_padding))
					l_desc.append_character ('<')
					l_desc.append (l_value_switch_2.arg_name)
					l_desc.append_string_general (">: ")
					create l_arg_desc.make (32)
					if l_value_switch_2.is_value_optional then
						l_arg_desc.append_string_general ("(Optional) ")
					end
					l_arg_desc.append (l_value_switch_2.arg_description)
					l_arg_desc := format_terminal_text (l_arg_desc, (l_padding + l_value_switch_2.arg_name.count + 4).as_natural_8)
					l_desc.append (l_arg_desc)
				end

				io.put_string_32 (tab_string)
				io.put_string_32 (l_name)
				io.put_string_32 (": ")
				io.put_string_32 (l_desc)
				io.new_line
			end

			if not l_inline_args and then not l_value_switches.is_empty then
				io.put_string_32 ("%NARGUMENTS:%N")

				create l_added_args.make (l_value_switches.count)

				l_max_len := 0
				across
					l_value_switches as s
				loop
					l_max_len := l_max_len.max (s.arg_name.count)
				end

				across
					l_value_switches as s
				loop
					l_value_switch := s

					l_immutable := l_value_switch.arg_name
					if not l_added_args.has (l_immutable) then
						if l_max_len > l_immutable.count then
							create l_name.make_filled (' ', l_max_len - l_immutable.count)
						else
							create l_name.make_empty
						end
						l_name.insert_character ('<', 1)
						l_name.insert_string (l_immutable, 2)
						l_name.insert_character ('>', l_immutable.count + 2)

						l_desc := format_terminal_text (l_value_switch.arg_description, (l_immutable.count + tab_string.count + 4).as_natural_8)
						io.put_string_32 (tab_string)
						io.put_string_32 (l_name)
						io.put_string_32 (": ")
						io.put_string_32 (l_desc)
						io.new_line

						l_added_args.put (True, l_immutable)
					end
				end
			end
		end

feature {NONE} -- Usage

	name: READABLE_STRING_GENERAL
			-- Full name of application.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	version: READABLE_STRING_GENERAL
			-- Version number of application.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	copyright: READABLE_STRING_GENERAL
			-- Copyright information.
			-- Not used if empty.
		deferred
		ensure
			result_attached: Result /= Void
		end

	frozen command_option_configurations: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- Command line option configuration string (to display in usage).
		local
			l_groups: like switch_groups
			l_group: ARGUMENT_GROUP
			l_cfg: like command_option_group_configuration
			l_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			l_switch: ARGUMENT_SWITCH
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
				across
					l_groups as g
				loop
					l_group := g
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
				end
			end
		ensure
			result_attached: Result /= Void
			result_contains_valid_items: ∀ l_c: Result ¦ not l_c.is_empty
			available_switches_unmoved: available_switches.cursor ~ old available_switches.cursor
			switch_groups_unmoved: switch_groups.cursor ~ old switch_groups.cursor
		end

	command_option_group_configuration (a_group: LIST [ARGUMENT_SWITCH]; a_show_non_switch: BOOLEAN; a_non_switch_required: BOOLEAN; a_add_appurtenances: BOOLEAN; a_src_group: LIST [ARGUMENT_SWITCH]): STRING_32
			-- Command line option configuration string (to display in usage) for a specific group of options.
		require
			a_group_attached: a_group /= Void
			a_src_group_attached: a_src_group /= Void
			a_group_equals_a_src_group: a_add_appurtenances implies a_group = a_src_group
		local
			l_dependencies: like switch_dependencies
			l_dependent_list: ARRAYED_LIST [ARGUMENT_SWITCH]
			l_use_separated: like is_using_separated_switch_values
			l_verbose: BOOLEAN
			l_unix_style: BOOLEAN
			l_switch: ARGUMENT_SWITCH
			l_cfg: like command_option_group_configuration
			l_prefix: CHARACTER_32
			l_opt: BOOLEAN
			l_opt_val: BOOLEAN
			l_add_switch: BOOLEAN
			i, l_upper: INTEGER
		do
			if not a_group.is_empty then
				l_dependencies := switch_dependencies
				l_prefix := switch_prefixes [1]
				l_use_separated := is_using_separated_switch_values
				l_verbose := is_usage_verbose
				l_unix_style := is_using_unix_switch_style
				create Result.make (a_group.count * 12)

				across
					a_group as g
				loop
					l_switch := g
					l_opt := l_switch.optional
					if not l_switch.id.same_string (help_switch) and not l_switch.is_hidden then
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
								if l_unix_style and not l_switch.has_short_name then
									Result.append_character (l_prefix)
								end
								Result.append (l_switch.name)
							end

							if attached {ARGUMENT_VALUE_SWITCH} l_switch as l_val_switch then
								l_opt_val := l_val_switch.is_value_optional
								if l_opt_val then
									Result.append_character ('[')
								end
								if l_use_separated then
									Result.append_string_general (" <")
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
								Result.append_string_general (" [")
								Result.append_character (l_prefix)
								Result.append (l_switch.name)
								Result.append_string_general ("...]")
							end
							if l_opt then
								Result.append_character (']')
							end
							if not @ g.is_last then
								Result.append_character (' ')
							end
						end
					end
				end
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
			a_group_unmoved: a_group.cursor ~ old a_group.cursor
		end

	frozen format_terminal_text (a_text: READABLE_STRING_GENERAL; a_left_padding: NATURAL_8): STRING_32
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
			l_lines: LIST [STRING_32]
			l_padding: STRING_32
			i: INTEGER
		do
			l_lines := a_text.as_string_32.split ('%N')
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

	extended_usage: IMMUTABLE_STRING_32
			-- Retrieces extended configuration information.
			--|Redefine in subclass.
		once
			create Result.make_empty
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Switches

	nologo_switch: IMMUTABLE_STRING_32
			-- Supress copyright information switch.
		once
			create Result.make_from_string_general ("nologo")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.same_string (nologo_switch)
		end

	help_switch: IMMUTABLE_STRING_32
			-- Display usage information switch.
		once
			if is_using_unix_switch_style then
				if {PLATFORM}.is_windows then
					create Result.make_from_string_general ("?|help")
				else
					create Result.make_from_string_general ("h|help")
				end
			else
				if {PLATFORM}.is_windows then
					create Result.make_from_string_8 ("?")
				else
					create Result.make_from_string_8 ("help")
				end
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.same_string (help_switch)
		end

	version_switch: IMMUTABLE_STRING_32
			-- Version information switch.
		once
			if is_using_unix_switch_style then
				create Result.make_from_string_general ("v|version")
			else
				create Result.make_from_string_general ("version")
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.same_string (version_switch)
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
				create l_switch.make (nologo_switch, "Supresses copyright information.", True, False)
				l_switch.set_is_special
				Result.extend (l_switch)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = available_switches
		end

	frozen available_visible_switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of available visible (not hidden) switch.
		local
			l_switches: like available_switches
			l_switch: ARGUMENT_SWITCH
		once
			l_switches := available_switches
			create Result.make (l_switches.count)
			across
				l_switches as s
			loop
				l_switch := s
				if not l_switch.is_hidden then
					Result.extend (l_switch)
				end
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = available_visible_switches
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a set of switch used for a specific application.
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = switches
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Valid switch grouping.
		once
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_consistent: Result = switch_groups
		end

	switch_dependencies: HASH_TABLE [ARRAY [ARGUMENT_SWITCH], ARGUMENT_SWITCH]
			-- Switch appurtenances (dependencies).
			-- Note: Switch appurtenances are implictly added to a group where a switch is present.
		once
			create Result.make (0)
		ensure
			result_attached: Result /= Void
			result_consistent: Result = switch_dependencies
		end

feature {NONE} -- Formatting

	frozen ellipse_text (a_str: READABLE_STRING_GENERAL): STRING_32
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
			-- Creates a new default argument source object for the parser.
		do
			create {ARGUMENT_TERMINAL_SOURCE} Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	switch_prefixes: ARRAY [CHARACTER_32]
			-- Prefixes used to indicate a command line switch.
		once
			Result :=
				if {PLATFORM}.is_windows then
					{ARRAY [CHARACTER_32]} <<'-', '/'>>
				else
					{ARRAY [CHARACTER_32]} <<'-'>>
				end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_printable_items: ∀ l_c: Result ¦ is_character_printable (l_c)
		end

	switch_value_qualifer: CHARACTER_32
			-- Character used to separate an switch from it's value.
		require
			not_is_using_separated_switch_values: not is_using_separated_switch_values
		once
			Result := ':'
		ensure
			result_is_printable: is_character_printable (Result)
			result_not_is_id_character: not Result.is_alpha_numeric and Result /= '_'
		end

	default_system_name: IMMUTABLE_STRING_32
			-- Default application name.
		once
			create Result.make_from_string_general ("app")
		end

	tab_string: IMMUTABLE_STRING_32
			-- Tab indent string.
		once
			create Result.make_from_string_general ("   ")
		end

feature {NONE} -- Internationalization

	e_invalid_switch_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("The switch '{1}' is invalid.")
		end

	e_unrecognized_switch_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Unrecognized switch '{1}'.")
		end

	e_invalid_switch_value: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("'{1}' is an invalid option for switch '{2}'.")
		end

	e_require_switch_value: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Switch '{1}' requires a paired value '{2}'.")
		end

	e_multiple_switch_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Switch '{1}' can only be used once.")
		end

	e_non_value_switch: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Switch '{1}' should not have any value paired with it.")
		end

	e_missing_switch_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Switch '{1}' was not specified.")
		end

	e_non_switched_argument_specified_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Arguments without a switch prefix are not valid arguments.")
		end

	e_multiple_non_switched_argument_specified_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Only one argument without a switch prefix can be passed.")
		end

	e_switch_group_unrecognized_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("The specified switches are not in a valid configuration.")
		end

	e_missing_switch_dependency_error: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("Switch '{1}' require the switch '{2}' be specified also.")
		end

	e_invalid_switch_value_with_reason: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("'{1}' is an invalid option for switch '{2}'.%N{3}")
		end

	e_invalid_non_switched_value_with_reason: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("'{1}' is an invalid option.%N{2}")
		end

feature {NONE} -- Implementation: Query

	internal_option_of_name (a_name: READABLE_STRING_GENERAL): detachable ARGUMENT_OPTION
			-- Retrieves the first switch-qualified option, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve an options for.
			-- `Result': An option passed via the command line or Void if the switch option was not found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_cs: like is_case_sensitive
			l_opt: ARGUMENT_OPTION
		do
			l_cs := is_case_sensitive
			across
				option_values as o
			loop
				l_opt := o
				if
					if l_cs then
						a_name.same_string (l_opt.switch.id)
					else
						a_name.is_case_insensitive_equal (l_opt.switch.id)
					end
				then
					Result := l_opt
				end
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_option_values: ARRAYED_LIST [ARGUMENT_OPTION]
			-- Mutable, unprotected verion of `option_values'.

	internal_values: ARRAYED_LIST [IMMUTABLE_STRING_32]
			-- Mutable, unprotected version of `values'.

	internal_argument_source: detachable like argument_source
			-- Cached version of `arugment_source'.
			-- Note: Do not use directly!

invariant
	not_is_non_switch_argument_required: not is_allowing_non_switched_arguments implies not is_non_switch_argument_required
	is_successful_means_has_parsed: is_successful implies has_parsed

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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

