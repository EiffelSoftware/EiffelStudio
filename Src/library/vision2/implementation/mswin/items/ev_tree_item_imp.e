indexing
	description:
		"EiffelVision tree item, Mswindows implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I

	EV_ITEM_IMP
		redefine
			parent
		end

	EV_TREE_ITEM_CONTAINER_IMP
		rename
			item_command_count as command_count
		end

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			set_text as wel_set_text,
			make as wel_make
		end

	WEL_TVIS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVM_CONSTANTS
		export
			{NONE} all
		end

creation
	make_with_text

feature -- Initialization

	make (par: EV_TREE_ITEM_CONTAINER) is
			-- Create a tree-item with an empty label and
			-- `par' as parent.
		do
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
			parent ?= par.implementation
		end

	make_with_text (par: EV_TREE_ITEM_CONTAINER; txt: STRING) is
			-- Create a tree-item with `txt' as label and
			-- `par' as parent.
		do
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
			parent ?= par.implementation
			set_text (txt)
		end

feature -- Access

	text: STRING
			-- Text of the item

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed
		do
			Result := not exists
		end

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			tree: WEL_TREE_VIEW
		do
			tree ?= wel_window
			Result := tree.is_selected (Current)
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		local
			tree: WEL_TREE_VIEW
		do
			tree ?= wel_window
			Result := tree.is_expanded (Current)
		end

feature -- Status setting

	destroy is
			-- Destroy the current item
		do
			destroy_item
		end

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			text := txt
			wel_set_text (txt)
		end

feature -- Event : command association

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		do
			add_command (Cmd_item_subtree, cmd, arg)
		end

feature -- Event -- removing command association

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		do
			remove_command (Cmd_item_subtree)
		end

feature {NONE} -- Implementation

	parent: EV_TREE_ITEM_CONTAINER_IMP
			-- Tree that contains the item

	add_item (an_item: EV_TREE_ITEM) is
			-- Add `item' to the list
		local
			item_imp: EV_TREE_ITEM_IMP
			insert_struct: WEL_TREE_VIEW_INSERT_STRUCT
			tree: WEL_TREE_VIEW
			ev_tree: EV_TREE_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			!! insert_struct.make
			insert_struct.set_parent (h_item)
			insert_struct.set_tree_view_item (item_imp)
			tree ?= wel_window
			tree.insert_item (insert_struct)
			item_imp.set_h_item (tree.last_item)
			ev_tree ?= wel_window
			ev_tree.ev_children.extend (item_imp, tree.last_item)
		end

end -- class EV_TREE_ITEM_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

