note
	description: "Checkable grid item can be activated and changed by space key."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_GRID_CHECKABLE_LABEL_ITEM

inherit
	EV_GRID_CHECKABLE_LABEL_ITEM
		redefine
			activate_action,
			deactivate
		end

feature -- Access

	check_button: detachable EV_CHECK_BUTTON
		-- Check button to be activated.

feature -- Element change

	set_check_button_key_press_action (a_action: like check_button_key_press_action)
			-- Set `check_button_key_press_action' with `a_action'
		do
			check_button_key_press_action := a_action
		ensure
			check_button_key_press_action_set: check_button_key_press_action = a_action
		end

feature -- Action

	deactivate
			-- Cleanup from previous call to activate.
		do
			Precursor {EV_GRID_CHECKABLE_LABEL_ITEM}
			if attached check_button as l_check_button then
				l_check_button.focus_out_actions.wipe_out
				if not user_cancelled_activation then
					if attached check_button as l_cb then
						if is_checked /= l_cb.is_selected then
							set_is_checked (l_cb.is_selected)
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
			l_parent: like parent
		do
			a_widget := a_popup.item
				-- Account for position of text relative to pixmap.
			l_x_offset := left_border
			if attached pixmap as l_pixmap then
				l_x_offset := l_x_offset + l_pixmap.width + spacing
			end

			l_parent := parent
			check l_parent /= Void end

			l_x_coord := (virtual_x_position + l_x_offset) - l_parent.virtual_x_position
			l_x_coord := l_x_coord.max (0).min (l_x_offset)

			a_width := a_popup.width - l_x_coord - right_border

			a_widget_y_offset := (a_widget.minimum_height - text_height) // 2

			a_widget.set_minimum_width (0)

			a_popup.set_x_position (a_popup.x_position + l_x_coord)
			a_popup.set_width (a_width)
			a_popup.set_y_position (a_popup.y_position + ((a_popup.height - top_border - bottom_border - text_height) // 2) + top_border - a_widget_y_offset)
			a_popup.set_height (text_height)
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
			l_bg_color: EV_COLOR
		do
			create l_check_button
			check_button := l_check_button

			if is_checked then
				l_check_button.enable_select
			else
				l_check_button.disable_select
			end

			l_bg_color := implementation.displayed_background_color
			popup_window.set_background_color (l_bg_color)
			l_check_button.set_foreground_color (implementation.displayed_foreground_color)

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
