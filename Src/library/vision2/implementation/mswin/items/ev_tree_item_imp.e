indexing
	description:
		"EiffelVision tree item, Mswindows implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		redefine
			parent_imp
		end

	EV_SIMPLE_ITEM_IMP
		redefine
			parent_imp,
			set_text,
			destroy
		end

	EV_TREE_ITEM_HOLDER_IMP
		rename
			item_command_count as command_count
		redefine
			add_item
		end

	EV_PND_SOURCE_IMP

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			set_text as wel_set_text,
			make as wel_make,
			children as children_nb
		end

	WEL_TVIS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVM_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the item.
		do
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
		end

	make_with_text (txt: STRING) is
			-- Create a row with text in it.
		do
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
			set_text (txt)
		end

feature -- Access

	parent_imp: EV_TREE_ITEM_HOLDER_IMP
			-- Parent implementation

	index: INTEGER is
			-- Index of the current item.
		do
			Result := top_parent_imp.internal_get_index (Current) + 1
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed
		do
			Result := not exists
		end

	children: ARRAYED_LIST [EV_TREE_ITEM_IMP] is
			-- List of the direct children of the tree-item.
		do
			if top_parent_imp = Void then
				Result := internal_children
			else
				Result := top_parent_imp.get_children (Current)
			end
		end

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			if top_parent_imp = Void then
				Result := internal_children.count
			else
				Result := top_parent_imp.get_children_count (Current)
			end
		end

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			Result := top_parent_imp.is_selected (Current)
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := top_parent_imp.is_expanded (Current)
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		do
			if top_parent_imp /= Void then
				Result := top_parent_imp.is_parent (Current)
			else
				Result := (internal_children /= Void) and then (internal_children.count > 0)
			end
		end

feature -- Status setting

	destroy is
			-- Destroy the current item
		do
			{EV_SIMPLE_ITEM_IMP} Precursor
			internal_children := Void
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				top_parent_imp.select_item (Current)
			else
				top_parent_imp.deselect_item (Current)
			end
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		do
			if flag then
				top_parent_imp.expand_item (Current)
			else
				top_parent_imp.collapse_item (Current)
			end
		end
 
feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		local
			tree: EV_TREE_IMP
		do
			-- First we set localy the text
			set_mask (Tvif_text)
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			wel_set_text (txt)

			-- Then, we update the graphical tree.
			tree := top_parent_imp
			if tree /= Void then
				tree.notify_item_info (Current)
			end
		end

	clear_items is
			-- Clear all the children of the tree-item.
			-- It destroys them.
		local
			c: ARRAYED_LIST [EV_TREE_ITEM_IMP]
		do
			c := children
			from
				c.start
			until
				c.after
			loop
				c.item.destroy
				c.forth
			end
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		do
			add_command (Cmd_item_subtree, cmd, arg)
		end

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				add_command (Cmd_button_one_press, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_press, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_press, cmd, arg)
			end
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		do
			inspect mouse_button
			when 1 then
				add_command (Cmd_button_one_release, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_release, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_release, cmd, arg)
			end
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			remove_command (Cmd_item_activate)			
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do
			remove_command (Cmd_item_deactivate)		
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		do
			remove_command (Cmd_item_subtree)
		end

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_press)
			when 2 then
				remove_command (Cmd_button_two_press)
			when 3 then
				remove_command (Cmd_button_three_press)
			end
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_release)
			when 2 then
				remove_command (Cmd_button_two_release)
			when 3 then
				remove_command (Cmd_button_three_release)
			end
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := top_parent_imp
		end

feature {EV_TREE_IMP} -- Implementation

	internal_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- Void if there is a parent, store the children
			-- otherwise.

	set_internal_children (list: ARRAYED_LIST [EV_TREE_ITEM_IMP]) is
			-- Make `list' the new list of children
		do
			internal_children := list
		end

feature {NONE} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item_imp' to the list
		do
			if top_parent_imp /= Void then
				top_parent_imp.general_insert_item (item_imp, h_item, Tvi_last)
			else
				internal_children.extend (item_imp)
			end
		end

	insert_item (item_imp: like item_type; pos: INTEGER) is
			-- Insert `item_imp' at the `index' position.
		do
			if top_parent_imp /= Void then
				if index = 1 then
					top_parent_imp.general_insert_item (item_imp, h_item, Tvi_first)
				else
					top_parent_imp.general_insert_item (item_imp, h_item, (children @ (index - 1)).h_item)
				end
			else
				internal_children.go_i_th (pos)
				internal_children.put_left (item_imp)
			end
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the children.
		do
			if top_parent_imp /= Void then
				top_parent_imp.general_remove_item (item_imp)
			else
				internal_children.prune_all (item_imp)
			end
		end

end -- class EV_TREE_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

