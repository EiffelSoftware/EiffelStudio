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

	EV_TREE_ITEM_HOLDER_IMP
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
	make,
	make_with_text,
	make_with_pixmap,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create the item.
		do
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
		end

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

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		local
			tree: WEL_TREE_VIEW
		do
			if parent_imp /= Void then
				tree ?= wel_window
				Result := tree.is_parent (Current)
			else
				Result := False
			end
		end

feature -- Status setting

	destroy is
			-- Destroy the current item
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
--			destroy_item
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		local
			tree: EV_TREE_IMP
		do
			tree ?= parent_widget.implementation
			if flag then
				tree.select_item (Current)
			else
				tree.deselect_item (Current)
			end
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
			-- Do nothing if the item is not a sub-tree.
		local
			tree: EV_TREE_IMP
		do
			tree ?= parent_widget.implementation
			if flag then
				tree.expand_item (Current)
			else
				tree.collapse_item (Current)
			end
		end
 
feature -- Element change

	set_parent (par: EV_TREE_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				set_selected (False)
				set_mask (Tvif_handle + Tvif_text)
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_item (Current)
			end
		end

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			text := txt
			wel_set_text (txt)
		end

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item_imp' to the list
		local
			struct: WEL_TREE_VIEW_INSERT_STRUCT
			tree: WEL_TREE_VIEW
			ev_tree: EV_TREE_IMP
		do
			!! struct.make
			struct.set_parent (h_item)
			struct.set_tree_view_item (item_imp)
			tree ?= wel_window
			tree.insert_item (struct)
			ev_tree ?= wel_window
			ev_tree.ev_children.force (item_imp, tree.last_item)
			ev_tree.invalidate
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the children.
		local
			ev_tree: EV_TREE_IMP
		do
			ev_tree ?= wel_window
			ev_tree.remove_item (item_imp)
			ev_tree.invalidate
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

