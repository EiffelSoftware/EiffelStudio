indexing
	description: 
		"EiffelVision menu item container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_CONTAINER_I

inherit
	EV_ANY_I

feature {EV_MENU_ITEM_CONTAINER} -- Implementation
	
	add_item (an_item: EV_MENU_ITEM) is
			-- Add `an_item' into container.
		require
			exist: not destroyed
			valid_item: is_valid (an_item)
		deferred
		end

end -- class EV_MENU_ITEM_CONTAINER_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
