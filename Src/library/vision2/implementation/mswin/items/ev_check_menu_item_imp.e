indexing	
	description: 
		"EiffelVision check menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			on_activate,
			interface,
			initialize
		end
	
create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize with state not `is_selected'.
		do
			Precursor
			is_selected := False
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			is_selected := True
			if has_parent then
				parent_imp.check_item (id)
			end
		end

	disable_select is
		do
			is_selected := False
			if has_parent then
				parent_imp.uncheck_item (id)
			end
		end

feature {NONE} -- Implementation

	on_activate is
			-- Invert the state and call `Precursor'.
		do
			interface.toggle
			Precursor
		end

	interface: EV_CHECK_MENU_ITEM

end -- class EV_CHECK_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

