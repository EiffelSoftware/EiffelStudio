indexing
	description: "Eiffel Vision menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end
		
	EV_SIMPLE_ITEM_IMP
		redefine
			interface
		end

	EV_ID_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the menu item.
		do
			base_make (an_interface)
			make_id
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	text: STRING
			-- Caption of the menu item.

feature -- Status report

	is_sensitive: BOOLEAN is
		do
			Result := parent_imp.item_enabled (id)
		end

feature -- Status setting

	enable_sensitive is
   			-- Set current item sensitive.
		do
			parent_imp.enable_item (id)
   		end

	disable_sensitive is
   			-- Set current item insensitive.
		do
			parent_imp.disable_item (id)
   		end

feature -- Element change

	set_parent (a_parent: like parent) is
			-- Make `a_parent' the parent of the menu-item.
		do
			if a_parent /= Void then
				parent_imp ?= a_parent.implementation
			end
		end

	set_text (txt: STRING) is
			-- Set `text' to `txt'.
		do
			text := clone (txt)
			--| FIXME Change text.
		end

feature {NONE} -- Implementation

	parent_imp: EV_MENU_ITEM_LIST_IMP

feature {EV_ANY_I} -- Implementation

	on_activate is
		do
			interface.press_actions.call ([])
		end

	interface: EV_MENU_ITEM

end -- class EV_MENU_ITEM_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.28  2000/02/23 02:14:35  brendel
--| Revised. Implemented.
--|
--| Revision 1.27  2000/02/22 19:16:21  brendel
--| Added callback to interface.press_actions.
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.8  2000/02/05 02:08:06  brendel
--| Cleanup.
--| Events need to be implemented!
--|
--| Revision 1.24.6.7  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.24.6.6  2000/02/03 17:19:05  brendel
--| Implemented *sensitive features.
--|
--| Revision 1.24.6.5  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.4  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.24.6.3  1999/12/22 19:29:51  rogers
--| pixmap_size_ok is no longer undefined, as this feature no longer exists.
--|
--| Revision 1.24.6.2  1999/12/17 17:34:39  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
