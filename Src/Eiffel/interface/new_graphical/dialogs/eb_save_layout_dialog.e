indexing
	description: "Dialog to select docking layout names for saving.."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_LAYOUT_DIALOG

inherit
	EV_DIALOG

	EB_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method.
		do
			default_create
			set_title (interface_names.t_save_layout_as)
			create manager.make (a_dev_window)
			init_widgets
			init_layout_items
			key_press_actions.extend (agent on_key_press)
		end

	init_widgets is
			-- Initilalize widgets.
		local
			l_h_box: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
		do
			create vertical_box
			vertical_box.set_border_width (layout_constants.default_border_size)
			vertical_box.set_padding (Layout_constants.Default_padding_size)
			extend (vertical_box)

			create l_h_box
			vertical_box.extend (l_h_box)
			vertical_box.disable_item_expand (l_h_box)

			create label_for_name
			label_for_name.set_text (interface_names.l_save_layout_name)
			l_h_box.extend (label_for_name)
			l_h_box.disable_item_expand (label_for_name)

			create l_h_box
			l_h_box.set_padding (layout_constants.Default_padding_size)
			vertical_box.extend (l_h_box)
			vertical_box.disable_item_expand (l_h_box)

			create label_name
			label_name.set_text (interface_names.l_layout_name)
			l_h_box.extend (label_name)
			l_h_box.disable_item_expand (label_name)

			create text_for_name
			text_for_name.change_actions.extend (agent on_text_change)
			text_for_name.key_press_actions.extend (agent on_text_key_press)
			l_h_box.extend (text_for_name)

			create l_h_box
			vertical_box.extend (l_h_box)
			vertical_box.disable_item_expand (l_h_box)

			create label_for_existing_layouts
			label_for_existing_layouts.set_text (interface_names.l_existing_layout_names)
			l_h_box.extend (label_for_existing_layouts)
			l_h_box.disable_item_expand (label_for_existing_layouts)

			create list_for_existing_layouts
			list_for_existing_layouts.set_minimum_height (list_minimum_height)
			list_for_existing_layouts.select_actions.extend (agent on_list_select)
			list_for_existing_layouts.pointer_double_press_actions.force_extend (agent on_list_double_press)
			list_for_existing_layouts.key_press_actions.extend (agent on_list_key_press)
			vertical_box.extend (list_for_existing_layouts)

			create l_h_box
			l_h_box.set_padding (layout_constants.default_padding_size)
			vertical_box.extend (l_h_box)
			vertical_box.disable_item_expand (l_h_box)

			create l_cell
			l_h_box.extend (l_cell)

			create ok
			ok.set_text (interface_names.b_ok)
			ok.disable_sensitive
			layout_constants.set_default_size_for_button (ok)
			ok.select_actions.extend (agent on_ok)
			l_h_box.extend (ok)
			l_h_box.disable_item_expand (ok)

			create cancel
			cancel.set_text (interface_names.b_cancel)
			layout_constants.set_default_size_for_button (cancel)
			cancel.select_actions.extend (agent on_cancel)
			l_h_box.extend (cancel)
			l_h_box.disable_item_expand (cancel)

			show_actions.extend_kamikaze (agent text_for_name.set_focus)
		end

	init_layout_items is
			-- Initlialize layout list items.
		local
			l_item: EV_LIST_ITEM
			l_names:  DS_HASH_TABLE [TUPLE [FILE_NAME, BOOLEAN], STRING_GENERAL]
		do
			from
				l_names := manager.layouts
				l_names.start
			until
				l_names.after
			loop
				create l_item.make_with_text (l_names.key_for_iteration)
				list_for_existing_layouts.extend (l_item)
				l_names.forth
			end
		end

