note
	description: "Checkable grid item can be activated and changed by space key."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_GRID_CHECKABLE_LABEL_ITEM

create
	make

feature {NONE} -- Init

	make
			-- Init
		do
			create item
			item.activate_actions.extend (agent activate_action)
			item.deactivate_actions.extend (agent deactivate)
		end

feature -- Access

	checked_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_GRID_CHECKABLE_LABEL_ITEM]]
			-- Actions called when checkbox value changed.
		do
			Result := item.checked_changed_actions
		end

	grid_item: EV_GRID_ITEM
			-- The grid item
		do
			Result := item
		end

feature {NONE} -- Access

	check_button: detachable EV_CHECK_BUTTON
			-- Check button to be activated.

	item: EV_GRID_CHECKABLE_LABEL_ITEM
			-- The item to be wrapped.

feature -- Element change

	set_check_button_key_press_action (a_action: like check_button_key_press_action)
			-- Set `check_button_key_press_action' with `a_action'
		do
			check_button_key_press_action := a_action
		ensure
			check_button_key_press_action_set: check_button_key_press_action = a_action
		end

	set_is_checked (b: BOOLEAN)
			-- Set checkbox status
		do
			item.set_is_checked (b)
		end

	enable_sensitive
			-- Make object sensitive to user input
		do
			item.enable_sensitive
		end

	disable_sensitive
			-- Make object non-sensitive to user input
		do
			item.disable_sensitive
		end

feature -- Action

	deactivate
			-- Cleanup from previous call to activate.
		do
			if attached check_button as l_check_button then
				l_check_button.focus_out_actions.wipe_out
				if not user_cancelled_activation then
					if attached check_button as l_cb then
						if item.is_checked /= l_cb.is_selected then
							item.set_is_checked (l_cb.is_selected)
						end
					end
				end
			end
			if attached check_button as l_check_button then
				l_check_button.destroy
				check_button := Void
			end
		end

feature {NONE} -- Implementation

	check_button_key_press_action: PROCEDURE [ANY, TUPLE [key: EV_KEY]]
			-- Actions to be performed when a keyboard key is pressed on the check button.

	update_popup_dimensions (a_popup: EV_POPUP_WINDOW)
			-- Update dimensions and positioning for `a_popup'.
		require
			a_popup_not_void: a_popup /= Void
		local
			l_x_offset, l_x_coord: INTEGER
			a_width: INTEGER
			a_widget_y_offset: INTEGER
			a_widget: EV_WIDGET
			l_parent: EV_GRID
			l_item: like item
		do
			a_widget := a_popup.item
			l_item := item
				-- Account for position of text relative to pixmap.
			l_x_offset := l_item.left_border
			if attached l_item.pixmap as l_pixmap then
				l_x_offset := l_x_offset + l_pixmap.width + l_item.spacing
			end

			l_parent := l_item.parent
			check l_parent /= Void end

			l_x_coord := (item.virtual_x_position + l_x_offset) - l_parent.virtual_x_position
			l_x_coord := l_x_coord.max (0).min (l_x_offset)

			a_width := a_popup.width - l_x_coord - item.right_border

			a_widget_y_offset := (a_widget.minimum_height - l_item.text_height) // 2

			a_widget.set_minimum_width (0)

			a_popup.set_x_position (a_popup.x_position + l_x_coord)
			a_popup.set_width (a_width)
			a_popup.set_y_position (a_popup.y_position + ((a_popup.height - l_item.top_border - l_item.bottom_border - l_item.text_height) // 2) + l_item.top_border - a_widget_y_offset)
			a_popup.set_height (l_item.text_height)
		end

	handle_key (a_key: EV_KEY)
			-- Handle the Escape key for cancelling activation.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				user_cancelled_activation := True
				deactivate
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				deactivate
			end
			if attached check_button_key_press_action as l_action then
				l_action.call ([a_key])
			end
		end

	user_cancelled_activation: BOOLEAN
		-- Did the user cancel the activation using the Esc key?

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		local
			l_check_button: like check_button
			l_bg_color: detachable EV_COLOR
		do
			create l_check_button
			check_button := l_check_button

			if item.is_checked then
				l_check_button.enable_select
			else
				l_check_button.disable_select
			end

			l_bg_color := item.background_color
			if l_bg_color /= Void then
				popup_window.set_background_color (l_bg_color)
			end
			l_bg_color := item.foreground_color
			if l_bg_color /= Void then
				l_check_button.set_foreground_color (l_bg_color)
			end

			popup_window.extend (l_check_button)
				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		local
			l_check_button: detachable like check_button
		do
			l_check_button := check_button
			check l_check_button /= Void end
			l_check_button.focus_out_actions.extend (agent deactivate)
			l_check_button.set_focus
			user_cancelled_activation := False
			l_check_button.key_press_actions.extend (agent handle_key)
		end

invariant
	item_not_void: item /= Void
	check_button_parented_during_activation: attached check_button as l_check_button implies l_check_button.parent /= Void

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
