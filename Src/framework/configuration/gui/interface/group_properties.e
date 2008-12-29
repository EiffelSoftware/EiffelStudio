note
	description: "Generate properties for groups."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GROUP_PROPERTIES

inherit
	OPTION_PROPERTIES

	DEFAULT_VALIDATOR

feature {NONE} -- Implementation

	add_group_properties (a_group: CONF_GROUP; a_target: CONF_TARGET)
			-- Add `properties' for `a_group'.
		require
			properties_not_void: properties /= Void
			a_group_not_void: a_group /= Void
			a_target_not_void: a_target /= Void
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_text_prop: STRING_PROPERTY
			l_dial: DIALOG_PROPERTY [CONF_CONDITION_LIST]
			l_bool_prop: BOOLEAN_PROPERTY
			l_dir_prop: DIRECTORY_LOCATION_PROPERTY
			l_file_prop: FILE_LOCATION_PROPERTY
			l_override: CONF_OVERRIDE
			l_cluster: CONF_CLUSTER
			l_assembly: CONF_ASSEMBLY
			l_library: CONF_LIBRARY
			l_file_rule_prop: FILE_RULE_PROPERTY
			l_list_prop: LIST_PROPERTY
			l_deps: DS_HASH_SET [CONF_GROUP]
			l_deps_list: ARRAYED_LIST [STRING_32]
			l_dep_dialog: GROUPS_LIST_DIALOG
			l_over: ARRAYED_LIST [CONF_GROUP]
			l_over_list: ARRAYED_LIST [STRING_32]
			l_over_dialog: GROUPS_LIST_DIALOG
			l_rename_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [STRING_32, STRING_32]]
			l_mapping_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [STRING_32, STRING_32]]
			l_class_opt_prop: DIALOG_PROPERTY [HASH_TABLE [CONF_OPTION, STRING_32]]
			l_class_opt_dial: CLASS_OPTION_DIALOG
			l_vis_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]], STRING]]
			l_vis_dial: VISIBLE_DIALOG
			l_visible: CONF_VISIBLE
			l_precompile: CONF_PRECOMPILE
			l_virtual_group: CONF_VIRTUAL_GROUP
			l_load: CONF_LOAD
		do
			properties.reset

			properties.add_section (conf_interface_names.section_general)

				-- type
			create l_text_prop.make (conf_interface_names.group_type_name)
			l_text_prop.set_description (conf_interface_names.group_type_description)
			if a_group.is_override then
				l_text_prop.set_value (conf_interface_names.group_override)
				l_override ?= a_group
				l_cluster := l_override
				l_visible := l_cluster
			elseif a_group.is_cluster then
				l_text_prop.set_value (conf_interface_names.group_cluster)
				l_cluster ?= a_group
				l_visible := l_cluster
			elseif a_group.is_precompile then
				l_text_prop.set_value (conf_interface_names.group_precompile)
				l_precompile ?= a_group
				l_library := l_precompile
				l_visible := l_library
			elseif a_group.is_library then
				l_text_prop.set_value (conf_interface_names.group_library)
				l_library ?= a_group
				l_visible := l_library
					-- if `a_group' is a library without a library target we need to parse the file and set the library target
					-- as options are inherited from there
				if l_library.library_target = Void then
					create l_load.make (create {CONF_PARSE_FACTORY})
					l_load.retrieve_configuration (l_library.location.evaluated_path)
					if not l_load.is_error and then l_load.last_system.library_target /= Void then
						l_load.last_system.set_application_target (l_library.target)
						l_library.set_library_target (l_load.last_system.library_target)
					end
				end
			elseif a_group.is_assembly or a_group.is_physical_assembly then
				l_text_prop.set_value (conf_interface_names.group_assembly)
				l_assembly ?= a_group
			else
				check should_not_reach: False end
			end
			l_text_prop.enable_readonly
			properties.add_property (l_text_prop)

				-- name
			create l_text_prop.make (conf_interface_names.group_name_name)
			l_text_prop.set_description (conf_interface_names.group_name_description)
			l_text_prop.set_value (a_group.name)
			l_text_prop.validate_value_actions.extend (agent check_group_name ({STRING_32} ?, a_group, a_target))
			l_text_prop.change_value_actions.extend (agent (s: STRING_32; a_grp: CONF_GROUP)
				require
					s_not_void: s /= Void
					a_grp_not_void: a_grp /= Void
				do
					a_grp.set_name (s.as_string_8)
				end (?, a_group))
			l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (True)))
			properties.add_property (l_text_prop)

				-- description
			create l_mls_prop.make (conf_interface_names.group_description_name)
			l_mls_prop.set_description (conf_interface_names.group_description_description)
			l_mls_prop.enable_text_editing
			if a_group.description /= Void then
				l_mls_prop.set_value (a_group.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_group.set_description))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- readonly
			l_bool_prop := new_boolean_property (conf_interface_names.group_readonly_name, a_group.internal_read_only)
			l_bool_prop.set_description (conf_interface_names.group_readonly_description)
			l_bool_prop.change_value_actions.extend (agent a_group.set_readonly)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_bool_prop)

			if l_library /= Void then
					-- use application options
				l_bool_prop := new_boolean_property (conf_interface_names.library_use_application_options_name, l_library.use_application_options)
				l_bool_prop.set_description (conf_interface_names.library_use_application_options_description)
				l_bool_prop.change_value_actions.extend (agent l_library.set_use_application_options)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
				properties.add_property (l_bool_prop)
			end

			if l_cluster /= Void then
					-- recursive
				l_bool_prop := new_boolean_property (conf_interface_names.cluster_recursive_name, l_cluster.is_recursive)
				l_bool_prop.set_description (conf_interface_names.cluster_recursive_description)
				l_bool_prop.change_value_actions.extend (agent l_cluster.set_recursive)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (True)))
				properties.add_property (l_bool_prop)

					-- hidden
				l_bool_prop := new_boolean_property (conf_interface_names.cluster_hidden_name, l_cluster.is_hidden)
				l_bool_prop.set_description (conf_interface_names.cluster_hidden_description)
				l_bool_prop.change_value_actions.extend (agent l_cluster.set_hidden)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (True)))
				properties.add_property (l_bool_prop)
			end

				-- location
			if a_group.is_cluster then
				create l_dir_prop.make (conf_interface_names.group_location_name)
				l_dir_prop.set_target (a_target)
				l_dir_prop.set_description (conf_interface_names.group_location_description)
				l_dir_prop.set_value (a_group.location.original_path)
				l_dir_prop.validate_value_actions.extend (agent is_not_void ({STRING_32}?))
				l_dir_prop.change_value_actions.extend (agent update_group_location (a_group, ?, a_target))
				l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (True)))
				properties.add_property (l_dir_prop)
			else
				create l_file_prop.make (conf_interface_names.group_location_name)
				l_file_prop.set_target (a_target)
				l_file_prop.set_description (conf_interface_names.group_location_description)
				l_file_prop.set_value (a_group.location.original_path)
				l_file_prop.validate_value_actions.extend (agent is_not_void ({STRING_32}?))
				l_file_prop.change_value_actions.extend (agent update_group_location (a_group, ?, a_target))
				l_file_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (True)))
				if a_group.is_assembly then
					l_file_prop.add_filters (all_assemblies_filter, all_assemblies_description)
					l_file_prop.add_filters (all_files_filter, all_files_description)
				elseif a_group.is_library then
					l_file_prop.add_filters (config_files_filter, config_files_description)
					l_file_prop.add_filters (all_files_filter, all_files_description)
				end
				properties.add_property (l_file_prop)
			end

				-- options
			if not a_group.is_assembly then
				add_misc_option_properties (a_group.changeable_internal_options, a_group.options, True)
				add_dotnet_option_properties (a_group.changeable_internal_options, a_group.options, True, a_group.target.setting_msil_generation)
				add_assertion_option_properties (a_group.changeable_internal_options, a_group.options, True)
				add_warning_option_properties (a_group.changeable_internal_options, a_group.options, True)
				add_debug_option_properties (a_group.changeable_internal_options, a_group.options, True)
			end

			properties.current_section.expand
			properties.add_section (conf_interface_names.section_advanced)

				-- condition
			create l_dial.make_with_dialog (conf_interface_names.group_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (conf_interface_names.group_condition_description)
			l_dial.set_value (a_group.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent a_group.set_conditions)
			l_dial.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_CONDITION_LIST}?, agent handle_value_changes (True)))
			properties.add_property (l_dial)

			l_virtual_group ?= a_group
			if l_virtual_group /= Void then
					-- prefix
				create l_text_prop.make (conf_interface_names.group_prefix_name)
				l_text_prop.set_description (conf_interface_names.group_prefix_description)
				l_text_prop.set_value (l_virtual_group.name_prefix)
				l_text_prop.validate_value_actions.extend (agent (a_name: STRING_32): BOOLEAN
					require
						a_name_not_void: a_name /= Void
					do
						Result := a_name = Void or a_name.is_empty or (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_name.as_string_8)
					end)
				l_text_prop.change_value_actions.extend (agent (s: STRING_32; a_grp: CONF_VIRTUAL_GROUP)
					require
						s_not_void: s /= Void
						a_grp_not_void: a_grp /= Void
					do
						a_grp.set_name_prefix (s.as_string_8)
					end (?, l_virtual_group))
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (True)))
				properties.add_property (l_text_prop)

					-- renaming
				create l_rename_prop.make_with_dialog (conf_interface_names.group_renaming_name, create {RENAMING_DIALOG})
				l_rename_prop.set_description (conf_interface_names.group_renaming_description)
				l_rename_prop.set_display_agent (agent output_renaming)
				if l_virtual_group.renaming /= Void then
					l_rename_prop.set_value (l_virtual_group.renaming_32)
				end
				l_rename_prop.change_value_actions.extend (agent l_virtual_group.set_renaming_32)
				l_rename_prop.change_value_actions.extend (agent change_no_argument_wrapper ({EQUALITY_HASH_TABLE [STRING_32, STRING_32]}?, agent handle_value_changes (True)))
				properties.add_property (l_rename_prop)
			end

				-- class options
			if not a_group.is_assembly then
				create l_class_opt_dial.make (conf_factory)
				l_class_opt_dial.set_group_options (a_group.options)
				l_class_opt_dial.set_debugs (debug_clauses)
				create l_class_opt_prop.make_with_dialog (conf_interface_names.group_class_option_name, l_class_opt_dial)
				l_class_opt_prop.set_description (conf_interface_names.group_class_option_description)
				l_class_opt_prop.set_display_agent (agent output_class_options)
				if a_group.internal_class_options /= Void then
					l_class_opt_prop.set_value (a_group.class_options_32)
				end
				l_class_opt_prop.change_value_actions.extend (agent a_group.set_class_options_32)
				l_class_opt_prop.change_value_actions.extend (agent change_no_argument_wrapper ({HASH_TABLE [CONF_OPTION, STRING_32]}?, agent handle_value_changes (False)))
				properties.add_property (l_class_opt_prop)
			end

			if l_override /= Void then
					-- overrides
				l_over := l_override.override
				if l_over /= Void then
					from
						create l_over_list.make (l_over.count)
						l_over.start
					until
						l_over.after
					loop
						l_over_list.force (l_over.item.name)
						l_over.forth
					end
				end
				create l_over_dialog
				l_over_dialog.set_conf_target (a_target)
				create l_list_prop.make_with_dialog (conf_interface_names.override_override_name, l_over_dialog)
				l_list_prop.set_description (conf_interface_names.override_override_description)
				l_list_prop.set_value (l_over_list)
				l_list_prop.change_value_actions.extend (agent update_overrides (l_override, ?, a_target))
				l_list_prop.change_value_actions.extend (agent change_no_argument_wrapper ({LIST [STRING_32]}?, agent handle_value_changes (False)))
				properties.add_property (l_list_prop)
			end

			if l_cluster /= Void then
					-- file rules
				create l_file_rule_prop.make (conf_interface_names.file_rule_name)
				l_file_rule_prop.set_description (conf_interface_names.file_rule_description)
				l_file_rule_prop.set_refresh_action (agent l_cluster.internal_file_rule)
				l_file_rule_prop.refresh
				l_file_rule_prop.change_value_actions.extend (agent l_cluster.set_file_rule)
				l_file_rule_prop.change_value_actions.extend (agent update_inheritance_file_rule_cluster (?, l_file_rule_prop, a_group))
				l_file_rule_prop.change_value_actions.extend (agent change_no_argument_wrapper ({ARRAYED_LIST [CONF_FILE_RULE]}?, agent handle_value_changes (True)))
				l_file_rule_prop.use_inherited_actions.extend (agent l_cluster.set_file_rule (create {ARRAYED_LIST [CONF_FILE_RULE]}.make (0)))
				l_file_rule_prop.use_inherited_actions.extend (agent update_inheritance_file_rule_cluster (Void, l_file_rule_prop, a_group))
				l_file_rule_prop.use_inherited_actions.extend (agent handle_value_changes (True))
				update_inheritance_file_rule_cluster (Void, l_file_rule_prop, a_group)
				properties.add_property (l_file_rule_prop)

					-- dependencies
				l_deps := l_cluster.dependencies
				if l_deps /= Void then
					from
						create l_deps_list.make (l_deps.count)
						l_deps.start
					until
						l_deps.after
					loop
						l_deps_list.force (l_deps.item_for_iteration.name)
						l_deps.forth
					end
				end
				create l_dep_dialog
				l_dep_dialog.set_conf_target (a_target)
				create l_list_prop.make_with_dialog (conf_interface_names.cluster_dependencies_name, l_dep_dialog)
				l_list_prop.set_description (conf_interface_names.cluster_dependencies_description)
				l_list_prop.set_value (l_deps_list)
				l_list_prop.change_value_actions.extend (agent update_dependencies (l_cluster, ?, a_target))
				l_list_prop.change_value_actions.extend (agent change_no_argument_wrapper ({LIST [STRING_32]}?, agent handle_value_changes (True)))
				properties.add_property (l_list_prop)

					-- mapping
				create l_mapping_prop.make_with_dialog (conf_interface_names.cluster_mapping_name, create {RENAMING_DIALOG})
				l_mapping_prop.set_description (conf_interface_names.cluster_mapping_description)
				l_mapping_prop.set_display_agent (agent output_renaming)
				if l_cluster.mapping /= Void then
					l_mapping_prop.set_value (l_cluster.mapping_32)
				end
				l_mapping_prop.change_value_actions.extend (agent l_cluster.set_mapping_32)
				l_mapping_prop.change_value_actions.extend (agent change_no_argument_wrapper ({EQUALITY_HASH_TABLE [STRING_32, STRING_32]}?, agent handle_value_changes (True)))
				properties.add_property (l_mapping_prop)
			elseif l_assembly /= Void then
					-- assembly culture
				create l_text_prop.make (conf_interface_names.assembly_name_name)
				l_text_prop.set_description (conf_interface_names.assembly_name_description)
				l_text_prop.set_value (l_assembly.assembly_name)
				l_text_prop.change_value_actions.extend (agent (s: STRING_32; a_ass: CONF_ASSEMBLY)
					require
						s_not_void: s /= Void
						a_ass_not_void: a_ass /= Void
					do
						a_ass.set_assembly_name (s.as_string_8)
					end (?, l_assembly))
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (False)))
				properties.add_property (l_text_prop)

					-- assembly culture
				create l_text_prop.make (conf_interface_names.assembly_culture_name)
				l_text_prop.set_description (conf_interface_names.assembly_culture_description)
				l_text_prop.set_value (l_assembly.assembly_culture)
				l_text_prop.change_value_actions.extend (agent (s: STRING_32; a_ass: CONF_ASSEMBLY)
					require
						s_not_void: s /= Void
						a_ass_not_void: a_ass /= Void
					do
						a_ass.set_assembly_culture (s.as_string_8)
					end (?, l_assembly))
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (False)))
				properties.add_property (l_text_prop)

					-- assembly version
				create l_text_prop.make (conf_interface_names.assembly_version_name)
				l_text_prop.set_description (conf_interface_names.assembly_version_description)
				l_text_prop.set_value (l_assembly.assembly_version)
				l_text_prop.change_value_actions.extend (agent (s: STRING_32; a_ass: CONF_ASSEMBLY)
					require
						s_not_void: s /= Void
						a_ass_not_void: a_ass /= Void
					do
						a_ass.set_assembly_version (s.as_string_8)
					end (?, l_assembly))
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (False)))
				properties.add_property (l_text_prop)

					-- assembly public key token
				create l_text_prop.make (conf_interface_names.assembly_public_key_token_name)
				l_text_prop.set_description (conf_interface_names.assembly_public_key_token_description)
				l_text_prop.set_value (l_assembly.assembly_public_key_token)
				l_text_prop.change_value_actions.extend (agent (s: STRING_32; a_ass: CONF_ASSEMBLY)
					require
						s_not_void: s /= Void
						a_ass_not_void: a_ass /= Void
					do
						a_ass.set_assembly_public_key (s.as_string_8)
					end (?, l_assembly))
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (False)))
				properties.add_property (l_text_prop)
			end

			if l_visible /= Void then
					-- visible
				create l_vis_dial
				create l_vis_prop.make_with_dialog (conf_interface_names.cluster_visible_name, l_vis_dial)
				l_vis_prop.set_description (conf_interface_names.cluster_visible_description)
				l_vis_prop.set_display_agent (agent output_visible)
				l_vis_prop.set_value (l_visible.visible)
				l_vis_prop.change_value_actions.extend (agent l_visible.set_visible)
				l_vis_prop.change_value_actions.extend (agent change_no_argument_wrapper ({EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [STRING, EQUALITY_HASH_TABLE [STRING, STRING]]], STRING]}?, agent handle_value_changes (False)))
				properties.add_property (l_vis_prop)
			end

			if l_precompile /= Void then
					-- eifgens_location for precompiles
				create l_dir_prop.make (conf_interface_names.group_eifgens_location_name)
				l_dir_prop.set_target (a_target)
				l_dir_prop.set_description (conf_interface_names.group_eifgens_location_description)
				if l_precompile.eifgens_location /= Void then
					l_dir_prop.set_value (l_precompile.eifgens_location.original_path)
				end
				l_dir_prop.change_value_actions.extend (agent update_eifgens_location (l_precompile, ?, a_target))
				l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (True)))
				properties.add_property (l_dir_prop)
			end
			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

feature {NONE} -- Configuration settings

	update_group_location (a_group: CONF_GROUP; a_location: STRING_32; a_target: CONF_TARGET)
			-- Update location of `a_group' to be `a_location'.
		require
			a_group: a_group /= Void
			a_target: a_target /= Void
		local
			l_location: CONF_LOCATION
		do
			if a_location /= Void then
				if a_group.is_cluster then
					create {CONF_DIRECTORY_LOCATION}l_location.make (a_location, a_target)
				elseif a_group.is_assembly then
					create {CONF_FILE_LOCATION}l_location.make (a_location, a_target)
				elseif a_group.is_library then
					create {CONF_FILE_LOCATION}l_location.make (a_location, a_target)
				end
				a_group.set_location (l_location)
			end
		end

	update_eifgens_location (a_precompile: CONF_PRECOMPILE; a_location: STRING_32; a_target: CONF_TARGET)
			-- Update eifgens location of `a_precompile' to be `a_location'.
		require
			a_precompile: a_precompile /= Void
			a_target: a_target /= Void
		local
			l_location: CONF_DIRECTORY_LOCATION
		do
			if a_location /= Void then
				create l_location.make (a_location, a_target)
				a_precompile.set_eifgens_location (l_location)
			else
				a_precompile.set_eifgens_location (Void)
			end
		end

	update_dependencies (a_cluster: CONF_CLUSTER; a_dependencies: LIST [STRING_32]; a_target: CONF_TARGET)
			-- Update dependencies of `a_cluster'.
		require
			a_target_not_void: a_target /= Void
		local
			l_grps: HASH_TABLE [CONF_GROUP, STRING]
		do
			a_cluster.set_dependencies (Void)
			if a_dependencies /= Void and then not a_dependencies.is_empty then
				from
					l_grps := a_target.groups
					a_dependencies.start
				until
					a_dependencies.after
				loop
					a_cluster.add_dependency (l_grps.item (a_dependencies.item))
					a_dependencies.forth
				end
			end
		end

	update_overrides (an_override: CONF_OVERRIDE; an_overriding: LIST [STRING_32]; a_target: CONF_TARGET)
			-- Update groups we override of `a_cluster'.
		require
			a_target_not_void: a_target /= Void
		local
			l_grps: HASH_TABLE [CONF_GROUP, STRING]
		do
			an_override.set_override (Void)
			if an_overriding /= Void and then not an_overriding.is_empty then
				from
					l_grps := a_target.groups
					an_overriding.start
				until
					an_overriding.after
				loop
					an_override.add_override (l_grps.item (an_overriding.item.as_string_8))
					an_overriding.forth
				end
			end
		end

