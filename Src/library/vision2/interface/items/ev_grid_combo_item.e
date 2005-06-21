indexing
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
	
	set_item_strings (a_string_array: INDEXABLE [STRING, INTEGER]) is
			-- Set each item in `Current' to the strings referenced in `a_string_array'.
		require
			a_string_array_not_void: a_string_array /= Void
		do
			if combo_box /= Void then
				combo_box.set_strings (a_string_array)
			end
			item_strings := a_string_array
		ensure
			item_strings_set: item_strings = a_string_array
		end

feature -- Access

	combo_box: EV_COMBO_BOX
		-- Text field used to edit `Current' on `activate'
		-- Void when `Current' isn't being activated.

	item_strings: INDEXABLE [STRING, INTEGER]
		-- Item strings used to make up combo box list.

feature {NONE} -- Implementation

	update_popup_dimensions (a_popup: EV_POPUP_WINDOW) is
			-- Update dimensions and positioning for `a_popup'.
		local
			x_offset: INTEGER
			a_width: INTEGER
			a_widget_x_offset: INTEGER
			a_widget: EV_WIDGET
			a_x_position, a_y_position: INTEGER
		do
			a_widget := a_popup.item
				-- Account for position of text relative to pixmap.
			x_offset := left_border
			if pixmap /= Void then
				x_offset := x_offset + pixmap.width + spacing
			end
			a_width := a_popup.width - x_offset - right_border
			
			a_widget_x_offset := 2

			a_x_position := a_popup.x_position + x_offset
				-- Align combo box to y position of text in `Current'.
			a_y_position := a_popup.y_position + ((a_popup.height - top_border - bottom_border - a_widget.minimum_height) // 2) + 1
			
			a_popup.set_size (a_width, a_widget.minimum_height)
			a_popup.set_position (a_x_position, a_y_position)			
		end

	handle_key (a_key: EV_KEY) is
			-- Handle the Escape key for cancelling activation.
		do
			if a_key.code = (create{EV_KEY_CONSTANTS}).key_escape then
				user_cancelled_activation := True
				deactivate
			end
		end
		
	user_cancelled_activation: BOOLEAN
		-- Did the user cancel the activation using the Esc key?

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			create combo_box
			popup_window.extend (combo_box)

			if font /= Void then
				combo_box.set_font (font)
			end
			
			if item_strings /= Void then
				combo_box.set_strings (item_strings)
			end
			combo_box.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			combo_box.set_foreground_color (implementation.displayed_foreground_color)

			combo_box.set_text (text)

			update_popup_dimensions (popup_window)

				-- No items should be selected.
			combo_box.remove_selection
		
				-- Initialize action sequences when `Current' is shown.
			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions is
			-- Setup the action sequences when the item is shown.
		do
			combo_box.select_actions.extend (agent deactivate)
			combo_box.return_actions.extend (agent deactivate)
			combo_box.focus_out_actions.extend (agent deactivate)
			user_cancelled_activation := False
			combo_box.key_press_actions.extend (agent handle_key)
		end

	deactivate is
			-- Cleanup from previous call to activate.
		do
			if combo_box /= Void then
				combo_box.focus_out_actions.wipe_out
				if not user_cancelled_activation then
					set_text (combo_box.text)				
				end
				combo_box := Void
				Precursor {EV_GRID_LABEL_ITEM}
			end
		end

invariant
	combo_box_parented_during_activation: combo_box /= Void implies combo_box.parent /= Void

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
