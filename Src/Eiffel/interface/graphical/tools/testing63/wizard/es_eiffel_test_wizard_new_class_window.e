indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_NEW_CLASS_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_NEW_CLASS_WINDOW

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			wizard_information,
			clean_screen,
			cancel
		end

	ES_EIFFEL_TEST_WIZARD_WINDOW
		redefine
			wizard_information,
			clean_screen,
			cancel
		end

create
	make_window

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
		do
			l_parent := initialize_container (choice_box)

			build_class_name (l_parent)
			create l_sep
			l_parent.extend (l_sep)
			l_parent.disable_item_expand (l_sep)

			build_class_tree (l_parent)

			if wizard_information.is_new_manual_test_class then
				create l_sep
				l_parent.extend (l_sep)
				l_parent.disable_item_expand (l_sep)
				build_checkboxes (l_parent)
			end

			on_after_initialize
		end

	build_class_name (a_parent: EV_BOX) is
			-- Initialize `class_name'.
		local
			l_label: EV_LABEL
			l_hb: EV_HORIZONTAL_BOX
			l_text_field: EV_TEXT_FIELD
		do
			create l_hb
			create l_label.make_with_text (local_formatter.translation (l_class_name))
			l_hb.extend (l_label)
			l_hb.disable_item_expand (l_label)

			create l_text_field
			create class_name.make (l_text_field, agent on_validate_class_name)
			class_name.valid_state_changed_event.subscribe (agent on_valid_state_changed)
			l_hb.extend (class_name)

			a_parent.extend (l_hb)
			a_parent.disable_item_expand (l_hb)
		end

	build_class_tree (a_parent: EV_BOX) is
			-- Initialize `class_tree'
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_button: SD_TOOL_BAR_BUTTON
			l_tb: SD_TOOL_BAR
			l_layouts: EV_LAYOUT_CONSTANTS
			l_label: EV_LABEL
			l_cmd: EB_NEW_CLUSTER_COMMAND
		do
			create l_hbox
			create l_label.make_with_text (local_formatter.translation (l_select_cluster))
			l_label.align_text_left
			l_hbox.extend (l_label)

			create l_tb.make
			create l_button.make
			l_button.set_pixmap (pixmaps.icon_pixmaps.new_cluster_icon)
			create l_cmd.make (development_window, True)
			l_button.select_actions.extend (agent l_cmd.execute)
			l_button.set_tooltip (local_formatter.translation (tt_new_cluster))
			l_tb.extend (l_button)
			l_tb.compute_minimum_size
			l_hbox.extend (l_tb)
			l_hbox.disable_item_expand (l_tb)

			a_parent.extend (l_hbox)
			a_parent.disable_item_expand (l_hbox)

			create l_layouts
			create class_tree.make_with_options (development_window.menus.context_menu_factory, False, False)
			class_tree.select_actions.extend (agent on_select_tree_item)
			class_tree.set_minimum_width (l_layouts.dialog_unit_to_pixels(350))
			class_tree.set_minimum_height (l_layouts.dialog_unit_to_pixels(200))
			class_tree.refresh
			a_parent.extend (class_tree)
		end

	build_checkboxes (a_parent: EV_BOX)
			-- Initialize `setup_checkbox' and `trear_down_checkbox'.
		local
			l_vb: EV_VERTICAL_BOX
		do
			create l_vb

			create setup_checkbox
			setup_checkbox.set_text (local_formatter.formatted_translation (b_setup_routine, [{EIFFEL_TEST_CONSTANTS}.prepare_routine_name]))
			setup_checkbox.select_actions.extend (agent on_setup_change)
			l_vb.extend (setup_checkbox)
			l_vb.disable_item_expand (setup_checkbox)

			create tear_down_checkbox
			tear_down_checkbox.set_text (local_formatter.formatted_translation (b_tear_down_routine, [{EIFFEL_TEST_CONSTANTS}.clean_routine_name]))
			tear_down_checkbox.select_actions.extend (agent on_tear_down_change)
			l_vb.extend (tear_down_checkbox)
			l_vb.disable_item_expand (tear_down_checkbox)

			create system_level_test_checkbox
			system_level_test_checkbox.set_text (local_formatter.translation (b_system_level_test))
			system_level_test_checkbox.select_actions.extend (agent on_system_level_test_change)
			l_vb.extend (system_level_test_checkbox)
			l_vb.disable_item_expand (system_level_test_checkbox)

			a_parent.extend (l_vb)
			a_parent.disable_item_expand (l_vb)
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		do
			if {l_name: !STRING} wizard_information.new_class_name_cache then
				if {l_name32: !STRING_32} l_name.to_string_32 then
					class_name.set_text (l_name32)
				end
			end
			class_name.validate

			if {l_cluster: !CONF_CLUSTER} wizard_information.cluster_cache then
				if {l_path: !STRING} wizard_information.path_cache then
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
	--			if wizard_information.is_system_level_test then
	--				system_level_test_checkbox.enable_select
	--			else
	--				system_level_test_checkbox.disable_select
	--			end
				system_level_test_checkbox.disable_sensitive
			end
			update_next_button_status
		end