feature {NONE} -- Implementation functions

	on_key_press (a_key: EV_KEY) is
			-- Handle key press actions.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_escape then
				destroy
			else

			end
		end

	on_text_change is
			-- On `text_for_name' texts changed
		local
			l_list: EV_LIST_ITEM
			l_has: BOOLEAN
			l_lists: LINEAR [EV_LIST_ITEM]
		do
			if text_for_name.text /= Void and then not text_for_name.text.is_equal ("") then
				ok.enable_sensitive
				from
					l_lists := list_for_existing_layouts.linear_representation
					l_lists.start
				until
					l_lists.after or l_has
				loop
					l_list := l_lists.item
					if l_list.text.is_equal (text_for_name.text) then
						l_list.enable_select
						l_has := True
					end
					l_lists.forth
				end
				if not l_has then
					l_lists.do_all (agent (a_item: EV_LIST_ITEM)
						do
							a_item.disable_select
						end
						)
				end
			else
				ok.disable_sensitive
			end
		end

	on_cancel is
			-- On `cancel' button pressed.
		do
			destroy
		end

	on_ok is
			-- On `ok' button pressed.
		local
			l_str: STRING_GENERAL
			l_result: BOOLEAN
		do
			l_str := text_for_name.text
			if l_str /= Void and then not l_str.as_string_8.is_equal ("") then
				if manager.layouts.has (l_str) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt_with_cancel (interface_names.l_overwrite_layout (l_str), Current, agent on_overwirte_and_destory (l_str), Void, agent destroy)
				else
					l_result := manager.add_layout (l_str)
					if not l_result then
						show_last_error
					end
					destroy
				end
			end
		end

	on_overwirte_and_destory (a_name: STRING_GENERAL) is
			-- Handle overwrite and destory actions.
		local
			l_result: BOOLEAN
		do
			l_result := manager.add_layout (a_name)
			if not l_result then
				show_last_error
			end
			destroy
		end

	on_list_select is
			-- Handle list select actions.
		do
			text_for_name.set_text (list_for_existing_layouts.selected_item.text)
			text_for_name.set_caret_position (list_for_existing_layouts.selected_item.text.count + 1)
		end

	on_list_key_press (a_key: EV_KEY) is
			-- Hanlde list key press actions
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_enter then
				if list_for_existing_layouts.selected_item /= Void then
					on_ok
				end
			else

			end
		end

	on_list_double_press is
			--
		do
			if list_for_existing_layouts.selected_item /= Void then
				on_ok
			end
		end

	on_text_key_press (a_key: EV_KEY) is
			-- Handle key press actions.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_enter then
				if text_for_name.text /= Void and then not text_for_name.text.is_equal ("") then
					on_ok
				end
			else

			end
		end

	show_last_error is
			-- Show last exception error
		local
			l_information: ES_PROMPT_PROVIDER
			l_exception: EXCEPTION_MANAGER
			l_meaning: STRING_GENERAL
		do
			create l_exception
			l_meaning := l_exception.last_exception.meaning
			if l_meaning = Void then
				l_meaning := interface_names.l_unknown_error
			end
			create l_information
			l_information.show_error_prompt (interface_names.l_saving_docking_data_error (l_meaning), Current, void)
		end

feature {NONE} -- Implementation

	manager: EB_NAMED_LAYOUT_MANAGER
			-- Named layout manager.

	vertical_box: EV_VERTICAL_BOX
			-- Vertical box

	label_for_name: EV_LABEL
			-- Label for layout name.

	label_name: EV_LABEL
			-- Label beside `text_for_name'

	text_for_name: EV_TEXT_FIELD
			-- Text for name.

	label_for_existing_layouts: EV_LABEL
			-- Label for existing layouts.

	list_for_existing_layouts: EV_LIST
			-- List for existing layouts.

	ok, cancel: EV_BUTTON
			-- Ok, cancel buttons.

	list_minimum_height: INTEGER is 200;
			-- Minimum height for `list_for_existing_layouts'

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

end -- class EB_SAVE_LAYOUT_DIALOG
