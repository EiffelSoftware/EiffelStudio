indexing
	description: "[
						Second page of new unit test wizard

																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_TWO

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			make,
			wizard_information
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- <Precursor>
		do
			wizard_information := an_info
			first_window.disable_next_button
		ensure then
			set: wizard_information = an_info
		end

	update_ui_with_wizard_information
			-- Fill text entries if possible
			-- This is useful when end users navigating back and forth
		do
			if wizard_information.new_class_name /= Void then

				if {lt_string: STRING_32} wizard_information.test_case_name.as_string_32 then
					test_case_name.set_text (lt_string)
				end

				if {lt_string_2: STRING_32} wizard_information.new_class_name.as_string_32 then
					class_name.set_text (lt_string_2)
				end

				if wizard_information.class_under_test /= Void then
					class_under_test.set_text (wizard_information.class_under_test)
				end

				if wizard_information.is_run_after_each_selected then
					on_after_test_run.enable_select
				end
				if wizard_information.is_run_after_all_selected then
					on_after_all_test_runs.enable_select
				end
				if wizard_information.is_run_before_each_selected then
					on_before_test_run.enable_select
				end
				if wizard_information.is_run_before_all_selected then
					on_before_all_test_runs.enable_select
				end
			end
		end

feature {NONE} -- Implementation

	display_state_text
			-- <Precursor>
		do
			title.set_text (title_string)
			subtitle.set_text (message_string)
		end

	proceed_with_current_info
			-- <Precursor>
		do
			if not class_name.text.is_empty and not is_new_class_name_already_exists then
				proceed_with_new_state (create {ES_NEW_UNIT_TEST_WIZARD_THREE}.make (wizard_information))
			end
		end

	build
			-- <Precursor>
		local
			l_h_box: EV_HORIZONTAL_BOX
			l_v_box, l_v_box_2: EV_VERTICAL_BOX
			l_label: EV_LABEL
			l_top_container: EV_BOX
			l_button: EV_BUTTON
			l_tmp_text_filed: EV_TEXT_FIELD
		do
			l_top_container := wizard_information.helper.parent_parent_of (choice_box)

			-- We want the part at top is expanded when resizing
			l_top_container.extend (create {EV_CELL})

			-- Cluster
			create l_h_box

			create l_label.make_with_text (interface_names.l_test_case_name_colon)
			l_h_box.extend (l_label)
			l_h_box.disable_item_expand (l_label)

			create l_tmp_text_filed
			l_tmp_text_filed.change_actions.extend (agent on_test_case_name_change)
			create test_case_name.make (l_tmp_text_filed, agent on_valid_test_case_name)
			test_case_name.validate
			test_case_name.text_field.focus_in_actions.extend_kamikaze (agent do
																															is_test_case_name_focused := True
																														end)
			l_h_box.extend (test_case_name)
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			l_top_container.extend (l_h_box)
			l_top_container.disable_item_expand (l_h_box)

			-- Separator
			l_top_container.extend (create {EV_HORIZONTAL_SEPARATOR})

			-- Class name
			create l_h_box

			create l_label.make_with_text (interface_names.l_root_class_name)
			l_h_box.extend (l_label)
			l_h_box.disable_item_expand (l_label)

			create l_tmp_text_filed
			l_tmp_text_filed.change_actions.extend (agent on_class_name_change)
			create class_name.make (l_tmp_text_filed, agent on_valid_class_name)
			class_name.validate
			class_name.text_field.focus_in_actions.extend_kamikaze (agent do
																													is_class_name_focused := True
																												end)
			l_h_box.extend (class_name)
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			l_top_container.extend (l_h_box)
			l_top_container.disable_item_expand (l_h_box)

			-- Which events would you like to create?
			create l_v_box

			create l_h_box

			create l_label.make_with_text (interface_names.l_Which_actions_would_you_like_to_create)
			l_h_box.extend (l_label)
			l_h_box.disable_item_expand (l_label)

			l_h_box.extend (create {EV_CELL})

			l_v_box.extend (l_h_box)

			create l_h_box

			l_h_box.extend (create {EV_CELL})

			create l_v_box_2

			create on_before_all_test_runs
			on_before_all_test_runs.set_text (interface_names.l_run_before_all)
			on_before_all_test_runs.select_actions.extend (agent on_run_before_all_selected)
			l_v_box_2.extend (on_before_all_test_runs)

			create on_before_test_run
			on_before_test_run.set_text (interface_names.l_run_before_each)
			on_before_test_run.select_actions.extend (agent on_run_before_each_selected)
			l_v_box_2.extend (on_before_test_run)

			l_h_box.extend (l_v_box_2)

			create l_v_box_2

			create on_after_all_test_runs
			on_after_all_test_runs.set_text (interface_names.l_run_after_all)
			on_after_all_test_runs.select_actions.extend (agent on_run_after_all_selected)
			l_v_box_2.extend (on_after_all_test_runs)

			create on_after_test_run
			on_after_test_run.set_text (interface_names.l_run_after_each)
			on_after_test_run.select_actions.extend (agent on_run_after_each_selected)
			l_v_box_2.extend (on_after_test_run)

			l_h_box.extend (l_v_box_2)

			l_v_box.extend (l_h_box)

			l_top_container.extend (l_v_box)
			-- Separator

			l_top_container.extend (create {EV_HORIZONTAL_SEPARATOR})

			-- Class under test.
			create l_h_box
			l_h_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create l_label.make_with_text (interface_names.l_class_under_test)
			l_h_box.extend (l_label)
			l_h_box.disable_item_expand (l_label)

			create class_under_test
			class_under_test.change_actions.extend (agent on_class_under_test_changed)
			l_h_box.extend (class_under_test)

			create l_button.make_with_text (interface_names.b_browse)
			l_button.select_actions.extend (agent on_browse_for_class)
			l_h_box.extend (l_button)
			l_h_box.disable_item_expand (l_button)

			l_top_container.extend (l_h_box)
			l_top_container.disable_item_expand (l_h_box)

			-- We want the part below an entry is expanded when resizing
			l_top_container.extend (create {EV_CELL})

			update_ui_with_wizard_information
		end

	update_next_button_sensitivity (a_force_disable: BOOLEAN) is
			-- Update next button sensitivity base on current wizard information
		local
			l_enable_next: BOOLEAN
		do
			l_enable_next :=  wizard_information.is_valid_without_cluster
			if l_enable_next and not a_force_disable then
				first_window.enable_next_button
			else
				first_window.disable_next_button
			end
		end