feature {NONE} -- Access

	wizard_information: ES_EIFFEL_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

	class_name_validator: ES_CLASS_NAME_VALIDATOR
			-- Validator for `class_name'
		once
			create Result
		end

feature {NONE} -- Access: widgets

	class_name: ES_VALIDATION_TEXT_FIELD
			-- Text field for new test class name

	class_tree: ?ES_EIFFEL_TEST_WIZARD_CLASS_TREE
			-- Tree displaying clusters and existing test classes
			--
			-- Note: must be detachable for recycling

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
			Result := class_name.is_valid and then wizard_information.cluster_cache /= Void
		end

feature {NONE} -- Events

	on_validate_class_name (a_name: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32] is
			-- Called when `class_name' contents need to be validated
		local
			l_name: !STRING
		do
			l_name ?= a_name.to_string_8
			wizard_information.set_new_class_name (l_name)
			if test_suite.is_service_available and then test_suite.service.is_project_initialized then
				class_name_validator.validate_new_class_name (l_name, test_suite.service.eiffel_project)
				Result := [class_name_validator.is_valid, class_name_validator.last_error_message]
			else
				Result := [False, local_formatter.translation (e_project_not_available)]
			end
			update_next_button_status
		end

	on_select_tree_item
			-- Called when item in `class_tree' is selected.
		do
			if {l_item: ES_EIFFEL_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM} class_tree.selected_item then
				if {l_eb_cluster: EB_SORTED_CLUSTER} l_item.data then
					if {l_parent: !CONF_CLUSTER} l_eb_cluster.actual_cluster then
						wizard_information.cluster_cache := l_parent
						if {l_path: !STRING} l_item.path then
							wizard_information.path_cache := l_path
						else
							wizard_information.path_cache := ""
						end
					end
				end
			end
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

	proceed_with_current_info
			-- <Precursor>
		do
			if wizard_information.is_extracted_test_class then
				proceed_with_new_state (create {ES_EIFFEL_TEST_WIZARD_CALL_STACK_WINDOW}.make_window (development_window, wizard_information))
			else
				proceed_with_new_state (create {ES_EIFFEL_TEST_WIZARD_ROUTINE_WINDOW}.make_window (development_window, wizard_information))
			end
		end

	display_state_text
			-- <Precursor>
		do
			title.set_text (local_formatter.translation (t_title))
			subtitle.set_text (local_formatter.translation (t_subtitle))
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

	t_title: STRING = "New test class"
	t_subtitle: STRING = "Define properties of new test class"

	l_class_name: STRING = "Class name: "
	l_select_cluster: STRING = "Select parent cluster for new class"

	tt_new_cluster: STRING = "Create new cluster"

	b_setup_routine: STRING = "Redefine `$1' routine"
	b_tear_down_routine: STRING = "Redefine `$1' routine"
	b_system_level_test: STRING = "Create system level test class"

	e_project_not_available: STRING = "Project is currently not available"

end
