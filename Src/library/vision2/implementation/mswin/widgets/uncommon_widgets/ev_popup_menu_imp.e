indexing
	description: 
		"EiffelVision popup menu. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_POPUP_MENU_IMP

inherit
	EV_POPUP_MENU_I

	EV_MENU_ITEM_HOLDER_IMP
	
	WEL_MENU
		rename
			make as wel_make
		end

creation
	make
	
feature {NONE} -- Initialization
	
	make is         
			-- Create an empty popup menu.
		do
			make_track
		end	

feature -- Access

	parent: EV_CONTAINER is
			-- Parent of the popup.
		do
			Result ?= parent_imp.interface
		end

	parent_imp: EV_CONTAINER_IMP
			-- Implementation of the parent.

	submenu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		do
			Result := Current
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is the current menu destroyed ?
		do
			Result := not exists
		end

feature -- Status setting

	destroy is
			-- Destroy the actual static menu-bar.
		do
			destroy_item
		end

	show_at_position (x, y: INTEGER) is
			-- Show the popup menu at the given position relatively
			-- to the parent position.
		local
			ww: WEL_COMPOSITE_WINDOW
			point: WEL_POINT
		do
			ww ?= parent_imp
			!! point.make (x, y)
			point.client_to_screen (ww)
			show_track (point.x, point.y, ww)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the popup.
		do
			parent_imp ?= par.implementation
			ev_children := parent_imp.menu_items
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
			check
				Inapplicable: True
			end
		end

end -- class EV_POPUP_MENU_IMP

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