feature {NONE}	-- Agents

	on_browse_for_class
			-- Browse for class which will be tested.
		local
			l_all_classes: EB_CHOOSE_CLASS_DIALOG
			l_result: STRING
		do
			create l_all_classes.make
			l_all_classes.show_on_active_window

			if l_all_classes.selected then
				l_result := l_all_classes.class_name
			end
			if l_result /= Void then
				class_under_test.set_text (l_result)
				wizard_information.set_class_under_test (l_result)
			end
		end

	on_class_under_test_changed
			-- Handler for `class_under_test'.change_actions.
		local
			l_color: EV_STOCK_COLORS
			l_text: STRING_32
			l_utext: STRING_32
			l_old_position: INTEGER
		do
			l_text := class_under_test.text
			l_utext := l_text.as_upper
			if not l_utext.is_equal (l_text) then
				l_old_position := class_under_test.caret_position
				class_under_test.set_text (l_utext)
				class_under_test.set_caret_position (l_old_position)
			else
				create l_color
				if is_class_under_test_name_valid or class_under_test.text.is_empty then
					class_under_test.set_foreground_color (l_color.default_foreground_color)
					if not l_text.is_empty then
						wizard_information.set_class_under_test (l_text.as_string_8)
						update_next_button_sensitivity (False)
					end
				else
					class_under_test.set_foreground_color (l_color.red)
					update_next_button_sensitivity (True)
				end
			end
		end

	on_valid_test_case_name (a_string: !STRING_32): !TUPLE [BOOLEAN, STRING_32] is
			-- Valid test case name `a_string'
		local
			l_valid: BOOLEAN
		do
			if is_test_case_name_focused then
				l_valid := 	not a_string.is_empty and then
					 		(create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_string) -- We use class name rule to check test case name
				 if {l_result: TUPLE [BOOLEAN, STRING_32]} [l_valid, Void] then
				 	Result := l_result
				 end
			else
				Result := [True, Void]
			end
		end

	on_test_case_name_change
			-- Handler for `test_case_name'.change_actions.
		local
			l_valid: BOOLEAN
		do
			l_valid := test_case_name.is_valid and then not test_case_name.text.is_empty
			if not l_valid then
				update_next_button_sensitivity (True)
			else
				wizard_information.set_test_case_name (test_case_name.text)

				update_next_button_sensitivity (False)
			end
		end

	on_valid_class_name (a_string: !STRING_32): !TUPLE [BOOLEAN, STRING_32] is
			-- Valid class name `a_string'
		local
			l_valid: BOOLEAN
		do
			if is_class_name_focused then
				l_valid := 	not a_string.is_empty and then
							not is_new_class_name_already_exists and then
				  			(create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_string)
				 if {l_result: TUPLE [BOOLEAN, STRING_32]} [l_valid, Void] then
				 	Result := l_result
				 end
			else
				Result := [True, Void]
			end
		end

	on_class_name_change
			-- Handler for `class_name'.change_actions.
		do

			if not class_name.is_valid or else class_name.text.is_empty then
				update_next_button_sensitivity (True)
			else
				wizard_information.set_new_class_name (class_name.text)
				update_next_button_sensitivity (False)
			end

		end

	on_run_before_all_selected is
			-- Handle select actions of `on_before_all_test_runs'
		do
			wizard_information.set_run_before_all_selected (on_before_all_test_runs.is_selected)
		end

	on_run_after_all_selected is
			-- Handle select actions of `on_after_all_test_runs'
		do
			wizard_information.set_run_after_all_selected (on_after_all_test_runs.is_selected)
		end

	on_run_before_each_selected is
			-- Handle select actions of `on_before_test_run'
		do
			wizard_information.set_run_before_each_selected (on_before_test_run.is_selected)
		end

	on_run_after_each_selected is
			-- Handle select actions of `on_after_test_run'
		do
			wizard_information.set_run_after_each_selected (on_after_test_run.is_selected)
		end

feature {NONE} -- UI widgets

	test_case_name: ES_VALIDATION_TEXT_FIELD
			-- Text field for test case name

	class_name: ES_VALIDATION_TEXT_FIELD
			-- Text field for class name

	on_before_all_test_runs: EV_CHECK_BUTTON
			-- Check button for `on_before_all_test_runs'

	on_after_all_test_runs: EV_CHECK_BUTTON
			-- Check button for `on_after_all_test_runs'

	on_before_test_run: EV_CHECK_BUTTON
			-- Check button for `on_before_test_run'

	on_after_test_run: EV_CHECK_BUTTON
			-- Check button for `on_after_test_run'

	class_under_test: EV_TEXT_FIELD
			-- Text field for class under test.

feature {NONE} -- Query

	is_class_under_test_name_valid: BOOLEAN
			-- If `class_under_test' name valid?
		local
			l_class_name: STRING
		do
			-- Valid class name
			l_class_name := class_under_test.text

			if not l_class_name.is_empty then
				Result := is_class_name_eixsts (l_class_name)
			end
		end

	is_new_class_name_already_exists: BOOLEAN
			-- If `class_name' name already exists?
		local
			l_class_name: STRING
		do
			l_class_name := class_name.text
			if not l_class_name.is_empty then
				Result := is_class_name_eixsts (l_class_name)
			end
		end

	is_class_name_eixsts (a_class_name: STRING): BOOLEAN
			-- If `a_class_name' valid?
		require
			not_void: a_class_name /= Void
		local
			l_list: LIST [CLASS_I]
		do
			if not a_class_name.is_empty then
				l_list := universe.classes_with_name (a_class_name.as_upper)
				Result := l_list.count > 0
			end
		end

	title_string: STRING_GENERAL is
			-- Title string
		do
			Result := interface_names.t_new_unit_test_case
		end

	message_string: STRING_GENERAL is
			-- Message string
		do
			Result := interface_names.t_Enter_name_of_the_unit_test
		end

	is_test_case_name_focused: BOOLEAN
			-- If `test_case_name' has been focused

	is_class_name_focused: BOOLEAN
			-- If `class_name' has been focused
			
	wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION;
			-- <Precursor>

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
