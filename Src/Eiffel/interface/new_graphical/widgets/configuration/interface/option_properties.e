indexing
	description: "Generate properties for options."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OPTION_PROPERTIES

inherit
	CONF_INTERFACE_NAMES

	CONF_ACCESS

	CONF_VALIDITY
		export
			{NONE} all
		end

feature -- Access

	properties: PROPERTY_GRID
			-- Grid where properties get added.

	is_il_generation: BOOLEAN
			-- IL generation enabled?

	debug_clauses: DS_ARRAYED_LIST [STRING]
			-- Possible debug clauses.

feature {NONE} -- Implementation

	add_misc_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_string_prop: TEXT_PROPERTY [STRING_32]
		do
			properties.add_section (section_general)

			create l_bool_prop.make_with_value (option_profile_name, an_inherited_options.is_profile)
			l_bool_prop.change_value_actions.extend (agent an_options.set_profile)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent is_profile_wrapper (an_inherited_options))
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_profile)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))

				if an_options.is_profile_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (option_trace_name, an_inherited_options.is_trace)
			l_bool_prop.change_value_actions.extend (agent an_options.set_trace)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent is_trace_wrapper (an_inherited_options))
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_trace)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))

				if an_options.is_trace_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (option_optimize_name, an_inherited_options.is_optimize)
			l_bool_prop.change_value_actions.extend (agent an_options.set_optimize)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent is_optimize_wrapper (an_inherited_options))
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_optimize)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))

				if an_options.is_optimize_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			if is_il_generation then
				create l_string_prop.make (option_namespace_name)
				l_string_prop.set_description (option_namespace_description)
				if an_options.namespace /= Void then
					l_string_prop.set_value (an_options.namespace)
				end
				l_string_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent an_options.set_namespace))
				properties.add_property (l_string_prop)
			end
		end

	add_assertion_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_require, l_ensure, l_check, l_invariant, l_loop: BOOLEAN_PROPERTY
			l_assertions, l_inh_assertions: CONF_ASSERTIONS
		do
			l_inh_assertions := an_inherited_options.assertions
			l_assertions := an_options.assertions
			if l_inh_assertions = Void then
				create l_inh_assertions
			end
			properties.add_section ("Assertions")

			create l_require.make_with_value (option_require_name, l_inh_assertions.is_precondition)
			l_require.set_description (option_require_description)
			l_require.change_value_actions.extend (agent update_assertion (an_options, option_require_name, ?))
			properties.add_property (l_require)

			create l_ensure.make_with_value (option_ensure_name, l_inh_assertions.is_postcondition)
			l_ensure.set_description (option_ensure_description)
			l_ensure.change_value_actions.extend (agent update_assertion (an_options, option_ensure_name, ?))
			properties.add_property (l_ensure)

			create l_check.make_with_value (option_check_name, l_inh_assertions.is_check)
			l_check.set_description (option_check_description)
			l_check.change_value_actions.extend (agent update_assertion (an_options, option_check_name, ?))
			properties.add_property (l_check)

			create l_invariant.make_with_value (option_invariant_name, l_inh_assertions.is_invariant)
			l_invariant.set_description (option_invariant_description)
			l_invariant.change_value_actions.extend (agent update_assertion (an_options, option_invariant_name, ?))
			properties.add_property (l_invariant)

			create l_loop.make_with_value (option_loop_name, l_inh_assertions.is_loop)
			l_loop.set_description (option_loop_description)
			l_loop.change_value_actions.extend (agent update_assertion (an_options, option_loop_name, ?))
			properties.add_property (l_loop)

				-- assertion inheritance handling
			if a_inherits then
				if l_assertions /= Void then
					l_require.enable_overriden
					l_ensure.enable_overriden
					l_check.enable_overriden
					l_invariant.enable_overriden
					l_loop.enable_overriden

					l_require.set_refresh_action (agent l_inh_assertions.is_precondition)
					l_ensure.set_refresh_action (agent l_inh_assertions.is_postcondition)
					l_check.set_refresh_action (agent l_inh_assertions.is_check)
					l_invariant.set_refresh_action (agent l_inh_assertions.is_invariant)
					l_loop.set_refresh_action (agent l_inh_assertions.is_loop)

					l_require.use_inherited_actions.extend (agent an_options.set_assertions (Void))
					l_require.use_inherited_actions.extend (agent refresh)
					l_ensure.use_inherited_actions.extend (agent an_options.set_assertions (Void))
					l_ensure.use_inherited_actions.extend (agent refresh)
					l_check.use_inherited_actions.extend (agent an_options.set_assertions (Void))
					l_check.use_inherited_actions.extend (agent refresh)
					l_invariant.use_inherited_actions.extend (agent an_options.set_assertions (Void))
					l_invariant.use_inherited_actions.extend (agent refresh)
					l_loop.use_inherited_actions.extend (agent an_options.set_assertions (Void))
					l_loop.use_inherited_actions.extend (agent refresh)
				else
					l_require.enable_inherited
					l_ensure.enable_inherited
					l_check.enable_inherited
					l_invariant.enable_inherited
					l_loop.enable_inherited

					l_require.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
					l_ensure.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
					l_check.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
					l_invariant.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
					l_loop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
				end
			end
		end

	add_warning_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add debug option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_warning: STRING
		do
			properties.add_section ("Warning")

			create l_bool_prop.make_with_value (option_warnings_name, an_inherited_options.is_warning)
			l_bool_prop.set_description (option_warnings_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_warning)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
			if a_inherits then
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_warning)
				l_bool_prop.use_inherited_actions.extend (agent refresh)

				if an_options.is_warning_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			if an_inherited_options.is_warning then
				from
					valid_warnings.start
				until
					valid_warnings.after
				loop
					l_warning := valid_warnings.item_for_iteration

					create l_bool_prop.make_with_value (l_warning, an_inherited_options.is_warning_enabled (l_warning))
					l_bool_prop.set_description (warning_descriptions.item (l_warning))
					l_bool_prop.change_value_actions.extend (agent an_options.add_warning (l_warning, ?))
					properties.add_property (l_bool_prop)

					valid_warnings.forth
				end
			end
		end

	add_debug_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add debug option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_debug: STRING
		do
			properties.add_section ("Debug")

			create l_bool_prop.make_with_value (option_debug_name, an_inherited_options.is_debug)
			l_bool_prop.set_description (option_debug_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_debug)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
			if a_inherits then
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_debug)
				l_bool_prop.use_inherited_actions.extend (agent refresh)

				if an_options.is_debug_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			if an_inherited_options.is_debug then
				create l_bool_prop.make_with_value (option_unnamed_debug_name, an_inherited_options.is_debug_enabled (unnamed_debug))
				l_bool_prop.change_value_actions.extend (agent an_options.add_debug (unnamed_debug, ?))
				properties.add_property (l_bool_prop)

				from
					debug_clauses.start
				until
					debug_clauses.after
				loop
					l_debug := debug_clauses.item_for_iteration

					create l_bool_prop.make_with_value (l_debug, an_inherited_options.is_debug_enabled (l_debug))
					l_bool_prop.change_value_actions.extend (agent an_options.add_debug (l_debug, ?))
					properties.add_property (l_bool_prop)

					debug_clauses.forth
				end
			end
		end

	update_assertion (an_option: CONF_OPTION; a_name: STRING; a_value: BOOLEAN) is
			-- Update the assertion setting of `an_option' with `a_name' to `a_value'.
		require
			a_name_valid: a_name.is_equal (option_require_name) or a_name.is_equal (option_ensure_name) or
				a_name.is_equal (option_check_name) or a_name.is_equal (option_invariant_name) or a_name.is_equal (option_loop_name)
		local
			l_assertion: CONF_ASSERTIONS
		do
			l_assertion := an_option.assertions
			if l_assertion = Void then
				create l_assertion
				an_option.set_assertions (l_assertion)
			end
			if a_name.is_equal (option_require_name) then
				if a_value then
					l_assertion.enable_precondition
				else
					l_assertion.disable_precondition
				end
			elseif a_name.is_equal (option_ensure_name) then
				if a_value then
					l_assertion.enable_postcondition
				else
					l_assertion.disable_postcondition
				end
			elseif a_name.is_equal (option_check_name) then
				if a_value then
					l_assertion.enable_check
				else
					l_assertion.disable_check
				end
			elseif a_name.is_equal (option_invariant_name) then
				if a_value then
					l_assertion.enable_invariant
				else
					l_assertion.disable_invariant
				end
			elseif a_name.is_equal (option_loop_name) then
				if a_value then
					l_assertion.enable_loop
				else
					l_assertion.disable_loop
				end
			end
		end

