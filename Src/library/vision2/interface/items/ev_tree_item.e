indexing	
	description: 
		"[
			Item for use with EV_TREE.
			A tree item is also a tree-item container because if
			we create a tree-item with a tree-item as parent, the
			parent will become a subtree.
		]"
	status: "See notice at end of class"
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
		
feature {EV_ANY_I}-- Implementation

	implementation: EV_TREE_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_TREE_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

