indexing
	description:
		"EiffelVision tree-item, gtk implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
	
	EV_SIMPLE_ITEM_IMP
		export {NONE}
			box
		redefine
			make,
			has_parent,
			set_pixmap,
			unset_pixmap,
			set_text,
			text,
			destroy,
			destroyed,
			dispose
		end

	EV_TREE_ITEM_HOLDER_IMP

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create an item with an empty name.
		do
			-- Set the text to "".
			text := ""

			-- Creating the array which will contain the tree_items.
			create ev_children.make (0)

			-- Set `destroyed' to False
			destroyed := False

			-- Create the argument list for the callback functions arguments.
			create argument_array.make (1, command_count)
		end
	
	make_with_index (par: EV_TREE_ITEM_HOLDER; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		do
			make

			-- set `par' as parent and put the item at the given position.
			set_parent (par)
			set_index (value)
		end

	make_with_all (par: EV_TREE_ITEM_HOLDER; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		do
			make_with_index (par, value)
			set_text (txt)
		end

feature -- Access

	text: STRING
			-- Text of the item.

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			par_imp: EV_TREE_IMP
				-- local variable created to get the tree_widget Pointer
				-- which is specific to EV_TREE_IMP and is not in EV_TREE_ITEM_HOLDER_IMP

			tree_item_imp: EV_TREE_ITEM_IMP
		do
			tree_item_imp ?= tree_parent_imp.selected_item.implementation
			Result := (tree_item_imp = Current)
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := c_gtk_ctree_item_is_expanded (widget)
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		do
			Result := (ev_children.count > 0)
		end

	index: INTEGER is
			-- Index of the current item.
		local
			array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
		do
			array := parent_imp.ev_children
			array.start
			array.search (Current)
			Result := array.index
		end

	destroyed: BOOLEAN
			-- Is screen widget destroyed?

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if (flag) then
				gtk_ctree_select (tree_parent_imp.tree_widget, widget)
			else
				gtk_ctree_unselect (tree_parent_imp.tree_widget, widget)
			end
		end
	
	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		do
			if flag then
				gtk_ctree_expand (tree_parent_imp.tree_widget, widget)
			else
				gtk_ctree_collapse (tree_parent_imp.tree_widget, widget)
			end
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		local
			pos: INTEGER
			new_sibling: POINTER
			local_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
		do
			if (value /= index) then
				local_array := parent_imp.ev_children

				-- Move to the GtkCTreeNode given position.
				if (value < local_array.count) then
					local_array.go_i_th (value)
					new_sibling := local_array.item.widget
					-- Move the Node just up to `new_sibling'.
					gtk_ctree_move (tree_parent_imp.tree_widget, widget, parent_imp.widget, new_sibling)
				else
					-- Move the Node at the end.
					gtk_ctree_move (tree_parent_imp.tree_widget, widget, parent_imp.widget, default_pointer)
				end

				-- updating the parent `ev_children' array.
				local_array.search (Current)
				pos := local_array.index

				local_array.go_i_th (value)
				local_array.put_left (Current)


				if (value < pos) then
					local_array.go_i_th (pos + 1)
				else
					local_array.go_i_th (pos)
				end
				local_array.remove
			end
		end


	destroy is
			-- Destroy screen widget implementation.
			-- Redefined because there is no GtkCTreeItem.
 		local
			local_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
               do
			if (parent_imp /= Void) then
				-- Remove the node from the gtk_ctree:
				gtk_ctree_remove_node (tree_parent_imp.tree_widget, widget)

				-- There is no more GtkCTreeNode.
				set_widget (default_pointer)

				-- Remove the item from the array `ev_children'.
				local_array := parent_imp.ev_children
				local_array.start
				local_array.search (Current)
				local_array.remove
	
--				-- Remove the item from the tree_parent_imp's array `ev_children'.
--				local_array := tree_parent_imp.ev_children
--				local_array.start
--				local_array.search (Current)
--				local_array.remove

-- To be modified and optimized XXX
				-- Remove the item from the tree_parent_imp's array `all_children'.
				local_array := tree_parent_imp.all_children
				local_array.start
				local_array.search (Current)
				local_array.remove

				-- Set the `tree_parent_widget' of the tree item to Void:
				set_tree_parent_imp (Void)
			end
			destroyed := True


		end
	
feature -- Element change

	set_parent (par: EV_TREE_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
		local
			par_imp: EV_TREE_ITEM_HOLDER_IMP
			parent_item : EV_TREE_ITEM_IMP
		do
			if (par /= Void) then
				-- The new parent is not Void.

				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				if (parent_imp /= Void) then
					-- If the new parent is another Node of the tree where the old
					-- parent is, then do not destroy the node and move it to
					-- the right place in the tree.
					-- Otherwise, we destroy it and will have
					-- to rebuild it if we want to put it in another tree.
					if (tree_parent_imp = par_imp.tree_parent_imp) then
						-- We set the node to another place in the same tree,
						-- therefore we only move it.

						parent_item ?= par_imp
						if (parent_item /= Void) then
							-- The parent is a tree item.
							gtk_ctree_move (tree_parent_imp.tree_widget, widget, parent_item.widget, default_pointer)
						else
							-- The parent is the tree.
							gtk_ctree_move (tree_parent_imp.tree_widget, widget, default_pointer, default_pointer)
						end

						-- We need to update the `ev_children' by adding the new menu_item:
						par_imp.ev_children.force (Current)		

						-- Remove the item from the array `ev_children'.
						parent_imp.ev_children.start
						parent_imp.ev_children.search (Current)
						parent_imp.ev_children.remove
					else
						-- We set the Node to another tree so we remove it
						-- from the old tree.
						parent_imp.remove_item (Current)
						par_imp.add_item (Current)

						-- We have to reconnect the callback functions
						-- to the new GtkCTreeNode.
						update_all_commands
					end
				else
					par_imp.add_item (Current)
					-- There was no former parent. So we have to reconnect the callback functions
					-- to the new GtkCTreeNode.
					update_all_commands
				end
				parent_imp := par_imp					
			else
				-- The new parent is void.
				if (parent_imp /= Void) then
					-- There was a parent before:
					-- 1- Disconnect the callbacks.
					update_all_commands
					-- 2- Remove the node.
					parent_imp.remove_item (Current)
				end				
				parent_imp := Void
			end
		end

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			a: ANY
			pix_imp: EV_PIXMAP_IMP
		do
			text := txt

			if (has_parent) then
				a ?= txt.to_c
				if (pixmap /= Void ) then
					pix_imp ?= pixmap.implementation
					c_gtk_ctree_item_set_pixtext (tree_parent_imp.tree_widget, widget, 1, pix_imp.widget, $a, 5)
				else
					c_gtk_ctree_item_set_pixtext (tree_parent_imp.tree_widget, widget, 1, default_pointer, $a, 5)
				end
			end
		end

	set_pixmap (pix: EV_PIXMAP) is
			-- Add a pixmap in the container
		local
			pix_imp: EV_PIXMAP_IMP
			a: ANY
		do
			pixmap := pix

			if (has_parent) then
				pix_imp ?= pixmap.implementation
				a ?= text.to_c
				c_gtk_ctree_item_set_pixtext (tree_parent_imp.tree_widget, widget, 1, pix_imp.widget, $a, 5)
			end
		end

	unset_pixmap is
			-- Add a pixmap in the container
		local
			pix_imp: EV_PIXMAP_IMP
			a: ANY
		do
			pixmap := Void

			if (has_parent) then
				a ?= text.to_c
				c_gtk_ctree_item_set_pixtext (tree_parent_imp.tree_widget, widget, 1, default_pointer, $a, 5)
			end
		end

	clear_items is
			-- Clear all the items of the tree item holder.
		local
			list: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			item: EV_TREE_ITEM_IMP
		do
			-- Destroy the implementation of the items
			-- and remove the children from `ev_children' and `all_children'.
			from
				list := ev_children
				list.start
			until
				list.after
			loop
				item := list.item

				-- test if the tree item has sub tree items.
				if item.count > 0 then
					item.clear_items
				end
			
				item.tree_parent_imp.all_children.start
				item.tree_parent_imp.all_children.search (item)
				item.tree_parent_imp.all_children.remove

				-- To be modified
				gtk_ctree_remove_node (tree_parent_imp.tree_widget, item.widget)

				item.interface.remove_implementation

				list.forth
			end
			list.wipe_out
		end

feature -- Assertion

	has_parent : BOOLEAN is
			-- Redefinition of has_a_parent, already defined
			-- in EV_WIDGET_I, because parent_imp has been
			-- redefined as widget_parent_imp
		do
			Result := parent_imp /= Void
		end

feature -- Event : command association

	add_select_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		local
			arg_list: LINKED_LIST [EV_ARGUMENT]
		do
			-- Connect to the GtkCTreeNode if it exists already.
			-- Otherwise just store the command and argument.
			if (widget /= default_pointer) then
				add_command (tree_parent_imp.tree_widget, "tree_select_row", command, arguments, widget)
			else
				add_command (default_pointer, "tree_select_row", command, arguments, default_pointer)
			end	

			if ((argument_array @ tree_select_row_id) = Void) then
				create arg_list.make
				argument_array.force (arg_list, tree_select_row_id)
			end

			(argument_array @ tree_select_row_id).force (arguments)
		end

	add_unselect_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		local
			arg_list: LINKED_LIST [EV_ARGUMENT]
		do
			add_command (tree_parent_imp.tree_widget, "tree_unselect_row", command, arguments, widget)

			if ((argument_array @ tree_unselect_row_id) = Void) then
				create arg_list.make
				argument_array.force (arg_list, tree_unselect_row_id)
			end

			(argument_array @ tree_unselect_row_id).force (arguments)
		end	

	add_subtree_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the selection subtree
			-- expanded or collapsed.
		local
			arg_list: LINKED_LIST [EV_ARGUMENT]
		do
			add_command (tree_parent_imp.tree_widget, "tree_expand", command, arguments, widget)

			if ((argument_array @ tree_expand_id) = Void) then
				create arg_list.make
				argument_array.force (arg_list, tree_expand_id)
			end

			(argument_array @ tree_expand_id).force (arguments)

			add_command (tree_parent_imp.tree_widget, "tree_collapse", command, arguments, widget)

			if ((argument_array @ tree_collapse_id) = Void) then
				create arg_list.make
				argument_array.force (arg_list, tree_collapse_id)
			end

			(argument_array @ tree_collapse_id).force (arguments)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		local
			list: LINKED_LIST [EV_COMMAND]
			list_com: EV_GTK_COMMAND_LIST
		do
			-- list of the commands to be executed for "select_row" signal.
			list := (event_command_array @ tree_select_row_id).command_list

			from
				list.start
			until
				list.after
			loop
				remove_single_command (tree_parent_imp.tree_widget, tree_select_row_id, list.item)
				-- we do not need to do "list.forth" as an item has been removed
				-- that list.
			end
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		local
			list: LINKED_LIST [EV_COMMAND]
		do
			-- list of the commands to be executed for "select_row" signal.
			list := (event_command_array @ tree_unselect_row_id).command_list

			from
				list.start
			until
				list.after
			loop
				remove_single_command (tree_parent_imp.tree_widget, tree_unselect_row_id, list.item)
				-- we do not need to do "list.forth" as an item has been removed
				-- that list.
			end
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		local
			list1: LINKED_LIST [EV_COMMAND]
			list2: LINKED_LIST [EV_COMMAND]
		do
			-- list of the commands to be executed for "select_row" signal.
			list1 := (event_command_array @ tree_expand_id).command_list
			list2 := (event_command_array @ tree_collapse_id).command_list

			from
				list1.start
				list2.start
			until
				list1.after
			loop
				remove_single_command (tree_parent_imp.tree_widget, tree_expand_id, list1.item)
				remove_single_command (tree_parent_imp.tree_widget, tree_collapse_id, list2.item)
				-- we do not need to do "list.forth" as an item has been removed
				-- that list.
			end
		end

feature {EV_TREE_ITEM_IMP} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item' to the list
		local
			p: POINTER
			par_imp: EV_TREE
			a: ANY
			local_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			tree_item_imp: EV_TREE_ITEM_IMP
		do
			local_array := item_imp.ev_children

			-- Set the `tree_parent_widget' of the tree_item:
			item_imp.set_tree_parent_imp (tree_parent_imp)

			-- Create a GtkCTreeNode and insert it as well as the children.
			add_gtk_ctree_node (item_imp)

			-- We need to update the `ev_children' by adding the new menu_item:
			local_array := ev_children
			local_array.force (item_imp)	

--			-- Every widgets also have to be in the tree_parent_imp's `ev_children'.
--			tree_parent_imp.ev_children.force (item_imp)

-- To be modified and optimized XXX
			-- Every widgets also have to be in the tree_parent_imp's `all_children'.
			tree_parent_imp.all_children.force (item_imp)
		end

	add_gtk_ctree_node (item_imp: EV_TREE_ITEM_IMP) is
			-- Called by `add_item'.
			-- Add a GtkCTreeNode, associated to `item_imp', to the current GtkCTreeNode.
			-- If the `item_imp' has children, create the GtkCTreeNode object associated to them.
		local
			p: POINTER
			a: ANY
			local_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			tree_item_imp: EV_TREE_ITEM_IMP
		do
			local_array := item_imp.ev_children

			-- Create a GtkCTreeNode and insert it.
			a ?= item_imp.text.to_c
			p := c_gtk_ctree_insert_node (tree_parent_imp.tree_widget, widget, default_pointer, $a, 2, default_pointer, default_pointer, False, False)
			item_imp.set_widget (p)

			-- If `item_imp' has children, create the gtk objects.
			if (local_array.count > 0) then
				from
					local_array.start
				until
					local_array.after
				loop
					tree_item_imp := local_array.item
					item_imp.add_gtk_ctree_node (tree_item_imp)

					local_array.forth
				end
			end
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		require else
			tree_has_this_child: tree_parent_imp.has_tree_item (item_imp)
		local
			local_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
		do
			-- Remove the node from the gtk_ctree:
			gtk_ctree_remove_node (tree_parent_imp.tree_widget, item_imp.widget)

			-- There is no more GtkCTreeNode.
			item_imp.set_widget (default_pointer)

			-- Set the `tree_parent_widget' of the tree item to Void:
			item_imp.set_tree_parent_imp (Void)

			-- Remove the item from the array `ev_children'.
			local_array := ev_children
			local_array.start
			local_array.search (item_imp)
			local_array.remove

--			-- Remove the item from the tree_parent_imp's array `ev_children'.
--			local_array := tree_parent_imp.ev_children
--			local_array.start
--			local_array.search (item_imp)
--			local_array.remove

-- To be modified and optimized XXX
			-- Remove the item from the tree_parent_imp's array `ev_children'.
			local_array := tree_parent_imp.all_children
			local_array.start
			local_array.search (item_imp)
			local_array.remove
		end

feature {EV_TREE_ITEM_IMP} -- Implementation

	argument_array: ARRAY[LINKED_LIST [EV_ARGUMENT]]
			-- Array of the arguments. Same index for the categories as `event_command_data'.
			-- We need it for ctrees.
			-- XXXX 

	update_all_commands is
			-- Removed the callbacks for all type of events.
		do
			update_commands (tree_select_row_id)
			update_commands (tree_unselect_row_id)
			update_commands (tree_subtree_id)
		end


	update_commands (event_id: INTEGER) is
			-- Called by feature `update_all_commands'.
			-- Remove the callbacks, of type `event_id', assigned to the previous pointer
			-- to GtkCTreeNode. Put them back associated to the new GtkCTreeNode.
			-- If there is no former  or new GtkCtreeNode, it will just update the different
			-- commands and argument arrays.
		local
			cmd_list: LINKED_LIST [EV_COMMAND]
			arg_list: LINKED_LIST [EV_ARGUMENT]
			cmd_list_copy: LINKED_LIST [EV_COMMAND]
			arg_list_copy: LINKED_LIST [EV_ARGUMENT]
			local_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			tree_item_imp: EV_TREE_ITEM_IMP
		do
			if ((argument_array @ event_id) /= Void) then
				cmd_list := (event_command_array @ event_id).command_list
				arg_list := argument_array @ event_id

				-- 1. Copy the linked lists.
				from
					cmd_list.start
					arg_list.start
					create cmd_list_copy.make
					create arg_list_copy.make
				until
					cmd_list.after
				loop
					cmd_list_copy.force (cmd_list.item)
					arg_list_copy.force (arg_list.item)
					cmd_list.forth	
					arg_list.forth	
				end

				-- 2. Update the `event_command_array' and `argument_array':
	
				-- 2-1. First, we remove the former commands and arguments.
				if (event_id = tree_subtree_id) then
					disconnect_commands (tree_expand_id)
					disconnect_commands (tree_collapse_id)
				else
					disconnect_commands (event_id)
				end
	
				-- 2-2. Then we connect new commands because there is a new GtkCTreeNode pointer.
				from
					cmd_list_copy.start
					arg_list_copy.start
				until
					cmd_list_copy.after
				loop
					inspect
						event_id
					when tree_select_row_id then
						add_select_command (cmd_list_copy.item, arg_list_copy.item)
					when tree_unselect_row_id then
						add_unselect_command (cmd_list_copy.item, arg_list_copy.item)
					when tree_subtree_id then
						add_subtree_command (cmd_list_copy.item, arg_list_copy.item)
					end

					cmd_list_copy.forth
					arg_list_copy.forth
				end

			end

			-- Do the same processing for the children if there are some.
			local_array := ev_children
			if (local_array.count > 0) then
				from
					local_array.start
				until
					local_array.after
				loop
					tree_item_imp := local_array.item
					tree_item_imp.update_commands (event_id)
					local_array.forth
				end		
			end
		end

	disconnect_all_commands is
			-- Disconnect every callbacks for the different signals.
		do
			disconnect_commands (tree_select_row_id)
			disconnect_commands (tree_unselect_row_id)
			disconnect_commands (tree_expand_id)
			disconnect_commands (tree_collapse_id)
		end

	disconnect_commands (event_id: INTEGER) is
			-- Called by feature `update_commands'.
			-- Clear `argument_array' list for the events of type `event_id'.
			-- And clear `event_command_array @ event_id' list by disconnecting
			-- the callback functions.
		local
			arg_list: LINKED_LIST [EV_ARGUMENT]
			cmd_list: LINKED_LIST [EV_COMMAND]
		do
			if (event_command_array /= Void) then
				if (event_command_array @ event_id /= Void) then
					cmd_list := (event_command_array @ event_id).command_list

					from
						cmd_list.start
					until
						cmd_list.empty
					loop
						-- Disconnect the commands for event of type `event_id'.
						remove_single_command (tree_parent_imp.tree_widget, event_id, cmd_list.item)
					end

					from
						arg_list := argument_array @ event_id
						arg_list.start
					until
						arg_list.empty
					loop
						-- Remove all arguments.
						arg_list.remove
					end
				end
			end
		end

feature {EV_TREE_ITEM_HOLDER_IMP} -- Implementation

	set_widget (p: POINTER) is
			-- Sets `widget' to the new pointer `p'.
		do
			widget := p
		end

feature {EV_TREE_ITEM_HOLDER_IMP} -- Implementation

	dispose is
			-- Function called when the Eiffel
			-- Object is garbage-collected.
			-- Does nothing here.
		do
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
