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

	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface
		end

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			make as wel_make,
			children as children_nb,
			item as wel_item
		redefine
			set_text
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
			-- Do post creation initialization.
		do
			create internal_children.make (1)
			create ev_children.make (1)
			is_initialized := True
		end

feature -- Access

	parent_imp: EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
			-- Parent implementation

	text: STRING


	top_parent_imp: EV_TREE_IMP is
			-- Implementation of `parent_tree'.
		do
			if parent_tree /= Void then
				Result ?= parent_tree.implementation
				check
					parent_tree_not_void: Result /= Void
				end
			end
		end

feature -- Status report

	ev_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- List of the direct children of the tree-item.

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			--if top_parent_imp = Void then
			--	Result := internal_children.count
			--else
			--	Result := top_parent_imp.get_children_count (Current)
			--end
			Result := ev_children.count
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
			if par /= Void then
				parent_imp ?= par.implementation
			else
				parent_imp := Void
			end
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
			text := clone (txt)
			Precursor (txt)
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

--|FIXME	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when the item is activated.
--|FIXME		do
--|FIXME			add_command (Cmd_item_activate, cmd, arg)			
--|FIXME		end	

--|FIXME	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when the item is unactivated.
--|FIXME		do
--|FIXME			add_command (Cmd_item_deactivate, cmd, arg)		
--|FIXME		end

--|FIXME	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when the selection subtree is expanded or collapsed.
--|FIXME		do
--|FIXME			add_command (Cmd_item_subtree, cmd, arg)
--|FIXME		end

--|FIXME	add_button_press_command (mouse_button: INTEGER; 
--|FIXME		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when button number 'mouse_button' is pressed.
--|FIXME		do
--|FIXME			inspect mouse_button 
--|FIXME			when 1 then
--|FIXME				add_command (Cmd_button_one_press, cmd, arg)
--|FIXME			when 2 then
--|FIXME				add_command (Cmd_button_two_press, cmd, arg)
--|FIXME			when 3 then
--|FIXME				add_command (Cmd_button_three_press, cmd, arg)
--|FIXME			end
--|FIXME		end

--|FIXME	add_button_release_command (mouse_button: INTEGER;
--|FIXME		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when button number 'mouse_button' is released.
--|FIXME		do
--|FIXME			inspect mouse_button
--|FIXME			when 1 then
--|FIXME				add_command (Cmd_button_one_release, cmd, arg)
--|FIXME			when 2 then
--|FIXME				add_command (Cmd_button_two_release, cmd, arg)
--|FIXME			when 3 then
--|FIXME				add_command (Cmd_button_three_release, cmd, arg)
--|FIXME			end
--|FIXME		end

feature -- Event -- removing command association

--|FIXME	remove_select_commands is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- the item is activated.
--|FIXME		do
--|FIXME			remove_command (Cmd_item_activate)			
--|FIXME		end	

--|FIXME	remove_unselect_commands is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- the item is deactivated.
--|FIXME		do
--|FIXME			remove_command (Cmd_item_deactivate)		
--|FIXME		end

--|FIXME	remove_subtree_commands is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- the selection subtree is expanded or collapsed.
--|FIXME		do
--|FIXME			remove_command (Cmd_item_subtree)
--|FIXME		end

--|FIXME	remove_button_press_commands (mouse_button: INTEGER) is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- button number 'mouse_button' is pressed.
--|FIXME		do
--|FIXME			inspect mouse_button 
--|FIXME			when 1 then
--|FIXME				remove_command (Cmd_button_one_press)
--|FIXME			when 2 then
--|FIXME				remove_command (Cmd_button_two_press)
--|FIXME			when 3 then
--|FIXME				remove_command (Cmd_button_three_press)
--|FIXME			end
--|FIXME		end

--|FIXME	remove_button_release_commands (mouse_button: INTEGER) is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- button number 'mouse_button' is released.
--|FIXME		do
--|FIXME			inspect mouse_button 
--|FIXME			when 1 then
--|FIXME				remove_command (Cmd_button_one_release)
--|FIXME			when 2 then
--|FIXME				remove_command (Cmd_button_two_release)
--|FIXME			when 3 then
--|FIXME				remove_command (Cmd_button_three_release)
--|FIXME			end
--|FIXME		end

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
				top_parent_imp.general_insert_item (item_imp, h_item, Tvi_last, index)
			else
				internal_children.extend (item_imp)
			end
		end

	insert_item (item_imp: EV_TREE_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' at the `index' position.
		do
			if top_parent_imp /= Void then
				if pos = 1 then
					top_parent_imp.general_insert_item (item_imp, h_item, Tvi_first, pos)
				else
					top_parent_imp.general_insert_item (item_imp, h_item, (ev_children @ (pos - 1)).h_item, pos)
				end
			else
				internal_children.go_i_th (pos)
				internal_children.put_left (item_imp)
			end
				-- We now add the child directly into ev_children.
			ev_children.go_i_th (pos - 1)
			ev_children.put_right (item_imp)

		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the children.
		do
			if top_parent_imp /= Void then
				top_parent_imp.general_remove_item (item_imp)
				ev_children.remove
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
--| Revision 1.33  2000/03/09 17:28:33  rogers
--| Removed redundent commented code. Insert item now uses pos - 1 correctly, instead of index when the insertion position is not one.
--|
--| Revision 1.31  2000/03/08 17:33:44  rogers
--| Set_text from WEL_TREE_VIEW is now redefined. Redundent make_with_text has been removed. Set text now sets the text to a clone of the passed text. All calls to general_insert_item now take an index.
--|
--| Revision 1.30  2000/03/07 17:43:18  rogers
--| Now inherits from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM] instead of EV_TREE_ITEM_HOLDER_IMP. The same type change has been implemented for parent_imp, and insert item now takes EV_TREE_ITEM_IMP instead of like item_type.
--|
--| Revision 1.29  2000/03/06 21:10:21  rogers
--| Is_initialized is now set to true in initialization, and internal_children is created. Re-implemented parent_imp.
--|
--| Revision 1.28  2000/03/06 19:07:22  rogers
--| Added text and also top_parent_imp which returns the implementation of parent_tree. Set text no longer calls the EV_SIMPLE_ITEM_IMP Precursor.
--|
--| Revision 1.27  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
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
