indexing	
	description: 
		"EiffelVision menu item. Item that must be put in an %
		% EV_MENU_ITEM_CONTAINER."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_MENU_ITEM

inherit

	EV_ITEM
		redefine
			implementation
		end
	
creation
	
	make_with_text
	
feature {NONE} -- Initialization
	
	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create a menu item and add it to the `par'
			-- container.
		do
			!EV_MENU_ITEM_IMP!implementation.make_with_text (par, txt)
			par.add_menu_item (Current)
		end	

feature -- Status report

	insensitive: BOOLEAN is
			-- Is current item insensitive to
			-- user actions? 
		require
			exists: not destroyed
		do
			Result := implementation.insensitive
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'. 
   		require
   			exists: not destroyed
   		do
 			implementation.set_insensitive (flag)
 		ensure
   			flag = insensitive
   		end

feature -- Implementation

	implementation: EV_MENU_ITEM_I

end -- class EV_MENU

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
