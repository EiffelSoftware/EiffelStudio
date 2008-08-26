indexing
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
			is_using_builtin_switches := {PLATFORM}.is_windows
			is_case_sensitive := a_cs
			is_allowing_non_switched_arguments := a_allow_non_switched
			is_non_switch_argument_required := a_non_switch_required
			is_showing_argument_usage_inline := True
			is_using_separated_switch_values := True
			is_usage_displayed_on_error := False
		ensure
			is_case_sensitive_set: is_case_sensitive = a_cs
			is_allowing_non_switched_arguments_set: is_allowing_non_switched_arguments = a_allow_non_switched
			is_non_switch_argument_required_set: is_non_switch_argument_required = a_non_switch_required
		end

feature -- Access

	frozen application_base: !STRING
			-- The base location of application.
		indexing
			once_status: global
		local
			l_result: ?STRING
			l_path: STRING
			i: INTEGER
		once
			l_path := arguments.argument (0)
			if l_path /= Void and then not l_path.is_empty then
				i := l_path.last_index_of (operating_environment.directory_separator, l_path.count)
				if i > 0 then
					l_result := l_path.substring (1, i - 1)
				end
			end
			if l_result = Void or else l_result.is_empty then
				l_result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
			create {STRING} Result.make_from_string (l_result)
		ensure
			not_result_is_empty: not Result.is_empty
			no_trailing_separator: Result.item (Result.count) /= operating_environment.directory_separator
		end

	frozen values: !LIST [!STRING]
			-- List of arguments values that were not qualified with a switch (aka loose arguments).
		require
			is_successful: is_successful
		do
			Result := internal_values
		ensure
			result_contains_attached_valid_items: Result.for_all (
				agent (ia_item: !STRING): BOOLEAN
					do
						Result := not ia_item.is_empty
					end)
		end

	frozen option_values: !LIST [!ARGUMENT_OPTION]
			-- Option values parsed via command line, these do not include the loose arguments. See `values'.
		require
			is_successful: is_successful
		do
			Result := internal_option_values
		end

	frozen error_messages: !ARRAYED_LIST [!STRING]
			-- Any error messages generated during parse and validation, if any.
		indexing
			once_status: global
		once
			create Result.make (0)
		ensure
			result_contains_attached_valid_items: Result.for_all (
				agent (ia_item: !STRING): BOOLEAN
					do
						Result := not ia_item.is_empty
					end)
		end

feature {NONE} -- Access

	frozen system_name: !STRING
			-- Retrieves system executable name.
		local
			l_path: STRING
			i: INTEGER
		do
			l_path := arguments.argument (0)
			if l_path /= Void and then not l_path.is_empty then
				i := l_path.last_index_of (operating_environment.directory_separator, l_path.count)
				if i > 0 then
					Result ?= l_path.substring (i + 1, l_path.count)
				else
					Result ?= l_path
				end
			else
				Result := default_system_name
			end
		end

	non_switched_argument_validator: ?ARGUMENT_VALUE_VALIDATOR assign set_non_switched_argument_validator
			-- Validator used to validate any non-switched arguments.

feature {NONE} -- Element change

	set_non_switched_argument_validator (a_validator: ?like non_switched_argument_validator)
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

	frozen has_option (a_name: ?STRING): BOOLEAN
			-- Determines if switch option was specified in the command-line arguments.
			--
			-- `a_name': The name of the switch to check existance for.
			-- `Result': True if the command line specified the given switch; False otherwise.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := has_parsed and then option_of_name (a_name) /= Void
		ensure
			result_true: Result = (has_parsed and then option_of_name (a_name) /= Void)
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
			-- Indicates of a parse has been performed

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

	option_of_name (a_name: ?STRING): ?ARGUMENT_OPTION
			-- Retrieves the first switch-qualified option, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve an options for.
			-- `Result': An option passed via the command line or Void if the switch option was not found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: !like option_values
			l_cursor: CURSOR
			l_cs: like is_case_sensitive
			l_opt: !ARGUMENT_OPTION
			l_equal: BOOLEAN
		do
			l_options := option_values
			if not l_options.is_empty then
				l_cs := is_case_sensitive
				l_cursor := l_options.cursor
				from l_options.start until l_options.after or Result /= Void loop
					l_opt := l_options.item
					if l_cs then
						l_equal := l_opt.switch.id.is_equal (a_name)
					else
						l_equal := l_opt.switch.id.is_case_insensitive_equal (a_name)
					end
					if l_equal then
						Result := l_opt
					end
					l_options.forth
				end
				l_options.go_to (l_cursor)
			end
		ensure
			result_attached: not options_of_name (a_name).is_empty implies Result /= Void
		end

	options_of_name (a_name: ?STRING): !LIST [!ARGUMENT_OPTION]
			-- Retrieves a list of switch-qualified options, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve a list of options for.
			-- `Result': A list of options passed via the command line.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: !like option_values
			l_cursor: CURSOR
			l_cs: like is_case_sensitive
			l_result: !ARRAYED_LIST [!ARGUMENT_OPTION]
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
						l_equal := l_opt.switch.id.is_equal (a_name)
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
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

	options_values_of_name (a_name: ?STRING): !LIST [!STRING]
			-- Retrieves a list of switch-qualified option values, passed by user, by switch name.
			--
			-- `a_name': The switch names to retrieve a list of options for.
			-- `Result': A list of options values passed via the command line.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			has_parsed: has_parsed
		local
			l_options: !like options_of_name
			l_result: !ARRAYED_LIST [!STRING]
		do
			l_options := options_of_name (a_name)
			create l_result.make (l_options.count)
			l_result.compare_objects
			if not l_options.is_empty then
				l_options.do_all (agent (ia_list: !ARRAYED_LIST [!STRING]; ia_option: !ARGUMENT_OPTION)
					require
						ia_list_attached: ia_list /= Void
						ia_option_attached: ia_option /= Void
					do
						if ia_option.has_value then
							ia_list.extend (ia_option.value)
						end
					ensure
						ia_list_has_a_path: ia_option.has_value implies ia_list.has (ia_option.value)
					end (l_result, ?))
			end
			Result := l_result
		ensure
			result_contains_attached_valid_items: Result.for_all (
				agent (ia_item: !STRING): BOOLEAN
					do
						Result := not ia_item.is_empty
					end)
		end

	unique_options_values_of_name (a_name: ?STRING; a_ignore_case: BOOLEAN): !LIST [!STRING]
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
			l_options: !like options_of_name
			l_result: !ARRAYED_LIST [!STRING]
			l_comp_list: !ARRAYED_LIST [!STRING]
		do
			l_options := options_of_name (a_name)
			create l_result.make (l_options.count)
			create l_comp_list.make (l_options.count)
			l_result.compare_objects
			l_comp_list.compare_objects
			if not l_options.is_empty then
				l_options.do_all (agent (a_list: !ARRAYED_LIST [STRING]; a_ic: BOOLEAN; a_option: !ARGUMENT_OPTION; a_nlist: !ARRAYED_LIST [STRING])
					require
						a_list_attached: a_list /= Void
						a_list_compares_objects: a_list.object_comparison
						a_option_attached: a_option /= Void
						a_nlist_attached: a_nlist /= Void
						a_nlist_compares_objects: a_nlist.object_comparison
					local
						l_value: STRING
						l_lvalue: STRING
					do
						if a_option.has_value then
							l_value := a_option.value
							if a_ic then
								l_lvalue := l_value.as_lower
							end
							if (not a_ic and not a_list.has (l_value)) or else (a_ic and not a_nlist.has (l_lvalue)) then
								a_list.extend (l_value)
								if a_ic then
									check l_lvalue_attached: l_lvalue /= Void end
									a_nlist.extend (l_lvalue)
								end
							end
						end
					ensure
						a_list_has_a_path: a_list.has (a_option.value)
					end (l_result, a_ignore_case, ?, l_comp_list))
			end
			Result := l_result
		ensure
			result_contains_attached_valid_items: Result.for_all (
				agent (ia_item: !STRING): BOOLEAN
					do
						Result := not ia_item.is_empty
					end)
		end

	switch_of_name (a_name: !STRING): ?ARGUMENT_SWITCH
			-- Retrieves a argument switch using its textual name.
			--
			-- `a_name': The name of the switch to retrieve.
			-- `Result': The associated argument switch of Void if non could be found.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_switches: !like available_switches
			l_cs: like is_case_sensitive
			l_cursor: CURSOR
			l_name: !STRING
			l_match_name: !STRING
		do
			l_switches := available_switches
			l_cursor := l_switches.cursor

			l_cs := is_case_sensitive
			if l_cs then
				l_match_name := a_name
			else
				l_match_name := a_name.as_lower
			end
			from l_switches.start until l_switches.after or Result /= Void loop
				if l_cs then
					l_name := l_switches.item.id
				else
					l_name := l_switches.item.lower_case_id
				end
				if l_match_name.is_equal (l_name) then
					Result := l_switches.item
				else
					l_switches.forth
				end
			end
			l_switches.go_to (l_cursor)
		ensure
			result_is_requsted_switch: Result /= Void implies Result.id.is_equal (a_name)
		end

feature {NONE} -- Helpers

	frozen arguments: !ARGUMENTS
			-- Access to raw arguments.
		once
			create Result
		end

	frozen string_formatter: !STRING_FORMATTER
			-- Access to a shared string formatter.
		once
			create Result
		end

feature -- Basic Operations

	execute (a_action: !PROCEDURE [ANY, ?TUPLE])
			-- Main entry point, which parses the supplied command line arguments and then executes the
			-- supplied action if parsing an argument validation was successful.
			--
			-- `a_action': The action to call to start the application when the arguments have been parsed
			--             and validated.
		require
			not_has_executed: not has_executed
		local
			l_options: like option_values
		do
			parse_arguments

			if is_successful then
				if not is_logo_information_suppressed then
					display_logo
				end

				if is_help_usage_displayed then
					display_usage
				else
					l_options := option_values
					if option_values.is_empty and values.is_empty then
						execute_noop (a_action)
					else
						a_action.call (Void)
					end
				end
			else
				if switch_of_name (nologo_switch) /= Void and then not is_logo_information_suppressed then
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

	execute_noop (a_action: !PROCEDURE [ANY, ?TUPLE])
			-- Executes an action when no arguments of any worth are passed.
			--
			-- `a_action': The action to call once the current parser has validated it can accept no
			--             arguments.
		require
			option_values_is_empty: option_values.is_empty and values.is_empty
		do
			if is_allowing_non_switched_arguments then
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
			l_last_switch: ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_option: !STRING
			l_value: STRING
			l_switch: ARGUMENT_SWITCH
			l_value_switch: ARGUMENT_VALUE_SWITCH
			l_prefixes: like switch_prefixes
			l_args: ARRAY [STRING]
			l_upper: INTEGER
			l_cs: like is_case_sensitive
			l_match: BOOLEAN
			l_options: like internal_option_values
			l_values: like internal_values
			l_err: BOOLEAN
			l_arg: !STRING
			l_use_long_name: BOOLEAN
			l_count: INTEGER
			i, j, k: INTEGER
		do
			create l_options.make (0)
			create l_values.make (0)
			internal_option_values := l_options
			internal_values := l_values

				-- Set parsed so we can access certain functions
			has_parsed := True

			l_args := arguments.argument_array
			if l_args.count > 1 then
				l_switches := available_switches
				l_prefixes := switch_prefixes
				l_cs := is_case_sensitive
				l_use_separated := is_using_separated_switch_values

					-- Iterate arguments
				from
					i := 1
					l_upper := l_args.upper
				until i > l_upper loop
					check
						l_last_switch_unattached: not l_use_separated implies l_last_switch = Void
					end
					l_arg ?= l_args[i]
					if not l_arg.is_empty and then l_prefixes.has (l_arg.item (1)) then
						l_last_switch := Void

						if l_arg.count > 2 and then l_prefixes.has (l_arg.item (2)) then
							l_option := l_arg.substring (3, l_arg.count)
							l_use_long_name := True
						else
							l_option := l_arg.substring (2, l_arg.count)
							l_use_long_name := False
						end

							-- Indicates a switch option
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
								l_value_switch := Void
								l_match := False
								l_cursor := l_switches.cursor
								from l_switches.start until l_switches.after or l_match loop
									l_switch := l_switches.item
									if l_use_long_name then
										if l_cs then
											l_match := l_switch.long_name.is_equal (l_option)
										else
											l_match := l_switch.long_name.is_case_insensitive_equal (l_option)
										end
									else
										if l_cs then
											l_match := l_switch.name.is_equal (l_option)
										else
											l_match := l_switch.name.is_case_insensitive_equal (l_option)
										end
									end
									if l_match then
										l_value_switch ?= l_switch
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
													l_match := l_switch.short_name.is_equal (l_option.item (k))
												else
													l_match := l_switch.short_name.as_lower.is_equal (l_option.item (k))
												end
												if l_match and k < l_count then
														-- if matches and we are not processing the last item
													internal_option_values.extend (l_switch.create_option)
												end
											end

											l_switches.forth
										end
										k := k + 1
									end

									if l_match then
											-- Last item can be a value switch
										l_value_switch ?= l_switch
									end
								end

								l_switches.go_to (l_cursor)
								check l_switch_attached: l_match implies l_switch /= Void end

								if l_match then
									if l_value /= Void and then not l_value.is_empty and then l_value_switch /= Void then
										internal_option_values.extend (l_value_switch.create_value_option (l_value))
									else
											-- Create user option
										internal_option_values.extend (l_switch.create_option)
									end
									if l_use_separated then
										l_last_switch := l_switch
									end
								else
									add_template_error (e_unreconized_switch_error, [ellipse_text (l_arg)])
								end
							end
						else
							add_template_error (e_invalid_switch_error, [ellipse_text (l_arg)])
						end
					else
						l_value_switch ?= l_last_switch
						if l_value_switch = Void then
							if not l_arg.is_empty then
									-- Create non-switched option
								internal_values.extend (l_arg)
							else
								add_template_error (e_invalid_switch_error, [ellipse_text (l_arg)])
							end
						else
							check
								not_internal_option_values_is_empty: not internal_option_values.is_empty
								same_name: internal_option_values.last.switch.id.is_equal (l_last_switch.id)
							end
							internal_option_values.finish
							if l_arg /= Void and then not l_arg.is_empty then
								internal_option_values.replace (l_value_switch.create_value_option (l_arg))
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
			is_logo_information_suppressed := switch_of_name (nologo_switch) = Void or else has_option (nologo_switch)
			is_help_usage_displayed := has_option (help_switch)
		end

feature {NONE} -- Validation

	validate_arguments
			-- Validates arguments to ensure they are configured correctly.
		require
			has_parsed: has_parsed
		local
			l_switches: !like available_switches
			l_options: ?like options_of_name
			l_switch_groups: ?like switch_groups
			l_switch_appurtenances: ?like switch_appurtenances
			l_cursor: CURSOR
			l_ocursor: CURSOR
			l_switch: ARGUMENT_SWITCH
			l_val_switch: ARGUMENT_VALUE_SWITCH
			l_value: STRING
			l_validator: ARGUMENT_VALUE_VALIDATOR
			l_succ: BOOLEAN
		do
			l_switch_groups := switch_groups
			l_switch_appurtenances := switch_appurtenances
			if l_switch_groups /= Void then
				l_switch_groups := valid_switch_groups
				if l_switch_groups.is_empty then
					add_error (e_switch_group_unreconized_error)
				end
			end
			if l_switch_appurtenances /= Void then
				if not option_values.is_empty then
					validate_switch_appurtenances
				end
			end

			if l_switch_groups = Void or else not l_switch_groups.is_empty then
					-- Validate applicable non-switched arguments
				validate_non_switched_arguments (l_switch_groups)
			end

			l_switches := available_switches
			l_cursor := l_switches.cursor
			from l_switches.start until l_switches.after loop
				l_succ := True
				l_switch := l_switches.item
				l_options := options_of_name (l_switch.id)

					-- Check optional
				if (l_switch_groups = Void and l_switch_appurtenances = Void)and then not l_switch.optional and l_options.is_empty then
					add_template_error (e_missing_switch_error, [l_switch.name])
				elseif not l_options.is_empty then

						-- Check multiple
					if not l_switch.allow_multiple and l_options.count > 1 then
						add_template_error (e_multiple_switch_error, [l_switch.name])
					end

					l_ocursor := l_options.cursor
					l_val_switch ?= l_switch
					if l_val_switch /= Void then

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
									l_validator.validate_value (l_value)
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
			switches_unmoved: available_switches.cursor.is_equal (old available_switches.cursor)
			option_values_unmoved: option_values.cursor.is_equal (old option_values.cursor)
			values_unmoved: values.cursor.is_equal (old values.cursor)
		end

	validate_non_switched_arguments (a_groups: ?LIST [!ARGUMENT_GROUP])
			-- Validates non-switched arguments for groups.
			--
			-- `a_groups': The group of arguments to validate.
		require
			has_parsed: has_parsed
			not_a_groups_is_empty: a_groups /= Void implies not a_groups.is_empty
		local
			l_values: like values
			l_cursor: CURSOR
			l_validator: ARGUMENT_VALUE_VALIDATOR
		do
			l_values := values
			if not l_values.is_empty then
				if not is_allowing_non_switched_arguments then
					add_error (e_non_switched_argument_specified_error)
				end
				if is_allowing_non_switched_arguments then
					l_validator := non_switched_argument_validator
					if non_switched_argument_validator /= Void then
						l_cursor := l_values.cursor
						from l_values.start until l_values.after loop
							l_validator.validate_value (l_values.item)
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
			values_unmoved: values.cursor.is_equal (old values.cursor)
		end

	validate_switch_appurtenances
			-- Validate all switch appurtenances to ensure a specified switch has all its dependencies.
		require
			has_parsed: has_parsed
			switch_appurtenances_attached: switch_appurtenances /= Void
			not_option_values_is_empty: not option_values.is_empty
		local
			l_switch_appurtenances: like switch_appurtenances
			l_appurtenances: ARRAY [ARGUMENT_SWITCH]
			l_appurtenance: ARGUMENT_SWITCH
			l_option: ARGUMENT_SWITCH
			l_options: !like option_values
			l_cursor: CURSOR
			l_count: INTEGER
			i: INTEGER
		do
			l_switch_appurtenances := switch_appurtenances
			l_options := option_values

			l_cursor := l_options.cursor
			from l_options.start until l_options.after loop
				l_option := l_options.item.switch
				if l_switch_appurtenances.has (l_option) then
					l_appurtenances := l_switch_appurtenances [l_option]
					l_count := l_appurtenances.count
					from i := 1 until i > l_count loop
						l_appurtenance := l_appurtenances [i]
						if not l_appurtenance.optional then
							if not l_appurtenance.is_special and then option_of_name (l_appurtenance.id) = Void then
								add_template_error (e_missing_switch_dependency_error, [l_option.name, l_appurtenance.name])
							end
						end
						i := i + 1
					end
				end
				l_options.forth
			end
			l_options.go_to (l_cursor)
		end

	frozen valid_switch_groups: !ARRAYED_LIST [!ARGUMENT_GROUP]
			-- Validate all switch groups to ensure argument configuration is correct.
			-- Note: Only switches are checked. This is to ensure full errors can be reported
			--       regarding non-switched arguments.
		require
			has_parsed: has_parsed
			switch_groups_attached: switch_groups /= Void
		local
			l_extend_groups: !like expanded_switch_groups
			l_options: !like option_values
			l_switch: ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_valid: BOOLEAN
			l_switches: ARRAY [ARGUMENT_SWITCH]
			i, nb: INTEGER
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
						i := l_switches.lower
						nb := l_switches.upper
						l_valid := True
					until
						i > nb or not l_valid
					loop
						l_switch := l_switches.item (i)
						if l_switch /= Void then
							l_valid := l_switch.optional or else has_option (l_switch.id)
						end
						i := i + 1
					end
					if not l_valid then
						l_extend_groups.remove
					else
						l_extend_groups.forth
					end
				end
			end

			Result := l_extend_groups
		end

	frozen expanded_switch_groups: !ARRAYED_LIST [!ARGUMENT_GROUP]
			-- Expanded set of switch groups based on `switch_groups' and `switch_appurtenances'.
		require
			has_parsed: has_parsed
			switch_groups_attached: switch_groups /= Void
		local
			l_groups: !like switch_groups
			l_cursor: CURSOR
		do
				-- Create extend switch groups
			l_groups ?= switch_groups
			create Result.make (l_groups.count)
			l_cursor := l_groups.cursor
			from l_groups.start until l_groups.after loop
				Result.extend (expand_switch_group (l_groups.item))
				l_groups.forth
			end
			l_groups.go_to (l_cursor)
			check matching_counts: Result.count = l_groups.count end
		ensure
			result_count_equal: Result.count = switch_groups.count
			switch_groups_unmoved: switch_groups.cursor.is_equal (old switch_groups.cursor)
		end

	frozen expand_switch_group (a_group: !ARGUMENT_GROUP): !ARGUMENT_GROUP
			-- Expands a group of switch `a_group' to include any item associated appurtenance switches.
			--
			-- `a_group':
			-- `Result':
		require
			a_group_attached: a_group /= Void
		local
			l_switch_appurtenances: ?like switch_appurtenances
			l_appurtenances: !ARRAY [!ARGUMENT_SWITCH]
			l_switch: !ARGUMENT_SWITCH
			l_switches: !ARRAYED_LIST [!ARGUMENT_SWITCH]
			l_group_switches: !ARRAY [!ARGUMENT_SWITCH]
			l_icount: INTEGER
			l_jcount: INTEGER
			i, j: INTEGER
		do
			l_group_switches := a_group.switches
			create l_switches.make_from_array (l_group_switches)
			l_switch_appurtenances := switch_appurtenances
			if l_switch_appurtenances /= Void then
				l_icount := l_group_switches.count
				from i := 1 until i > l_icount loop
					l_switch := l_group_switches [i]
					if l_switch_appurtenances.has (l_switch) then
						l_appurtenances := l_switch_appurtenances [l_switch]
						l_jcount := l_appurtenances.count
						from j := 1 until j > l_jcount loop
							l_switch := l_appurtenances [j]
							if not l_switches.has (l_switch) then
								l_switches.extend (l_switch)
							end
							j := j + 1
						end
					end
					i := i + 1
				end
			end

			if a_group.is_hidden then
				create Result.make (l_switches, a_group.is_allowing_non_switched_arguments)
			else
				create Result.make_hidden (l_switches, a_group.is_allowing_non_switched_arguments)
			end
		end

feature {NONE} -- Error Handling

	add_error (a_msg: !STRING)
			-- Adds a parse error.
			--
			-- `a_msg': The message to log as an error.
		require
			not_a_msg_is_empty: not a_msg.is_empty
			not_error_messages_has_a_msg: not error_messages.has (a_msg)
		do
			error_messages.extend (a_msg)
		ensure
			error_messages_extended: error_messages.has (a_msg)
		end

	add_template_error (a_tmpl: !STRING; a_contexts: !TUPLE)
			-- Adds a parse error base on a template specification.
			-- Note: See {STRING_FORMATTER}.`format'.
			--
			-- `a_tmpl': A template message to log as an error.
			-- `a_contexts': A list of arguments to use to replace the token in the template.
		require
			not_a_tmpl_is_empty: not a_tmpl.is_empty
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
			l_cfgs: ?like command_option_configurations
			l_cfg: STRING
			l_cursor: CURSOR
			l_ext: like extended_usage
			l_name: STRING
		do
			l_name := system_name
			io.put_string (once "USAGE: %N")

			l_cfgs := command_option_configurations
			if l_cfgs /= Void then
				l_cursor := l_cfgs.cursor
				from l_cfgs.start until l_cfgs.after loop
					io.put_string ("   ")
					io.put_string (l_name)
					io.put_character (' ')
					l_cfg := l_cfgs.item.twin
					l_cfg.replace_substring_all ("%N", "%N" + create {STRING}.make_filled (' ', l_name.count + 1))
					io.put_string (l_cfg)
					if not l_cfgs.islast then
						io.new_line
					end
					l_cfgs.forth
				end
				l_cfgs.go_to (l_cursor)
			else
				io.put_string ("   ")
				io.put_string (l_name)
			end

			if has_visible_available_options then
				io.new_line
				display_options
			end
			l_ext := extended_usage
			if l_ext /= Void then
				io.new_line
				io.put_string (l_ext)
			end
			io.new_line
		end

	display_logo
			-- Displays copyright information.
		local
			l_name: !like name
			l_copy: !like copyright
			l_ver: !like version
			l_logo: !STRING
		do
			l_name := name
			l_copy := copyright
			l_ver := version

			create l_logo.make (l_name.count + l_copy.count + l_ver.count + 13)
			l_logo.append (l_name)
			l_logo.append (" - Version: ")
			l_logo.append (l_ver)
			l_logo.append ("%N")
			l_logo.append (l_copy)
			io.put_string (l_logo)
			io.new_line
			io.new_line
		end

	display_errors
			-- Displays any parse/validation related error messages.
		require
			not_is_successful: not is_successful
		local
			l_errors: !like error_messages
			l_cursor: CURSOR
			l_item: !STRING
			l_error: !STRING
			l_tab_string: !STRING
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

				l_item := l_errors.item
				create l_error.make (2 + tab_string.count + l_item.count)
				l_error.append (l_item)
				l_error.replace_substring_all ("%N", l_tab_string)

				io.error.put_string (l_error)
				io.error.new_line
				l_errors.forth
			end
			l_errors.go_to (l_cursor)
			io.error.new_line
		ensure
			error_messages_unmoved: error_messages.cursor.is_equal (old error_messages.cursor)
		end

	display_options
			-- Displays configurable options.
		require
			has_visible_available_options: has_visible_available_options
		local
			l_nl: STRING
			l_tabbed_nl: STRING
			l_max_len: INTEGER
			l_options: like available_switches
			l_cursor: CURSOR
			l_opt: ARGUMENT_SWITCH
			l_name: STRING
			l_arg_name: STRING
			l_desc: STRING
			l_arg_desc: STRING
			l_prefixes: like switch_prefixes
			l_prefix: STRING
			l_def_prefix: CHARACTER
			l_value_switches: ARRAYED_LIST [ARGUMENT_VALUE_SWITCH]
			l_value_switch: ARGUMENT_VALUE_SWITCH
			l_added_args: ARRAYED_LIST [STRING]
			l_inline_args: like is_showing_argument_usage_inline
			l_count: INTEGER
			i: INTEGER
		do
			io.put_string ("%NOPTIONS:%N")

			create l_value_switches.make (0)

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

			l_options := available_visible_switches
			l_nl := "%N"

				-- Retrieve option max length for alignment
			l_cursor := l_options.cursor
			from l_options.start until l_options.after loop
				if not l_options.item.is_hidden then
					if l_options.item.has_short_name then
						l_max_len := l_max_len.max (l_options.item.long_name.count + 4)
					else
						l_max_len := l_max_len.max (l_options.item.long_name.count)
					end
				end
				l_options.forth
			end

			create l_tabbed_nl.make_filled (' ', l_nl.count + tab_string.count + 2 + l_max_len)
			l_tabbed_nl.insert_string (l_nl, 1)

			l_def_prefix := switch_prefixes[1]

			l_inline_args := is_showing_argument_usage_inline

				-- Output available options			
			from l_options.start until l_options.after loop
				l_opt := l_options.item
				l_value_switch ?= l_opt
				if l_value_switch /= Void then
					l_value_switches.extend (l_value_switch)
				end

				if l_opt.has_short_name then
					l_arg_name := l_opt.short_name.out + " " + l_def_prefix.out + l_def_prefix.out + l_opt.long_name
				else
					l_arg_name := l_opt.long_name
				end
				if l_max_len > l_arg_name.count then
					create l_name.make_filled (' ', l_max_len - l_arg_name.count)
				else
					create l_name.make_empty
				end
				l_name.insert_string (l_arg_name, 1)

				create l_desc.make (256)
				l_desc.append (l_opt.description)
				if l_opt.optional then
					l_desc.append (once " (Optional)")
				end
				if l_inline_args and then l_value_switch /= Void then
					l_arg_name := l_value_switch.arg_name
					l_desc.append (once "%N<")
					l_desc.append (l_arg_name)
					l_desc.append (once ">: ")
					if l_value_switch.is_value_optional then
						l_desc.append (once "(Optional) ")
					end
					l_arg_desc := l_value_switch.arg_description.twin
					l_arg_desc.replace_substring_all ("%N", "%N" + create {STRING}.make_filled (' ', l_arg_name.count + 4))
					l_desc.append (l_arg_desc)
				end
				l_desc.replace_substring_all (l_nl, l_tabbed_nl)

				io.put_string (tab_string)
				io.put_character (l_def_prefix)
				io.put_string (l_name)
				io.put_string (once ": ")
				io.put_string (l_desc)
				io.new_line
				l_options.forth
			end
			l_options.go_to (l_cursor)

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

				create l_tabbed_nl.make_filled (' ', l_nl.count + 6 + l_max_len)
				l_tabbed_nl.insert_string (l_nl, 1)

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

						l_desc := l_value_switch.arg_description.twin
						l_desc.replace_substring_all (l_nl, l_tabbed_nl)

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

	name: !STRING
			-- Full name of application.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	version: !STRING
			-- Version number of application.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	copyright: !STRING
			-- Copyright information.
		once
			Result := "Copyright Eiffel Software 1985-2008. All Rights Reserved."
		ensure
			not_result_is_empty: not Result.is_empty
		end

	frozen command_option_configurations: ?ARRAYED_LIST [!STRING]
			-- Command line option configuration string (to display in usage).
		indexing
			once_status: global
		local
			l_groups: ?like switch_groups
			l_group: ARGUMENT_GROUP
			l_cfg: ?like command_option_group_configuration
			l_switches: !ARRAYED_LIST [!ARGUMENT_SWITCH]
			l_switch: ?ARGUMENT_SWITCH
			l_cursor: CURSOR
			l_empty_groups: BOOLEAN
		once
			l_groups := switch_groups
			create Result.make (10)
			l_empty_groups := l_groups = Void or else l_groups.is_empty
			if not l_empty_groups then
				l_empty_groups := l_groups.for_all (agent {!ARGUMENT_GROUP}.is_hidden)
			end
			if l_empty_groups then
				l_switches := available_visible_switches
				l_cfg := command_option_group_configuration (l_switches, is_allowing_non_switched_arguments, is_non_switch_argument_required, True, l_switches)
				if l_cfg /= Void then
					Result.extend (l_cfg)
				end
			else
				create Result.make (1024)
				Result.compare_objects
				l_cursor := l_groups.cursor
				from l_groups.start until l_groups.after loop
					l_group := l_groups.item
					if not l_group.is_hidden then
						l_switches := create {ARRAYED_LIST [!ARGUMENT_SWITCH]}.make_from_array (l_group.switches)
							-- Add nologo switch, if not already added
						l_switch := switch_of_name (nologo_switch)
						if l_switch /= Void then
							if not l_switches.has (l_switch) then
								l_switches.extend (l_switch)
							end
						end

						l_cfg := command_option_group_configuration (l_switches, is_allowing_non_switched_arguments and l_group.is_allowing_non_switched_arguments, True, True, l_switches)
						if l_cfg /= Void and then not Result.has (l_cfg) then
								-- With exclusion of hidden options command line groups may look the same.
							Result.extend (l_cfg)
						end
					end
					l_groups.forth
				end
				l_groups.go_to (l_cursor)
				if Result.is_empty then
					Result := Void
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_contains_valid_items: Result /= Void implies Result.for_all (
				agent (ia_item: !STRING): BOOLEAN
					do
						Result := not ia_item.is_empty
					end)
			available_switches_unmoved: available_switches.cursor.is_equal (old available_switches.cursor)
			switch_groups_unmoved: (
				agent (a_new, a_old: ?like switch_groups): BOOLEAN
					do
						Result := a_old = Void
						if not Result then
							Result := a_new.cursor.is_equal (a_old.cursor)
						end
					end).item ([switch_groups, old switch_groups])
		end

	command_option_group_configuration (a_group: !LIST [!ARGUMENT_SWITCH]; a_show_non_switch: BOOLEAN; a_non_switch_required: BOOLEAN; a_add_appurtenances: BOOLEAN; a_src_group: !LIST [!ARGUMENT_SWITCH]): ?STRING
			-- Command line option configuration string (to display in usage) for a specific group of options.
		require
			a_group_equals_a_src_group: a_add_appurtenances implies a_group = a_src_group
		local
			l_appurtenances: like switch_appurtenances
			l_use_separated: like is_using_separated_switch_values
			l_cursor: CURSOR
			l_switch: !ARGUMENT_SWITCH
			l_val_switch: ARGUMENT_VALUE_SWITCH
			l_cfg: STRING
			l_prefix: CHARACTER
			l_opt: BOOLEAN
			l_opt_val: BOOLEAN
			l_add_switch: BOOLEAN
		do
			if not a_group.is_empty then
				l_appurtenances := switch_appurtenances

				l_prefix := switch_prefixes[1]
				l_use_separated := is_using_separated_switch_values
				create Result.make  (a_group.count * 12)

				l_cursor := a_group.cursor
				from a_group.start until a_group.after loop
					l_switch := a_group.item
					l_val_switch ?= l_switch
					l_opt := l_switch.optional
					if not l_switch.id.is_equal (help_switch) and not l_switch.is_hidden then
						l_add_switch := not a_add_appurtenances implies (not a_src_group.has (l_switch) or l_switch.optional)
						if l_add_switch then

							if l_opt then
								Result.append_character ('[')
							end
							Result.append_character (l_prefix)
							Result.append (l_switch.name)
							if l_val_switch /= Void then
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
							if l_appurtenances /= Void and then l_appurtenances.has (l_switch) then
								l_cfg := command_option_group_configuration (create {ARRAYED_LIST [!ARGUMENT_SWITCH]}.make_from_array (l_appurtenances [l_switch]), False, False, False, a_src_group)
								if l_cfg /= Void then
									Result.append_character (' ')
									Result.append (l_cfg)
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

				if Result.is_empty then
					Result := Void
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			a_group_unmoved: a_group.cursor.is_equal (old a_group.cursor)
		end

	extended_usage: ?STRING
			-- Retrieces extended configuration information
			-- Redefine in subclass.
		do
				--| Nothing to do here.
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {NONE} -- Switches

	nologo_switch: !STRING
			-- Supress copyright information switch.
		once
			Result := "nologo"
		ensure
			not_result_is_empty: not Result.is_empty
		end

	help_switch: !STRING
			-- Display usage information switch.
		once
			if {PLATFORM}.is_windows then
				Result := "?"
			else
				Result := "h|help"
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	frozen available_switches: !ARRAYED_LIST [!ARGUMENT_SWITCH]
			-- Retrieve a list of available switch.
		indexing
			once_status: global
		local
			l_switches: ?like switches
			l_switch: !ARGUMENT_SWITCH
		once
			l_switches := switches
			if l_switches /= Void then
				create Result.make (2 + l_switches.count)
				Result.append (l_switches)
			else
				create Result.make (2)
			end

			if is_using_builtin_switches then
				create l_switch.make (nologo_switch, "Supresses copyright information.", True, False)
				l_switch.set_is_special
				Result.extend (l_switch)
			end
			create l_switch.make (help_switch, "Display usage information.", True, False)
			l_switch.set_is_special
			Result.extend (l_switch)
		end

	frozen available_visible_switches: !ARRAYED_LIST [!ARGUMENT_SWITCH]
			-- Retrieve a list of available visible (not hidden) switch.
		indexing
			once_status: global
		local
			l_switches: !like available_switches
			l_switch: !ARGUMENT_SWITCH
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
		end

	switches: ?ARRAYED_LIST [!ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application.
		deferred
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	switch_groups: ?ARRAYED_LIST [!ARGUMENT_GROUP]
			-- Valid switch grouping.
		do
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	switch_appurtenances: ?HASH_TABLE [!ARRAY [!ARGUMENT_SWITCH], !ARGUMENT_SWITCH]
			-- Switch appurtenances (dependencies)
			-- Note: Siwtch appurtenances are implictly added to a group where a switch is present.
		do
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {NONE} -- Formatting

	frozen ellipse_text (a_str: !STRING): !STRING
			-- If `a_str' is bigger than `ellipse_threshold'.
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

