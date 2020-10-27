note
	description: "Summary description for {ES_TEST_GENERATION_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_TAGS_WIZARD_PAGE_PANEL

inherit
	ES_TEST_WIZARD_PAGE_PANEL

create
	make

feature {NONE} -- Initialization

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_frame: EV_FRAME
			l_vbox: EV_VERTICAL_BOX
		do
			create l_vbox
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create l_frame.make_with_text (locale_formatter.translation (title_text))
			extend_no_expand (a_widget, l_frame)
			l_frame.extend (l_vbox)

			build_tag_list_interface (l_vbox)
			build_tag_field_interface (l_vbox)
		end

	build_tag_list_interface (a_widget: EV_VERTICAL_BOX)
			-- Build widget for entering tags.
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create tag_list
			tag_list.set_minimum_height (dialog_unit_to_pixels (150))
			tag_list.enable_multiple_selection
			tag_list.select_actions.extend (agent on_selection_change)
			tag_list.deselect_actions.extend (agent on_selection_change)
			tag_list.key_press_actions.extend (
				agent (a_key: EV_KEY)
					do
						if a_key.code = {EV_KEY_CONSTANTS}.key_delete then
							on_remove_tags
						end
					end)
			l_hbox.extend (tag_list)

			create l_vbox
			create remove_button
			remove_button.set_text (locale_formatter.translation (remove_text))
			remove_button.select_actions.extend (agent on_remove_tags)
			l_vbox.extend (remove_button)
			l_vbox.disable_item_expand (remove_button)
			l_vbox.extend (create {EV_CELL})

			l_hbox.extend (l_vbox)
			l_hbox.disable_item_expand (l_vbox)

			a_widget.extend (l_hbox)
		end

	build_tag_field_interface (a_widget: EV_VERTICAL_BOX)
			-- Build interface for entering user defined tag
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_vbox: EV_VERTICAL_BOX
			l_text_field: EV_TEXT_FIELD
			l_button: EV_BUTTON
			l_link_label: EV_LINK_LABEL
			l_dialog: EV_DIALOG
		do

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_text_field
			create add_button

			l_dialog := composition.window.dialog
			l_button := l_dialog.default_push_button
			l_text_field.focus_in_actions.extend (agent l_dialog.set_default_push_button (add_button))
			l_text_field.focus_out_actions.extend (agent l_dialog.set_default_push_button (l_button))

			create tag_field.make (l_text_field, agent on_validate_tag_field)
			l_hbox.extend (tag_field)

			add_button.set_text (locale_formatter.translation (add_text))
			add_button.select_actions.extend (agent on_add_tag)
			l_hbox.extend (add_button)
			l_hbox.disable_item_expand (add_button)

			extend_no_expand (a_widget, l_hbox)

			create l_vbox

			create l_link_label.make_with_text (locale.translation (add_covers_text))
			l_link_label.set_tooltip (locale.translation (add_covers_tooltip))
			l_link_label.align_text_left
			l_link_label.select_actions.extend (agent on_add_cover_tag)
			l_vbox.extend (l_link_label)

			create l_link_label.make_with_text (locale.translation (add_serial_text))
			l_link_label.set_tooltip (locale.translation (add_serial_tooltip))
			l_link_label.align_text_left
			l_link_label.select_actions.extend (agent add_tag ("execution/isolated"))
			l_vbox.extend (l_link_label)

			create l_link_label.make_with_text (locale.translation (add_isolated_text))
			l_link_label.set_tooltip (locale.translation (add_isolated_tooltip))
			l_link_label.align_text_left
			l_link_label.select_actions.extend (agent add_tag ("execution/serial"))
			l_vbox.extend (l_link_label)

			extend_no_expand (a_widget, l_vbox)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_session: SESSION_I
			l_tag_list: LIST [STRING]
		do
			l_session := a_service.retrieve (True)
			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.tags,
					{TEST_SESSION_CONSTANTS}.tags_default) as l_tags
			then
				l_tag_list := l_tags.split (',')
				from
					l_tag_list.start
				until
					l_tag_list.after
				loop
					add_tag (l_tag_list.item_for_iteration.to_string_32)
					l_tag_list.forth
				end
			end
			tag_field.validate
			on_selection_change
		end

