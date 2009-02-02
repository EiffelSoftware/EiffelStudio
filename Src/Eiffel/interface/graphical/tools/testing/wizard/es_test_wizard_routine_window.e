note
	description: "Summary description for {ES_TEST_WIZARD_ROUTINE_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_ROUTINE_WINDOW

inherit
	ES_TEST_WIZARD_FINAL_WINDOW
		redefine
			update_state_information,
			conf,
			has_valid_conf
		end

	SHARED_ERROR_HANDLER
		export
			{NONE}
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make_window

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_vbox: EV_VERTICAL_BOX
		do
			first_window.set_final_state (locale_formatter.translation (b_create))

			l_parent := initialize_container (choice_box)

			build_test_name (l_parent)
			create l_sep
			l_parent.extend (l_sep)
			l_parent.disable_item_expand (l_sep)

			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			build_tag_list (l_vbox)
			build_tag_fields (l_vbox)

			l_parent.extend (l_vbox)
			l_parent.disable_item_expand (l_vbox)

			on_after_initialize
		end

	build_test_name (a_parent: EV_BOX)
			-- Initialize `class_name'.
		local
			l_label: EV_LABEL
			l_hb: EV_HORIZONTAL_BOX
			l_text_field: EV_TEXT_FIELD
		do
			create l_hb
			create l_label.make_with_text (locale_formatter.translation (l_test_name))
			l_hb.extend (l_label)
			l_hb.disable_item_expand (l_label)

			create l_text_field
			create test_name.make (l_text_field, agent on_validate_test_name)
			test_name.valid_state_changed_actions.extend (agent on_valid_state_changed)
			l_hb.extend (test_name)

			a_parent.extend (l_hb)
			a_parent.disable_item_expand (l_hb)
		end

	build_tag_list (a_parent: EV_BOX)
			-- Initialize `tag_field'.
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
			l_link_label: EVS_LINK_LABEL
		do
			create l_hbox
			create l_label.make_with_text (locale_formatter.translation (l_tag_list))
			l_label.align_text_left
			l_hbox.extend (l_label)
			create l_link_label.make_with_text (locale_formatter.translation (l_tag_help))
			l_link_label.align_text_right
			l_hbox.extend (l_link_label)

			a_parent.extend (l_hbox)
			a_parent.disable_item_expand (l_hbox)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create tag_list
			tag_list.enable_multiple_selection
			tag_list.select_actions.extend (
				agent
					do
						if not remove_button.is_sensitive then
							remove_button.enable_sensitive
						end
					end)
			tag_list.deselect_actions.extend (
				agent
					do
						if tag_list.selected_items.is_empty and remove_button.is_sensitive then
							remove_button.disable_sensitive
						end
					end)
			tag_list.key_press_actions.extend (
				agent (a_key: EV_KEY)
					do
						if a_key.code = {EV_KEY_CONSTANTS}.key_delete then
							on_remove_tag
						end
					end)
			l_hbox.extend (tag_list)

			create l_vbox
			create remove_button
			remove_button.set_text (locale_formatter.translation (l_remove))
			remove_button.select_actions.extend (agent on_remove_tag)
			l_vbox.extend (remove_button)
			l_vbox.disable_item_expand (remove_button)
			l_vbox.extend (create {EV_CELL})

			l_hbox.extend (l_vbox)
			l_hbox.disable_item_expand (l_vbox)

			a_parent.extend (l_hbox)
		end

	build_tag_fields (a_parent: EV_BOX)
			-- Initialize widgets for adding tags.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_text_field: EV_TEXT_FIELD
			l_item: EV_LIST_ITEM
		do
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_text_field
			create add_button
			l_text_field.focus_in_actions.extend (
				agent
					do
						first_window.set_default_push_button (add_button)
					end)
			l_text_field.focus_out_actions.extend (
				agent
					do
						first_window.reset_default_push_button
					end)
			create tag_field.make (l_text_field, agent on_validate_tag_field)
			l_hbox.extend (tag_field)

			add_button.set_text (locale_formatter.translation (l_add))
			add_button.select_actions.extend (agent on_add_tag)
			l_hbox.extend (add_button)
			l_hbox.disable_item_expand (add_button)

			a_parent.extend (l_hbox)
			a_parent.disable_item_expand (l_hbox)

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create template_list
			create add_template_button
			template_list.focus_in_actions.extend (
				agent
					do
						first_window.set_default_push_button (add_template_button)
					end)
			template_list.focus_out_actions.extend (
				agent
					do
						first_window.reset_default_push_button
					end)
			create l_item
			l_item.set_text (locale_formatter.translation ("Add class/feature under test tag"))
			l_item.set_data (agent on_add_cover_tag)
			template_list.extend (l_item)

			create l_item
			l_item.set_text (locale_formatter.translation ("Add isolated execution tag"))
			l_item.set_data (
				agent
					do
						conf.tags_cache.force ("execution/isolate")
						update_tag_list
					end)
			template_list.extend (l_item)
			l_hbox.extend (template_list)

			add_template_button.set_text (locale_formatter.translation (l_add))
			add_template_button.select_actions.extend (
				agent
					local
						l_sitem: EV_LIST_ITEM
					do
						l_sitem := template_list.selected_item
						if l_sitem /= Void and then {l_proc: PROCEDURE [ANY, TUPLE]} l_sitem.data then
							l_proc.call (Void)
						end
					end)
			l_hbox.extend (add_template_button)
			l_hbox.disable_item_expand (add_template_button)

			a_parent.extend (l_hbox)
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_name: ?STRING
			l_name_32: STRING_32
		do
			l_name := conf.name_cache
			if l_name /= Void and then not l_name.is_empty then
				l_name_32 := l_name.to_string_32
			else
				l_name_32 := default_routine_name.to_string_32
			end
			check l_name_32 /= Void end
			test_name.set_text (l_name_32)
			test_name.validate
			test_name.widget.set_focus

			update_tag_list
			update_next_button_status
		end

