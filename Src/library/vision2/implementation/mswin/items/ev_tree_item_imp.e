--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			parent_imp,
			interface
		select
			parent
		end

	EV_SIMPLE_ITEM_IMP
		rename
			parent as old_simple_parent
		redefine
			parent_imp,
			set_text,
			destroy,
			interface
		end

	EV_TREE_ITEM_HOLDER_IMP
		--|FIXME Where has this gone?
		--rename
		--	item_command_count as command_count
		redefine
			--add_item,
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface
		end

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			set_text as wel_set_text,
			make as wel_make,
			children as children_nb,
			item as wel_item
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
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the item.
		do
			base_make (an_interface)
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
		end

	initialize is
		do
		end

	--make_with_text (txt: STRING) is
	--		-- Create a row with text in it.
	--	do
	--		wel_make
	--		set_mask (Tvif_text + Tvif_state + Tvif_handle)
	--		set_text (txt)
	--	end

feature -- Access

	parent_imp: EV_TREE_ITEM_HOLDER_IMP
			-- Parent implementation


	--|FIXME I think this can be inherited now
	--index: INTEGER is
	--		-- Index of the current item.
	--	do
	--		Result := top_parent_imp.internal_get_index (Current) + 1
	--	end

feature -- Status report

	ev_children: ARRAYED_LIST [EV_TREE_ITEM_IMP] is
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

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
		--|FIXME what to do?
		--	if parent_imp /= Void then
		--		parent_imp.remove_item (Current)
		--		parent_imp := Void
		--	end
		--	if par /= Void then
		--		parent_imp ?= par.implementation
		--		parent_imp.add_item (Current)
		--	end
		end

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
			c := ev_children
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

	set_capture is
			-- Grab user input.
		do
			top_parent_imp.set_capture
		end

	release_capture is
			-- Release user input.
		do
			top_parent_imp.release_capture
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
					top_parent_imp.general_insert_item (item_imp, h_item, (ev_children @ (index - 1)).h_item)
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

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM

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


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.4  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.24.6.3  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.2  1999/12/17 17:29:52  rogers
--| Altered to fit in with the review branch. Make takes an interface. Now inherits from EV_PICK_AND_dROPABLE_IMP.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
