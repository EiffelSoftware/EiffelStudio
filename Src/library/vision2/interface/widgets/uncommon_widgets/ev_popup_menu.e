indexing
	description: 
		"EiffelVision popup menu. A popup menu can appear%
		 %anywhere in the window. It contains menus."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_MENU

inherit
	EV_ANY
		redefine
			implementation
		end

	EV_MENU_ITEM_HOLDER
		redefine
			implementation
		end

creation
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create an empty popup menu with `par' as parent.
		do
			!EV_POPUP_MENU_IMP!implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end	

feature -- Access

	parent: EV_CONTAINER is
			-- Parent of the popup.
		require
			exists: not destroyed
		do
			Result := implementation.parent
		end

feature -- Status setting

	show_at_position (x, y: INTEGER) is
			-- Show the popup menu at the given position
		require
			exists: not destroyed
			valid_parent: is_valid (parent)
		do
			implementation.show_at_position (x, y)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the popup.
		do
			implementation.set_parent (par)
		end

feature {NONE} -- Implementation
	
	implementation: EV_POPUP_MENU_I	

end -- class EV_POPUP_MENU

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