feature {NONE} -- Access

	conf: TEST_MANUAL_CREATOR_CONF
			-- <Precursor>
		do
			Result := wizard_information.manual_conf
		end

	factory_type: !TYPE [TEST_CREATOR_I]
			-- <Precursor>
		do
			Result := manual_factory_type
		end

	feature_name_validator: ES_FEATURE_NAME_VALIDATOR
			-- Validator for `test_name'
		once
			create Result
		end

feature {NONE} -- Access: widgets

	test_name: ES_VALIDATION_TEXT_FIELD
			-- Text field for new test class name

	tag_list: EV_LIST
			-- List containing current tags in `wizard_information'

	remove_button: EV_BUTTON
			-- Button for removing selected items in `tag_list'

	tag_field: ES_VALIDATION_TEXT_FIELD
			-- Text field containing additional tags for new test

	add_button: EV_BUTTON
			-- Button which add tag in `tag_field'

	template_list: EV_COMBO_BOX
			-- List containing tag templates.

	add_template_button: EV_BUTTON
			-- Button adding tag for selected item in `tamplate_list'

feature {NONE} -- Access: tag utilities

	tag_utilities: TAG_UTILITIES
			-- Tag utilities
		once
			create Result
		end

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := test_name.is_valid
		end

	has_valid_conf (a_wizard_info: like wizard_information): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_wizard_info) and a_wizard_info.is_manual_conf
		end

feature {NONE} -- Events

	on_validate_test_name (a_name: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32]
			-- Called when `class_name' content needs to be validated
		local
			l_valid: BOOLEAN
			l_msg: STRING_32
			l_name: STRING
		do
			l_name := a_name.to_string_8
			check l_name /= Void end
			if not conf.is_new_class and then {l_class: !CLASS_I} conf.test_class_cache then
				feature_name_validator.validate_new_feature_name (l_name, l_class)
			else
				feature_name_validator.validate_feature_name (l_name)
			end
			l_valid := feature_name_validator.is_valid
			l_msg := feature_name_validator.last_error_message
			if l_valid then
				if l_name.is_equal ({TEST_CONSTANTS}.prepare_routine_name) or l_name.is_equal ({TEST_CONSTANTS}.clean_routine_name) then
					l_valid := False
					l_msg := locale_formatter.formatted_translation (e_bad_test_name, [a_name])
				end
			end
			Result := [l_valid, l_msg]
		end

	on_validate_tag_field (a_tag_32: !STRING_32): !TUPLE [BOOLEAN, ?STRING_32]
			-- Called when `tag_field' content needs to be validated
		local
			l_error: ?STRING_32
			l_enable, l_valid: BOOLEAN
			l_tag: STRING
		do
			l_tag := a_tag_32.to_string_8
			check l_tag /= Void end
			if l_tag.is_empty then
				l_valid := True
			elseif tag_utilities.is_valid_tag (l_tag) then
				l_valid := True
				l_enable := True
			else
				l_error := locale_formatter.formatted_translation (e_invalid_tag,
					[l_tag, example_tag, tag_utilities.valid_token_chars])
			end
			if l_enable then
				if not add_button.is_sensitive then
					add_button.enable_sensitive
				end
			else
				if add_button.is_sensitive then
					add_button.disable_sensitive
				end
			end
			Result := [l_valid, l_error]
		end

	on_add_tag
			-- Add content of `tag_field' to tags in `wizard_information' and reset widgets.
		local
			l_tag: STRING
		do
			l_tag := tag_field.text.to_string_8
			check l_tag /= Void end
			if not l_tag.is_empty and tag_utilities.is_valid_tag (l_tag) then
				conf.tags_cache.force (l_tag)
				update_tag_list
				tag_field.set_text (create {STRING_32}.make_empty)
			end
		end

	on_remove_tag
			-- Remove selected tags in `tag_list'.
		local
			l_removed: BOOLEAN
			i, l_pos, l_count: INTEGER
			l_item: EV_LIST_ITEM
			l_tag: STRING
		do
			from
				i := 1
				l_count := tag_list.count
			until
				i > l_count
			loop
				l_item := tag_list.i_th (i)
				if l_item.is_selected then
					l_tag := l_item.text.to_string_8
					check l_tag /= Void end
					conf.tags_cache.remove (l_tag)
					if not l_removed then
						l_removed := True
						l_pos := i
					end
				end
				i := i + 1
			end
			if l_removed then
				update_tag_list
				if not tag_list.is_empty then
					tag_list.i_th (l_pos.min (tag_list.count)).enable_select
				end
			end
		end

	on_add_cover_tag
			-- Add covers tag to `wizard_information'.
		local
			l_dialog: ES_TEST_WIZARD_FEATURE_DIALOG
			l_class: ?CLASS_I
			l_feature: ?E_FEATURE
			l_tag: STRING
		do
			create l_dialog.make_with_window (development_window)
			l_dialog.show (development_window.window)
			if l_dialog.dialog_result = {ES_DIALOG_BUTTONS}.ok_button then
				l_class := l_dialog.selected_class
				if l_class /= Void then
					create l_tag.make (40)
					l_tag.append ("covers/{")
					l_tag.append (l_class.name)
					l_tag.append ("}")
					l_feature := l_dialog.selected_feature
					if l_feature /= Void then
						l_tag.append_character ('.')
						if l_feature.is_prefix then
							l_tag.append ("prefix_")
							l_tag.append (l_feature.prefix_symbol)
						elseif l_feature.is_infix then
							l_tag.append ("infix_")
							l_tag.append (l_feature.infix_symbol)
						else
							l_tag.append (l_feature.name)
						end
					end
					conf.tags_cache.force (l_tag)
					update_tag_list
				end
			end
			l_dialog.recycle
		end

