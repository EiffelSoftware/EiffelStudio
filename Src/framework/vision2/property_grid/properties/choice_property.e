note
	description: "Property with several values to choose from."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CHOICE_PROPERTY [G]

inherit
	ELLIPSIS_PROPERTY [G]
		redefine
			ellipsis,
			initialize,
			initialize_actions,
			deactivate,
			has_focus,
			activate_action
		end

feature {NONE} -- Initialization

	make_with_choices (a_name: like name; a_choices: ARRAYED_LIST [G])
			-- Initialize with some choices.
		require
			a_choices_ok: a_choices /= Void and not a_choices.is_empty
		do
			make (a_name)
			item_strings := a_choices
		ensure
			item_strings_set: item_strings = a_choices
		end

	initialize
			-- Initialize.
		do
			Precursor

			ellipsis_actions.extend (agent show_ellipsis)
		end

feature -- Status

	has_focus: BOOLEAN
			-- Does this property have the focus?
		do
			Result := Precursor {ELLIPSIS_PROPERTY} or has_combo_focus
		end

	has_combo_focus: BOOLEAN
			-- Does the combo popup have the focus?
		do
			Result := (combo_grid /= Void and then combo_grid.has_focus) or (combo_popup /= Void and then combo_popup.has_focus)
		end

feature -- Access

	item_strings: LIST [like value]
			-- Possible choices.

feature {NONE} -- Agents

	activate_action (a_popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		local
			l_te: BOOLEAN
		do
				-- we don't want the ellipsis action to be called, because we want to be able to switch the value even if we don't allow text editing
			l_te := is_text_editing
			is_text_editing := True
			Precursor {ELLIPSIS_PROPERTY}(a_popup_window)
			is_text_editing := l_te
			if not is_text_editing then
				text_field.disable_edit
			end
		end

	switch
			-- Switch value.
		local
			l_done: BOOLEAN
			l_item: like value
			l_converted_data: like value
		do
			from
				item_strings.start
			until
				l_done or item_strings.after
			loop
				l_converted_data := convert_to_data (text_field.text)
				if l_converted_data /= Void and then l_converted_data.is_equal (item_strings.item) then
					if item_strings.islast then
						l_item := item_strings.first
					else
						item_strings.forth
						l_item := item_strings.item
					end
					if is_valid_value (l_item) then
						set_value (l_item)
					end
					l_done := True
				end
				item_strings.forth
			end
		end

	initialize_actions
			-- Setup the actions sequences when the item is shown.
		do
			Precursor
			text_field.disable_edit
			text_field.pointer_button_press_actions.force_extend (agent switch)
			text_field.key_press_actions.extend (agent on_text_field_key)
		end

	show_ellipsis
			-- Called when ellipsis is pressed.
		require
			popup_window: popup_window /= Void
		local
			l_item: GENERIC_GRID_ITEM [G]
			l_frame: EV_FRAME
		do
			create combo_popup
			combo_popup.set_position (popup_window.x_position, popup_window.y_position + popup_window.height)
			combo_popup.set_width (popup_window.width)

			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_out)

			create combo_grid
			combo_grid.hide_header
			combo_grid.pointer_button_press_item_actions.extend (agent combo_click)
			combo_grid.key_press_actions.extend (agent on_combo_key)
			l_frame.extend (combo_grid)
			from
				item_strings.start
			until
				item_strings.after
			loop
				create l_item.make_with_text (to_displayed_value (item_strings.item))
				l_item.set_value (item_strings.item)
				combo_grid.set_item (1, item_strings.index, l_item)
				l_item.pointer_enter_actions.force_extend (agent combo_select (l_item))
				if l_item.text.is_equal (displayed_value) then
					l_item.enable_select
				end
				item_strings.forth
			end
			if item_strings.count < 10 then
				combo_popup.set_height ((item_strings.count) * (combo_grid.row_height) + 4)
				combo_grid.column (1).set_width (popup_window.width)
				combo_grid.hide_horizontal_scroll_bar
			else
				combo_popup.set_height (10 * (combo_grid.row_height) + 4)
				combo_grid.column (1).set_width (popup_window.width)
				combo_grid.hide_horizontal_scroll_bar
			end
			combo_grid.set_minimum_height (0)
			combo_grid.set_minimum_width (0)

			combo_popup.focus_out_actions.force (agent combo_focus_lost)
			combo_grid.focus_out_actions.force (agent combo_focus_lost)

			combo_popup.extend (l_frame)
			combo_popup.show
			combo_grid.set_focus
		end

	deactivate
			-- Called on deactivate.
		do
			Precursor {ELLIPSIS_PROPERTY}
			destroy_combo_popup
		end

	combo_focus_lost
			-- Called if focus of the combo popup is lost.
		do
			if not has_combo_focus then
				destroy_combo_popup
				focus_lost
			end
		end

	combo_select (an_item: EV_GRID_ITEM)
			-- Change the selected item in the combo.
		do
			if combo_grid /= Void then
				combo_grid.remove_selection
				an_item.enable_select
			end
		end

	combo_click (x_pos, y_pos, a_button: INTEGER; an_item: EV_GRID_ITEM)
			-- Choose a different value.
		local
			l_item: GENERIC_GRID_ITEM [G]
		do
			l_item ?= an_item
			if l_item /= Void then
				if is_valid_value (l_item.value) then
					set_value (l_item.value)
				end
				update_text_on_deactivation
				destroy_combo_popup
			end
		end

	on_combo_key (a_key: EV_KEY)
			-- A key was pressed in `combo_grid'.
		require
			a_key_not_void: a_key /= Void
		local
			l_item: GENERIC_GRID_ITEM [G]
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				if combo_grid.selected_items /= Void and then combo_grid.selected_items.count = 1 then
					l_item ?= combo_grid.selected_items.first
					if l_item /= Void and then is_valid_value (l_item.value) then
						set_value (l_item.value)
					end
					deactivate
				end
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				deactivate
			end
		end

	on_text_field_key (a_key: EV_KEY)
			-- A key was pressed in `text_field'.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter or a_key.code = {EV_KEY_CONSTANTS}.key_down then
				ellipsis_actions.call (Void)
			end
		end

feature {NONE} -- Implementation

	ellipsis: EV_PIXMAP
			-- Icon for combo box button.
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (9, 6)
			Result.draw_segment (1, 1, 7, 1)
			Result.draw_segment (2, 2, 6, 2)
			Result.draw_segment (3, 3, 5, 3)
			Result.draw_segment (4, 4, 4, 4)

			create l_mask.make_with_size (9, 6)
			l_mask.draw_segment (0, 0, 8, 0)
			l_mask.draw_segment (0, 1, 8, 1)
			l_mask.draw_segment (1, 2, 7, 2)
			l_mask.draw_segment (2, 3, 6, 3)
			l_mask.draw_segment (3, 4, 5, 4)
			l_mask.draw_segment (4, 5, 4, 5)

			Result.set_mask (l_mask)
		end

	combo_popup: EV_POPUP_WINDOW
			-- Popup window for showing the combo list.

	combo_grid: EV_GRID
			-- Grid that shows the available choices.

	destroy_combo_popup
			-- Destroy combo popup.
		do
			if combo_grid /= Void then
				combo_grid.focus_out_actions.wipe_out
				combo_grid.destroy
				combo_grid := Void
			end
			if combo_popup /= Void then
				combo_popup.focus_out_actions.wipe_out
				combo_popup.destroy
				combo_popup := Void
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
