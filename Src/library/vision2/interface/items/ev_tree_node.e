indexing	
	description: 
		"Node for use with EV_TREE."
	status: "See notice at end of class"
	keywords: "tree, item, leaf, node, branch"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_NODE

inherit
	EV_ITEM
		rename
			parent as old_parent
		export
			{NONE} old_parent
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_DESELECTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_TOOLTIPABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_NODE_CONTAINER
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_NODE_ACTION_SEQUENCES
		redefine
			implementation
		end

feature -- Access

	parent: EV_TREE_NODE_CONTAINER is
			-- Parent of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent
		end
	
	parent_tree: EV_TREE is
			-- Contains `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent_tree
		end

	find_item_recursively_by_data (v: ANY): EV_TREE_NODE is
			-- An item at any level in tree that has `data'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.find_item_recursively_by_data (v)
		end
		
	has_recursively (an_item: like item): BOOLEAN is
			-- Does `Current' contain `an_item' at any level?
		do
			Result := implementation.has_recursively (an_item)
		end
		

feature -- Status report

	is_expanded: BOOLEAN is
			-- Are items in `Current' displayed?
		require
			not_destroyed: not is_destroyed
		do
			if parent_tree /= Void then
				Result := implementation.is_expanded	
			end
		end

feature -- Status setting

	expand is
			-- Set `is_expanded' `True'.
		require
			not_destroyed: not is_destroyed
			parent_tree_not_void: parent_tree /= Void
			is_expandable: is_expandable
		do
			implementation.set_expand (True)
		ensure
			is_expanded: is_expanded
		end

	collapse is
			-- Set `is_expanded' `False'.
		require
			not_destroyed: not is_destroyed
			parent_tree_not_void: parent_tree /= Void
			is_collapsable: is_expandable
		do
			implementation.set_expand (False)
		ensure
			not_is_expanded: not is_expanded
		end

feature -- Contract support

	is_expandable: BOOLEAN is
			-- Can `Current' be expanded and collapsed?
		require
			not_destroyed: not is_destroyed
		deferred
		end
		
feature {EV_TREE_NODE}

	is_parent_recursive (a_list: EV_TREE_NODE): BOOLEAN is
			-- Is `a_list' `parent' or recursively `parent' of `parent'?
		require
			not_destroyed: not is_destroyed
		local
			a_parent: EV_TREE_NODE
		do
			a_parent ?= parent
			Result := a_list = a_parent or else
			(a_parent /= Void and then a_parent.is_parent_recursive (a_list))
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and Precursor {EV_TEXTABLE} and
			Precursor {EV_DESELECTABLE} and Precursor {EV_TOOLTIPABLE} and
			Precursor {EV_TREE_NODE_CONTAINER} and is_expanded = False
		end

feature {EV_ANY_I}-- Implementation

	implementation: EV_TREE_NODE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_TREE_NODE

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
