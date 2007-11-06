indexing
	description:
		"[
			EV_GRID Text label that may be interactively edited by the user via a text field.

			To allow the user to edit the item, connect an agent that calls `item' to an action sequence
			of `Current' such as `pointer_button_press_actions'.
			
			`set_text_validation_agent' may be used to pass an agent that validates the text of `Current' before it is
			changed by the activain_popup_action
				
			The default behavior of the activation may be overriden using `activate_actions' or `item_activate_actions' (from
			EV_GRID).

			By default, `text_label' is Void unless the item is being activated, this prevents the need for a persistent text_label
			widget for each ES_OBJECTS_GRID_CELL. `text_label' must not be unparented during activation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_CELL

inherit
	EV_GRID_LABEL_ITEM
		redefine
			activate_action,
			deactivate
		end

create
	default_create,
	make_with_text

feature -- Access

	text_label: EV_LABEL
		-- Text label used to display particular view of `Current' on `activate'.
		-- Void when `Current' isn't being activated.

feature -- Action

	deactivate is
			-- Cleanup from previous call to activate.
		do
			if text_label /= Void then
				text_label.focus_out_actions.wipe_out
				Precursor {EV_GRID_LABEL_ITEM}
				if text_label /= Void then
					text_label.destroy
					text_label := Void
				end
			end
		end

feature {NONE} -- Implementation

	update_popup_dimensions (a_popup: EV_POPUP_WINDOW) is
			-- Update dimensions and positioning for `a_popup'.
		require
			a_popup_not_void: a_popup /= Void
		local
			l_x_offset, l_x_coord: INTEGER
			a_width: INTEGER
			a_widget_y_offset: INTEGER
			a_widget: EV_WIDGET
		do
			a_widget := a_popup.item
				-- Account for position of text relative to pixmap.
			l_x_offset := left_border
			if pixmap /= Void then
				l_x_offset := l_x_offset + pixmap.width + spacing
			end

			l_x_coord := (virtual_x_position + l_x_offset) - parent.virtual_x_position
			l_x_coord := l_x_coord.max (0).min (l_x_offset)

			a_width := a_popup.width - l_x_coord - right_border

			a_widget_y_offset := (a_widget.minimum_height - text_height) // 2

			a_widget.set_minimum_width (0)

			a_popup.set_x_position (a_popup.x_position + l_x_coord)
			a_popup.set_width (a_width)
			a_popup.set_y_position (a_popup.y_position + ((a_popup.height - top_border - bottom_border - text_height) // 2) + top_border - a_widget_y_offset)
			a_popup.set_height (text_height)
		end

	handle_key (a_key: EV_KEY) is
			-- Handle the Escape key for cancelling activation.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				user_cancelled_activation := True
				deactivate
			end
		end

	user_cancelled_activation: BOOLEAN
		-- Did the user cancel the activation using the Esc key?

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			create text_label
			text_label.set_minimum_size (1, text_height)
			text_label.align_text_left
			if font /= Void then
				text_label.set_font (font)
			end
			text_label.set_text (text)

			text_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255,0,0)) --implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			text_label.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (text_label)
				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions is
			-- Setup the action sequences when the item is shown.
		do
			user_cancelled_activation := False
			text_label.key_press_actions.extend (agent handle_key)
		end

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

end
