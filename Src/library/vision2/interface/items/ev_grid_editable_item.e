note
	description:
		"[
			EV_GRID Text label that may be interactively edited by the user via a text field.

			To allow the user to edit the item, connect an agent that calls `item' to an action sequence
			of `Current' such as `pointer_button_press_actions'.
			
			`set_text_validation_agent' may be used to pass an agent that validates the text of `Current' before it is
			changed by the activain_popup_action
				
			The default behavior of the activation may be overriden using `activate_actions' or `item_activate_actions' (from
			EV_GRID).

			By default, `text_field' is Void unless the item is being activated, this prevents the need for a persistent text_field
			widget for each EV_GRID_EDITABLE_ITEM. `text_field' must not be unparented during activation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_EDITABLE_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			initialize,
			activate_action,
			deactivate
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

create
	default_create,
	make_with_text

feature {EV_ANY} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
			set_is_tab_navigatable (True)
		end

feature -- Element change

	set_text_validation_agent (a_validation_agent: FUNCTION [STRING_32, BOOLEAN])
			-- Set the agent that validates the text of `text_field' on `deactivate'.
			-- If `a_validation_agent' is Void then no validation is performed before setting `text'.
		do
			validation_agent := a_validation_agent
		ensure
			validation_agent_set: validation_agent = a_validation_agent
		end

feature -- Access

	validation_agent: detachable FUNCTION [STRING_32, BOOLEAN]
		-- Agent used to validate `text_field' text.

	text_field: detachable EV_TEXT_FIELD
		-- Text field used to edit `Current' on `activate'.
		-- Void when `Current' isn't being activated.

feature -- Action

	deactivate
			-- Cleanup from previous call to activate.
		do
			if attached text_field as l_text_field and then l_text_field.is_usable then
				l_text_field.focus_out_actions.wipe_out
				if not user_cancelled_activation and then (validation_agent = Void or else (attached validation_agent as l_validation_agent and then l_validation_agent.item ([l_text_field.text]))) then
					set_text (l_text_field.text)
				end
				l_text_field.destroy
				text_field := Void
				Precursor {EV_GRID_LABEL_ITEM}
			end
		end

feature {NONE} -- Implementation

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
			l_layout: like grid_label_item_layout
		do
			a_widget := a_popup.item

			l_parent := parent
			check l_parent /= Void then end

				-- Due to the drawing hack for text which assumes that text is by default drawing
				-- {EV_GRID_LABEL_ITEM}.default_left_border pixels to the right, we need to check
				-- if user has set `left_border' or not.
			if internal_left_border >= 0 then
				l_x_offset := left_border
			end
				-- Account for position of text relative to pixmap.
			if attached pixmap as l_pixmap then
				l_x_offset := l_x_offset + l_pixmap.width + spacing
			end

			l_x_coord := (virtual_x_position + l_x_offset) - l_parent.virtual_x_position
			l_x_coord := l_x_coord.max (0).min (l_x_offset)

			a_width := a_popup.width - l_x_coord - right_border

				-- Border of the widget
			a_widget_y_offset := (a_widget.minimum_height - text_height) // 2

			a_widget.set_minimum_width (0)

			a_popup.set_x_position (a_popup.x_position + l_x_coord)
			a_popup.set_width (a_width)
				-- Move the popup above the text location which we need to compute.
			l_layout := computed_initial_grid_label_item_layout (width, height)
			if attached layout_procedure as l_layout_procedure then
				l_layout_procedure.call ([Current, l_layout])
			end
			a_popup.set_y_position (a_popup.y_position + l_layout.text_y - a_widget_y_offset)
			a_popup.set_height (text_height)
		end

	handle_key (a_key: EV_KEY)
			-- Handle keys for exiting activation.
		require
			a_key_not_void: a_key /= Void
		local
			l_deactivate, l_propagate_tab_key: BOOLEAN
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_escape then
					-- User is cancelling the activation.
				user_cancelled_activation := True
				l_deactivate := True
			when {EV_KEY_CONSTANTS}.key_tab, {EV_KEY_CONSTANTS}.key_enter then
					-- Tab and Enter key should exit the activation.
				l_deactivate := True
					-- Tab or enter key should propagate to the next item if `is_item_tab_navigation_enabled'.
				l_propagate_tab_key := attached parent as l_parent and then l_parent.is_item_tab_navigation_enabled
			else
				-- Do nothing
			end
			if l_deactivate and then attached parent as l_parent then
				if l_propagate_tab_key then
					l_parent.propagate_key_press (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab))
				end
					-- Make sure that `Current' is deactivated if not already done so by the key propagation.
				if l_parent.activated_item = Current then
					deactivate
				end
			end
		end

	user_cancelled_activation: BOOLEAN
		-- Did the user cancel the activation using the Esc key?

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		local
			l_text_field: like text_field
			l_bg_color: EV_COLOR
		do
			create l_text_field
			text_field := l_text_field

			if attached font as l_font then
				l_text_field.set_font (l_font)
			end
			l_text_field.set_text (text)

				-- Follow the current alignment of item.
			if is_right_aligned then
				l_text_field.align_text_right
			elseif is_center_aligned then
				l_text_field.align_text_center
			end

				-- Hide the border of the text field.
				-- This may trigger a minimum size calculation so it is performed after the contents have been updated.
			l_text_field.implementation.hide_border

				-- Let's set the text field min height, to match the cell's height
			l_text_field.set_minimum_height (height)

			l_bg_color := implementation.displayed_background_color
			l_text_field.set_background_color (l_bg_color)
			popup_window.set_background_color (l_bg_color)
			l_text_field.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (l_text_field)
				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
			if attached text_field as l_text_field then
				l_text_field.focus_out_actions.extend (agent ev_application.do_once_on_idle (agent deactivate))
				l_text_field.set_focus
				l_text_field.set_caret_position (l_text_field.text_length + 1)
				user_cancelled_activation := False
				l_text_field.key_press_actions.extend (agent handle_key)
			end
		end

invariant
	text_field_parented_during_activation: attached text_field as l_field implies l_field.has_parent

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end










