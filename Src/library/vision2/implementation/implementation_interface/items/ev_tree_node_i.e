indexing
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

	parent: EV_TREE_NODE_LIST is
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
		
feature -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
		do
			if parent_tree /= Void then
				scaled_pixmap := a_pixmap.TWIN
				scaled_pixmap.stretch (parent_tree.pixmaps_width, parent_tree.pixmaps_height)
			else
				scaled_pixmap := a_pixmap
			end
			Result := scaled_pixmap.is_equal (pixmap)
		end
		
feature {EV_ANY_I, EV_DYNAMIC_TREE_ITEM} -- Implementation

	ensure_expandable is
			-- Ensure `Current' is displayed as expandable.
		require
			is_empty: interface.is_empty
		deferred
		ensure
			is_empty: interface.is_empty
		end
		
	remove_expandable is
			-- Ensure `Current' is no longer displayed as expandable.
		deferred
		end

feature {EV_ANY_I, EV_DYNAMIC_TREE_ITEM} -- Implementation

	interface: EV_TREE_NODE;

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




end -- class EV_TREE_NODE_I