feature {NONE} -- Constants

	switch_prefixes: !ARRAY [CHARACTER]
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
		end

	switch_value_qualifer: CHARACTER
			-- Character used to separate an switch from it's value.
		once
			Result := ':'
		ensure
			result_not_null: Result /= '%U'
			result_not_is_id_character: not Result.is_alpha_numeric and Result /= '_'
		end

	default_system_name: !STRING = "app"
			-- Default application name.

	tab_string: !STRING = "   "
			-- Tab indent string.

feature {NONE} -- Internationalization`

	e_invalid_switch_error: !STRING = "The switch '{1}' is invalid."
	e_unreconized_switch_error: !STRING = "Unreconized switch '{1}'."
	e_invalid_switch_value: !STRING = "'{1}' is an invalid option for switch '{2}'."
	e_require_switch_value: !STRING = "Switch '{1}' requires a paired value '{2}'."
	e_multiple_switch_error: !STRING = "Switch '{1}' can only be used once."
	e_non_value_switch: !STRING = "Switch '{1}' should not have any value paired with it."
	e_missing_switch_error: !STRING = "Switch '{1}' was not specified."
	e_non_switched_argument_specified_error: !STRING = "Arguments without a switch prefix are not valid arguments."
	e_multiple_non_switched_argument_specified_error: !STRING = "Only one argument without a switch prefix can be passed."
	e_switch_group_unreconized_error: !STRING = "The specified switches are not in a valid configuration."
	e_missing_switch_dependency_error: !STRING = "Switch '{1}' require the switch '{2}' be specified also."
	e_invalid_switch_value_with_reason: !STRING = "'{1}' is an invalid option for switch '{2}'.%N{3}"
	e_invalid_non_switched_value_with_reason: !STRING = "'{1}' is an invalid option.%N{2}"

feature {NONE} -- Internal Implementation Cache

	internal_option_values: !ARRAYED_LIST [!ARGUMENT_OPTION]
			-- Mutable, unprotected verion of `option_values'

	internal_values: !ARRAYED_LIST [!STRING]
			-- Mutable, unprotected version of `values'

invariant
	not_is_non_switch_argument_required: not is_allowing_non_switched_arguments implies not is_non_switch_argument_required
	internal_option_values_attached: has_parsed implies internal_option_values /= Void
	internal_values_attached: is_successful implies internal_values /= Void
	is_successful_means_has_parsed: is_successful implies has_parsed

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {ARGUMENT_BASE_PARSER}