feature {NONE} -- Refresh displayed data.

	refresh is
			-- Called if the displayed data should be regenerated from scratch.
		do
		end

feature {NONE} -- Wrappers

	change_no_argument_boolean_wrapper (a_dummy: BOOLEAN; a_call: PROCEDURE [ANY, TUPLE[]]) is
			-- Wrapper that allows to plugin in an agent without arguments on a change call (e.g. to refresh inheritance information).
		require
			a_call_not_void: a_call /= Void
		do
			a_call.call ([])
		end

	simple_wrapper (a_string: STRING_GENERAL; a_call: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Wrapper to allow to call agents that only accept STRING.
		require
			valid_8_string: a_string /= Void implies a_string.is_valid_as_string_8
			a_call_not_void: a_call /= Void
		do
			if a_string /= Void then
				a_call.call ([a_string.to_string_8])
			else
				a_call.call (Void)
			end
		end

feature {NONE} -- Attribute access wrappers.

	is_profile_wrapper (an_options: CONF_OPTION): BOOLEAN is
			-- Wrapper to access `is_profile' attribute of {CONF_OPTION}.
		require
			an_options_not_void: an_options /= Void
		do
			Result := an_options.is_profile
		end

	is_trace_wrapper (an_options: CONF_OPTION): BOOLEAN is
			-- Wrapper to access `is_trace' attribute of {CONF_OPTION}.
		require
			an_options_not_void: an_options /= Void
		do
			Result := an_options.is_trace
		end

	is_optimize_wrapper (an_options: CONF_OPTION): BOOLEAN is
			-- Wrapper to access `is_optimize' attribute of {CONF_OPTION}.
		require
			an_options_not_void: an_options /= Void
		do
			Result := an_options.is_optimize
		end


end
