note
	description: "Property with several values to choose from."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CHOICE_PROPERTY [G -> detachable ANY]

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

	make_with_choices (a_name: like name; a_choices: like item_strings)
			-- Initialize with some choices.
		require
			a_choices_ok: a_choices /= Void and not a_choices.is_empty
		do
			item_strings := a_choices
			make (a_name)
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
			Result := (attached combo_grid as l_combo_grid and then l_combo_grid.has_focus) or
				(attached combo_popup as l_combo_popup and then l_combo_popup.has_focus)
		end

feature -- Access

	item_strings: LIST [attached like value]
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
			if not is_text_editing and then attached text_field as l_text_field then
				l_text_field.disable_edit
			end
		end

	switch
			-- Switch value.
		local
			l_done: BOOLEAN
			l_item: like value
		do
			if attached text_field as l_text_field then
				from
					item_strings.start
				until
					l_done or item_strings.after
				loop
					if
						attached convert_to_data (l_text_field.text) as l_converted_data and then
						l_converted_data ~ item_strings.item
					then
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
		end

	initialize_actions
			-- Setup the actions sequences when the item is shown.
		do
			Precursor
			if attached text_field as l_text_field and then not l_text_field.is_destroyed then
				l_text_field.disable_edit
				l_text_field.pointer_button_press_actions.extend (agent (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							switch
						end)
				l_text_field.key_press_actions.extend (agent on_text_field_key)
			end
		end

	show_ellipsis
			-- Called when ellipsis is pressed.
		require
			popup_window: popup_window /= Void
		local
			l_item: GENERIC_GRID_ITEM [G]
			l_frame: EV_FRAME
			l_combo_popup: like combo_popup
			l_combo_grid: like combo_grid
		do
			if attached popup_window as w then
				create l_combo_popup
				combo_popup := l_combo_popup
				l_combo_popup.set_position (w.x_position, w.y_position + w.height)
				l_combo_popup.set_width (w.width)

				create l_frame
				l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_out)

				create l_combo_grid
				combo_grid := l_combo_grid
				l_combo_grid.hide_header
				l_combo_grid.pointer_button_press_item_actions.extend (agent combo_click)
				l_combo_grid.key_press_actions.extend (agent on_combo_key)
				l_frame.extend (l_combo_grid)
				from
					item_strings.start
				until
					item_strings.after
				loop
					create l_item.make_with_text (to_displayed_value (item_strings.item))
					l_item.set_value (item_strings.item)
					l_combo_grid.set_item (1, item_strings.index, l_item)
					l_item.pointer_enter_actions.extend (agent combo_select (l_item))
					if l_item.text.is_equal (displayed_value) then
						l_item.enable_select
					end
					item_strings.forth
				end
				if item_strings.count < 10 then
					l_combo_popup.set_height ((item_strings.count) * (l_combo_grid.row_height) + 4)
				else
					l_combo_popup.set_height (10 * (l_combo_grid.row_height) + 4)
				end
				l_combo_grid.column (1).set_width (w.width.max (l_combo_grid.column (1).minimum_width))
				l_combo_grid.hide_horizontal_scroll_bar
				l_combo_grid.set_minimum_height (0)
				l_combo_grid.set_minimum_width (0)

				l_combo_popup.focus_out_actions.force (agent combo_focus_lost)
				l_combo_grid.focus_out_actions.force (agent combo_focus_lost)

				l_combo_popup.extend (l_frame)
				l_combo_popup.show_actions.extend (agent l_combo_grid.set_focus)
				l_combo_popup.show
			else
				check from_precondition: attached popup_window end
			end
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
			if attached combo_grid as l_combo_grid then
				l_combo_grid.remove_selection
				an_item.enable_select
			end
		end

	combo_click (x_pos, y_pos, a_button: INTEGER; an_item: EV_GRID_ITEM)
			-- Choose a different value.
		do
			if attached {GENERIC_GRID_ITEM [G]} an_item as l_item then
				if is_valid_value (l_item.value) then
					set_value (l_item.value)
				end
				update_text_on_deactivation
				if not is_destroyed and then is_parented then
					deactivate
				end
			end
		end

	on_combo_key (a_key: EV_KEY)
			-- A key was pressed in `combo_grid'.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter and attached combo_grid as l_combo_grid then
				if
					attached l_combo_grid.selected_items as l_combo_selected_items and then
					l_combo_selected_items.count = 1
				then
					if attached {GENERIC_GRID_ITEM [G]} l_combo_selected_items.first as l_item and then is_valid_value (l_item.value) then
						set_value (l_item.value)
					end
					if not is_destroyed and then is_parented then
						deactivate
					end
				end
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				if not is_destroyed and then is_parented then
					deactivate
				end
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

	combo_popup: detachable EV_POPUP_WINDOW
			-- Popup window for showing the combo list.

	combo_grid: detachable EV_GRID
			-- Grid that shows the available choices.

	destroy_combo_popup
			-- Destroy combo popup.
		do
			if attached combo_grid as l_combo_grid then
				l_combo_grid.focus_out_actions.wipe_out
				l_combo_grid.destroy
				combo_grid := Void
			end
			if attached combo_popup as l_combo_popup then
				l_combo_popup.focus_out_actions.wipe_out
				l_combo_popup.destroy
				combo_popup := Void
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
