indexing
	description: 
		"EiffelVision menu bar. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 

	EV_MENU_BAR_IMP

inherit

	EV_MENU_BAR_I

	EV_MENU_ITEM_CONTAINER_IMP
		rename
			make as wel_make
		end
	
	EV_WIDGET_IMP
		rename
			exists as widget_exists
		end

	WEL_MENU
		rename
			make as wel_make
		select
			exists
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as parent.
			-- We increase the counter to have ids bigger than 1.
			-- Here, we create the local wel_window, for the moment
			-- it is just to avoid that the features of ev_primitive
			-- crash, but it has no need, because when you use them,
			-- it has no effect.
		do
			wel_make
			test_and_set_parent (par)
			initialize
			parent_imp.set_menu (Current)
		end
	
end -- class EV_WEL_MENU_BAR_IMP

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
--|---------------------------------------------------------------
