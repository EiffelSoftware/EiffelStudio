indexing	
	description: 
		"EiffelVision radio menu item. Item that must be put in%
		% an EV_MENU_ITEM_CONTAINER. It has the same appearance%
		% than the check menu-item, yet, when a radio menu-item%
		% is checked, all the other radio menu-item of the%
		% container are unchecked."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_CHECK_MENU_ITEM
		redefine
			make_with_text,
			implementation
		end
	
creation
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create a menu item and add it to the `par'
			-- container.
		do
			!EV_RADIO_MENU_ITEM_IMP!implementation.make_with_text (par, txt)
			implementation.set_interface (Current)
			par.add_menu_item (Current)
		end	

feature -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I

end -- class EV_RADIO_MENU_ITEM

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
