indexing
	description: "EiffelVision static menu bar. Mswindows inplementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_STATIC_MENU_BAR_IMP

inherit
	EV_STATIC_MENU_BAR_I

	EV_MENU_CONTAINER_IMP

	WEL_MENU
		rename
			make as wel_make
		end

creation
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_WINDOW) is         
			-- Create a menu widget with `par' as parent window.
		do
			wel_make
			parent_imp ?= par.implementation
			check
				parent_imp /= Void
			end
			ev_children := parent_imp.menu_items
			parent_imp.set_menu (Current)
		end	

feature -- Status report

	destroyed: BOOLEAN is
			-- Is the current menu destroyed ?
		do
			Result := False
	--		Result := not equal (parent_imp.menu, Current)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual static menu-bar.
		do
			parent_imp.unset_menu
		end

feature {NONE} -- Implementation

	menu_container: WEL_MENU is
			-- Actual WEL container
		do
			Result := Current
		end

feature {NONE} -- Inapplicable

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
			-- do nothing here
		do
		end

end -- class EV_STATIC_MENU_BAR_IMP

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
