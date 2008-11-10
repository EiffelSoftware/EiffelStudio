indexing
	description: "[
		Sequential, one-way linked lists that call an action
		sequence when an item is removed or added.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, linked, list"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_LIST [G]

inherit
	INTERACTIVE_LIST [G]
		redefine
			default_create,
			make_filled,
			on_item_added_at,
			on_item_removed_at
		end

create
	default_create

create {ACTIVE_LIST}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Initialize
		do
			create add_actions
			create remove_actions
			Precursor {INTERACTIVE_LIST}
		end

	make_filled (n: INTEGER) is
			-- <Precursor>
		do
			create add_actions
			create remove_actions
			Precursor {INTERACTIVE_LIST} (n)
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
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ACTIVE_LIST

