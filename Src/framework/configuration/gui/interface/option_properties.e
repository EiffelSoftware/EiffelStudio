note
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

	CONF_LOAD_PARSE_CALLBACKS_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	conf_factory: CONF_PARSE_FACTORY
			-- Factory to create new nodes.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	window: detachable EV_WINDOW
			-- Window to show errors modal. If `Void' it will be shown using the default from ES_PROMPT_PROVIDER.

	properties: PROPERTY_GRID
			-- Grid where properties get added.

	debug_clauses: ARRAYED_LIST [STRING]
			-- Possible debug clauses.

feature -- Update

	set_debugs (a_debugs: like debug_clauses)
			-- Set `debug_clauses' to `a_debugs'.
		require
			a_debugs_not_void: a_debugs /= Void
		do
			debug_clauses := a_debugs
		ensure
			debug_clauses_set: debug_clauses = a_debugs
		end

feature {NONE} -- Modification: language properties

	add_void_safety_property (an_options, an_inherited_options: CONF_TARGET_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a void safety property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			c: CONF_VALUE_CHOICE
		do
			if a_inherits then
				c := an_inherited_options.void_safety
			end
			add_choice_property (
				conf_interface_names.option_void_safety_name,
				conf_interface_names.option_void_safety_description,
				conf_interface_names.option_void_safety_value,
				an_options.void_safety,
				c
			)
			if
				attached last_added_choice_property as l_prop and then
				a_check_non_client_option and then
				is_supplier_option (at_void_safety)
			then
				l_prop.enable_readonly
			end
		end

	add_cat_call_property (an_options, an_inherited_options: CONF_TARGET_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a cat call detection property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			c: CONF_VALUE_CHOICE
		do
			if a_inherits then
				c := an_inherited_options.catcall_detection
			end
			add_choice_property (
				conf_interface_names.option_catcall_detection_name,
				conf_interface_names.option_catcall_detection_description,
				conf_interface_names.option_catcall_detection_value,
				an_options.catcall_detection,
				c
			)
			if attached last_added_choice_property as l_prop and then a_check_non_client_option and then is_supplier_option (at_catcall_detection) then
				l_prop.enable_readonly
			end
		end

	add_syntax_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a syntax property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			c: CONF_VALUE_CHOICE
		do
			if a_inherits then
				c := an_inherited_options.syntax
			else
				c := Void
			end
			add_choice_property (
				conf_interface_names.option_syntax_name,
				conf_interface_names.option_syntax_description,
				create {ARRAYED_LIST [STRING_32]}.make_from_array (
					<<conf_interface_names.option_syntax_obsolete_name,
					conf_interface_names.option_syntax_transitional_name,
					conf_interface_names.option_syntax_standard_name,
					conf_interface_names.option_syntax_provisional_name>>),
				an_options.syntax,
				c
			)
			if attached last_added_choice_property as l_prop and then a_check_non_client_option and then is_supplier_option (at_syntax_level) then
				l_prop.enable_readonly
			end
		end

	add_obsolete_iteration_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add an obsolete iteration property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		do
			add_boolean_property
				(
					an_options,
					an_inherited_options,
					a_inherits,
					a_check_non_client_option,
					locale.translation_in_context (once "Obsolete iteration syntax", once "compiler"),
					locale.translation_in_context (once "[
						Is obsolete iteration syntax used?
						
						Contemporary syntax for iteration provides direct access to
						the iteration item and uses keyword `as`:
								across foo as x loop ... x ... @x.key ... end
						
						Obsolete syntax for iteration provides direct access to
						the iteration item (using `is`) or cursor (using `as`):
								across foo as x loop ... x.item ... x.key ... end
								across foo is x loop ... x ... @x.key ... end
					]", once "compiler"),
					agent {CONF_OPTION}.is_obsolete_iteration,
					agent an_options.set_is_obsolete_iteration,
					agent an_options.unset_is_obsolete_iteration,
					an_options.is_obsolete_iteration_configured,
					at_is_obsolete_iteration
				)
		end

	add_array_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a manifest array type check property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			c: CONF_VALUE_CHOICE
		do
			if a_inherits then
				c := an_inherited_options.array
			else
				c := Void
			end
			add_choice_property (
				conf_interface_names.option_array_name,
				conf_interface_names.option_array_description,
				create {ARRAYED_LIST [STRING_32]}.make_from_array (
					<<conf_interface_names.option_array_mismatch_error_name,
					conf_interface_names.option_array_mismatch_warning_name,
					conf_interface_names.option_array_standard_name>>),
				an_options.array,
				c
			)
			if attached last_added_choice_property as l_prop and then a_check_non_client_option and then is_supplier_option (at_manifest_array_type) then
				l_prop.enable_readonly
			end
		end

	add_full_checking_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a full class checking property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		do
			add_boolean_property
				(
					an_options,
					an_inherited_options,
					a_inherits,
					a_check_non_client_option,
					conf_interface_names.option_full_class_checking_name,
					conf_interface_names.option_full_class_checking_description,
					agent {CONF_OPTION}.is_full_class_checking,
					agent an_options.set_full_class_checking,
					agent an_options.unset_full_class_checking,
					an_options.is_full_class_checking_configured,
					at_full_class_checking
				)
		end

feature {NONE} -- Modification: property addition

	add_boolean_property (
		an_options: CONF_OPTION;
		an_inherited_options: CONF_OPTION;
		a_inherits: BOOLEAN;
		a_check_non_client_option: BOOLEAN;
		name: READABLE_STRING_32;
		description: READABLE_STRING_32;
		get: FUNCTION [CONF_OPTION, BOOLEAN];
		set: PROCEDURE [BOOLEAN];
		unset: PROCEDURE;
		is_set: BOOLEAN;
		option_id: INTEGER)
			-- Add a boolean property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
			-- Arguments:
			-- • `name` — the name of the option;
			-- • `description` — the description of the option;
			-- • `get` — the function to get the value of the option from the given option collection;
			-- • `set` — the procedure to set the option to the specified value;
			-- • `unset` — the procedure to mark the option as unset;
			-- • `is_set` — a flag indicating whether the option is set;
			-- • `option_id` — ID of the option in the parser;
		local
			l_bool_prop: BOOLEAN_PROPERTY
		do
			l_bool_prop := new_boolean_property (name, get (an_options))
			l_bool_prop.set_description (description)
			l_bool_prop.change_value_actions.extend (set)
			if a_inherits then
				l_bool_prop.set_refresh_action (agent get.item (an_inherited_options))
				l_bool_prop.use_inherited_actions.extend (unset)
				l_bool_prop.use_inherited_actions.extend (agent l_bool_prop.enable_inherited)
				l_bool_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent l_bool_prop.enable_overriden))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
				if is_set then
					l_bool_prop.enable_overriden
				else
					l_bool_prop.enable_inherited
				end
			end
			if a_check_non_client_option and then is_supplier_option (option_id) then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)
		end

