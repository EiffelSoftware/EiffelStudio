indexing
	description: 
		"EiffelVision popup menu, implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POPUP_MENU_I

inherit
	EV_ANY_I

	EV_MENU_ITEM_HOLDER_I 

feature -- Access

	parent_imp: EV_CONTAINER_IMP is
			-- Implementation of the parent.
		deferred
		end

feature -- Status setting

	show is
			-- Show the popup menu at the current position
			-- of the mouse.
		require
			exists: not destroyed
			valid_parent: parent_imp /= Void
		deferred
		end

	show_at_position (x, y: INTEGER) is
			-- Show the popup menu at the given position
		require
			exists: not destroyed
			valid_parent: parent_imp /= Void
		deferred
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the popup.
		deferred
		end

end -- class EV_POPUP_MENU_I

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

