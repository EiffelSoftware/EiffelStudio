indexing	
	description:
		"[
			Menu item with state displayed as a circular check box.
			`is_selected' is mutually exclusive with respect to other radio menu
			items between separators in a menu.
		]"
	status: "See notice at end of class"
	keywords: "radio, item, menu, check, select, unselect"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_RADIO_PEER
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_SELECTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end
	
create
	default_create,
	make_with_text,
	make_with_text_and_action
	
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := Precursor {EV_MENU_ITEM}
				and then Precursor {EV_RADIO_PEER}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_RADIO_MENU_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_RADIO_MENU_ITEM

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

