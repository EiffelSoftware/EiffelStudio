indexing
	description:
		"EiffelVision tree node. Implementation interface.";
	status: "See notice at end of class."		
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_NODE_I

inherit
	EV_ITEM_I
		rename
			parent as old_parent
		export {NONE}
			old_parent
		redefine
			interface
		select
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_TREE_NODE_LIST_I
		rename
			interface as nl_interface
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_TREE_NODE_ACTION_SEQUENCES_I

feature -- Access

	parent: EV_TREE_NODE_CONTAINER is
			-- Parent of `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
				check
					result_not_void: Result /= Void
				end
			end
		end	

	parent_tree: EV_TREE is
			-- Root tree that holds `Current'.
		local
			parent_item: EV_TREE_NODE_I
		do
			Result ?= parent
			if Result = Void and then parent /= Void then
				parent_item ?= parent.implementation
				Result := parent_item.parent_tree
			end
		end

feature -- Status report

	is_selectable: BOOLEAN is
			-- May the `Current' be selected?
		do
			Result := parent_tree /= Void
		end

	is_expanded: BOOLEAN is
			-- is `Current' expanded ?
		require
			in_tree: parent_tree /= Void
		deferred
		end

feature -- Status setting

	set_expand (flag: BOOLEAN) is
			-- Expand `Current' if `flag', otherwise collapse it.
		require
			in_tree: parent_tree /= Void
			is_expandable: count > 0
		deferred
		ensure
			state_set: is_expanded = flag
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE

end -- class EV_TREE_NODE_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

