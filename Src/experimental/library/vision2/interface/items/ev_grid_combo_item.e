note
	description:
		"[
			EV_GRID Text label that may be interactively edited by the user via a combo box.

			To allow the user to edit the item, connect an agent that calls `item' to an action sequence
			of `Current' such as `pointer_button_press_actions'.

			`set_item_strings' may be used to set the list items used in the combo box before the item is activated.

			By default a combo box containing the strings set from `set_item_strings' is displayed, allowing
			the user to change the text of `Current' by selecting an item within the combo box.
				
			The default behavior of the activation may be overriden using `activate_actions' or `item_activate_actions' (from
			EV_GRID).

			By default, `combo_box' is Void unless the item is being activated, this prevents the need for a persistent combo box
			widget for each EV_GRID_COMBO_ITEM. `combo_box' must not be unparented during activation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_COMBO_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			activate_action,
			deactivate
		end

create
	default_create,
	make_with_text

feature -- Element change

	set_item_strings (a_string_array: INDEXABLE [STRING_GENERAL, INTEGER])
			-- Set each item in `Current' to the strings referenced in `a_string_array'.
		require
			a_string_array_not_void: a_string_array /= Void
		do
			if attached combo_box as l_combo_box then
				l_combo_box.set_strings (a_string_array)
			end
			item_strings := a_string_array
		ensure
			item_strings_set: item_strings = a_string_array
		end

feature -- Access

	combo_box: detachable EV_COMBO_BOX
		-- Text field used to edit `Current' on `activate'
		-- Void when `Current' isn't being activated.

	item_strings: detachable INDEXABLE [STRING_GENERAL, INTEGER]
		-- Item strings used to make up combo box list.

feature {NONE} -- Implementation

	update_popup_dimensions (a_popup: EV_POPUP_WINDOW)
			-- Update dimensions and positioning for `a_popup'.
		require
			a_popup_not_void: a_popup /= Void
		local
			l_x_offset: INTEGER
			a_width: INTEGER
			a_widget: EV_WIDGET
			a_x_position, a_y_position: INTEGER
			l_x_coord: INTEGER
			l_parent: like parent
		do
			a_widget := a_popup.item
				-- Account for position of text relative to pixmap.
			l_x_offset := left_border
			if attached pixmap as l_pixmap then
					-- Calculate x offset for pixmap spacing if any
				l_x_offset := l_x_offset + l_pixmap.width + spacing
			end

			l_parent := parent
			check l_parent /= Void end
			l_x_coord := (virtual_x_position + l_x_offset) - l_parent.virtual_x_position
			l_x_coord := l_x_coord.max (0).min (l_x_offset)

			a_width := a_popup.width - l_x_coord - right_border

			a_x_position := a_popup.x_position + l_x_coord
				-- Align combo box to y position of text in `Current'.
			a_y_position := a_popup.y_position + top_border + ((a_popup.height - top_border - bottom_border - a_widget.minimum_height) // 2) + 1

			a_widget.set_minimum_width (0)

			a_popup.set_x_position (a_x_position)
			a_popup.set_width (a_width)
			a_popup.set_y_position (a_y_position)
			a_popup.set_height (a_widget.minimum_height)
		end

	handle_key (a_key: EV_KEY)
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

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		local
			l_combo_box: EV_COMBO_BOX
		do
			create l_combo_box
			combo_box := l_combo_box
			popup_window.extend (l_combo_box)

			if attached font as l_font then
				l_combo_box.set_font (l_font)
			end

			if attached item_strings as l_item_strings then
				l_combo_box.set_strings (l_item_strings)
			end
			l_combo_box.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			l_combo_box.set_foreground_color (implementation.displayed_foreground_color)

			l_combo_box.set_text (text)

			update_popup_dimensions (popup_window)

				-- Initialize action sequences when `Current' is shown.
			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
			if attached combo_box as l_combo_box then
				l_combo_box.set_focus
				l_combo_box.focus_out_actions.extend (agent deactivate)
				l_combo_box.return_actions.extend (agent deactivate)
				user_cancelled_activation := False
				l_combo_box.key_press_actions.extend (agent handle_key)
			end
		end

	deactivate
			-- Cleanup from previous call to activate.
		do
			if attached combo_box as l_combo_box then
				l_combo_box.focus_out_actions.wipe_out
				if not user_cancelled_activation then
					set_text (l_combo_box.text)
				end
				Precursor {EV_GRID_LABEL_ITEM}
				combo_box := Void
			end
		end

invariant
	combo_box_parented_during_activation: attached combo_box as l_combo_box implies l_combo_box.parent /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end










