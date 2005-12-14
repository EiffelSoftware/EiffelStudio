indexing
	description: "[
		Sequential, one-way linked lists that call an action
		sequence when an item is removed or added.
		]"
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
			on_item_added_at,
			on_item_removed_at
		end

create
	default_create

create {ACTIVE_LIST}
	array_make,
	make,
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Initialize
		do
			Precursor {INTERACTIVE_LIST}
			create add_actions
			create remove_actions
		end

feature -- Access

	add_actions: ACTION_SEQUENCE [TUPLE [like item]]
			-- Actions performed when an item has just been added.

	remove_actions: ACTION_SEQUENCE [TUPLE [like item]]
			-- Actions performed when an item has just been removed.

feature -- Miscellaneous

	on_item_added_at (an_item: like item; item_index: INTEGER) is
			-- `an_item' has just been added at index `item_index'.
		local
			a_cursor: CURSOR
		do
			a_cursor := cursor
			add_actions.call ([an_item])
			go_to (a_cursor)
		end

	on_item_removed_at (an_item: like item; item_index: INTEGER) is
			-- `an_item' has just been removed at index `item_index'.
		local
			a_cursor: CURSOR
		do
			a_cursor := cursor
			remove_actions.call ([an_item])
			go_to (a_cursor)
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end
		
invariant
	add_actions_not_void: add_actions /= Void
	remove_actions_not_void: remove_actions /= Void

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ACTIVE_LIST

