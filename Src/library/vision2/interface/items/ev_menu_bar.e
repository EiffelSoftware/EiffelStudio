indexing
	description:
		 "EiffelVision menu bar. Menu bar is a vertical bar with%
		% a several menus inside. It can be moved by the user or%
		% put back in the menu receptable."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR

inherit

	EV_MENU_ITEM_CONTAINER 
		redefine
			implementation
		end

	EV_PRIMITIVE
		redefine
			implementation
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as parent.
			-- We can't use `widget_make' here, because a menu
			-- is not a child, otherwise, you couldn't put more
			-- than a menu in a window. A menu is an option of a
			-- window
		do
			!EV_MENU_BAR_IMP!implementation.make (par)
			implementation.set_interface (Current)
			implementation.test_and_set_parent (par)
			implementation.build
			managed := par.manager
			widget_make (par)
		end	
	
feature {NONE} -- Implementation
	
	implementation: EV_MENU_BAR_I	

end -- class EV_MENU BAR

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
