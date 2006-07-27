indexing
	description: "Generate properties for groups."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GROUP_PROPERTIES

inherit
	OPTION_PROPERTIES

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	add_group_properties (a_group: CONF_GROUP; a_target: CONF_TARGET) is
			-- Add `properties' for `a_group'.
		require
			properties_not_void: properties /= Void
			a_group_not_void: a_group /= Void
			a_target_not_void: a_target /= Void
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_text_prop: STRING_PROPERTY [STRING]
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
			l_dep_dialog: DEPENDENCY_DIALOG
			l_over: ARRAYED_LIST [CONF_GROUP]
			l_over_list: ARRAYED_LIST [STRING_32]
			l_over_dialog: OVERRIDE_DIALOG
			l_rename_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [STRING, STRING]]
			l_mapping_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [STRING, STRING]]
			l_class_opt_prop: DIALOG_PROPERTY [HASH_TABLE [CONF_OPTION, STRING]]
			l_class_opt_dial: CLASS_OPTION_DIALOG
			l_vis_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]], STRING]]
			l_vis_dial: VISIBLE_DIALOG
			l_visible: CONF_VISIBLE
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
				l_library ?= a_group
				l_visible := l_library
			elseif a_group.is_library then
				l_text_prop.set_value (conf_interface_names.group_library)
				l_library ?= a_group
				l_visible := l_library
			elseif a_group.is_assembly then
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
			l_text_prop.validate_value_actions.extend (agent check_group_name (?, a_group, a_target))
			l_text_prop.change_value_actions.extend (agent a_group.set_name)
			l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent handle_value_changes))
			properties.add_property (l_text_prop)

				-- description
			create l_mls_prop.make (conf_interface_names.group_description_name)
			l_mls_prop.set_description (conf_interface_names.group_description_description)
			l_mls_prop.enable_text_editing
			if a_group.description /= Void then
				l_mls_prop.set_value (a_group.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_group.set_description))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes))
			properties.add_property (l_mls_prop)

				-- readonly
			create l_bool_prop.make_with_value (conf_interface_names.group_readonly_name, a_group.internal_read_only)
			l_bool_prop.set_description (conf_interface_names.group_readonly_description)
			l_bool_prop.change_value_actions.extend (agent a_group.set_readonly)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes))
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent refresh))
			properties.add_property (l_bool_prop)

			if l_cluster /= Void then
					-- recursive
				create l_bool_prop.make_with_value (conf_interface_names.cluster_recursive_name, l_cluster.is_recursive)
				l_bool_prop.set_description (conf_interface_names.cluster_recursive_description)
				l_bool_prop.change_value_actions.extend (agent l_cluster.set_recursive)
				l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes))
				properties.add_property (l_bool_prop)
			end

				-- location
			if a_group.is_cluster then
				create l_dir_prop.make (conf_interface_names.group_location_name)
				l_dir_prop.set_target (a_target)
				l_dir_prop.set_description (conf_interface_names.group_location_description)
				l_dir_prop.set_value (a_group.location.original_path)
				l_dir_prop.change_value_actions.extend (agent update_group_location (a_group, ?, a_target))
				l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes))
				properties.add_property (l_dir_prop)
			else
				create l_file_prop.make (conf_interface_names.group_location_name)
				l_file_prop.set_target (a_target)
				l_file_prop.set_description (conf_interface_names.group_location_description)
				l_file_prop.set_value (a_group.location.original_path)
				l_file_prop.change_value_actions.extend (agent update_group_location (a_group, ?, a_target))
				l_file_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes))
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
			l_dial.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_CONDITION_LIST}?, agent handle_value_changes))
			properties.add_property (l_dial)

				-- prefix
			create l_text_prop.make (conf_interface_names.group_prefix_name)
			l_text_prop.set_description (conf_interface_names.group_prefix_description)
			l_text_prop.set_value (a_group.name_prefix)
			l_text_prop.change_value_actions.extend (agent a_group.set_name_prefix)
			l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent handle_value_changes))
			properties.add_property (l_text_prop)

				-- renaming
			create l_rename_prop.make_with_dialog (conf_interface_names.group_renaming_name, create {RENAMING_DIALOG})
			l_rename_prop.set_description (conf_interface_names.group_renaming_description)
			l_rename_prop.set_display_agent (agent output_renaming)
			if a_group.renaming /= Void then
				l_rename_prop.set_value (a_group.renaming)
			end
			l_rename_prop.change_value_actions.extend (agent a_group.set_renaming)
			l_rename_prop.change_value_actions.extend (agent change_no_argument_wrapper ({EQUALITY_HASH_TABLE [STRING, STRING]}?, agent handle_value_changes))
			properties.add_property (l_rename_prop)

				-- class options
			if not a_group.is_assembly then
				create l_class_opt_dial
				l_class_opt_dial.set_group_options (a_group.options)
				l_class_opt_dial.set_debugs (debug_clauses)
				create l_class_opt_prop.make_with_dialog (conf_interface_names.group_class_option_name, l_class_opt_dial)
				l_class_opt_prop.set_description (conf_interface_names.group_class_option_description)
				l_class_opt_prop.set_display_agent (agent output_class_options)
				if a_group.class_options /= Void then
					l_class_opt_prop.set_value (a_group.class_options)
				end
				l_class_opt_prop.change_value_actions.extend (agent a_group.set_class_options)
				l_class_opt_prop.change_value_actions.extend (agent change_no_argument_wrapper ({HASH_TABLE [CONF_OPTION, STRING]}?, agent handle_value_changes))
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
				l_list_prop.change_value_actions.extend (agent change_no_argument_wrapper ({LIST [STRING_32]}?, agent handle_value_changes))
				properties.add_property (l_list_prop)
			end

			if l_cluster /= Void then
					-- file rules
				create l_file_rule_prop.make (conf_interface_names.cluster_file_rule_name)
				l_file_rule_prop.set_description (conf_interface_names.cluster_file_rule_description)
				l_file_rule_prop.set_refresh_action (agent l_cluster.internal_file_rule)
				l_file_rule_prop.refresh
				l_file_rule_prop.change_value_actions.extend (agent l_cluster.set_file_rule)
				l_file_rule_prop.change_value_actions.extend (agent update_inheritance_file_rule_cluster (?, l_file_rule_prop, a_group))
				l_file_rule_prop.change_value_actions.extend (agent change_no_argument_wrapper ({ARRAYED_LIST [CONF_FILE_RULE]}?, agent handle_value_changes))
				l_file_rule_prop.use_inherited_actions.extend (agent l_cluster.set_file_rule (create {ARRAYED_LIST [CONF_FILE_RULE]}.make (0)))
				l_file_rule_prop.use_inherited_actions.extend (agent update_inheritance_file_rule_cluster (Void, l_file_rule_prop, a_group))
				l_file_rule_prop.use_inherited_actions.extend (agent handle_value_changes)
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
				l_list_prop.change_value_actions.extend (agent change_no_argument_wrapper ({LIST [STRING_32]}?, agent handle_value_changes))
				properties.add_property (l_list_prop)

					-- mapping
				create l_mapping_prop.make_with_dialog (conf_interface_names.cluster_mapping_name, create {RENAMING_DIALOG})
				l_mapping_prop.set_description (conf_interface_names.cluster_mapping_description)
				l_mapping_prop.set_display_agent (agent output_renaming)
				if l_cluster.mapping /= Void then
					l_mapping_prop.set_value (l_cluster.mapping)
				end
				l_mapping_prop.change_value_actions.extend (agent l_cluster.set_mapping)
				l_mapping_prop.change_value_actions.extend (agent change_no_argument_wrapper ({EQUALITY_HASH_TABLE [STRING, STRING]}?, agent handle_value_changes))
				properties.add_property (l_mapping_prop)
			elseif l_assembly /= Void then
					-- assembly culture
				create l_text_prop.make (conf_interface_names.assembly_name_name)
				l_text_prop.set_description (conf_interface_names.assembly_name_description)
				l_text_prop.set_value (l_assembly.assembly_name)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_name)
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent handle_value_changes))
				properties.add_property (l_text_prop)

					-- assembly culture
				create l_text_prop.make (conf_interface_names.assembly_culture_name)
				l_text_prop.set_description (conf_interface_names.assembly_culture_description)
				l_text_prop.set_value (l_assembly.assembly_culture)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_culture)
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent handle_value_changes))
				properties.add_property (l_text_prop)

					-- assembly version
				create l_text_prop.make (conf_interface_names.assembly_version_name)
				l_text_prop.set_description (conf_interface_names.assembly_version_description)
				l_text_prop.set_value (l_assembly.assembly_version)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_version)
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent handle_value_changes))
				properties.add_property (l_text_prop)

					-- assembly public key token
				create l_text_prop.make (conf_interface_names.assembly_public_key_token_name)
				l_text_prop.set_description (conf_interface_names.assembly_public_key_token_description)
				l_text_prop.set_value (l_assembly.assembly_public_key_token)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_public_key)
				l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent handle_value_changes))
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
				l_vis_prop.change_value_actions.extend (agent change_no_argument_wrapper ({EQUALITY_HASH_TABLE [TUPLE [STRING, EQUALITY_HASH_TABLE [STRING, STRING]], STRING]}?, agent handle_value_changes))
				properties.add_property (l_vis_prop)
			end
			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

