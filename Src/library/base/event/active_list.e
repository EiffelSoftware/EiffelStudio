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
			default_create,
			on_item_added,
			on_item_removed
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize
		do
			Precursor
			create add_actions.make
			create remove_actions.make
		end

feature -- Access

	add_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item has just been added.

	remove_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions performed when an item has just been removed.

feature -- Miscellaneous

	on_item_added (an_item: G) is
			-- `an_item' has just been added.
		do
			add_actions.call ([an_item])
		end

	on_item_removed (an_item: G) is
			-- `an_item' has just been removed.
		do
			remove_actions.call ([an_item])
		end

invariant
	add_actions_not_void: add_actions /= Void
	remove_actions_not_void: remove_actions /= Void

end -- class ACTIVE_LIST

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
