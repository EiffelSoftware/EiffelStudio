note
	description: "Summary description for {ES_TEST_WIZARD_NEW_CLASS_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_NEW_CLASS_WINDOW

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			wizard_information,
			clean_screen,
			cancel
		end

	ES_TEST_WIZARD_WINDOW
		redefine
			wizard_information,
			clean_screen,
			cancel
		end

	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_cluster_added
		end

create
	make_window

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_hsep: EV_HORIZONTAL_SEPARATOR
			l_vsep: EV_VERTICAL_SEPARATOR
			l_hbox: EV_HORIZONTAL_BOX
			l_cell: EV_VERTICAL_BOX
		do
			l_parent := initialize_container (choice_box)

			build_class_name (l_parent)
			create l_hsep
			l_parent.extend (l_hsep)
			l_parent.disable_item_expand (l_hsep)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			build_class_tree (l_hbox)

			if wizard_information.is_new_manual_test_class then
				create l_vsep
				l_hbox.extend (l_vsep)
				l_hbox.disable_item_expand (l_vsep)
				build_checkboxes (l_hbox)
			else
				create l_cell
				build_checkboxes (l_cell)
				l_hbox.extend (l_cell)
				l_hbox.disable_item_expand (l_cell)
				l_cell.hide
			end

			l_parent.extend (l_hbox)

			on_after_initialize
		end

	build_class_name (a_parent: EV_BOX)
			-- Initialize `class_name'.
		local
			l_label: EV_LABEL
			l_hb: EV_HORIZONTAL_BOX
		do
			create l_hb
			l_hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_label
			if wizard_information.is_generated_test_class then
				l_label.set_text (locale_formatter.translation (l_class_name_prefix))
			else
				l_label.set_text (locale_formatter.translation (l_class_name))
			end
			l_hb.extend (l_label)
			l_hb.disable_item_expand (l_label)

			create class_name.make (create {EV_TEXT_FIELD}, agent validate_class_name, agent {!STRING_32}.as_upper)
			l_hb.extend (class_name)

			a_parent.extend (l_hb)
			a_parent.disable_item_expand (l_hb)

			create class_name_error_label
			class_name_error_label.set_foreground_color ((create {EV_STOCK_COLORS}).red)
			class_name_error_label.align_text_right
			a_parent.extend (class_name_error_label)
			a_parent.disable_item_expand (class_name_error_label)
		end

	build_class_tree (a_parent: EV_BOX)
			-- Initialize `class_tree'
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_button: SD_TOOL_BAR_BUTTON
			l_tb: SD_TOOL_BAR
			l_layouts: EV_LAYOUT_CONSTANTS
			l_label: EV_LABEL
		do
			create l_vbox

			create l_hbox
			create l_label.make_with_text (locale_formatter.translation (l_select_cluster))
			l_label.align_text_left
			l_hbox.extend (l_label)

			cluster_error_icon := pixmaps.icon_pixmaps.general_error_icon.twin
			l_hbox.extend (cluster_error_icon)
			l_hbox.disable_item_expand (cluster_error_icon)

			create l_tb.make
			create l_button.make
			l_button.set_pixmap (pixmaps.icon_pixmaps.new_cluster_icon)
			l_button.select_actions.extend (agent on_create_cluster)
			l_button.set_tooltip (locale_formatter.translation (tt_new_cluster))
			l_tb.extend (l_button)
			l_tb.compute_minimum_size
			l_hbox.extend (l_tb)
			l_hbox.disable_item_expand (l_tb)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

			create l_layouts
			create class_tree.make_with_options (development_window.menus.context_menu_factory, False, False)
			class_tree.select_actions.extend (agent on_select_tree_item)
	--		class_tree.set_minimum_width (l_layouts.dialog_unit_to_pixels(270))
	--		class_tree.set_minimum_height (l_layouts.dialog_unit_to_pixels(200))
			class_tree.refresh
			l_vbox.extend (class_tree)

			a_parent.extend (l_vbox)
		end

	build_checkboxes (a_parent: EV_BOX)
			-- Initialize `setup_checkbox' and `trear_down_checkbox'.
		local
			l_vb: EV_VERTICAL_BOX
		do
			create l_vb

			create setup_checkbox
			setup_checkbox.set_text (locale_formatter.formatted_translation (b_setup_routine, [{TEST_CONSTANTS}.prepare_routine_name]))
			setup_checkbox.select_actions.extend (agent on_setup_change)
			l_vb.extend (setup_checkbox)
			l_vb.disable_item_expand (setup_checkbox)

			create tear_down_checkbox
			tear_down_checkbox.set_text (locale_formatter.formatted_translation (b_tear_down_routine, [{TEST_CONSTANTS}.clean_routine_name]))
			tear_down_checkbox.select_actions.extend (agent on_tear_down_change)
			l_vb.extend (tear_down_checkbox)
			l_vb.disable_item_expand (tear_down_checkbox)

			create system_level_test_checkbox
			system_level_test_checkbox.set_text (locale_formatter.translation (b_system_level_test))
			system_level_test_checkbox.select_actions.extend (agent on_system_level_test_change)
			l_vb.extend (system_level_test_checkbox)
			l_vb.disable_item_expand (system_level_test_checkbox)

			a_parent.extend (l_vb)
			a_parent.disable_item_expand (l_vb)
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_text: STRING_32
			l_name, l_path: ?STRING
			l_cluster: ?CONF_CLUSTER
			b: BOOLEAN
		do
			l_name := wizard_information.new_class_name_cache
			if l_name /= Void then
				class_name.widget.set_text (l_name)
			else
				class_name.widget.set_text (default_class_name)
			end
			class_name.widget.set_focus
			l_text := class_name.widget.text
			check l_text /= Void end
			b := validate_class_name (l_text)

			l_cluster := wizard_information.cluster_cache
			if l_cluster /= Void then
				l_path := wizard_information.path_cache
				if l_path /= Void then
					class_tree.show_subfolder (l_cluster, l_path)
				else
					class_tree.show_subfolder (l_cluster, "")
				end
			end

			if wizard_information.is_new_manual_test_class then
				if wizard_information.has_prepare_cache then
					setup_checkbox.enable_select
				else
					setup_checkbox.disable_select
				end
				if wizard_information.has_clean_cache then
					tear_down_checkbox.enable_select
				else
					tear_down_checkbox.disable_select
				end
				if wizard_information.is_system_level_test then
					system_level_test_checkbox.enable_select
				else
					system_level_test_checkbox.disable_select
				end
				system_level_test_checkbox.disable_sensitive
			end

			validate_cluster
			update_next_button_status
		end

