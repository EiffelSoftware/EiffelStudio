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
	EV_POPUP_MENU_IMP

inherit
	EV_POPUP_MENU_I

	EV_MENU_ITEM_HOLDER_IMP

create
	make
	
feature {NONE} -- Initialization
	
	make is         
			-- Create an empty popup menu with `par' as parent.
		do
			check
				To_be_implemented: False
			end
		end	

feature -- Access

	parent: EV_CONTAINER is
			-- Parent of the popup.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Status setting

	show_at_position (x_coord, y_coord: INTEGER) is
			-- Show the popup menu at the given position
		do
			check
				To_be_implemented: False
			end
		end

feature -- Element change
	
	add_menu (menu_imp: EV_MENU_IMP) is
			-- Add `menu_imp' in the container.
		do
			check
				To_be_implemented: False
			end
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove `menu_imp' from the container.
		do
			check
				To_be_implemented: False
			end
		end

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		do
			check
				To_be_implemented: False
			end
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		do
			check
				To_be_implemented: False
			end
		end

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the popup.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
			-- (Remove them from the popup menu and destroy them).
		do
			check
				To_be_implemented: False
			end
		end

end -- class EV_POPUP_MENU_IMP

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
--| Revision 1.8  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.4  2000/02/04 19:57:52  oconnor
--| unreleased
--|
--| Revision 1.6.6.3  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.6.6.2  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:00  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
