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
		undefine
			on_draw_menu_item_left_part
		redefine
			on_activate,
			interface,
			initialize
		end
		
	EV_CHECKABLE_MENU_ITEM_IMP
	
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

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECK_MENU_ITEM
	
feature {NONE} -- Implementation

	on_activate is
			-- Invert the state and call `Precursor'.
		do
			interface.toggle
			Precursor
		end

	check_mark_bitmap_constant: INTEGER is
			-- Constant coding for the check mark used in Current.
		do
			Result := Wel_drawing_constants.Dfcs_menucheck
		end

end -- class EV_CHECK_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