feature {NONE} -- Basic operations

	update_state_information
			-- <Precursor>
		do
			conf.name_cache := test_name.text.to_string_8
		end

feature {NONE} -- Implementation

	sorter: DS_QUICK_SORTER [STRING]
			-- Tag sorter
		once
			create Result.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make)
		ensure
			result_attached: Result /= Void
		end

	update_tag_list
			-- Update `tag_list' according to `wizard_information'.
		local
			l_item: EV_LIST_ITEM
			l_tag: STRING
			l_tags: DS_ARRAYED_LIST [STRING]
		do
			tag_list.wipe_out
			create l_tags.make_from_linear (conf.tags_cache)
			l_tags.sort (sorter)
			from
				l_tags.start
			until
				l_tags.after
			loop
				l_tag := l_tags.item_for_iteration
				create l_item.make_with_text (l_tag)
				tag_list.extend (l_item)
				l_tags.forth
			end
		end

feature {NONE} -- Constants

	default_routine_name: STRING = "new_test_routine"
	example_tag: STRING = "token1/token2/token3/..."

feature {NONE} -- Internationalization

	t_title: STRING = "Test routine"
	t_subtitle: STRING = "Define properties of new test routine"

	b_create: STRING = "Create"

	l_test_name: STRING = "Test name: "
	l_tag_list: STRING = "Tags for new tests"
	l_tag_help: STRING = "What are tags?"
	l_remove: STRING = "Remove"
	l_add: STRING = "Add"

	e_bad_test_name: STRING = "$1 can not be used as a new test routine name since it already exists in one of the ancestor classes."
	e_invalid_tag: STRING = "[
			$1 is not a valid tag
			
			Tag must have the form
			
				$2
				
			where tokens contain letters, numbers or any of $3
		]"

;note
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
