indexing
	description: "contains information used to add a new item to a %
		%tree-view control."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to%
		% be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TREE_VIEW_INSERT_STRUCT

inherit
	WEL_STRUCTURE

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	parent: POINTER is
			-- Handle to the parent item. If this member is
			-- the Tvi_root value or NULL, the item is inserted
			-- at the root of the tree-view control.
		do
			Result := cwel_insertstruct_get_hparent (item)
		end

	insert_after: POINTER is
			-- Handle to the item after which the new item is to
			-- be inserted or one of the Tvi_* values.
			-- See class WEL_TVI_CONSTANTS.
		do
			Result := cwel_insertstruct_get_hinsertafter (item)
		end

	tree_view_item: WEL_TREE_VIEW_ITEM is
			-- Item to insert
		do
			create Result.make_by_pointer (cwel_insertstruct_get_item (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_parent (a_parent: POINTER) is
			-- Set `parent' with `a_parent'.
		do
			cwel_insertstruct_set_hparent (item, a_parent)
		ensure
			parent_set: parent = a_parent
		end

	set_insert_after (a_insert_after: POINTER) is
			-- Set `insert_after' with `a_insert_after'.
		do
			cwel_insertstruct_set_hinsertafter (item,
				a_insert_after)
		ensure
			insert_after_set: insert_after = a_insert_after
		end

	set_tree_view_item (a_tree_view_item: WEL_TREE_VIEW_ITEM) is
			-- Set `tree_view_item' with `a_tree_view_item'.
			-- In this case, windows copy the structure we
			-- send into another structure. Therefore, we need
			-- to keep a reference on the first structure in case
			-- the user is using it.
			-- At insertion time, the h_item paremeter of both
			-- structure will be set at the good value.
		do
			cwel_insertstruct_set_item (item, a_tree_view_item.item)
			user_tree_view_item := a_tree_view_item
		end

	set_first is
			-- Insert the item at the beginning of the list.
		do
			set_insert_after (Tvi_first)
		end

	set_last is
			-- Insert the item at the end of the list.
		do
			set_insert_after (Tvi_last)
		end

	set_sort is
			-- Insert the item into the list in alphabetical order.
		do
			set_insert_after (Tvi_sort)
		end

	set_root is
			-- Insert the item as the root of the list.
		do
			set_parent (Tvi_root)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_insertstruct
		end

feature {WEL_TREE_VIEW} -- Implementation

	user_tree_view_item: WEL_TREE_VIEW_ITEM
			-- The tree-item given by the user. 

feature {NONE} -- Externals

	c_size_of_insertstruct: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (TV_INSERTSTRUCT)"
		end

	cwel_insertstruct_set_hparent (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tvinss.h>]"
		end

	cwel_insertstruct_set_hinsertafter (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tvinss.h>]"
		end

	cwel_insertstruct_set_item (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tvinss.h>]"
		end

	cwel_insertstruct_get_hparent (ptr: POINTER): POINTER is
		external
			"C [macro <tvinss.h>] (TV_INSERTSTRUCT*): EIF_POINTER"
		end

	cwel_insertstruct_get_hinsertafter (ptr: POINTER): POINTER is
		external
			"C [macro <tvinss.h>] (TV_INSERTSTRUCT*): EIF_POINTER"
		end

	cwel_insertstruct_get_item (ptr: POINTER): POINTER is
		external
			"C [macro <tvinss.h>] (TV_INSERTSTRUCT*): EIF_POINTER"
		end

end -- class WEL_TREE_VIEW_INSERT_STRUCT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

