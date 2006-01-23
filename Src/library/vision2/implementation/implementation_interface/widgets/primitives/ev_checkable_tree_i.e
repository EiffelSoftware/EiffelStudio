indexing
	description:
		"[
			A tree which displays a check box to left
			hand side of each item contained. Implementation interface.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHECKABLE_TREE_I
	
inherit
	EV_TREE_I
		redefine
			interface
		end
		
	EV_TREE_ACTION_SEQUENCES_I
	
	EV_CHECKABLE_TREE_ACTION_SEQUENCES_I
	
feature -- Access

	checked_items: ARRAYED_LIST [EV_TREE_NODE] is
			-- All items checked in `Current'.
		do
			create Result.make (4)
			recursive_do_all (agent get_state (?, Result))
		ensure
			result_not_void: Result /= Void
		end

	is_item_checked (tree_item: EV_TREE_NODE): BOOLEAN is
			-- Is `tree_item' currently checked?
		require
		--	has_an_item: has_recursively (tree_item)
		deferred
		end

feature -- Status setting

	check_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		require
--			has_an_item: has_recursively (tree_item)
		deferred
		ensure
			item_is_checked: is_item_checked (tree_item)
		end


	uncheck_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- unchecked.
		require
--			has_an_item: has_recursively (tree_item)
		deferred
		ensure
			not_item_is_checked: not is_item_checked (tree_item)
		end

feature {NONE} -- Implementation

	get_state (node: EV_TREE_NODE; list: ARRAYED_LIST [EV_TREE_NODE]) is
			-- Add `node' to `list' if `node' is currently checked.
		require
			node_not_void: node /= Void
			list_not_void: list /= Void
		do
			if is_item_checked (node) then
				list.extend (node)
			end
		ensure
			checked_item_increases_count: is_item_checked (node) implies list.count = old list.count + 1
		end
	
feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_TREE;

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




end -- class EV_CHECKABLE_TREE_I