feature {NONE} -- Access

	tag_list: EV_LIST
			-- List containing current tags in `wizard_information'

	remove_button: EV_BUTTON
			-- Button for removing a tag from the list

	tag_field: ES_VALIDATING_WRAPPED_WIDGET
			-- Text field containing additional tags for new test

	add_button: EV_BUTTON
			-- Button which add tag in `tag_field'

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Events

	on_validate_tag_field (a_tag_32: STRING_32): TUPLE [BOOLEAN, detachable STRING_32]
			-- Called when `tag_field' content needs to be validated
		local
			l_error: detachable STRING_32
			l_enable, l_valid: BOOLEAN
			l_tag: STRING_32
		do
			l_tag := a_tag_32
			check l_tag /= Void end
			if l_tag.is_empty then
				l_valid := True
			elseif
				attached test_suite.service as l_test_suite and then
				l_test_suite.is_interface_usable and then
				l_test_suite.tag_tree.validator.is_valid_tag (l_tag)
			then
				l_valid := True
				l_enable := True
			else
				l_error := locale_formatter.formatted_translation (e_invalid_tag,
					[l_tag, example_tag, "_{}()[]:.-"])
			end
			adjust_sensitivity (add_button, l_enable)
			Result := [l_valid, l_error]
		end

	on_add_tag
			-- Add content of `tag_field' to tags in `wizard_information' and reset widgets.
		do
			perform_with_test_suite (agent (a_test_suite: TEST_SUITE_S)
				local
					l_tag: STRING_32
				do
					l_tag := tag_field.text
					if a_test_suite.tag_tree.validator.is_valid_tag (l_tag) then
						add_tag (l_tag)
						tag_field.set_text ("")
					end
				end)
		end

	on_add_cover_tag
			-- Add covers tag to `wizard_information'.
		local
			l_dialog: ES_TEST_WIZARD_FEATURE_DIALOG
			l_class: detachable CLASS_I
			l_feature: detachable E_FEATURE
			l_tag: STRING_32
		do
			create l_dialog.make_with_window (window_manager.last_focused_development_window)
			l_dialog.show (composition.window.dialog)
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
						l_tag.append (l_feature.name_32)
					end
					add_tag (l_tag)
				end
			end
			l_dialog.recycle
		end

	on_remove_tags
			-- Remove selected tags.
		local
			l_list: DYNAMIC_LIST [EV_LIST_ITEM]
		do
			l_list := tag_list.selected_items
			from
				l_list.start
			until
				l_list.after
			loop
				tag_list.prune (l_list.item_for_iteration)
				l_list.forth
			end
		end

	on_selection_change
			-- Called when selection of `type_list' changes.
		do
			adjust_sensitivity (remove_button, not tag_list.selected_items.is_empty)
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_tags: STRING
			l_session: SESSION_I
		do
			create l_tags.make (tag_list.count * 20)
			from
				tag_list.start
			until
				tag_list.after
			loop
				l_tags.append_string_general (tag_list.item_for_iteration.text)
				tag_list.forth
				if not tag_list.after then
					l_tags.append_character (',')
				end
			end
			l_session := a_service.retrieve (True)
			l_session.set_value (l_tags, {TEST_SESSION_CONSTANTS}.tags)
		end

feature {NONE} -- Basic operations

	add_tag (a_tag: STRING_32)
			-- Add `a_tag' to `tag_list' if not already added.
		local
			l_item: EV_LIST_ITEM
			l_comp: INTEGER
		do
			if not a_tag.is_empty then
				from
					tag_list.start
					l_comp := -1
				until
					l_comp >= 0
				loop
					if tag_list.after then
						l_comp := 1
					else
						l_comp := tag_list.item_for_iteration.text.as_lower.three_way_comparison (a_tag.as_lower)
						if l_comp = -1 then
							tag_list.forth
						end
					end
				end
				if l_comp = 1 then
					create l_item.make_with_text (a_tag)
					tag_list.put_left (l_item)
				end
			end
		end

feature {NONE} -- Constants

	example_tag: STRING = "token1/token2/token3/..."

feature {NONE} -- Internationalization

	title_text: STRING = "Tags used in new test"
	add_text: STRING = "Add"
	remove_text: STRING = "Remove"
	add_covers_text: STRING = "Add tag for covered class/feature"
	add_covers_tooltip: STRING = "Specify what class and feature are covered by the test."
	add_serial_text: STRING = "Add tag to run test serially"
	add_serial_tooltip: STRING = "For tests which make use of some resource which has to be accessed serially. %N%
								%It is possible to create subgroups by extending the tag with additional tokens (eg. execution/serial/db/customers)"
	add_isolated_text: STRING = "Add tag to run test in private evaluator"
	add_isolated_tooltip: STRING = "For tests which rely on once routines being accessed the first time or tests which might leave memory in a corrupted state."

	e_invalid_tag: STRING = "[
			$1 is not a valid tag

			Tag must have the form

				$2

			where tokens contain letters, numbers or any of $3
		]"

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
