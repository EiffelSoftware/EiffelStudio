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
			update_state_information,
			clean_screen,
			cancel
		end

	ES_TEST_WIZARD_WINDOW
		redefine
			wizard_information,
			update_state_information,
			clean_screen,
			cancel,
			has_valid_conf
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
			l_vbox: EV_VERTICAL_BOX
		do
			l_parent := initialize_container (choice_box)

			build_class_name (l_parent)
			create l_hsep
			l_parent.extend (l_hsep)
			l_parent.disable_item_expand (l_hsep)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			build_class_tree (l_hbox)

			create l_vbox
			build_checkboxes (l_vbox)
			l_vbox.extend (create {EV_CELL})


			if wizard_information.is_manual_conf then
				create l_vsep
				l_hbox.extend (l_vsep)
				l_hbox.disable_item_expand (l_vsep)
			else
				l_vbox.hide
			end
			l_hbox.extend (l_vbox)
			l_hbox.disable_item_expand (l_vbox)

			l_parent.extend (l_hbox)

			on_after_initialize
		end

	build_class_name (a_parent: EV_BOX)
			-- Initialize `class_name'.
		local
			l_label: EV_LABEL
			l_hb: EV_HORIZONTAL_BOX
			l_prefix: BOOLEAN
		do
			l_prefix := conf.is_multiple_new_classes

			create l_hb
			l_hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_label
			if l_prefix then
				l_label.set_text (locale_formatter.translation (l_class_name_prefix))
			else
				l_label.set_text (locale_formatter.translation (l_class_name))
			end
			l_hb.extend (l_label)
			l_hb.disable_item_expand (l_label)

			create class_name.make (create {EV_TEXT_FIELD}, agent validate_class_name)
			class_name.set_entry_formatter (agent {!STRING_32}.as_upper)
			class_name.valid_state_changed_actions.extend (agent on_valid_state_changed)
			class_name.set_entry_validation (
				agent (a_entry: !STRING_32): BOOLEAN
					do
						if a_entry.is_empty then
							Result := True
						else
							class_name_validator.validate_class_name (a_entry.to_string_8.as_attached)
							Result := class_name_validator.is_valid
						end
					end)
			l_hb.extend (class_name)

			if l_prefix then
				create l_label.make_with_text (multiple_class_suffix)
				l_hb.extend (l_label)
				l_hb.disable_item_expand (l_label)
			end

			a_parent.extend (l_hb)
			a_parent.disable_item_expand (l_hb)
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
			l_vb.extend (setup_checkbox)
			l_vb.disable_item_expand (setup_checkbox)

			create tear_down_checkbox
			tear_down_checkbox.set_text (locale_formatter.formatted_translation (b_tear_down_routine, [{TEST_CONSTANTS}.clean_routine_name]))
			l_vb.extend (tear_down_checkbox)
			l_vb.disable_item_expand (tear_down_checkbox)

			create system_level_test_checkbox
			system_level_test_checkbox.set_text (locale_formatter.translation (b_system_level_test))
			l_vb.extend (system_level_test_checkbox)
			l_vb.disable_item_expand (system_level_test_checkbox)

			a_parent.extend (l_vb)
			a_parent.disable_item_expand (l_vb)
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_name, l_path: ?STRING
			l_name_32: STRING_32
			l_cluster: ?CONF_CLUSTER
		do
			l_name := conf.new_class_name_cache
			if l_name /= Void and then not l_name.is_empty then
				l_name_32 := l_name.to_string_32
			else
				l_name_32 := default_class_name.as_string_32
			end
			check l_name_32 /= Void end
			class_name.set_text (l_name_32)
			class_name.widget.set_focus

			l_cluster := conf.cluster_cache
			if l_cluster /= Void then
				l_path := conf.path_cache
				if l_path /= Void then
					class_tree.show_subfolder (l_cluster, l_path)
				else
					class_tree.show_subfolder (l_cluster, "")
				end
			end

			if wizard_information.is_manual_conf then
				if manual_conf.has_prepare_cache then
					setup_checkbox.enable_select
				else
					setup_checkbox.disable_select
				end
				if manual_conf.has_clean_cache then
					tear_down_checkbox.enable_select
				else
					tear_down_checkbox.disable_select
				end
				if manual_conf.is_system_level_test then
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

	manual_conf: TEST_MANUAL_CREATOR_CONF
			-- Manual configuration
		require
			valid_conf: has_valid_conf (wizard_information)
			manual_conf: wizard_information.is_manual_conf
		do
			Result := wizard_information.manual_conf
		end

	class_name_validator: ES_CLASS_NAME_VALIDATOR
			-- Validator for `class_name'
		once
			create Result
		end

