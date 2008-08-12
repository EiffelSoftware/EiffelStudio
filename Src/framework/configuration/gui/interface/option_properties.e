indexing
	description: "Generate properties for options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OPTION_PROPERTIES

inherit
	CONF_GUI_INTERFACE_CONSTANTS

	CONF_ACCESS

	CONF_VALIDITY
		export
			{NONE} all
		end

	WRAPPER_HELPER

	PROPERTY_HELPER

feature -- Access

	conf_factory: CONF_PARSE_FACTORY is
			-- Factory to create new nodes.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	window: EV_WINDOW
			-- Window to show errors modal. If `Void' it will be shown using the default from ES_PROMPT_PROVIDER.

	properties: PROPERTY_GRID
			-- Grid where properties get added.

	debug_clauses: DS_ARRAYED_LIST [STRING]
			-- Possible debug clauses.

feature -- Update

	set_debugs (a_debugs: like debug_clauses) is
			-- Set `debug_clauses' to `a_debugs'.
		require
			a_debugs_not_void: a_debugs /= Void
		do
			debug_clauses := a_debugs
		ensure
			debug_clauses_set: debug_clauses = a_debugs
		end

feature {NONE} -- Implementation

	handle_value_changes (a_has_group_changed: BOOLEAN) is
			-- Handle changed values (e.g. store changes to disk).
			-- `a_has_group_changed' indicates that a value that makes the node not group_equivalent has changed.
		do
			-- default is to do nothing
		end

	add_misc_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_choice_prop: STRING_CHOICE_PROPERTY
		do
			properties.add_section (conf_interface_names.section_general)

				-- Profiling option
			l_bool_prop := new_boolean_property (conf_interface_names.option_profile_name, an_inherited_options.is_profile)
			l_bool_prop.set_description (conf_interface_names.option_profile_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_profile)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_profile)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_profile)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_profile_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

				-- Tracing option
			l_bool_prop := new_boolean_property (conf_interface_names.option_trace_name, an_inherited_options.is_trace)
			l_bool_prop.set_description (conf_interface_names.option_trace_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_trace)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_trace)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_trace)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_trace_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

				-- Full checking option
			l_bool_prop := new_boolean_property (conf_interface_names.option_full_class_checking_name, an_inherited_options.is_full_class_checking)
			l_bool_prop.set_description (conf_interface_names.option_full_class_checking_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_full_class_checking)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_full_class_checking)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_full_class_checking)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_full_class_checking_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

				-- Cat call detection
			l_bool_prop := new_boolean_property (conf_interface_names.option_cat_call_detection_name, an_inherited_options.is_cat_call_detection)
			l_bool_prop.set_description (conf_interface_names.option_cat_call_detection_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_cat_call_detection)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_cat_call_detection)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_cat_call_detection)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_cat_call_detection_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

				-- Attachment properties
			l_bool_prop := new_boolean_property (conf_interface_names.option_is_attached_by_default_name, an_inherited_options.is_attached_by_default)
			l_bool_prop.set_description (conf_interface_names.option_is_attached_by_default_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_is_attached_by_default)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_attached_by_default)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_is_attached_by_default)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_attached_by_default_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

				-- Void safety
			l_bool_prop := new_boolean_property (conf_interface_names.option_is_void_safe_name, an_inherited_options.is_void_safe)
			l_bool_prop.set_description (conf_interface_names.option_is_void_safe_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_is_void_safe)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_void_safe)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_is_void_safe)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_void_safe_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

				-- Syntax support
			create l_choice_prop.make_with_choices (conf_interface_names.option_syntax_level_name, <<conf_interface_names.option_syntax_level_obsolete_name, conf_interface_names.option_syntax_level_transitional_name, conf_interface_names.option_syntax_level_standard_name>>)
			l_choice_prop.set_description (conf_interface_names.option_syntax_level_description)
			l_choice_prop.disable_text_editing
			if a_inherits then
				l_choice_prop.set_refresh_action (
					agent (i: CONF_OPTION): STRING_32
						do
							inspect i.syntax_level.item
							when {CONF_OPTION}.syntax_level_obsolete then
								Result := conf_interface_names.option_syntax_level_obsolete_name
							when {CONF_OPTION}.syntax_level_transitional then
								Result := conf_interface_names.option_syntax_level_transitional_name
							when {CONF_OPTION}.syntax_level_standard then
								Result := conf_interface_names.option_syntax_level_standard_name
							end
						end
					(an_inherited_options)
				)
				if an_options.syntax_level.is_set then
					l_choice_prop.enable_overriden
				else
					l_choice_prop.enable_inherited
				end
				l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?,
					agent (o: CONF_OPTION; p: STRING_CHOICE_PROPERTY)
						do
							if o.syntax_level.is_set then
								p.enable_overriden
							else
								p.enable_inherited
							end
						end
					(an_options, l_choice_prop)
				))
				l_choice_prop.use_inherited_actions.extend (agent (o: CONF_OPTION) do o.syntax_level.unset end (an_options))
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.enable_inherited)
				l_choice_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.enable_inherited)
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.redraw)
			end
			if an_options.syntax_level.is_set then
				inspect an_options.syntax_level.item
				when {CONF_OPTION}.syntax_level_obsolete then
					l_choice_prop.set_value (l_choice_prop.item_strings [1])
				when {CONF_OPTION}.syntax_level_transitional then
					l_choice_prop.set_value (l_choice_prop.item_strings [2])
				when {CONF_OPTION}.syntax_level_standard then
					l_choice_prop.set_value (l_choice_prop.item_strings [3])
				end
			end
			l_choice_prop.change_value_actions.put_front (
				agent (o: CONF_OPTION; value: STRING_32)
					do
						if value /= Void then
							if value.is_equal (conf_interface_names.option_syntax_level_obsolete_name) then
								o.syntax_level.put ({CONF_OPTION}.syntax_level_obsolete)
							elseif value.is_equal (conf_interface_names.option_syntax_level_transitional_name) then
								o.syntax_level.put ({CONF_OPTION}.syntax_level_transitional)
							else
								o.syntax_level.put ({CONF_OPTION}.syntax_level_standard)
							end
						end
					end
				(an_options, ?)
			)
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent l_choice_prop.redraw))
			properties.add_property (l_choice_prop)

			properties.current_section.expand
		end

	add_assertion_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require: BOOLEAN_PROPERTY
			l_assertions, l_inh_assertions: CONF_ASSERTIONS
		do
			l_inh_assertions := an_inherited_options.assertions
			l_assertions := an_options.assertions
			if l_inh_assertions = Void then
				l_inh_assertions := conf_factory.new_assertions
			end
			properties.add_section (conf_interface_names.section_assertions)

			l_require := new_boolean_property (conf_interface_names.option_require_name, l_inh_assertions.is_precondition)
			l_require.set_description (conf_interface_names.option_require_description)
			l_require.set_refresh_action (agent l_inh_assertions.is_precondition)
			l_require.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_require_name, ?))
			l_require.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_require)

			l_ensure := new_boolean_property (conf_interface_names.option_ensure_name, l_inh_assertions.is_postcondition)
			l_ensure.set_description (conf_interface_names.option_ensure_description)
			l_ensure.set_refresh_action (agent l_inh_assertions.is_postcondition)
			l_ensure.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_ensure_name, ?))
			l_ensure.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_ensure)

			l_check := new_boolean_property (conf_interface_names.option_check_name, l_inh_assertions.is_check)
			l_check.set_description (conf_interface_names.option_check_description)
			l_check.set_refresh_action (agent l_inh_assertions.is_check)
			l_check.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_check_name, ?))
			l_check.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_check)

			l_invariant := new_boolean_property (conf_interface_names.option_invariant_name, l_inh_assertions.is_invariant)
			l_invariant.set_description (conf_interface_names.option_invariant_description)
			l_invariant.set_refresh_action (agent l_inh_assertions.is_invariant)
			l_invariant.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_invariant_name, ?))
			l_invariant.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_invariant)

			l_loop := new_boolean_property (conf_interface_names.option_loop_name, l_inh_assertions.is_loop)
			l_loop.set_description (conf_interface_names.option_loop_description)
			l_loop.set_refresh_action (agent l_inh_assertions.is_loop)
			l_loop.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_loop_name, ?))
			l_loop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_loop)

			l_sup_require := new_boolean_property (conf_interface_names.option_sup_require_name, l_inh_assertions.is_supplier_precondition)
			l_sup_require.set_description (conf_interface_names.option_sup_require_description)
			l_sup_require.set_refresh_action (agent l_inh_assertions.is_supplier_precondition)
			l_sup_require.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_sup_require_name, ?))
			l_sup_require.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_sup_require)

				-- assertion inheritance handling
			if a_inherits then
				l_require.use_inherited_actions.extend (agent an_options.set_assertions (Void))
				l_require.use_inherited_actions.extend (agent handle_value_changes (False))
				l_require.use_inherited_actions.extend (agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, False))
				l_require.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, True)))

				l_ensure.use_inherited_actions.extend (agent an_options.set_assertions (Void))
				l_ensure.use_inherited_actions.extend (agent handle_value_changes (False))
				l_ensure.use_inherited_actions.extend (agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, False))
				l_ensure.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, True)))

				l_check.use_inherited_actions.extend (agent an_options.set_assertions (Void))
				l_check.use_inherited_actions.extend (agent handle_value_changes (False))
				l_check.use_inherited_actions.extend (agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, False))
				l_check.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, True)))

				l_invariant.use_inherited_actions.extend (agent an_options.set_assertions (Void))
				l_invariant.use_inherited_actions.extend (agent handle_value_changes (False))
				l_invariant.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, True)))
				l_invariant.use_inherited_actions.extend (agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, False))

				l_loop.use_inherited_actions.extend (agent an_options.set_assertions (Void))
				l_loop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_loop.use_inherited_actions.extend (agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, False))
				l_loop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, True)))

				l_sup_require.use_inherited_actions.extend (agent an_options.set_assertions (Void))
				l_sup_require.use_inherited_actions.extend (agent handle_value_changes (False))
				l_sup_require.use_inherited_actions.extend (agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, False))
				l_sup_require.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, True)))

				update_inheritance_assertion (l_require, l_ensure, l_check, l_invariant, l_loop, l_sup_require, l_assertions /= Void)
			end

			properties.current_section.expand
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
			properties.add_section (conf_interface_names.section_warning)

			l_bool_prop := new_boolean_property (conf_interface_names.option_warnings_name, an_inherited_options.is_warning)
			l_bool_prop.set_description (conf_interface_names.option_warnings_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_warning)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			if a_inherits then
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_warning)
				l_bool_prop.use_inherited_actions.extend (agent refresh)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))

				if an_options.is_warning_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			from
				valid_warnings.start
			until
				valid_warnings.after
			loop
				l_warning := valid_warnings.item_for_iteration

				l_bool_prop := new_boolean_property (conf_interface_names.warning_names.item (l_warning), an_inherited_options.is_warning_enabled (l_warning))
				l_bool_prop.set_description (conf_interface_names.warning_descriptions.item (l_warning))
				l_bool_prop.change_value_actions.extend (agent an_options.add_warning (l_warning, ?))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
				properties.add_property (l_bool_prop)
				if not an_inherited_options.is_warning then
					l_bool_prop.enable_readonly
				end

					valid_warnings.forth
			end

			properties.current_section.expand
		end

	add_debug_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN) is
			-- Add debug option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
			debug_clauses_not_void: debug_clauses /= Void
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_debug: STRING
		do
			properties.add_section (conf_interface_names.section_debug)

			l_bool_prop := new_boolean_property (conf_interface_names.option_debug_name, an_inherited_options.is_debug)
			l_bool_prop.set_description (conf_interface_names.option_debug_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_debug)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
			if a_inherits then
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_debug)
				l_bool_prop.use_inherited_actions.extend (agent refresh)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))

				if an_options.is_debug_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			l_bool_prop := new_boolean_property (conf_interface_names.option_unnamed_debug_name, an_inherited_options.is_debug_enabled (unnamed_debug))
			l_bool_prop.change_value_actions.extend (agent an_options.add_debug (unnamed_debug, ?))
			if not an_inherited_options.is_debug then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			from
				debug_clauses.start
			until
				debug_clauses.after
			loop
				l_debug := debug_clauses.item_for_iteration

				l_bool_prop := new_boolean_property (l_debug, an_inherited_options.is_debug_enabled (l_debug))
				l_bool_prop.change_value_actions.extend (agent an_options.add_debug (l_debug, ?))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
	 			if not an_inherited_options.is_debug then
 					l_bool_prop.enable_readonly
				end
				properties.add_property (l_bool_prop)

				debug_clauses.forth
			end

			properties.current_section.expand
		end

	add_dotnet_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits, a_il_generation: BOOLEAN) is
			-- Add .NET option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_string_prop: STRING_PROPERTY
		do
			properties.add_section (conf_interface_names.section_dotnet)

			create l_string_prop.make (conf_interface_names.option_namespace_name)
			l_string_prop.set_description (conf_interface_names.option_namespace_description)
			if an_options.local_namespace /= Void then
				l_string_prop.set_value (an_options.local_namespace)
			end
			l_string_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent an_options.set_local_namespace))
			l_string_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			if not a_il_generation then
				l_string_prop.enable_readonly
			end
			properties.add_property (l_string_prop)

			l_bool_prop := new_boolean_property (conf_interface_names.option_msil_application_optimize_name, an_inherited_options.is_msil_application_optimize)
			l_bool_prop.set_description (conf_interface_names.option_msil_application_optimize_description)
			l_bool_prop.change_value_actions.extend (agent an_options.set_msil_application_optimize)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent an_inherited_options.is_msil_application_optimize)
				l_bool_prop.use_inherited_actions.extend (agent an_options.unset_msil_application_optimize)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))

				if an_options.is_msil_application_optimize_configured then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			properties.add_property (l_bool_prop)

			properties.current_section.expand
		end

	update_assertion (an_option, a_inherited_option: CONF_OPTION; a_name: STRING_GENERAL; a_value: BOOLEAN) is
			-- Update the assertion setting of `an_option' with `a_name' to `a_value'.
		require
			an_option_not_void: an_option /= Void
			a_inherited_option_not_void: a_inherited_option /= Void
			a_name_valid: a_name.is_equal (conf_interface_names.option_require_name) or a_name.is_equal (conf_interface_names.option_ensure_name) or
				a_name.is_equal (conf_interface_names.option_check_name) or a_name.is_equal (conf_interface_names.option_invariant_name) or
				a_name.is_equal (conf_interface_names.option_loop_name) or a_name.is_equal (conf_interface_names.option_sup_require_name)
		local
			l_assertion: CONF_ASSERTIONS
		do
			l_assertion := an_option.assertions
			if l_assertion = Void then
				l_assertion := a_inherited_option.assertions
				if l_assertion = Void then
					l_assertion := conf_factory.new_assertions
				else
					l_assertion := l_assertion.twin
				end
				an_option.set_assertions (l_assertion)
			end
			if a_name.is_equal (conf_interface_names.option_require_name) then
				if a_value then
					l_assertion.enable_precondition
				else
					l_assertion.disable_precondition
				end
			elseif a_name.is_equal (conf_interface_names.option_ensure_name) then
				if a_value then
					l_assertion.enable_postcondition
				else
					l_assertion.disable_postcondition
				end
			elseif a_name.is_equal (conf_interface_names.option_check_name) then
				if a_value then
					l_assertion.enable_check
				else
					l_assertion.disable_check
				end
			elseif a_name.is_equal (conf_interface_names.option_invariant_name) then
				if a_value then
					l_assertion.enable_invariant
				else
					l_assertion.disable_invariant
				end
			elseif a_name.is_equal (conf_interface_names.option_loop_name) then
				if a_value then
					l_assertion.enable_loop
				else
					l_assertion.disable_loop
				end
			elseif a_name.is_equal (conf_interface_names.option_sup_require_name) then
				if a_value then
					l_assertion.enable_supplier_precondition
				else
					l_assertion.disable_supplier_precondition
				end
			else
				check
					should_not_reach: False
				end
			end
		end

	update_inheritance_assertion (a_require, a_ensure, a_check, a_invariant, a_loop, a_sup_require: PROPERTY; a_overriden: BOOLEAN) is
			-- Update inheritance of `a_require', `a_ensure', `a_check', `a_invariant', `a_sup_require' and `a_loop' to `a_overriden'.
		require
			a_require_not_void: a_require /= Void
			a_ensure_not_void: a_ensure /= Void
			a_check_not_void: a_check /= Void
			a_invariant_not_void: a_invariant /= Void
			a_loop_not_void: a_loop /= Void
			a_sup_require_not_void: a_sup_require /= Void
		do
			if a_overriden then
				a_require.enable_overriden
				a_ensure.enable_overriden
				a_check.enable_overriden
				a_invariant.enable_overriden
				a_loop.enable_overriden
				a_sup_require.enable_overriden
			else
				a_require.enable_inherited
				a_require.refresh
				a_ensure.enable_inherited
				a_ensure.refresh
				a_check.enable_inherited
				a_check.refresh
				a_invariant.enable_inherited
				a_invariant.refresh
				a_loop.enable_inherited
				a_loop.refresh
				a_sup_require.enable_inherited
				a_sup_require.refresh
			end
		end

feature {NONE} -- Refresh displayed data.

	refresh is
			-- Called if the displayed data should be regenerated from scratch.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
