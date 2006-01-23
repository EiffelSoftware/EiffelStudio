indexing
	description:
		"Cursor for Eiffel Vision dynamic lists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, list, cursor"
	date: "$Date$"
	revision: "$Revision$"

class
	 EV_DYNAMIC_LIST_CURSOR [G]

inherit
	CURSOR

create
	make,
	make_with_item

feature {NONE}--EV_DYNAMIC_LIST_I} -- Initialization

	make (current_item: G; before_state, after_state: BOOLEAN) is
			-- Create a cursor pointing to `current_item'.
			-- When `current_item' Void, must be before or after.
		require
			item_void_equals_before_or_after:
				(current_item = Void) = (before_state or after_state)
		do
			item := current_item
			after := after_state
			before := before_state
		ensure
			item_assigned: item = current_item
			after_assigned: after = after_state
			before_assigned: before = before_state
		end

	make_with_item (an_item: G) is
			-- Create a cursor pointing to `an_item'.
		require
			an_item_not_void: an_item /= Void
		do
			item := an_item
		ensure
			item_assigned: item = an_item
			not_after: not after
			not_before: not before
		end

feature {EV_DYNAMIC_LIST_I, EV_TABLE_I} -- Access

	item: G
		-- Item `Current' points to.

	after: BOOLEAN
		-- When `item' Void, is list `after'?

	before: BOOLEAN
		-- When `item' Void, is list `before'?

invariant
	item_void_equals_before_or_after: (item = Void) = (before or after)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DYNAMIC_LIST_CURSOR