feature {NONE} -- Access: widgets

	class_name: ES_VALIDATING_WRAPPED_WIDGET
			-- Text field for new test class name

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

	class_name_example: EV_LABEL
			-- Label showing example class name for given prefix.

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := class_name.is_valid and is_cluster_valid
		end

	has_valid_conf (a_wizard_info: like wizard_information): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_wizard_info) and then a_wizard_info.current_conf.is_new_class
		end

	is_cluster_valid: BOOLEAN
			-- Is choosen cluster valid?

feature {NONE} -- Events

	validate_class_name (a_name: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32]
			-- Called when `class_name' contents need to be validated
		local
			l_name: STRING
			l_path: STRING
			l_error: ?STRING_32
			l_cluster: ?CONF_CLUSTER
		do
			l_name := a_name.to_string_8
			check l_name /= Void end
			class_name_validator.validate_class_name (l_name)
			if class_name_validator.is_valid then
				if test_suite.is_service_available and then test_suite.service.is_project_initialized then
					if not wizard_information.is_generator_conf then
						class_name_validator.validate_new_class_name (l_name, test_suite.service.eiffel_project)
						if not class_name_validator.is_valid then
							l_error := class_name_validator.last_error_message
						elseif is_cluster_valid then
							l_cluster := conf.cluster_cache
							check l_cluster /= Void end
							l_path := l_cluster.location.build_path (conf.path_cache, l_name.as_lower)
							l_path.append (".e")
							if (create {RAW_FILE}.make (l_path)).exists then
								l_error := locale_formatter.formatted_translation (e_file_exists, [l_path])
							end
						end
					end
				else
					l_error := locale_formatter.translation (e_project_not_available)
				end
			else
				l_error := class_name_validator.last_error_message
			end
			Result := [l_error = Void, l_error]
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
			l_parent: CONF_CLUSTER
			l_path: ?STRING
		do
			conf.cluster_cache := Void
			conf.path_cache := Void
			if {l_item: ES_TEST_WIZARD_CLASS_TREE_FOLDER_ITEM} class_tree.selected_item then
				if {l_eb_cluster: EB_SORTED_CLUSTER} l_item.data then
					if l_eb_cluster.actual_group /= Void and then l_eb_cluster.is_cluster then
						l_parent := l_eb_cluster.actual_cluster
						conf.cluster_cache := l_parent
						l_path := l_item.path
						if l_path /= Void then
							conf.path_cache := l_path
						else
							conf.path_cache := ""
						end
					end
				end
			end
			validate_cluster
			class_name.validate
			update_next_button_status
		end

feature {NONE} -- Basic operations

	validate_cluster
			-- Validate cluster information
		local
			l_error: ?STRING_32
			l_path: FILE_NAME
			l_directory: DIRECTORY
		do
			if conf.cluster_cache /= Void and conf.path_cache /= Void then
				is_cluster_valid := True
				create l_path.make_from_string (conf.cluster_cache.location.build_path (conf.path_cache, ""))
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
			if wizard_information.is_extractor_conf then
				proceed_with_new_state (create {ES_TEST_WIZARD_CALL_STACK_WINDOW}.make_window (development_window, wizard_information))
			elseif wizard_information.is_generator_conf then
				proceed_with_new_state (create {ES_TEST_WIZARD_AUTO_TEST_WINDOW}.make_window (development_window, wizard_information))
			else
				proceed_with_new_state (create {ES_TEST_WIZARD_ROUTINE_WINDOW}.make_window (development_window, wizard_information))
			end
		end

	update_state_information
			-- <Precursor>
		do
			conf.new_class_name_cache := class_name.text.to_string_8
			if wizard_information.is_manual_conf then
				manual_conf.has_prepare_cache := setup_checkbox.is_selected
				manual_conf.has_clean_cache := tear_down_checkbox.is_selected
				manual_conf.is_system_level_test_cache := system_level_test_checkbox.is_selected
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
	multiple_class_suffix: STRING = "_001"

feature {NONE} -- Internationalization

	t_title: STRING = "New test class"
	t_subtitle: STRING = "Define properties of new test class"

	l_class_name: STRING = "Class name: "
	l_class_name_prefix: STRING = "Class name prefix: "
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
	cluster_valid_implies_attached: is_cluster_valid implies (conf.cluster_cache /= Void and
		conf.path_cache /= Void)
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
