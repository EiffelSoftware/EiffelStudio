indexing
	description: 
		"EiffelVision menu item container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_HOLDER_I

inherit
	EV_ITEM_HOLDER_I

feature -- Element change
	
	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		require
			exist: not destroyed
		deferred
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		require
			exist: not destroyed
		deferred
		end

end -- class EV_MENU_ITEM_HOLDER_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