feature {NONE} -- Access

	wizard_information: ES_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

	class_name_validator: ES_CLASS_NAME_VALIDATOR
			-- Validator for `class_name'
		once
			create Result
		end

feature {NONE} -- Access: widgets

	class_name: ES_RESTRICTED_TEXTABLE_WIDGET [EV_TEXT_FIELD]
			-- Text field for new test class name

	class_name_error_label: EV_LABEL
			-- Label showing invalid class name

	class_tree: ?ES_TEST_WIZARD_CLASS_TREE
			-- Tree displaying clusters and existing test classes
			--
			-- Note: must be detachable for recycling

	cluster_error_icon: EV_PIXMAP
			-- Icon used to show error with selected cluster

	setup_checkbox: EV_CHECK_BUTTON
			-- Checkbox for creating setup routine

	tear_down_checkbox: EV_CHECK_BUTTON
			-- Checkbox for creating tear down routine

	system_level_test_checkbox: EV_CHECK_BUTTON
			-- Checkbox for creating a system level test

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := is_class_name_valid and is_cluster_valid
		end

	is_class_name_valid: BOOLEAN
			-- Is entered class name valid?

	is_cluster_valid: BOOLEAN
			-- Is choosen cluster valid?

	is_validating_class_name: BOOLEAN
			-- Is `on_validate_class_name' already called?

