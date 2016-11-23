note
	description: "Properties that can be edited by an extended action."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ELLIPSIS_PROPERTY [G -> detachable ANY]

inherit
	TEXT_PROPERTY [G]
		redefine
			activate_action,
			initialize_actions,
			deactivate,
			create_interface_objects,
			update_text_on_deactivation
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

	EV_UTILITIES
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	create_interface_objects
			-- Initialize.
		do
			Precursor
			create ellipsis_actions
		end

feature -- Status

	has_focus: BOOLEAN
			-- Does this property have the focus?
		require
			is_activated
		do
			Result := (attached text_field as l_text_field and then l_text_field.has_focus) or
				(attached button as l_button and then l_button.has_focus)
		end

	is_activated: BOOLEAN
			-- Is the property activated?

	is_text_editing: BOOLEAN
			-- Can the text be directly edited in the text field?

feature -- Access

	button: detachable EV_BUTTON
			-- Ellipsis button used to edit `Current' on activate.
			-- Void when `Current' isn't beeing activated.

	popup_window: detachable EV_POPUP_WINDOW note option: stable attribute end
			-- Popup window used on activate.
			-- Void when `Current' isn't beeing activated.

feature -- Update

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

feature -- Events

	ellipsis_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the ellipsis button is pressed.

feature {NONE} -- Agents

	update_text_on_deactivation
			-- Update text on deactivation.
		do
			if is_text_editing then
				Precursor {TEXT_PROPERTY}
			end
		end

	initialize_actions
			-- Setup the actions sequences when the item is shown.
		do
			if
				attached text_field as l_text_field and then not l_text_field.is_destroyed and then
				attached button as l_button and then not l_button.is_destroyed
			then
				l_text_field.focus_out_actions.extend (agent focus_lost)
				l_text_field.set_focus
				user_cancelled_activation := False
				l_text_field.key_press_actions.extend (agent handle_key)
				l_text_field.return_actions.extend (agent deactivate)
				l_button.focus_out_actions.extend (agent focus_lost)
				l_button.select_actions.append (ellipsis_actions)
			end
		end

	focus_lost
			-- Check if no other element in the popup has the focus.
		do
			if {PLATFORM}.is_windows then
				if not is_destroyed and then is_activated and then not has_focus and then is_parented then
					deactivate
				end
			else
					-- This is a hack for gtk Vision2 as focus out actions are fired
					-- before focus in actions which means that no window has the focus
					-- when focusing from one app window to the other and checking focus state
					-- in the focus out actions.
				ev_application.do_once_on_idle (agent do
					if not is_destroyed and then is_activated and then not has_focus and then is_parented then
						deactivate
					end
				end
				)
			end
		end

	activate_action (a_popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		local
			l_hb: EV_HORIZONTAL_BOX
			l_text_field: like text_field
			l_button: like button
		do
			popup_window := a_popup_window
			popup_window.set_x_position (popup_window.x_position + (left_border - 1))
			popup_window.set_size (popup_window.width - (left_border - 1) - (right_border - 1), popup_window.height - 1)

			if is_text_editing then
				create l_text_field
				text_field := l_text_field
				l_text_field.implementation.hide_border
				if attached font as l_font then
					l_text_field.set_font (l_font)
				end

				l_text_field.set_text (displayed_value)
				l_text_field.set_background_color (implementation.displayed_background_color)
				popup_window.set_background_color (implementation.displayed_background_color)
				l_text_field.set_foreground_color (implementation.displayed_foreground_color)

				create l_hb
				l_hb.extend (l_text_field)

				create l_button
				button := l_button
				l_button.set_pixmap (ellipsis)
				l_hb.extend (l_button)
				l_hb.disable_item_expand (l_button)
				l_button.set_minimum_height (popup_window.height)

				popup_window.extend (l_hb)

				popup_window.show_actions.extend (agent initialize_actions)

				is_activated := True
			else
				ellipsis_actions.call (Void)
			end
		ensure then
			popup_window_set: popup_window /= Void
			text_editing_implies_activation: is_text_editing implies is_activated and text_field /= Void and button /= Void
		end

	deactivate
			-- Cleanup from previous call to `activate'.
		do
			Precursor {TEXT_PROPERTY}
			if attached button as l_button then
				l_button.focus_out_actions.wipe_out
				l_button.destroy
				button := Void
			end
			is_activated := False
			if attached parent as l_parent and then not l_parent.is_destroyed and then l_parent.is_displayed then
				l_parent.set_focus
			end
		ensure then
			button_void: button = Void
			not_activated: not is_activated
		end

feature {NONE} -- Implementation

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
	ellipsis_actions_not_void: is_initialized implies ellipsis_actions /= Void
	active_elements: is_activated implies button /= Void and text_field /= Void
note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
