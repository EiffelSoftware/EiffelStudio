indexing

	description: 
		"EiffelVision menu bar, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_MENU_BAR_IMP
	
inherit
	
	EV_MENU_BAR_I
		
	EV_MENU_HOLDER_IMP

	EV_WIDGET_IMP
	
creation
	
	make

feature {NONE} -- Initialization
	
        make is
                        -- Create a fixed widget. 
		do
			widget := gtk_menu_bar_new ()
		end	
	
feature -- Element change	
	
	add_menu (menu_imp: EV_MENU_IMP) is
			-- Add `menu_imp' in the container.
		do
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove `menu_imp' from the container.
		do
		end

feature {NONE} -- Implementation	

	add_menu_item_pointer (item_p: POINTER) is
		do
			gtk_menu_bar_append (gtk_menu_bar (widget), item_p)
		end

end

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
