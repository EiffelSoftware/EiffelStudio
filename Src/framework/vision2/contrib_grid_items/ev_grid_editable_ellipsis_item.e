note
	description: "Objects that represents an editable grid label with ellipsis button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GRID_EDITABLE_ELLIPSIS_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			initialize,
			activate_action,
			initialize_actions,
			deactivate,
			set_text
		end

	EV_UTILITIES
		undefine
			default_create,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		do
			create ellipsis_actions
			create change_actions
			Precursor
		end

feature -- Status

	has_focus: BOOLEAN
			-- Does this property have the focus?
		require
			is_activated
		do
			Result := text_field.has_focus or button.has_focus
		end

	is_activated: BOOLEAN
			-- Is the property activated?

	is_text_editing: BOOLEAN
			-- Can the text be directly edited in the text field?

feature -- Access

	button: EV_BUTTON
			-- Ellipsis button used to edit `Current' on activate.
			-- Void when `Current' isn't beeing activated.

	popup_window: EV_POPUP_WINDOW
			-- Popup window used on activate.
			-- Void when `Current' isn't beeing activated.

feature -- Update

	set_text (a_text: STRING_GENERAL)
		local
			l_has_changed: BOOLEAN
		do
			l_has_changed := text = Void or else not text.is_equal (a_text)
			Precursor {EV_GRID_EDITABLE_ITEM} (a_text)
			if l_has_changed then
				change_actions.call (Void)
			end
		end

	disable_text_editing
			-- Disable editing the text directly in the text field.
		do
			is_text_editing := False
		ensure
			not_is_text_editing: not is_text_editing
		end

	enable_text_editing
			-- Enable editing the text directly in the text field.
		do
			is_text_editing := True
		ensure
			is_text_editing: is_text_editing
		end

feature {NONE} -- Implementation

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
			text_field.return_actions.extend (agent return_pressed)
			text_field.focus_out_actions.extend (agent focus_lost)
			button.focus_out_actions.extend (agent focus_lost)
			button.select_actions.extend (agent call_ellipsis_actions)

			text_field.set_focus
			user_cancelled_activation := False
			text_field.key_press_actions.extend (agent handle_key)
		end

	focus_lost
			-- Check if no other element in the popup has the focus.
		do
			if
				is_activated
				and then not inside_outter_edition
				and then not has_focus
				and then is_parented
			then
				deactivate
			end
		end

	activate_action (a_popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		local
			hb: EV_HORIZONTAL_BOX
		do
			popup_window := a_popup_window
--			a_popup_window.set_x_position (a_popup_window.x_position + 1)
--			a_popup_window.set_size (a_popup_window.width - 1, a_popup_window.height -1 )

			if is_text_editing then
				create text_field
				text_field.implementation.hide_border
				if font /= Void then
					text_field.set_font (font)
				end

				if not is_text_editing then
					text_field.disable_edit
				end

				text_field.set_text (text)

				text_field.set_background_color (implementation.displayed_background_color)
				a_popup_window.set_background_color (implementation.displayed_background_color)
				text_field.set_foreground_color (implementation.displayed_foreground_color)

				create hb
				hb.extend (text_field)

				create button
				button.set_pixmap (ellipsis)
				hb.extend (button)
				hb.disable_item_expand (button)
				button.set_minimum_height (a_popup_window.height)

				a_popup_window.extend (hb)
				update_popup_dimensions (a_popup_window)

				a_popup_window.show_actions.extend_kamikaze (agent initialize_actions)
				is_activated := True
			else
--				update_popup_dimensions (a_popup_window)
				call_ellipsis_actions
			end
		ensure then
			popup_window_set: popup_window /= Void
			text_editing_implies_activation: is_text_editing implies is_activated and text_field /= Void and button /= Void
		end

	deactivate
			-- Cleanup from previous call to `activate'.
		do
			Precursor {EV_GRID_EDITABLE_ITEM}
			if button /= Void then
				button.destroy
				button := Void
			end
			if text_field /= Void then
				text_field.destroy
				text_field := Void
			end
			if popup_window /= Void then
				popup_window.destroy
				popup_window := Void
			end
			is_activated := False
			if parent /= Void and then not parent.is_destroyed and then parent.is_displayed then
				parent.set_focus
			end
		ensure then
			popup_window_void: popup_window = Void
			text_field_void: text_field = Void
			button_void: button = Void
			not_activated: not is_activated
		end

	inside_outter_edition: BOOLEAN

	enter_outter_edition
			--
		require
			is_activated: is_activated
		do
			inside_outter_edition := True
			if text_field /= Void then
				text_field.disable_sensitive
			end
			if button /= Void then
				button.disable_sensitive
			end
			if popup_window /= Void then
				popup_window.hide
			end
		end

	leave_outter_edition
			--
--		require
--			is_activated: is_activated
		do
			if popup_window /= Void then
				popup_window.show
			end
			if text_field /= Void then
				text_field.enable_sensitive
			end
			if button /= Void then
				button.enable_sensitive
			end
			inside_outter_edition := False
		end

feature -- Events

	ellipsis_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the ellipsis button is pressed.

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the text changed.

feature {NONE} -- Implementation

	return_pressed
			-- On control+Enter call ellipsis actions, otherwise deactivate
		do
			if ev_application.ctrl_pressed then
				call_ellipsis_actions
			else
				deactivate
			end
		end

	call_ellipsis_actions
			-- Call ellipsis_actions
		do
			ellipsis_actions.call (Void)
		end

	ellipsis: EV_PIXMAP
			-- Icon for ellipsis
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (8, 2)
			Result.fill_rectangle (0, 0, 2, 2)
			Result.fill_rectangle (3, 0, 2, 2)
			Result.fill_rectangle (6, 0, 2, 2)

			create l_mask.make_with_size (8, 2)
			l_mask.fill_rectangle (0, 0, 2, 2)
			l_mask.fill_rectangle (3, 0, 2, 2)
			l_mask.fill_rectangle (6, 0, 2, 2)

			Result.set_mask (l_mask)
		ensure
			Result_set: Result /= Void
		end

invariant

	ellipsis_actions_not_void: ellipsis_actions /= Void

note
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

end
