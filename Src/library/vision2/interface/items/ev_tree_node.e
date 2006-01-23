indexing	
	description: 
		"[
			Node for use with EV_TREE.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tree, item, leaf, node, branch"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_NODE

inherit
	EV_ITEM
		undefine
			is_equal, parent
		redefine
			implementation,
			is_in_default_state
		end
		
	EV_TREE_NODE_LIST
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXTABLE
		undefine
			initialize,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_DESELECTABLE
		undefine
			initialize,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TOOLTIPABLE
		undefine
			initialize,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_TREE_NODE_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

feature -- Access

	parent: EV_TREE_NODE_LIST is
			-- Parent of `Current'.
		do
			Result := implementation.parent
		end
	
	parent_tree: EV_TREE is
			-- Contains `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent_tree
		ensure
			bridge_ok: Result = implementation.parent_tree
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
		
	is_parent_recursive (a_list: EV_TREE_NODE): BOOLEAN is
			-- Is `a_list' `parent' or recursively `parent' of `parent'?
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
			Precursor {EV_TREE_NODE_LIST} and is_expanded = False
		end

feature {EV_ANY, EV_ANY_I}-- Implementation

	implementation: EV_TREE_NODE_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_TREE_NODE

