note
	description:
		"EiffelVision tree node. Implementation interface."
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_NODE_I

inherit
	EV_ITEM_I
		redefine
			interface,
			pixmap_equal_to,
			parent
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

	parent: detachable EV_TREE_NODE_LIST
			-- Parent of `Current'.
		do
			if attached parent_imp as l_parent_imp then
				Result ?= l_parent_imp.interface
			end
		end

	parent_tree: detachable EV_TREE
			-- Root tree that holds `Current'.
		local
			parent_item: detachable EV_TREE_NODE_I
		do
			Result ?= parent
			if Result = Void and then attached parent as l_parent then
				parent_item ?= l_parent.implementation
				check parent_item /= Void end
				Result := parent_item.parent_tree
			end
		end

	parent_tree_i: detachable EV_TREE_I
			-- Root tree that holds `Current'.
		do
			Result ?= parent_imp
			if Result = Void and then attached {EV_TREE_NODE_I} parent_imp as l_parent_imp then
				Result := l_parent_imp.parent_tree_i
			end
		end

feature -- Status report

	is_selectable: BOOLEAN
			-- May the `Current' be selected?
		do
			Result := parent_tree_i /= Void
		end

	is_expanded: BOOLEAN
			-- is `Current' expanded ?
		require
			in_tree: parent_tree_i /= Void
		deferred
		end

feature {EV_TREE_NODE} -- Status setting

	set_expand (flag: BOOLEAN)
			-- Expand `Current' if `flag', otherwise collapse it.
		deferred
		ensure
			state_set: is_expanded = flag
		end

feature -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
		do
			if attached parent_tree_i as l_parent_tree then
				scaled_pixmap := a_pixmap.twin
				scaled_pixmap.stretch (l_parent_tree.pixmaps_width, l_parent_tree.pixmaps_height)
			else
				scaled_pixmap := a_pixmap
			end
			if attached pixmap as l_pixmap then
				Result := scaled_pixmap.is_equal (l_pixmap)
			end
		end

feature {EV_ANY_I, EV_DYNAMIC_TREE_ITEM} -- Implementation

	ensure_expandable
			-- Ensure `Current' is displayed as expandable.
		require
			is_empty: attached_interface.is_empty
		deferred
		ensure
			is_empty: attached_interface.is_empty
		end

	remove_expandable
			-- Ensure `Current' is no longer displayed as expandable.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TREE_NODE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TREE_NODE_I










