--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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

create
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
		do
			if implementation.parent_imp /= Void then
				Result ?= implementation.parent_imp.interface
			else
				Result := Void
			end
		end

feature -- Status setting

	show is
			-- Show the popup menu at the current position
			-- of the mouse.
			-- Nothing appears if the menu is empty.
		require
			valid_parent: is_valid (parent)
		do
			implementation.show
		end

	show_at_position (x, y: INTEGER) is
			-- Show the popup menu at the given position
			-- Nothing appears if the menu is empty.
		require
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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.4  2000/02/04 19:57:52  oconnor
--| unreleased
--|
--| Revision 1.7.6.3  2000/01/28 22:24:26  oconnor
--| released
--|
--| Revision 1.7.6.2  2000/01/27 19:30:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.7.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
