indexing
	description: "Text label that may be interactively edited by the user via a combo box"
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
			-- Set each item in `Current' to the strings referenced in `a_string_array'
		require
			a_string_array_not_void: a_string_array /= Void
		do
			item_strings := a_string_array
		ensure
			item_strings_set: item_strings = a_string_array
		end

feature -- Access

	item_strings: INDEXABLE [STRING, INTEGER]
		-- Item strings used to make up combo box list.

feature {NONE} -- Implementation

	combo_box: EV_COMBO_BOX
		-- Text field used to edit `Current' on `activate'.

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		local
			x_offset: INTEGER
		do
			if pixmap /= Void then
				x_offset := left_border + pixmap.width
			end
			popup_window.set_x_position (popup_window.x_position + x_offset)
			popup_window.set_width (popup_window.width - x_offset)
			create combo_box
			if item_strings /= Void then
				combo_box.set_strings (item_strings)
			end
			combo_box.set_text (text)
			popup_window.extend (combo_box)
			popup_window.show_actions.extend (agent combo_box.set_focus)
			combo_box.select_actions.extend (agent deactivate)
			combo_box.return_actions.extend (agent deactivate)
			combo_box.focus_out_actions.extend (agent deactivate)
		end

	deactivate is
			-- Cleanup from previous call to activate.
		do
			if combo_box /= Void then
				combo_box.focus_out_actions.wipe_out
				Precursor {EV_GRID_LABEL_ITEM}
				set_text (combo_box.text)
				combo_box := Void
			end
		end

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