feature {NONE} -- Events

	validate_class_name (a_name: !STRING_32): BOOLEAN
			-- Called when `class_name' contents need to be validated
		local
			l_name: STRING
			l_path: STRING
			l_error: ?STRING_32
			l_cluster: ?CONF_CLUSTER
		do
			l_name := a_name.to_string_8
			check l_name /= Void end
			Result := True
			class_name_validator.validate_class_name (l_name)
			if l_name.is_empty or class_name_validator.is_valid then
				Result := True
				wizard_information.new_class_name_cache := l_name
				if not l_name.is_empty then
					if test_suite.is_service_available and then test_suite.service.is_project_initialized then
						if wizard_information.is_generated_test_class then
							class_name_validator.validate_class_name (l_name)
						else
							class_name_validator.validate_new_class_name (l_name, test_suite.service.eiffel_project)
						end
						if class_name_validator.is_valid then
							if is_cluster_valid and not wizard_information.is_generated_test_class then
								l_cluster := wizard_information.cluster_cache
								check l_cluster /= Void end
								l_path := l_cluster.location.build_path (wizard_information.path, l_name.as_lower)
								l_path.append (".e")
								if (create {RAW_FILE}.make (l_path)).exists then
									l_error := locale_formatter.formatted_translation (e_file_exists, [l_path])
								end
							end
						else
							l_error := class_name_validator.last_error_message
						end
					else
						l_error := locale_formatter.translation (e_project_not_available)
					end
				end
				if l_error /= Void then
					class_name_error_label.set_text (l_error)
					class_name_error_label.show
					is_class_name_valid := False
				else
					is_class_name_valid := not l_name.is_empty
					class_name_error_label.hide
				end
				update_next_button_status
			else
					-- This means text in box will remain the same, so we also should not update anything
				Result := False
			end
		end

	on_create_cluster
			-- Called when new cluster should be added.
		local
			l_cmd: EB_NEW_CLUSTER_COMMAND
		do
			create l_cmd.make (development_window, True)
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
			l_text: STRING_32
			l_parent: CONF_CLUSTER
			l_path: ?STRING
			b: BOOLEAN
		do
			wizard_information.cluster_cache := Void
			wizard_information.path_cache := Void
			if {l_item: ES_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM} class_tree.selected_item then
				if {l_eb_cluster: EB_SORTED_CLUSTER} l_item.data then
					if l_eb_cluster.actual_group /= Void and then l_eb_cluster.is_cluster then
						l_parent := l_eb_cluster.actual_cluster
						wizard_information.cluster_cache := l_parent
						l_path := l_item.path
						if l_path /= Void then
							wizard_information.path_cache := l_path
						else
							wizard_information.path_cache := ""
						end
					end
				end
			end
			validate_cluster
			l_text := class_name.widget.text
			check l_text /= Void end
			b := validate_class_name (l_text)
			update_next_button_status
		end

	on_setup_change
			-- Called when selection state of `setup_checkbox' changes.
		do
			wizard_information.has_prepare := setup_checkbox.is_selected
		end

	on_tear_down_change
			-- Called when selection state of `tear_down_checkbox' changes.
		do
			wizard_information.has_clean := tear_down_checkbox.is_selected
		end

	on_system_level_test_change
			-- Called when selection state of `system_level_test_checkbox' changes.
		do
			wizard_information.is_system_level_test := system_level_test_checkbox.is_selected
		end

feature {NONE} -- Basic operations

	validate_cluster
			-- Validate cluster information
		local
			l_error: ?STRING_32
			l_path: FILE_NAME
			l_directory: DIRECTORY
		do
			if wizard_information.cluster_cache /= Void and wizard_information.path_cache /= Void then
				is_cluster_valid := True
				create l_path.make_from_string (wizard_information.cluster.location.build_path (wizard_information.path, ""))
				create l_directory.make (l_path)
				if l_directory.exists then
					if not l_directory.is_writable then
						l_error := locale_formatter.formatted_translation (e_directory_not_writable, [l_path])
					end
				else
					l_error := locale_formatter.formatted_translation (e_directory_non_existent, [l_path])
				end
			else
				is_cluster_valid := False
			end
			if l_error /= Void then
				is_cluster_valid := False
				cluster_error_icon.show
			else
				create l_error.make_empty
				cluster_error_icon.hide
			end
			cluster_error_icon.set_tooltip (l_error)
		end

	proceed_with_current_info
			-- <Precursor>
		do
			if wizard_information.is_extracted_test_class then
				proceed_with_new_state (create {ES_TEST_WIZARD_CALL_STACK_WINDOW}.make_window (development_window, wizard_information))
			elseif wizard_information.is_generated_test_class then
				proceed_with_new_state (create {ES_TEST_WIZARD_AUTO_TEST_WINDOW}.make_window (development_window, wizard_information))
			else
				proceed_with_new_state (create {ES_TEST_WIZARD_ROUTINE_WINDOW}.make_window (development_window, wizard_information))
			end
		end

	clean_screen
			-- <Precursor>
		do
			Precursor
			if class_tree /= Void then
				class_tree.recycle
			end
		end

	cancel
			-- <Precursor>
		do
			Precursor
			class_tree.recycle
		end

feature {NONE} -- Constants

	default_class_name: STRING = "NEW_TEST_CLASS"

feature {NONE} -- Internationalization

	t_title: STRING = "New test class"
	t_subtitle: STRING = "Define properties of new test class"

	l_class_name: STRING = "Class name: "
	l_class_name_prefix: STRING = "Prefix for new class names"
	l_select_cluster: STRING = "Select cluster:"

	tt_new_cluster: STRING = "Create new cluster"

	b_setup_routine: STRING = "Redefine `$1'"
	b_tear_down_routine: STRING = "Redefine `$1'"
	b_system_level_test: STRING = "System level test"

	e_project_not_available: STRING = "Project is currently not available"
	e_file_exists: STRING = "Class file $1 already exists"
	e_directory_not_writable: STRING = "Directory $1 is not writable"
	e_directory_non_existent: STRING = "Directory $1 does not exists"

invariant
	cluster_valid_implies_attached: is_cluster_valid implies (wizard_information.cluster_cache /= Void and
		wizard_information.path_cache /= Void)
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
