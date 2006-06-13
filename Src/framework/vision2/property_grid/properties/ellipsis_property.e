indexing
	description: "Properties that can be edited by an extended action."
	date: "$Date$"
	revision: "$Revision$"

class
	ELLIPSIS_PROPERTY [G]

inherit
	TEXT_PROPERTY [G]
		redefine
			activate_action,
			initialize_actions,
			deactivate,
			initialize,
			update_text_on_deactivation
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			create ellipsis_actions
			Precursor
		end

feature -- Status

	has_focus: BOOLEAN is
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

	disable_text_editing is
			-- Disable editing the text directly in the text field.
		do
			is_text_editing := False
		ensure
			not_is_text_editing: not is_text_editing
		end

	enable_text_editing is
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

	update_text_on_deactivation is
			-- Update text on deactivation.
		do
			if is_text_editing then
				Precursor {TEXT_PROPERTY}
			end
		end

	initialize_actions is
			-- Setup the actions sequences when the item is shown.
		do
			text_field.set_focus
			text_field.return_actions.extend (agent deactivate)
			text_field.focus_out_actions.extend (agent focus_lost)
			button.focus_out_actions.extend (agent focus_lost)
			user_cancelled_activation := False
			text_field.key_press_actions.extend (agent handle_key)
			button.select_actions.append (ellipsis_actions)
		end

	focus_lost is
			-- Check if no other element in the popup has the focus.
		do
			if is_activated and then not has_focus then
				deactivate
			end
		end

	activate_action (a_popup_window: EV_POPUP_WINDOW) is
			-- Activate action.
		local
			l_hb: EV_HORIZONTAL_BOX
		do
			popup_window := a_popup_window
			create text_field
			text_field.implementation.hide_border
			if font /= Void then
				text_field.set_font (font)
			end

			if not is_text_editing then
				text_field.disable_edit
			end
			text_field.set_text (displayed_value)
			text_field.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			text_field.set_foreground_color (implementation.displayed_foreground_color)

			create l_hb
			l_hb.extend (text_field)

			create button
			button.set_pixmap (ellipsis)
			l_hb.extend (button)
			l_hb.disable_item_expand (button)
			button.set_minimum_height (popup_window.height-1)

			popup_window.extend (l_hb)

			popup_window.show_actions.extend (agent initialize_actions)
			popup_window.set_x_position (popup_window.x_position + 1)
			popup_window.set_size (popup_window.width - 1, popup_window.height -1 )
			is_activated := True
		ensure then
			is_activated: is_activated
		end

	deactivate is
			-- Cleanup from previous call to `activate'.
		do
			Precursor {TEXT_PROPERTY}
			if button /= Void then
				button.focus_out_actions.wipe_out
				button.destroy
				button := Void
			end
			is_activated := False
			if not parent.is_destroyed then
				parent.set_focus
			end
		ensure then
			button_void: button = Void
			not_activated: not is_activated
		end


feature {NONE} -- Implementation

	ellipsis: EV_PIXMAP is
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

	parent_window: EV_WINDOW is
			-- Return the parent window (if any), where the property has been put.
		local
			l_parent: EV_CONTAINER
		do
			from
				l_parent := parent
			until
				Result /= Void or l_parent = Void
			loop
				Result ?= l_parent
				l_parent := l_parent.parent
			end
		end

invariant
	ellipsis_actions_not_void: is_initialized implies ellipsis_actions /= Void
	active_elements: is_activated implies button /= Void and text_field /= Void
end
