indexing
	description:
	"[
			A tree which displays a check box to left
			hand side of each item contained.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE
	
inherit
	EV_TREE
		redefine
			implementation,
			create_implementation
		end
		
	EV_CHECKABLE_TREE_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

feature -- Access

	checked_items: DYNAMIC_LIST [EV_TREE_NODE] is
			-- All items checked in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.checked_items	
		ensure
			bridge_ok: lists_equal (Result, implementation.checked_items)
		end
		
	is_item_checked (tree_item: EV_TREE_NODE): BOOLEAN is
			-- Is `tree_item' currently checked?
		require
			not_destroyed: not is_destroyed
			has_an_item: has_recursively (tree_item)
		do
			Result := implementation.is_item_checked (tree_item)
		end

feature -- Status setting

	check_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		require
			not_destroyed: not is_destroyed
			has_an_item_recursively: has_recursively (tree_item)
		do
			implementation.check_item (tree_item)
		ensure
			item_is_checked: is_item_checked (tree_item)
		end
		
	uncheck_item (tree_item: EV_TREE_NODE) is
			-- Ensure `tree_item' is not checked.
		require
			not_destroyed: not is_destroyed
			has_an_item: has_recursively (tree_item)
		do
			implementation.uncheck_item (tree_item)
		ensure
			item_is_not_checked: not is_item_checked (tree_item)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_CHECKABLE_TREE_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CHECKABLE_TREE_IMP} implementation.make (Current)
		end

invariant
	checked_items_not_void: is_usable implies checked_items /= Void
	checked_items_consistent: checked_items.for_all (agent is_item_checked)
	checked_items_valid: checked_items.count >= 0 and checked_items.count <= count

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




end -- class EV_CHECKABLE_TREE
