--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision menu separator, mswindows implemenatation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		redefine
			--parent_imp,
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			--parent_imp,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `an_interface'.
		do
			base_make (an_interface)
		end

--	initialize is
--		do
--		end

feature -- Access

	--parent_imp: EV_MENU_ITEM_LIST_IMP

--	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
--		do
	
--			if parent_imp /= Void then
--				parent_imp.remove_separator (Current)
--				parent_imp := Void
--			end
--			if par /= Void then
--				parent_imp ?= par.implementation
--				parent_imp.add_separator (Current)
--			end
--		end

	index: INTEGER is
			-- Index of the current item.
		do
		--	Result := parent_imp.internal_get_index (Current)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_SEPARATOR

end -- class EV_MENU_SEPARATOR_IMP

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
--| Revision 1.2  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.6  2000/02/05 02:09:41  brendel
--| Works now.
--| Needs cleanup.
--|
--| Revision 1.1.10.5  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.1.10.4  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.1.10.3  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.2  1999/12/17 17:33:46  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.1.10.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