feature {NONE} -- Output generation

	output_renaming (a_table: EQUALITY_HASH_TABLE [STRING_32, STRING_32]): STRING_32
			-- Generate a text representation of `a_table'.
		do
			if a_table /= Void and then not a_table.is_empty then
				from
					create Result.make (20)
					a_table.start
				until
					a_table.after
				loop
					Result.append (a_table.key_for_iteration+"=>"+a_table.item_for_iteration+";")
					a_table.forth
				end
				Result.remove_tail (1)
			else
				create Result.make_empty
			end
		end

	output_class_options (a_table: HASH_TABLE [CONF_OPTION, STRING_32]): STRING_32
			-- Generate a text representation of class options table `a_table'.
		do
			if a_table /= Void and then not a_table.is_empty then
				from
					create Result.make (20)
					a_table.start
				until
					a_table.after
				loop
					if not a_table.item_for_iteration.is_empty then
						Result.append (a_table.key_for_iteration+";")
					end
					a_table.forth
				end
				if not Result.is_empty then
					Result.remove_tail (1)
				end
			else
				create Result.make_empty
			end
		end

	output_visible (a_visible: EQUALITY_HASH_TABLE [EQUALITY_TUPLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]]], STRING]): STRING_32
			-- Generate a text representation for `a_visible'.
		do
			if a_visible /= Void and then not a_visible.is_empty then
				from
					create Result.make (20)
					a_visible.start
				until
					a_visible.after
				loop
					Result.append (a_visible.key_for_iteration+";")
					a_visible.forth
				end
				Result.remove_tail (1)
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Validation and warning generation

	check_group_name (a_name: STRING_GENERAL; a_group: CONF_GROUP; a_target: CONF_TARGET): BOOLEAN
			-- Is `a_name' a valid name for `a_group' in `a_target'?
		require
			a_target: a_target /= Void
			a_name_not_void: a_name /= Void
			a_name_valid_as_string_8: a_name.is_valid_as_string_8
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
			l_name: STRING_8
		do
			l_groups := a_target.groups
			l_name := a_name.as_string_8.as_lower
			l_groups.search (l_name.as_lower)
			if not (create {EIFFEL_SYNTAX_CHECKER}).is_valid_group_name (l_name) then
				prompts.show_error_prompt (conf_interface_names.group_name_invalid, window, Void)
			elseif l_groups.found and then l_groups.found_item /= a_group then
				prompts.show_error_prompt (conf_interface_names.group_name_duplicate, window, Void)
			elseif l_name.is_empty then
				prompts.show_error_prompt (conf_interface_names.group_name_empty, window, Void)
			else
				Result := True
			end
		end

feature {NONE} -- Inheritance handling

	update_inheritance_file_rule_cluster (a_dummy: ARRAYED_LIST [CONF_FILE_RULE]; a_property: PROPERTY; a_group: CONF_GROUP)
			-- Enable inheritance/override on `a_property' depending on if there are file rules in the `a_group'.
		require
			a_property_not_void: a_property /= Void
			a_group_ok: a_group /= Void and then a_group.is_cluster
		local
			l_cluster: CONF_CLUSTER
		do
			l_cluster ?= a_group
			if not l_cluster.internal_file_rule.is_empty then
				a_property.enable_overriden
			else
				a_property.enable_inherited
			end
		end

note
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
