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

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE

end -- class EV_TREE_NODE_I

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

