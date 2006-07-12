indexing
	description: "Generate properties for targets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_PROPERTIES

inherit
	OPTION_PROPERTIES
		export
			{NONE} all
		end

feature {NONE} -- Actions

	refresh_target (a_target: STRING_32) is
			-- Refresh target selection box and select `a_target'.
		require
			a_target_valid_8_string: a_target.is_valid_as_string_8
		do
		end

feature {NONE} -- Implementation

	current_target: CONF_TARGET
			-- Target for which to generate properties.

	conf_factory: CONF_FACTORY
			-- Factory to create new configuration nodes.

	conf_system: CONF_SYSTEM
			-- Configuration system.

	window: EV_WINDOW
			-- Window to show errors modal.

	add_general_properties is
			-- Add general properties.
		require
			properties_not_void: properties /= Void
			current_target_not_void: current_target /= Void
			conf_system_not_void: conf_system /= Void
		local
			l_string_prop: STRING_PROPERTY [STRING_32]
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_choice_prop: STRING_CHOICE_PROPERTY [STRING_32]
			l_root_prop: DIALOG_PROPERTY [CONF_ROOT]
			l_version_prop: DIALOG_PROPERTY [CONF_VERSION]
			l_file_rule_prop: FILE_RULE_PROPERTY
			l_targ_ord: ARRAYED_LIST [CONF_TARGET]
			l_base_targets: ARRAYED_LIST [STRING_32]
			l_done: BOOLEAN
			l_root_dial: ROOT_DIALOG
			l_extends: BOOLEAN
			l_bool_prop: BOOLEAN_PROPERTY
		do
			properties.reset

				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

				-- general section
			properties.add_section (section_general)

				-- name
			create l_string_prop.make (target_name_name)
			l_string_prop.set_description (target_name_description)
			l_string_prop.set_value (current_target.name)
			l_string_prop.validate_value_actions.extend (agent check_target_name)
			l_string_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent current_target.set_name))
			l_string_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent store_changes))
			l_string_prop.change_value_actions.extend (agent refresh_target)
			properties.add_property (l_string_prop)

				-- description
			create l_mls_prop.make (target_description_name)
			l_mls_prop.set_description (target_description_description)
			l_mls_prop.enable_text_editing
			if current_target.description /= Void then
				l_mls_prop.set_value (current_target.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent current_target.set_description))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent store_changes))
			properties.add_property (l_mls_prop)

				-- parent target
			l_targ_ord := conf_system.target_order
			create l_base_targets.make (l_targ_ord.count)
			from
				l_targ_ord.start
			until
				l_done or l_targ_ord.after
			loop
				l_done := l_targ_ord.item = current_target
				if not l_done then
					l_base_targets.force (l_targ_ord.item.name)
				end
				l_targ_ord.forth
			end
			l_base_targets.put_front ("")
			create l_choice_prop.make_with_choices (target_base_name, l_base_targets)
			l_choice_prop.set_description (target_base_description)
			if current_target.extends /= Void then
				l_choice_prop.set_value (current_target.extends.name)
			end
			l_choice_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent current_target.set_parent_by_name))
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent store_changes))
			if l_base_targets.count = 1 then
				l_choice_prop.enable_readonly
			end
			properties.add_property (l_choice_prop)

				-- abstract target
			create l_bool_prop.make_with_value (target_abstract_name, current_target.is_abstract)
			l_bool_prop.set_description (target_abstract_description)
			l_bool_prop.change_value_actions.extend (agent current_target.set_abstract)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent store_changes))
			properties.add_property (l_bool_prop)

				-- compilation type
			create l_choice_prop.make_with_choices (target_compilation_type_name, <<target_compilation_type_standard, target_compilation_type_dotnet>>)
			l_choice_prop.set_description (target_compilation_type_description)
			l_choice_prop.disable_text_editing
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent update_inheritance_setting (s_msil_generation, l_choice_prop)))
			if current_target.setting_msil_generation then
				l_choice_prop.set_value (target_compilation_type_dotnet)
			else
				l_choice_prop.set_value (target_compilation_type_standard)
			end
			l_choice_prop.change_value_actions.put_front (agent set_compilation_mode)
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent store_changes))
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent refresh))
			l_choice_prop.use_inherited_actions.extend (agent current_target.update_setting (s_msil_generation, Void))
			l_choice_prop.use_inherited_actions.extend (agent refresh)
			l_choice_prop.use_inherited_actions.extend (agent store_changes)
			properties.add_property (l_choice_prop)

				-- output name
			create l_string_prop.make (target_executable_name)
			l_string_prop.set_description (target_executable_description)
			add_string_setting_actions (l_string_prop, s_executable_name, "")
			properties.add_property (l_string_prop)

				-- root
			create l_root_dial
			create l_root_prop.make_with_dialog (target_root_name, l_root_dial)
			l_root_prop.set_description (target_root_description)
			l_root_prop.set_refresh_action (agent current_target.root)
			l_root_prop.refresh
			l_root_prop.change_value_actions.extend (agent current_target.set_root)
			l_root_prop.change_value_actions.extend (agent update_inheritance_root (?, l_root_prop))
			l_root_prop.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_ROOT}?, agent store_changes))
			l_root_prop.use_inherited_actions.extend (agent current_target.set_root (Void))
			l_root_prop.use_inherited_actions.extend (agent update_inheritance_root (Void, l_root_prop))
			l_root_prop.use_inherited_actions.extend (agent store_changes)
			update_inheritance_root (Void, l_root_prop)
			properties.add_property (l_root_prop)

				-- version
			create l_version_prop.make_with_dialog (target_version_name, create {VERSION_DIALOG})
			l_version_prop.set_description (target_version_description)
			l_version_prop.set_refresh_action (agent current_target.version)
			l_version_prop.refresh
			l_version_prop.change_value_actions.extend (agent current_target.set_version)
			l_version_prop.change_value_actions.extend (agent update_inheritance_version (?, l_version_prop))
			l_version_prop.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_VERSION}?, agent store_changes))
			l_version_prop.use_inherited_actions.extend (agent current_target.set_version (Void))
			l_version_prop.use_inherited_actions.extend (agent update_inheritance_version (Void, l_version_prop))
			l_version_prop.use_inherited_actions.extend (agent store_changes)
			update_inheritance_version (Void, l_version_prop)
			properties.add_property (l_version_prop)

				-- file rules
			create l_file_rule_prop.make (target_file_rule_name)
			l_file_rule_prop.set_description (target_file_rule_description)
			l_file_rule_prop.set_refresh_action (agent current_target.file_rule)
			l_file_rule_prop.refresh
			l_file_rule_prop.change_value_actions.extend (agent current_target.set_file_rules)
			l_file_rule_prop.change_value_actions.extend (agent update_inheritance_file_rule (?, l_file_rule_prop))
			l_file_rule_prop.change_value_actions.extend (agent change_no_argument_wrapper ({ARRAYED_LIST [CONF_FILE_RULE]}?, agent store_changes))
			l_file_rule_prop.use_inherited_actions.extend (agent current_target.set_file_rules (create {ARRAYED_LIST [CONF_FILE_RULE]}.make (0)))
			l_file_rule_prop.use_inherited_actions.extend (agent update_inheritance_file_rule (Void, l_file_rule_prop))
			l_file_rule_prop.use_inherited_actions.extend (agent store_changes)
			update_inheritance_file_rule (Void, l_file_rule_prop)
			properties.add_property (l_file_rule_prop)

			properties.current_section.expand

			add_misc_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)

			create l_bool_prop.make_with_value (target_line_generation_name, current_target.setting_line_generation)
			l_bool_prop.set_description (target_line_generation_description)
			add_boolean_setting_actions (l_bool_prop, s_line_generation, False)
			properties.add_property (l_bool_prop)
		ensure
			properties_not_void: properties /= Void
		end

	add_advanced_properties is
			-- Add advanced properties.
		require
			properties_not_void: properties /= Void
			current_target_not_void: current_target /= Void
			conf_system_not_void: conf_system /= Void
		local
			l_string_prop: STRING_PROPERTY [STRING_32]
			l_choice_prop: STRING_CHOICE_PROPERTY [STRING_32]
			l_extends: BOOLEAN
			l_bool_prop: BOOLEAN_PROPERTY
			l_pf_choices: ARRAYED_LIST [STRING_32]
			l_dir_prop: DIRECTORY_PROPERTY
			l_file_prop: FILE_PROPERTY
			l_key_file_prop: KEY_FILE_PROPERTY
			l_installed_runtimes: DS_LINEAR [STRING]
			l_il_env: IL_ENVIRONMENT
			l_il_choices: ARRAYED_LIST [STRING_32]
			l_il_version: STRING
		do
				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

			properties.add_section (section_advanced)

			create l_bool_prop.make_with_value (target_address_expression_name, current_target.setting_address_expression)
			l_bool_prop.set_description (target_address_expression_description)
			add_boolean_setting_actions (l_bool_prop, s_address_expression, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_check_vape_name, current_target.setting_check_vape)
			l_bool_prop.set_description (target_check_vape_description)
			add_boolean_setting_actions (l_bool_prop, s_check_vape, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_console_application_name, current_target.setting_console_application)
			l_bool_prop.set_description (target_console_application_description)
			add_boolean_setting_actions (l_bool_prop, s_console_application, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_dead_code_removal_name, current_target.setting_dead_code_removal)
			l_bool_prop.set_description (target_dead_code_removal_description)
			add_boolean_setting_actions (l_bool_prop, s_dead_code_removal, False)
			if is_il_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_dynamic_runtime_name, current_target.setting_dynamic_runtime)
			l_bool_prop.set_description (target_dynamic_runtime_description)
			add_boolean_setting_actions (l_bool_prop, s_dynamic_runtime, False)
			if is_il_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_exception_trace_name, current_target.setting_exception_trace)
			l_bool_prop.set_description (target_exception_trace_description)
			add_boolean_setting_actions (l_bool_prop, s_exception_trace, False)
			if is_il_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_inlining_name, current_target.setting_inlining)
			l_bool_prop.set_description (target_inlining_description)
			add_boolean_setting_actions (l_bool_prop, s_inlining, False)
			if is_il_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_string_prop.make (target_inlining_size_name)
			l_string_prop.set_description (target_inlining_size_description)
			add_string_setting_actions (l_string_prop, s_inlining_size, "")
			l_string_prop.validate_value_actions.extend (agent valid_inlining_size)
			if is_il_generation then
				l_string_prop.enable_readonly
			end
			properties.add_property (l_string_prop)

			create l_bool_prop.make_with_value (target_multithreaded_name, current_target.setting_multithreaded)
			l_bool_prop.set_description (target_multithreaded_description)
			add_boolean_setting_actions (l_bool_prop, s_multithreaded, False)
			if is_il_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_old_verbatim_strings_name, current_target.setting_old_verbatim_strings)
			l_bool_prop.set_description (target_old_verbatim_strings_description)
			add_boolean_setting_actions (l_bool_prop, s_old_verbatim_strings, False)
			properties.add_property (l_bool_prop)

			create l_pf_choices.make (platform_names.count + 1)
			l_pf_choices.extend ("")
			from
				platform_names.start
			until
				platform_names.after
			loop
				l_pf_choices.extend (platform_names.item_for_iteration.as_lower)
				platform_names.forth
			end
			create l_choice_prop.make_with_choices (target_platform_name, l_pf_choices)
			l_choice_prop.set_description (target_platform_description)
			l_choice_prop.set_value (current_target.setting_platform)
			add_string_setting_actions (l_choice_prop, s_platform, "")
			properties.add_property (l_choice_prop)

			create l_file_prop.make (target_shared_library_definition_name)
			l_file_prop.set_description (target_shared_library_definition_description)
			add_string_setting_actions (l_file_prop, s_shared_library_definition, "")
			if is_il_generation then
				l_file_prop.enable_readonly
			end
			properties.add_property (l_file_prop)

			create l_dir_prop.make (target_library_root_name)
			l_dir_prop.set_description (target_library_root_description)
			add_string_setting_actions (l_dir_prop, s_library_root, "")
			properties.add_property (l_dir_prop)

			properties.current_section.expand

				-- .NET section
			properties.add_section (section_dotnet)

			create l_bool_prop.make_with_value (target_msil_use_optimized_precompile_name, current_target.setting_msil_use_optimized_precompile)
			l_bool_prop.set_description (target_msil_use_optimized_precompile_description)
			add_boolean_setting_actions (l_bool_prop, s_msil_use_optimized_precompile, False)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_use_cluster_name_as_namespace_name, current_target.setting_use_cluster_name_as_namespace)
			l_bool_prop.set_description (target_use_cluster_name_as_namespace_description)
			add_boolean_setting_actions (l_bool_prop, s_use_cluster_name_as_namespace, True)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_use_all_cluster_name_as_namespace_name, current_target.setting_use_all_cluster_name_as_namespace)
			l_bool_prop.set_description (target_use_all_cluster_name_as_namespace_description)
			add_boolean_setting_actions (l_bool_prop, s_use_all_cluster_name_as_namespace, True)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_dotnet_naming_convention_name, current_target.setting_dotnet_naming_convention)
			l_bool_prop.set_description (target_dotnet_naming_convention_description)
			add_boolean_setting_actions (l_bool_prop, s_dotnet_naming_convention, False)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_il_verifiable_name, current_target.setting_il_verifiable)
			l_bool_prop.set_description (target_il_verifiable_description)
			add_boolean_setting_actions (l_bool_prop, s_il_verifiable, True)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_cls_compliant_name, current_target.setting_cls_compliant)
			l_bool_prop.set_description (target_cls_compliant_description)
			add_boolean_setting_actions (l_bool_prop, s_cls_compliant, False)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			create l_dir_prop.make (target_metadata_cache_path_name)
			l_dir_prop.set_description (target_metadata_cache_path_description)
			add_string_setting_actions (l_dir_prop, s_metadata_cache_path, "")
			if not current_target.setting_msil_generation then
				l_dir_prop.enable_readonly
			end
			properties.add_property (l_dir_prop)

			create l_string_prop.make (target_msil_classes_per_module_name)
			l_string_prop.set_description (target_msil_classes_per_module_description)
			add_string_setting_actions (l_string_prop, s_msil_classes_per_module, "")
			l_string_prop.validate_value_actions.extend (agent valid_classes_per_module)
			if not current_target.setting_msil_generation then
				l_string_prop.enable_readonly
			end
			properties.add_property (l_string_prop)

			create l_il_env
			l_installed_runtimes := l_il_env.installed_runtimes
			create l_il_choices.make (l_installed_runtimes.count)
			from
				l_installed_runtimes.start
			until
				l_installed_runtimes.after
			loop
				l_il_choices.put_right (l_installed_runtimes.item_for_iteration)
				l_installed_runtimes.forth
			end
			create l_choice_prop.make_with_choices (target_msil_clr_version_name, l_il_choices)

			l_choice_prop.set_description (target_msil_clr_version_description)
			add_string_setting_actions (l_choice_prop, s_msil_clr_version, "")
			if not current_target.setting_msil_generation then
				l_choice_prop.enable_readonly
			end
			properties.add_property (l_choice_prop)

			create l_choice_prop.make_with_choices (target_msil_generation_type_name, <<"exe", "dll">>)
			l_choice_prop.set_description (target_msil_generation_type_description)
			add_string_setting_actions (l_choice_prop, s_msil_generation_type, "")
			if not current_target.setting_msil_generation then
				l_choice_prop.enable_readonly
			end
			properties.add_property (l_choice_prop)

			create l_key_file_prop.make (target_msil_key_file_name_name)
			l_key_file_prop.set_description (target_msil_key_file_name_description)
			l_il_version := current_target.setting_msil_clr_version
			if l_il_version.is_empty then
				l_il_version := l_il_env.default_version
			end
			l_key_file_prop.set_il_version (l_il_version)
			add_string_setting_actions (l_key_file_prop, s_msil_key_file_name, "")
			if not current_target.setting_msil_generation then
				l_key_file_prop.enable_readonly
			end
			properties.add_property (l_key_file_prop)

			create l_bool_prop.make_with_value (target_force_32bits_name, current_target.setting_force_32bits)
			l_bool_prop.set_description (target_force_32bits_description)
			add_boolean_setting_actions (l_bool_prop, s_force_32bits, False)
			if not current_target.setting_msil_generation then
				l_bool_prop.enable_readonly
			end
			properties.add_property (l_bool_prop)

			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

feature {NONE} -- Implementation helper

	add_string_setting_actions (a_property: TYPED_PROPERTY [STRING_32]; a_name: STRING; a_default: STRING) is
			-- Add actions that deal with string settings.
		require
			a_property_not_void: a_property /= Void
			a_name_valid: valid_setting (a_name)
			current_target_not_void: current_target /= Void
		do
			a_property.set_refresh_action (agent get_setting (a_name))
			a_property.refresh
			a_property.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent set_string_setting (a_name, a_default, ?)))
			a_property.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent update_inheritance_setting (a_name, a_property)))
			a_property.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent store_changes))
			a_property.use_inherited_actions.extend (agent current_target.update_setting (a_name, Void))
			a_property.use_inherited_actions.extend (agent update_inheritance_setting (a_name, a_property))
			a_property.use_inherited_actions.extend (agent store_changes)
			update_inheritance_setting (a_name, a_property)
		end

	add_boolean_setting_actions (a_property: BOOLEAN_PROPERTY; a_name: STRING; a_default: BOOLEAN) is
			-- Add actions that deal with boolean settings.
		require
			a_property_not_void: a_property /= Void
			a_name_valid: valid_setting (a_name)
			current_target_not_void: current_target /= Void
		do
			a_property.set_refresh_action (agent current_target.setting_boolean (a_name))
			a_property.refresh
			a_property.change_value_actions.extend (agent set_boolean_setting (a_name, a_default, ?))
			a_property.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_setting (a_name, a_property)))
			a_property.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent store_changes))
			a_property.use_inherited_actions.extend (agent current_target.update_setting (a_name, Void))
			a_property.use_inherited_actions.extend (agent update_inheritance_setting (a_name, a_property))
			a_property.use_inherited_actions.extend (agent store_changes)
			update_inheritance_setting (a_name, a_property)
		end

feature {NONE} -- Inheritance handling

	update_inheritance_setting (a_name: STRING; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' accordint to the setting `a_name'.
		require
			a_name_valid: valid_setting (a_name)
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if current_target.internal_settings.has (a_name) then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_root (a_dummy: CONF_ROOT; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if the root value is set in the current_target.
		require
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if current_target.internal_root /= Void then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_version (a_dummy: CONF_VERSION; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if the version value is set in the current_target.
		require
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if current_target.internal_version /= Void then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_file_rule (a_dummy: ARRAYED_LIST [CONF_FILE_RULE]; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if there are file rules in the `current_target'.
		require
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if not current_target.internal_file_rule.is_empty then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

feature {NONE} -- Configuration setting

	set_compilation_mode (a_mode: STRING_32) is
			-- Set settings for `a_mode'.
		require
			current_target_not_void: current_target /= Void
			a_mode_ok: a_mode /= Void implies a_mode.is_equal (target_compilation_type_standard) or a_mode.is_equal (target_compilation_type_dotnet)
		do
			if a_mode = Void then
				current_target.update_setting (s_msil_generation, Void)
			elseif a_mode.is_equal (target_compilation_type_standard) then
				if current_target.internal_settings.has (s_msil_generation) then
					current_target.update_setting (s_msil_generation, "")
				else
					current_target.update_setting (s_msil_generation, "false")
				end
			else
				current_target.update_setting (s_msil_generation, "true")
			end
			is_il_generation := current_target.setting_msil_generation
		end

	set_string_setting (a_name: STRING; a_default: STRING; a_value: STRING) is
			-- Set a string setting with `a_name' to `a_value'.
		require
			a_name_valid: valid_setting (a_name)
			current_target: current_target /= Void
		do
			if current_target.extends = Void and then equal (a_value, a_default) and current_target.internal_settings.has (a_name) then
				current_target.update_setting (a_name, Void)
			else
				current_target.update_setting (a_name, a_value)
			end
		end

	set_boolean_setting (a_name: STRING; a_default: BOOLEAN; a_value: BOOLEAN) is
			-- Set a boolean setting with `a_name' to `a_value'.
		require
			a_name_valid: valid_setting (a_name)
			current_target: current_target /= Void
		do
			if current_target.extends = Void and then a_value = a_default and current_target.internal_settings.has (a_name) then
				current_target.update_setting (a_name, "")
			else
				current_target.update_setting (a_name, a_value.out.as_lower)
			end
		end

feature {NONE} -- Validation and warning generation

	check_target_name (a_name: STRING_32): BOOLEAN is
			-- Is `a_name' a valid name for a target?
		require
			current_target: current_target /= Void
			a_name_not_void: a_name /= Void
		local
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
			wd: EV_WARNING_DIALOG
		do
			l_targets := conf_system.targets
			l_targets.search (a_name)
			if l_targets.found and then l_targets.found_item /= current_target then
				create wd.make_with_text (target_name_duplicate)
				wd.show_modal_to_window (window)
			else
				Result := True
			end
		end

	valid_classes_per_module (a_value: STRING_32): BOOLEAN is
			-- Is `a_value' a correct value for the classes per module setting?
		require
			current_target: current_target /= Void
		do
			if a_value /= Void and then not a_value.is_empty then
				Result := a_value.is_natural_16 and then a_value.to_natural_16 > 0
			else
				Result := True
			end
		end

	valid_inlining_size (a_value: STRING_32): BOOLEAN is
			-- Is `a_value' a correct value for the classes per module setting?
		require
			current_target: current_target /= Void
		do
			if a_value /= Void and then not a_value.is_empty then
				Result := a_value.is_natural_8 and then a_value.to_natural_8 <= 100
			else
				Result := True
			end
		end

feature {NONE} -- Wrappers

	get_setting (a_name: STRING): STRING_32 is
			-- Get value of a setting as STRING_32.
		require
			current_target: current_target /= Void
			valid_name: valid_setting (a_name)
		local
			l_val: STRING
		do
			l_val := current_target.settings.item (a_name)
			if l_val /= Void then
				Result := l_val
			end
		end

invariant
	config_factory: conf_factory /= Void
	window: window /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
