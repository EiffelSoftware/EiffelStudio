indexing
	description:
		"EiffelVision static menu bar, gtk implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_STATIC_MENU_BAR_IMP

inherit
	EV_STATIC_MENU_BAR_I

	EV_MENU_ITEM_CONTAINER_IMP
		rename
			parent_imp as widget_parent_imp
		select
			make
		end

	EV_PRIMITIVE_IMP	
			-- It is a widget in gtk
		rename
			make as widget_make,
			parent_imp as widget_parent_imp
		end

creation
	make

feature {NONE} -- Initialization
	
	make (par: EV_WINDOW) is         
			-- Create a menu widget with `par' as parent window.
		local
			par_imp: EV_WINDOW_IMP
		do
			widget := gtk_menu_bar_new ()
			par_imp ?= par.implementation
			check
				good_implementation: par_imp /= Void
			end
			par_imp.add_static_menu (Current)	
		end	

feature {NONE} -- Implementation	

	add_menu_item_pointer (item_p: POINTER) is
		do
			gtk_menu_bar_append (gtk_menu_bar (widget), item_p)
		end

	widget_make (par: EV_CONTAINER) is
			-- Need to be implemented, but do nothing.
		do
		end

end -- class EV_STATIC_MENU_BAR_IMP

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
