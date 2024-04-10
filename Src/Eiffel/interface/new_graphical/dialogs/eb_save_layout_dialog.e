note
	description: "Dialog to select docking layout names for saving.."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_LAYOUT_DIALOG

inherit
	ES_DIALOG

	EB_CONSTANTS
		rename
			interface_names as interface_names_from_constants,
			interface_messages as interface_messages_from_constants
		undefine
			default_create,
			copy
		end

create
	make_with_window

feature {NONE} -- Initlization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			create manager.make (internal_development_window)
			init_widgets (a_container)
			init_layout_items
		end

	init_widgets (a_container: EV_VERTICAL_BOX)
			-- Initilalize widgets.
		require
			not_void: a_container /= Void
		local
			l_h_box: EV_HORIZONTAL_BOX
			l_tool_bar: SD_TOOL_BAR
			l_spacer: EV_CELL
		do
			a_container.set_border_width (layout_constants.default_border_size)
			a_container.set_padding (Layout_constants.Default_padding_size)

			create l_h_box
			a_container.extend (l_h_box)
			a_container.disable_item_expand (l_h_box)

			create label_for_name
			label_for_name.set_text (interface_names.l_save_layout_name)
			l_h_box.extend (label_for_name)
			l_h_box.disable_item_expand (label_for_name)

			create l_h_box
			l_h_box.set_padding (layout_constants.Default_padding_size)
			a_container.extend (l_h_box)
			a_container.disable_item_expand (l_h_box)

			create label_name
			label_name.set_text (interface_names.l_layout_name)
			l_h_box.extend (label_name)
			l_h_box.disable_item_expand (label_name)

			create text_for_name
			text_for_name.change_actions.extend (agent on_text_change)
			text_for_name.key_press_actions.extend (agent on_text_key_press)
			l_h_box.extend (text_for_name)

			create l_h_box
			a_container.extend (l_h_box)
			a_container.disable_item_expand (l_h_box)

			create label_for_existing_layouts
			label_for_existing_layouts.set_text (interface_names.l_existing_layout_names)
			l_h_box.extend (label_for_existing_layouts)
			l_h_box.disable_item_expand (label_for_existing_layouts)

			create l_spacer
			l_h_box.extend (l_spacer)

			create l_tool_bar.make
			create delete_button.make
			delete_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_delete_icon_buffer)
			delete_button.set_tooltip (interface_names.t_delete_selected_item)
			delete_button.select_actions.extend (agent on_delete_button_clicked)
			delete_button.disable_sensitive
			l_tool_bar.extend (delete_button)
			l_tool_bar.compute_minimum_size
			l_h_box.extend (l_tool_bar)
			l_h_box.disable_item_expand (l_tool_bar)

			create list_for_existing_layouts
			list_for_existing_layouts.set_minimum_height (list_minimum_height)
			list_for_existing_layouts.select_actions.extend (agent on_list_select)
			list_for_existing_layouts.pointer_double_press_actions.extend (agent on_list_double_press)
			list_for_existing_layouts.key_press_actions.extend (agent on_list_key_press)
			a_container.extend (list_for_existing_layouts)

			dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).disable_sensitive
			set_button_action_before_close ({ES_DIALOG_BUTTONS}.ok_button, agent on_ok)

			show_actions.extend_kamikaze (agent text_for_name.set_focus)
		end

	init_layout_items
			-- Initlialize layout list items.
		local
			l_item: EV_LIST_ITEM
			l_names:  like manager.layouts
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

	on_text_change
			-- On `text_for_name' texts changed
		local
			l_list: EV_LIST_ITEM
			l_has: BOOLEAN
			l_lists: LINEAR [EV_LIST_ITEM]
		do
			if text_for_name.text /= Void and then not text_for_name.text.is_equal ("") then
				dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).enable_sensitive
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
					if not l_lists.after then
						l_lists.forth
					end
				end
				if not l_has then
					l_lists.do_all (agent (a_item: EV_LIST_ITEM)
						do
							a_item.disable_select
						end
						)
					delete_button.disable_sensitive
				end
			else
				dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).disable_sensitive
			end
		end

	on_ok
			-- On `ok' button pressed.
		local
			l_str: STRING_GENERAL
		do
			l_str := text_for_name.text
			if l_str /= Void and then not l_str.is_empty then
				if manager.layouts.has (l_str) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (interface_names.l_overwrite_layout (l_str), dialog, agent on_overwrite_and_destroy (l_str), agent veto_close)
				else
					on_overwrite_and_destroy (l_str)
				end
			end
		end

	on_overwrite_and_destroy (a_name: STRING_GENERAL)
			-- Handle overwrite and destroy actions.
		local
			l_result: BOOLEAN
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		do
			l_result := manager.add_layout (a_name)
			if not l_result then
				show_last_error
			end

			create l_builder.make (development_window)
			l_builder.update_exist_layouts_menu
		end

	on_list_select
			-- Handle list select actions.
		do
			text_for_name.set_text (list_for_existing_layouts.selected_item.text)
			text_for_name.set_caret_position (list_for_existing_layouts.selected_item.text.count + 1)

			delete_button.enable_sensitive
		end

	on_list_key_press (a_key: EV_KEY)
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

	on_list_double_press (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
		do
			if list_for_existing_layouts.selected_item /= Void then
				on_ok
			end
		end

	on_text_key_press (a_key: EV_KEY)
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

	on_delete_button_clicked
			-- Delet current selected item in `list_for_existing_layouts'
		require
			list_not_void: list_for_existing_layouts /= Void
			selected: list_for_existing_layouts.selected_item /= Void
		local
			l_item: EV_LIST_ITEM
			l_success: BOOLEAN
			l_prompt: ES_SHARED_PROMPT_PROVIDER
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		do
			l_item := list_for_existing_layouts.selected_item
			l_success := manager.delete_layout (l_item.text)

			if l_success then
				list_for_existing_layouts.prune_all (l_item)
				delete_button.disable_sensitive

				create l_builder.make (development_window)
				l_builder.update_exist_layouts_menu
			else
				create l_prompt
				l_prompt.prompts.show_error_prompt (interface_names.l_cannot_delete_selected_item, void, void)
			end
		end

	show_last_error
			-- Show last exception error
		local
			l_information: ES_PROMPT_PROVIDER
			l_exception: EXCEPTION_MANAGER
			l_tag: detachable READABLE_STRING_GENERAL
		do
			create l_exception
			l_tag := l_exception.last_exception.tag
			if l_tag = Void then
				l_tag := interface_names.l_unknown_error
			end
			create l_information
			l_information.show_error_prompt (interface_names.l_saving_docking_data_error (l_tag), dialog, void)
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

	delete_button: SD_TOOL_BAR_BUTTON
			-- Delete layout button

	list_for_existing_layouts: EV_LIST
			-- List for existing layouts.

	list_minimum_height: INTEGER = 200;
			-- Minimum height for `list_for_existing_layouts'

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.t_save_layout_as
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.ok_button
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

end -- class EB_SAVE_LAYOUT_DIALOG
