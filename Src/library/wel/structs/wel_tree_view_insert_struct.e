note
	description: "[
		Contains information used to add a new item to a
		tree-view control.

		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

create
	make

feature -- Access

	parent: POINTER
			-- Handle to the parent item. If this member is
			-- the Tvi_root value or NULL, the item is inserted
			-- at the root of the tree-view control.
		do
			Result := cwel_insertstruct_get_hparent (item)
		end

	insert_after: POINTER
			-- Handle to the item after which the new item is to
			-- be inserted or one of the Tvi_* values.
			-- See class WEL_TVI_CONSTANTS.
		do
			Result := cwel_insertstruct_get_hinsertafter (item)
		end

	tree_view_item: WEL_TREE_VIEW_ITEM
			-- Item to insert
		do
			create Result.make_by_pointer (cwel_insertstruct_get_item (item))
		ensure
			result_not_void: Result /= Void
		end

	user_tree_view_item: ?WEL_TREE_VIEW_ITEM
			-- The tree-item given by the user.

feature -- Element change

	set_parent (a_parent: POINTER)
			-- Set `parent' with `a_parent'.
		do
			cwel_insertstruct_set_hparent (item, a_parent)
		ensure
			parent_set: parent = a_parent
		end

	set_insert_after (a_insert_after: POINTER)
			-- Set `insert_after' with `a_insert_after'.
		do
			cwel_insertstruct_set_hinsertafter (item,
				a_insert_after)
		ensure
			insert_after_set: insert_after = a_insert_after
		end

	set_tree_view_item (a_tree_view_item: WEL_TREE_VIEW_ITEM)
			-- Set `tree_view_item' with `a_tree_view_item'.
			-- In this case, windows copy the structure we
			-- send into another structure. Therefore, we need
			-- to keep a reference on the first structure in case
			-- the user is using it.
			-- At insertion time, the h_item paremeter of both
			-- structure will be set at the good value.
		require
			a_tree_view_item_not_void: a_tree_view_item /= Void
			a_tree_view_item_exists: a_tree_view_item.exists
		do
			cwel_insertstruct_set_item (item, a_tree_view_item.item)
			user_tree_view_item := a_tree_view_item
		ensure
			user_tree_view_item_set: user_tree_view_item = a_tree_view_item
		end

	set_first
			-- Insert the item at the beginning of the list.
		do
			set_insert_after (Tvi_first)
		end

	set_last
			-- Insert the item at the end of the list.
		do
			set_insert_after (Tvi_last)
		end

	set_sort
			-- Insert the item into the list in alphabetical order.
		do
			set_insert_after (Tvi_sort)
		end

	set_root
			-- Insert the item as the root of the list.
		do
			set_parent (Tvi_root)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_insertstruct
		end

feature {NONE} -- Externals

	c_size_of_insertstruct: INTEGER
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (TV_INSERTSTRUCT)"
		end

	cwel_insertstruct_set_hparent (ptr: POINTER; value: POINTER)
		external
			"C [macro <tvinss.h>]"
		end

	cwel_insertstruct_set_hinsertafter (ptr: POINTER; value: POINTER)
		external
			"C [macro <tvinss.h>]"
		end

	cwel_insertstruct_set_item (ptr: POINTER; value: POINTER)
		external
			"C [macro <tvinss.h>]"
		end

	cwel_insertstruct_get_hparent (ptr: POINTER): POINTER
		external
			"C [macro <tvinss.h>] (TV_INSERTSTRUCT*): EIF_POINTER"
		end

	cwel_insertstruct_get_hinsertafter (ptr: POINTER): POINTER
		external
			"C [macro <tvinss.h>] (TV_INSERTSTRUCT*): EIF_POINTER"
		end

	cwel_insertstruct_get_item (ptr: POINTER): POINTER
		external
			"C [macro <tvinss.h>] (TV_INSERTSTRUCT*): EIF_POINTER"
		end

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

end
