indexing	
	description: 
		"Item for use with EV_TREE.%N%
		%A tree item is also a tree-item container because if%
		%we create a tree-item with a tree-item as parent, the%
		%parent will become a subtree."
	status: "See notice at end of class"
	keywords: "tree, item, leaf, node, branch"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM

inherit
	EV_TREE_NODE
		undefine
			off,
			index_of,
			search,
			changeable_comparison_criterion,
			occurrences,
			has,
			initialize,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_NODE_LIST
		redefine
			implementation,
			is_in_default_state
		select
			parent
		end

create
	default_create,
	make_with_text

feature -- Contract support

	is_expandable: BOOLEAN is
			-- Is `Current' able to expand or collapse.
		do
			Result := count > 0
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TREE_NODE} and Precursor {EV_TREE_NODE_LIST} 
		end
		
feature {EV_ANY_I}-- Implementation

	implementation: EV_TREE_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_TREE_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
