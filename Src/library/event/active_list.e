indexing
	description:
		"Sequential, one-way linked lists that call an action %N%
		%sequence when an item is removed or added."
	status: "See notice at end of class"
	keywords: "event, action, linked, list"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_LIST [G]

inherit
	INTERACTIVE_LIST [G]
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize
		do
			Precursor
			create add_actions.make ("add", <<"item">>)
			create remove_actions.make ("remove", <<"item">>)
			create added_actions.make ("added", <<"item">>)
			create removed_actions.make ("removed", <<"item">>)
		end

feature -- Access

	add_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item is about to be added.

	added_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item has just been added.

	remove_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item is about to be removed.

	removed_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item has just been removed.

feature -- Miscellaneous

	on_item_added (an_item: G) is
			-- `an_item' is about to be added.
		do
			add_actions.call ([an_item])
		end

	on_item_already_added (an_item: G) is
			-- `an_item' is about to be added.
		do
			added_actions.call ([an_item])
		end

	on_item_removed (an_item: G) is
			-- `an_item' is about to be removed.
		do
			remove_actions.call ([an_item])
		end

	on_item_already_removed (an_item: G) is
			-- `an_item' is about to be removed.
		do
			removed_actions.call ([an_item])
		end

invariant
	add_actions_not_void: add_actions /= Void
	remove_actions_not_void: remove_actions /= Void
	added_actions_not_void: added_actions /= Void
	removed_actions_not_void: removed_actions /= Void

end -- class ACTIVE_LIST

--!-----------------------------------------------------------------------------
--! EiffelEvent: library of reusable components for ISE Eiffel.
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
--| Revision 1.5  2000/06/15 03:30:37  pichery
--| Added 2 new actions: These actions are called
--| once the items are added/removed. The other
--| actions are now called BEFORE the items are
--| added/removed.
--|
--| Revision 1.4  2000/03/23 16:42:58  brendel
--| Now inherits new class INTERACTIVE_LIST.
--|
--| Revision 1.3  2000/01/25 18:19:29  oconnor
--| added keywords and Contract support feature heading
--|
--| Revision 1.2  2000/01/25 16:55:08  brendel
--| Minor bug fixes.
--|
--| Revision 1.1  2000/01/25 16:27:40  brendel
--| Initial.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