feature {NONE} -- Modification: execution properties

	add_profile_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a profile property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			l_bool_prop: BOOLEAN_PROPERTY
		do
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
			if a_check_non_client_option and then is_supplier_option (at_profile) then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)
		end

	add_trace_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a trace property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			l_bool_prop: BOOLEAN_PROPERTY
		do
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
			if a_check_non_client_option and then is_supplier_option (at_trace) then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)
		end

feature {NONE} -- Modification: optimization properties

	add_dotnet_namespace_property (an_options, an_inherited_options: CONF_OPTION; a_inherits, a_il_generation: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a .NET namespace property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			l_string_prop: STRING_PROPERTY
		do
			create l_string_prop.make (conf_interface_names.option_namespace_name)
			l_string_prop.set_description (conf_interface_names.option_namespace_description)
			if an_options.local_namespace /= Void then
				l_string_prop.set_value (an_options.local_namespace)
			end
			l_string_prop.change_value_actions.extend (agent an_options.set_local_namespace)
			l_string_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			if not a_il_generation then
				l_string_prop.enable_readonly
			end
			if a_check_non_client_option and then is_supplier_option (at_namespace) then
				l_string_prop.enable_readonly
			end
			properties.add_property (l_string_prop)
		end

	add_dotnet_optimization_property (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add a .NET optimization property that  may come from `an_options' (defined on the node itself) itself
			-- or from `an_inherited_options' (final value after inheritance).
		local
			l_bool_prop: BOOLEAN_PROPERTY
		do
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
			if a_check_non_client_option and then is_supplier_option (at_msil_application_optimize) then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)
		end

feature {NONE} -- Modification

	handle_value_changes (a_has_group_changed: BOOLEAN)
			-- Handle changed values (e.g. store changes to disk).
			-- `a_has_group_changed' indicates that a value that makes the node not group_equivalent has changed.
		do
			-- default is to do nothing
		end

	add_misc_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		do
				-- Language section.
			properties.add_section (conf_interface_names.section_language)
				-- Full checking.
			add_full_checking_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
				-- Syntax.
			add_syntax_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
				-- Loop syntax.
			add_obsolete_iteration_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
				-- Manifest array type checks.
			add_array_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end

				-- Execution section.
			properties.add_section (conf_interface_names.section_execution)
				-- Profile.
			add_profile_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
				-- Trace.
			add_trace_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
		end

	add_assertion_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
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
			if a_check_non_client_option and then is_supplier_option (at_precondition) then
				l_require.enable_readonly
			end
			properties.add_property (l_require)

			l_ensure := new_boolean_property (conf_interface_names.option_ensure_name, l_inh_assertions.is_postcondition)
			l_ensure.set_description (conf_interface_names.option_ensure_description)
			l_ensure.set_refresh_action (agent l_inh_assertions.is_postcondition)
			l_ensure.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_ensure_name, ?))
			l_ensure.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			if a_check_non_client_option and then is_supplier_option (at_postcondition) then
				l_ensure.enable_readonly
			end
			properties.add_property (l_ensure)

			l_check := new_boolean_property (conf_interface_names.option_check_name, l_inh_assertions.is_check)
			l_check.set_description (conf_interface_names.option_check_description)
			l_check.set_refresh_action (agent l_inh_assertions.is_check)
			l_check.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_check_name, ?))
			l_check.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			if a_check_non_client_option and then is_supplier_option (at_check) then
				l_check.enable_readonly
			end
			properties.add_property (l_check)

			l_invariant := new_boolean_property (conf_interface_names.option_invariant_name, l_inh_assertions.is_invariant)
			l_invariant.set_description (conf_interface_names.option_invariant_description)
			l_invariant.set_refresh_action (agent l_inh_assertions.is_invariant)
			l_invariant.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_invariant_name, ?))
			l_invariant.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			if a_check_non_client_option and then is_supplier_option (at_invariant) then
				l_invariant.enable_readonly
			end
			properties.add_property (l_invariant)

			l_loop := new_boolean_property (conf_interface_names.option_loop_name, l_inh_assertions.is_loop)
			l_loop.set_description (conf_interface_names.option_loop_description)
			l_loop.set_refresh_action (agent l_inh_assertions.is_loop)
			l_loop.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_loop_name, ?))
			l_loop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			if a_check_non_client_option and then is_supplier_option (at_loop) then
				l_loop.enable_readonly
			end
			properties.add_property (l_loop)

			l_sup_require := new_boolean_property (conf_interface_names.option_sup_require_name, l_inh_assertions.is_supplier_precondition)
			l_sup_require.set_description (conf_interface_names.option_sup_require_description)
			l_sup_require.set_refresh_action (agent l_inh_assertions.is_supplier_precondition)
			l_sup_require.change_value_actions.extend (agent update_assertion (an_options, an_inherited_options, conf_interface_names.option_sup_require_name, ?))
			l_sup_require.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			if a_check_non_client_option and then is_supplier_option (at_supplier_precondition) then
				l_sup_require.enable_readonly
			end
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

			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end
		end

	add_warning_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add debug option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: attached properties as props and then not props.is_destroyed
		local
			l_bool_prop: BOOLEAN_PROPERTY
			l_warning: READABLE_STRING_32
			p: PROPERTY
		do
			properties.add_section (conf_interface_names.section_warning)

			add_choice_property (
				locale.translation_in_context ("Warning", "configuration.option"),
				locale.translation_in_context ({STRING_32} "[
					How should warnings be reported?
					 • None: Do not report wanings;
					 • Warning: Report enabled warnings as warnings;
					 • Error: Report enabled warnings as errors.
				]", "configuration.option"),
				create {ARRAYED_LIST [STRING_32]}.make_from_array (
					<<locale.translation_in_context ("None", "configuration.option"),
					locale.translation_in_context ("Warning", "configuration.option"),
					locale.translation_in_context ("Error", "configuration.option")>>),
				an_options.warning,
				if a_inherits then an_inherited_options.warning else Void end
			)
			if attached last_added_choice_property as l_prop then
				l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent refresh))
				l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
				if a_inherits then
					l_prop.use_inherited_actions.extend (agent refresh)
					l_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				end
				if a_check_non_client_option and then is_supplier_option (at_warning) then
					l_prop.enable_readonly
				end
			end

			across
				known_warnings as w
			loop
				l_warning := w.key.as_string_32
					-- Search if it is a warning that we show in the UI.
					-- (we hide the obsolete warnings in the UI).
				conf_interface_names.warning_names.search (l_warning)
				if attached conf_interface_names.warning_names.item (l_warning) as n then
					p := Void
					if l_warning.same_string (w_obsolete_feature) then
						add_choice_property (
							l_warning,
							locale.translation_in_context ({STRING_32} "[
								What warnings about obsolete feature calls should be reported?
								 • None: None;
								 • Current: Only warnings that are relevant now (with the date that passed already);
								 • All: All warnings (regardless of the associated date).
							]", "configuration.option"),
							create {ARRAYED_LIST [STRING_32]}.make_from_array (
								<<locale.translation_in_context ("None", "configuration.option"),
								locale.translation_in_context ("Current", "configuration.option"),
								locale.translation_in_context ("All", "configuration.option")>>),
							an_options.warning_obsolete_call,
							if a_inherits then an_inherited_options.warning_obsolete_call else Void end
						)
						if attached last_added_choice_property as l_prop then
							l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent refresh))
							l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
							if a_inherits then
								l_prop.use_inherited_actions.extend (agent refresh)
								l_prop.use_inherited_actions.extend (agent handle_value_changes (False))
							end
							p := l_prop
						end
					else
						l_bool_prop := new_boolean_property (n, an_inherited_options.is_warning_enabled (l_warning))
						if attached conf_interface_names.warning_descriptions.item (l_warning) as d then
							l_bool_prop.set_description (d)
						end
						l_bool_prop.change_value_actions.extend (agent an_options.add_warning (l_warning, ?))
						l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
						properties.add_property (l_bool_prop)
						p := l_bool_prop
					end
					if attached p and then an_inherited_options.warning.index = {CONF_OPTION}.warning_index_none then
						p.enable_readonly
					end
				end
			end

			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end
		end

	add_debug_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits: BOOLEAN; a_check_non_client_option: BOOLEAN)
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
			if a_check_non_client_option and then is_supplier_option (at_debug) then
				l_bool_prop.enable_readonly
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
			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end
		end

	add_dotnet_option_properties (an_options, an_inherited_options: CONF_OPTION; a_inherits, a_il_generation: BOOLEAN; a_check_non_client_option: BOOLEAN)
			-- Add .NET option properties which may come from `an_options' (defined on the node itself) itself or from `an_inherited_options' (final value after inheritance).
		require
			an_options_not_void: an_options /= Void
			an_inherited_options_not_void: an_inherited_options /= Void
			properties_not_void: properties /= Void
		do
			properties.add_section (conf_interface_names.section_dotnet)
			add_dotnet_namespace_property (an_options, an_inherited_options, a_inherits, a_il_generation, a_check_non_client_option)
			add_dotnet_optimization_property (an_options, an_inherited_options, a_inherits, a_check_non_client_option)
			if attached properties.current_section as l_current_section then
				if a_il_generation then
					l_current_section.expand
				else
					l_current_section.collapse
				end
			end
		end

	add_choice_property (name, description: STRING_32; items: ARRAYED_LIST [STRING_32];
		option: CONF_VALUE_CHOICE; inherited_option: detachable CONF_VALUE_CHOICE)
			-- Add a choice property `option' with the given `name' and `description'
			-- that contains specified `items' and may inherit from `inherited_option' if it is attached.
		require
			name_attached: name /= Void
			description_attached: description /= Void
			items_attached: items /= Void
			option_attached: option /= Void
		local
			l_choice_prop: STRING_CHOICE_PROPERTY
		do
			create l_choice_prop.make_with_choices (name, items)
			l_choice_prop.set_description (description)
			l_choice_prop.disable_text_editing
			if inherited_option /= Void then
				l_choice_prop.set_refresh_action (
					agent (content: ARRAYED_LIST [STRING_32]; i: CONF_VALUE_CHOICE): STRING_32
						do
							Result := content.i_th (i.index)
						end
					(items, inherited_option)
				)
				if option.is_set then
					l_choice_prop.enable_overriden
				else
					l_choice_prop.enable_inherited
				end
				l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?,
					agent (o: CONF_VALUE_CHOICE; p: STRING_CHOICE_PROPERTY)
						do
							if o.is_set then
								p.enable_overriden
							else
								p.enable_inherited
							end
						end
					(option, l_choice_prop)
				))
				l_choice_prop.use_inherited_actions.extend (agent option.unset)
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.enable_inherited)
				l_choice_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.redraw)
			end
			if option.is_set then
				l_choice_prop.set_value (l_choice_prop.item_strings [option.index])
			end
			l_choice_prop.change_value_actions.put_front (
				agent (o: CONF_VALUE_CHOICE; content: ARRAYED_LIST [READABLE_STRING_32]; value: detachable READABLE_STRING_32)
					local
						i: INTEGER
					do
						if attached value then
							from
								i := content.count
							until
								i <= 0
							loop
								if value.is_equal (content [i]) then
									o.put_index (i.to_natural_8)
									i := 1
								end
								i := i - 1
							end
						end
					end
				(option, items, ?)
			)
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent l_choice_prop.redraw))
			properties.add_property (l_choice_prop)
			last_added_choice_property := l_choice_prop
		end

	add_use_capability_property (name, description: STRING_32; items: ARRAYED_LIST [STRING_32];
		capability: CONF_ORDERED_CAPABILITY; inherited_capability: detachable CONF_ORDERED_CAPABILITY)
			-- Add a choice property `capability' with the given `name' and `description'
			-- that contains specified `items' and may inherit from `inherited_capability' if it is attached.
		require
			name_attached: name /= Void
			description_attached: description /= Void
			items_attached: items /= Void
			capability_attached: capability /= Void
		local
			l_choice_prop: STRING_CHOICE_PROPERTY
		do
			create l_choice_prop.make_with_choices (name, items)
			l_choice_prop.set_description (description)
			l_choice_prop.disable_text_editing
			if inherited_capability /= Void then
				l_choice_prop.set_refresh_action (
					agent (content: ARRAYED_LIST [READABLE_STRING_32]; i: CONF_ORDERED_CAPABILITY): READABLE_STRING_32
						do
							Result := content [i.root_index]
						end
					(items, inherited_capability)
				)
				if capability.is_root_set then
					l_choice_prop.enable_overriden
				else
					l_choice_prop.enable_inherited
				end
				l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?,
					agent (o: CONF_ORDERED_CAPABILITY; p: STRING_CHOICE_PROPERTY)
						do
							if o.is_root_set then
								p.enable_overriden
							else
								p.enable_inherited
							end
						end
					(capability, l_choice_prop)
				))
				l_choice_prop.use_inherited_actions.extend (agent capability.unset_root)
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.enable_inherited)
				l_choice_prop.use_inherited_actions.extend (agent handle_value_changes (False))
				l_choice_prop.use_inherited_actions.extend (agent l_choice_prop.redraw)
			end
			if capability.is_root_set then
				l_choice_prop.set_value (l_choice_prop.item_strings [capability.custom_root_index])
			end
			l_choice_prop.change_value_actions.put_front (
				agent (o: CONF_ORDERED_CAPABILITY; content: ARRAYED_LIST [STRING_32]; value: detachable READABLE_STRING_32)
					local
						i: INTEGER
					do
						if attached value then
							from
								i := content.count
							until
								i <= 0
							loop
								if value.same_string (content [i]) then
									o.put_root_index (i.to_natural_8)
									i := 1
								end
								i := i - 1
							end
						end
					end
				(capability, items, ?)
			)
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent l_choice_prop.redraw))
			l_choice_prop.validate_value_actions.extend
				(agent (o: CONF_ORDERED_CAPABILITY; content: ARRAYED_LIST [READABLE_STRING_32]; value: detachable READABLE_STRING_32): BOOLEAN
					do
						Result :=
							attached value and then
							across content as c some c.item.same_string (value) and then o.is_capable (c.target_index.to_natural_8) end
					end (capability, items, ?))
			properties.add_property (l_choice_prop)
			last_added_choice_property := l_choice_prop
		end

	update_assertion (an_option, a_inherited_option: CONF_OPTION; a_name: STRING_GENERAL; a_value: BOOLEAN)
			-- Update the assertion setting of `an_option' with `a_name' to `a_value'.
		require
			an_option_not_void: an_option /= Void
			a_inherited_option_not_void: a_inherited_option /= Void
			a_name_valid: a_name.same_string (conf_interface_names.option_require_name) or a_name.same_string (conf_interface_names.option_ensure_name) or
				a_name.same_string (conf_interface_names.option_check_name) or a_name.same_string (conf_interface_names.option_invariant_name) or
				a_name.same_string (conf_interface_names.option_loop_name) or a_name.same_string (conf_interface_names.option_sup_require_name)
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
			if a_name.same_string (conf_interface_names.option_require_name) then
				if a_value then
					l_assertion.enable_precondition
				else
					l_assertion.disable_precondition
				end
			elseif a_name.same_string (conf_interface_names.option_ensure_name) then
				if a_value then
					l_assertion.enable_postcondition
				else
					l_assertion.disable_postcondition
				end
			elseif a_name.same_string (conf_interface_names.option_check_name) then
				if a_value then
					l_assertion.enable_check
				else
					l_assertion.disable_check
				end
			elseif a_name.same_string (conf_interface_names.option_invariant_name) then
				if a_value then
					l_assertion.enable_invariant
				else
					l_assertion.disable_invariant
				end
			elseif a_name.same_string (conf_interface_names.option_loop_name) then
				if a_value then
					l_assertion.enable_loop
				else
					l_assertion.disable_loop
				end
			elseif a_name.same_string (conf_interface_names.option_sup_require_name) then
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

	update_inheritance_assertion (a_require, a_ensure, a_check, a_invariant, a_loop, a_sup_require: PROPERTY; a_overriden: BOOLEAN)
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

	refresh
			-- Called if the displayed data should be regenerated from scratch.
		do
		end

	last_added_choice_property: detachable STRING_CHOICE_PROPERTY
			-- Last added choice property

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
end
