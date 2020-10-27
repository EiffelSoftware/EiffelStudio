note
	description: "Summary description for {ES_TEST_GENERAL_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_GENERAL_WIZARD_PAGE_PANEL

inherit
	ES_TEST_WIZARD_PAGE_PANEL

	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_cluster_added
		end

	EB_SHARED_WINDOW_MANAGER

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_frame: EV_FRAME
		do
			build_class_name (a_widget)

			create l_frame.make_with_text (locale_formatter.translation (l_location))
			extend_no_expand (a_widget, l_frame)
			build_cluster_tree (l_frame)

			create l_frame.make_with_text (locale_formatter.translation (options_text))
			extend_no_expand (a_widget, l_frame)
			build_options_interface (l_frame)
		end

	build_class_name (a_widget: EV_VERTICAL_BOX)
			-- Initialize `class_name'.
		local
			l_label: EV_LABEL
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create l_label.make_with_text (locale_formatter.translation (l_class_name))
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)

			create class_name.make (create {EV_TEXT_FIELD}, agent validate_class_name)
			l_hbox.extend (class_name)

			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)
		end

	build_cluster_tree (a_frame: EV_FRAME)
			-- Initialize `class_tree'.
		local
			l_vbox: EV_VERTICAL_BOX
			l_link_label: EV_LINK_LABEL
		do
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create class_tree.make_with_options (Void, False, False)
			class_tree.set_minimum_height (dialog_unit_to_pixels (200))
			class_tree.refresh
			l_vbox.extend (class_tree)

			create l_link_label.make_with_text (locale_formatter.translation (l_new_cluster))
			l_link_label.select_actions.extend (agent on_create_cluster)
			l_link_label.align_text_left
			l_vbox.extend (l_link_label)
			l_vbox.disable_item_expand (l_link_label)

			a_frame.extend (l_vbox)
		end

	build_options_interface (a_frame: EV_FRAME)
			-- Build interface for general test creation options
		local
			l_vbox: EV_VERTICAL_BOX
		do
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			a_frame.extend (l_vbox)

			create launch_wizard_checkbox.make_with_text (locale.translation (launch_wizard_text))
			l_vbox.extend (launch_wizard_checkbox)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_name, l_path: STRING
			l_cluster: detachable CONF_CLUSTER
			l_global_session, l_session: SESSION_I
		do
			l_session := a_service.retrieve (True)
			l_global_session := a_service.retrieve (False)

			class_name.set_entry_formatter (agent {attached STRING_32}.as_upper)
			class_name.valid_state_changed_actions.extend (agent on_valid_state_changed)
			class_tree.select_actions.extend (agent on_select_tree_item)

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.class_name,
					{TEST_SESSION_CONSTANTS}.class_name_default) as l_clname
			then
				l_name := l_clname
			else
				l_name := {TEST_SESSION_CONSTANTS}.class_name_default
			end
			class_name.set_text (l_name)

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.cluster_name,
					{TEST_SESSION_CONSTANTS}.cluster_name_default) as l_cluster_name
			then
				if not l_cluster_name.is_empty then
					l_cluster := eiffel_universe.cluster_of_name (l_cluster_name)
				end
			end

			if l_cluster /= Void then
				l_path := {TEST_SESSION_CONSTANTS}.path_default
				if attached {STRING} l_session.value ({TEST_SESSION_CONSTANTS}.path) as l_spath then
					l_path := l_spath
				end
				class_tree.show_subfolder (l_cluster, l_path)
			end

			if
				attached {BOOLEAN} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.launch_wizard,
					{TEST_SESSION_CONSTANTS}.launch_wizard_default) as l_launch_wizard
			then
				if l_launch_wizard then
					launch_wizard_checkbox.enable_select
				else
					launch_wizard_checkbox.disable_select
				end
			end
		end

feature {NONE} -- Access

	class_name: ES_VALIDATING_WRAPPED_WIDGET
			-- Text field for new test class name

	class_tree: ES_TEST_WIZARD_CLASS_TREE
			-- Tree displaying clusters and existing test classes

	class_name_validator: ES_CLASS_NAME_VALIDATOR
			-- Validator for `class_name'
		once
			create Result
		end

	selected_cluster: detachable STRING
			-- Name of selected cluster, Void if no cluster is selected

	selected_path: detachable IMMUTABLE_STRING_32
			-- Selected relative path, Void if no path selected

	launch_wizard_checkbox: EV_CHECK_BUTTON
			-- Checkbox for setting wizard behavior

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := class_name.is_valid and then (selected_cluster /= Void)
		end

feature {NONE} -- Events

	validate_class_name (a_name: STRING_32): TUPLE [BOOLEAN, detachable STRING_32]
			-- Called when `class_name' contents need to be validated
		local
			l_name: STRING
			l_error: detachable STRING_32
		do
			l_name := a_name.to_string_8
			check l_name /= Void end
			class_name_validator.validate_class_name (l_name)
			if not class_name_validator.is_valid then
				l_error := class_name_validator.last_error_message
			end
			Result := [l_error = Void, l_error]
		end

	on_create_cluster
			-- Called when new cluster should be added.
		local
			l_cmd: EB_NEW_CLUSTER_COMMAND
		do
			create l_cmd.make (window_manager.last_focused_development_window, True)
			if l_cmd.executable then
				manager.add_observer (Current)
				l_cmd.execute
				manager.remove_observer (Current)
			end
			l_cmd.recycle
		end

	on_cluster_added (a_cluster: CLUSTER_I)
			-- <Precursor>
		do
			class_tree.show_stone (create {CLUSTER_STONE}.make (a_cluster))
		end

	on_select_tree_item
			-- Called when item in `class_tree' is selected.
		local
			l_parent: CONF_CLUSTER
		do
			selected_cluster := Void
			selected_path := Void
			if attached {ES_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM} class_tree.selected_item as l_item then
				if attached {EB_SORTED_CLUSTER} l_item.data as l_eb_cluster then
					if l_eb_cluster.actual_group /= Void and then l_eb_cluster.is_cluster then
						l_parent := l_eb_cluster.actual_cluster
						selected_cluster := l_parent.name
						selected_path := l_item.path
					end
				end
			end
			on_valid_state_change
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_global_session, l_session: SESSION_I
			l_cluster, l_path: STRING
		do
			l_session := a_service.retrieve (True)
			l_global_session := a_service.retrieve (False)
			l_session.set_value (class_name.text.to_string_8, {TEST_SESSION_CONSTANTS}.class_name)
			l_cluster := {TEST_SESSION_CONSTANTS}.cluster_name_default
			l_path := {TEST_SESSION_CONSTANTS}.path_default
			if attached {STRING} selected_cluster as l_scluster then
				l_cluster := l_scluster
				if attached {STRING} selected_path as l_spath then
					l_path := l_spath
				end
			end
			l_session.set_value (l_cluster, {TEST_SESSION_CONSTANTS}.cluster_name)
			l_session.set_value (l_path, {TEST_SESSION_CONSTANTS}.path)
			l_global_session.set_value (launch_wizard_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.launch_wizard)
		end

feature {NONE} -- Internationalization

	l_class_name: STRING = "Class name: "
	l_location: STRING = "Location"
	l_new_cluster: STRING = "New Cluster"
	options_text: STRING = "Options"
	launch_wizard_text: STRING = "Always show wizard before launching test creation"

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
