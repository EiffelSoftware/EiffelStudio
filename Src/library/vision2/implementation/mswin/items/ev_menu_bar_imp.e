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

creation
	
	make

	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as parent.
			-- We increase the counter to have ids bigger than 1.
		local
			par_imp: EV_CONTAINER_IMP
		do
			wel_make
			par_imp ?= par.implementation
			check
				valid_container: par_imp /= Void
			end
			initialize
			!! wel_window.make (par_imp.wel_window," ")
			par_imp.wel_window.set_menu (Current)
		end	

feature -- Implementation

	wel_window: EV_WEL_CONTROL_WINDOW
	
end -- class EV_MENU BAR_IMP

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
