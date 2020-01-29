note
	description: "Dialog to edit the root of a target."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_DIALOG

inherit
	PROPERTY_DIALOG [CONF_ROOT]
		redefine
			create_interface_objects,
			initialize,
			on_ok
		end

	CONF_INTERFACE_CONSTANTS
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (t: like target)
			-- Initialize a dialog with a target `t`.
		do
			target := t
			default_create
		ensure
			target_set: target = t
		end

	create_interface_objects
		do
			Precursor
			create all_classes
			create feature_name
			create class_name
			create cluster_name
		end

	initialize
			-- Initialization
		local
			l_label: EV_LABEL
		do
			Precursor {PROPERTY_DIALOG}

			create l_label.make_with_text (conf_interface_names.target_dialog_root_cluster)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create cluster_name
			element_container.extend (cluster_name)
			element_container.disable_item_expand (cluster_name)
			append_small_margin (element_container)

			create l_label.make_with_text (conf_interface_names.target_dialog_root_class)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create class_name
			element_container.extend (class_name)
			element_container.disable_item_expand (class_name)
			append_small_margin (element_container)

			create l_label.make_with_text (conf_interface_names.target_dialog_root_feature)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create feature_name
			element_container.extend (feature_name)
			element_container.disable_item_expand (feature_name)
			append_small_margin (element_container)

--			create all_classes
			all_classes.set_text (conf_interface_names.target_dialog_root_all)
			element_container.extend (all_classes)
			element_container.disable_item_expand (all_classes)
			append_small_margin (element_container)

			set_size (200, 0)
			show_actions.extend (agent on_show)
			all_classes.select_actions.extend (agent on_all_classes)
		end

feature -- Access

	target: CONF_TARGET
			-- Target that has the root.

feature {NONE} -- Gui elements

	cluster_name: EV_TEXT_FIELD
			-- Field to enter the root cluster.

	class_name: EV_TEXT_FIELD
			-- Field to enter the root class.

	feature_name: EV_TEXT_FIELD
			-- Field to enter the root feature name.

	all_classes: EV_CHECK_BUTTON
			-- Compile all classes check box.

feature {NONE} -- Agents

	on_show
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			if attached value as v then
				if v.is_all_root then
					all_classes.enable_select
				else
					all_classes.disable_select
					if attached v.cluster_name as s then
						cluster_name.set_text (s)
					end
					class_name.set_text (v.class_type_name)
					if attached v.feature_name as s then
						feature_name.set_text (s)
					end
				end
			end
		end

	on_all_classes
			-- All classes was selected.
		do
			if all_classes.is_selected then
				cluster_name.disable_sensitive
				class_name.disable_sensitive
				feature_name.disable_sensitive
			else
				cluster_name.enable_sensitive
				class_name.enable_sensitive
				feature_name.enable_sensitive
			end
		end

	on_ok
			-- Ok was pressed.
		local
			l_root: CONF_ROOT
			l_cluster, l_class: STRING_32
			l_feature: STRING_32
			l_checker: EIFFEL_SYNTAX_CHECKER
		do
			if all_classes.is_selected then
				create l_root.make (Void, Void, Void, True)
			else
				l_cluster := cluster_name.text
				l_class := class_name.text
				l_feature := feature_name.text

					-- Check validity of l_cluster, l_class and l_feature.
				create l_checker
				if not l_cluster.is_empty and not l_checker.is_valid_group_name (l_cluster) then
					prompts.show_error_prompt (conf_interface_names.root_invalid_cluster, Current, Void)
				elseif not l_class.is_empty and not l_checker.is_valid_class_type_name (l_class) then
					prompts.show_error_prompt (conf_interface_names.root_invalid_class, Current, Void)
				elseif not l_feature.is_empty and not l_checker.is_valid_feature_name_32 (l_feature) then
					prompts.show_error_prompt (conf_interface_names.root_invalid_feature, Current, Void)
				else
					if l_cluster.is_empty then
						l_cluster := Void
					end
					if l_feature.is_empty then
						l_feature := Void
					end
					if not l_class.is_empty then
						create l_root.make (l_cluster, l_class, l_feature, False)
					elseif l_cluster /= Void or l_feature /= Void then
						prompts.show_error_prompt (conf_interface_names.root_no_class, Current, Void)
					elseif target.child_targets.is_empty then
							-- we don't have any child targets, so we need a root class.
						prompts.show_error_prompt (conf_interface_names.root_none, Current, Void)
					end
				end
			end

			if l_root /= Void then
				set_value (l_root)
				Precursor {PROPERTY_DIALOG}
			end
		end

invariant
	elements: is_initialized implies cluster_name /= Void and class_name /= Void and feature_name /= Void and all_classes /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
