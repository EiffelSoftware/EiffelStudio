indexing
	description: "Eiffel Vision list item list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_ITEM_LIST_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_LIST_ITEM]
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_I

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- `Result' is currently selected item.
			-- Topmost selected item if multiple items are selected.
		deferred
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at one based index, `an_index'.
		require
			index_within_range: an_index > 0 and an_index <= count
		deferred
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at one based index, `an_index'.
		require
			index_within_range: an_index > 0 and an_index <= count
		deferred
		end

	clear_selection is
			-- Ensure there is no `selected_item' in `Current'.
		deferred
		end

feature {EV_LIST_ITEM_LIST_I, EV_LIST_ITEM_IMP} -- Implementation

	interface: EV_LIST_ITEM_LIST

end -- class EV_LIST_ITEM_LIST_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.3  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.4  2000/10/27 02:28:21  manus
--| Removed declaration or undefinition of `set_default_colors'. Now it is defined
--| in a platform dependent manner to improve performance and correctness.
--|
--| Revision 1.1.2.3  2000/08/17 23:44:45  rogers
--| removed fixme not_reviewed. Comments, formatting.
--|
--| Revision 1.1.2.2  2000/07/24 21:30:48  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.1.2.1  2000/05/10 19:00:17  king
--| Initial
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
