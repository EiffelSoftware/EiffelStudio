indexing
	description:
		"[
			EiffelVision tree.
		]"
	status: "See notice at end of class"
	keywords: "tree, container"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE

inherit
	EV_PRIMITIVE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_NODE_LIST
		redefine
			is_in_default_state,
			implementation
		end
		
	EV_ITEM_PIXMAP_SCALER
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

create
	default_create

feature -- Access

	selected_item: EV_TREE_NODE is
			-- Currently selected item at any level
			-- within tree hierarchy.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

feature -- Status report

	ensure_item_visible (an_item: EV_TREE_NODE) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
			item_contained: has_recursively	(an_item)
		do
			implementation.ensure_item_visible (an_item)
		end

	selected: BOOLEAN is
			-- Is an item selected in `Current' ?
		obsolete "Use selected_item /= Void instead."
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected
		end

feature -- Contract support

	is_parent_recursive (a_tree_node: EV_TREE_NODE): BOOLEAN is
			-- Is `a_tree_node' a parent of `Current'?
		do
				-- As we cannot insert a EV_TREE into a EV_TREE_NODE,
				-- it cannot be True.
			Result := False
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_TREE_NODE_LIST}
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation
	
	implementation: EV_TREE_I	
			-- Responsible for interaction with native graphics toolkit.
		
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TREE_IMP} implementation.make (Current)
		end

end -- class EV_TREE

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

