indexing	
	description: 
		"[
			Item for use with EV_TREE.
			A tree item is also a tree-item container because if
			we create a tree-item with a tree-item as parent, the
			parent will become a subtree.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tree, item, leaf, node, branch"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM

inherit
	EV_TREE_NODE
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text

feature -- Contract support

	is_expandable: BOOLEAN is
			-- Is `Current' able to expand or collapse.
		do
			Result := parent_tree /= Void and count > 0
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TREE_NODE}
		end
		
feature {EV_ANY, EV_ANY_I}-- Implementation

	implementation: EV_TREE_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_ITEM_IMP} implementation.make (Current)
		end

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




end -- class EV_TREE_ITEM