feature {NONE} -- Configuration settings

	update_group_location (a_group: CONF_GROUP; a_location: STRING_32; a_target: CONF_TARGET) is
			-- Update location of `a_group' to be `a_location'.
		require
			a_group: a_group /= Void
			a_target: a_target /= Void
		local
			l_location: CONF_LOCATION
		do
			if a_location /= Void and then not a_location.is_empty then
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

	update_dependencies (a_cluster: CONF_CLUSTER; a_dependencies: LIST [STRING_32]; a_target: CONF_TARGET) is
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

	update_overrides (an_override: CONF_OVERRIDE; an_overriding: LIST [STRING_32]; a_target: CONF_TARGET) is
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
					an_override.add_override (l_grps.item (an_overriding.item))
					an_overriding.forth
				end
			end
		end

feature {NONE} -- Output generation

	output_renaming (a_table: EQUALITY_HASH_TABLE [STRING, STRING]): STRING_32 is
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

	output_class_options (a_table: HASH_TABLE [CONF_OPTION, STRING]): STRING_32 is
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

	output_visible (a_visible: EQUALITY_HASH_TABLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]], STRING]): STRING_32 is
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

	check_group_name (a_name: STRING; a_group: CONF_GROUP; a_target: CONF_TARGET): BOOLEAN is
			-- Is `a_name' a valid name for `a_group' in `a_target'?
		require
			a_target: a_target /= Void
			a_name_not_void: a_name /= Void
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
			wd: EV_WARNING_DIALOG
		do
			l_groups := a_target.groups
			l_groups.search (a_name.as_lower)
			if l_groups.found and then l_groups.found_item /= a_group then
				create wd.make_with_text (conf_interface_names.group_name_duplicate)
				wd.show_modal_to_window (window)
			else
				Result := True
			end
		end

feature {NONE} -- Inheritance handling

	update_inheritance_file_rule_cluster (a_dummy: ARRAYED_LIST [CONF_FILE_RULE]; a_property: PROPERTY; a_group: CONF_GROUP) is
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
