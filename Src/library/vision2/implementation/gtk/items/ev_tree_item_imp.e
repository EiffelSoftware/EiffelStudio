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
		redefine
			make,
			has_parent
		end

	EV_TREE_ITEM_HOLDER_IMP
		rename
			parent_set as widget_parent_set,
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk,
			parent_imp as widget_parent_imp,
			set_parent as widget_set_parent
		undefine
			has_parent,
			set_foreground_color
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an item with an empty name.
		do
			-- Create the gtk object.
			widget := gtk_tree_item_new
			gtk_object_ref (widget)

			-- Create the `box'.
			initialize

			-- Set the text to "".
			Create_text_label ("")
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			par_imp: EV_TREE_IMP
				-- local variable created to get the tree_widget Pointer
				-- which is specific to EV_TREE_IMP and is not in EV_TREE_ITEM_HOLDER_IMP
		do
			check
				To_be_tested: False
			end
			Result := c_gtk_tree_item_is_selected (tree_parent_imp.tree_widget, widget)				
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := c_gtk_tree_item_expanded (widget)
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		do
			Result := (GTK_TREE_ITEM_SUBTREE(widget) /= default_pointer)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if (flag) then
				gtk_tree_item_select (widget)
			else
				gtk_tree_item_deselect (widget)
			end
		end
	
feature -- Element change

	set_parent (par: EV_TREE_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_TREE_ITEM_HOLDER_IMP
			parent_temp : EV_TREE_ITEM_HOLDER
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp := par_imp
				par_imp.add_item (Current)
				show
				gtk_object_unref (widget)
			end
		end

feature -- Assertion

	has_parent : BOOLEAN is
			-- Redefinition of has_a_parent, already defined
			-- in EV_WIDGET_I, because parent_imp has been
			-- redefined as widget_parent_imp
		do
			Result := parent_imp /= void
		end

feature -- Event : command association

	add_activate_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command (widget, "select", command, arguments)
		end

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command (widget, "deselect", cmd, arg)
		end	

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the selection subtree
			-- expanded or collapsed.
		do
			add_command (widget, "expand", cmd, arg)
			add_command (widget, "collapse", cmd, arg)
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			remove_commands (widget, select_id)
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do	
			remove_commands (widget, deselect_id)
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		do
			remove_commands (widget, expand_id)
			remove_commands (widget, collapse_id)
		end

feature {NONE} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item' to the list
		local
			p: POINTER
			par_imp: EV_TREE
		do
			-- If the tree item does not have any items children,
			-- we need to add a tree under it to be able to add tree items
			-- (we make it become a subtree).
			if GTK_TREE_ITEM_SUBTREE(widget) = default_pointer then
				p := gtk_tree_new
				gtk_tree_item_set_subtree (widget, p)
				c_gtk_tree_set_single_selection_mode (GTK_TREE_ITEM_SUBTREE(widget))
			end

			-- add the tree item to the current tree which is a subtree.
			gtk_tree_append (GTK_TREE_ITEM_SUBTREE(widget), item_imp.widget)

			-- Set the `tree_parent_widget' of the tree_item:
			item_imp.set_tree_parent_imp (tree_parent_imp)

			-- We need to update the parent (the tree)
			-- `ev_children' by adding the new menu_item:
			tree_parent_imp.ev_children.force (item_imp)
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		do
			-- remove the gtk_tree_item of the gtk_tree_item:
			gtk_tree_remove_item (GTK_TREE_ITEM_SUBTREE(widget), item_imp.widget)

			-- Remove the item from the array `ev_children' of the tree parent.
			tree_parent_imp.ev_children.search (item_imp)
			tree_parent_imp.ev_children.remove

			-- Set the `tree_parent_widget' of the tree item to Void:
			item_imp.set_tree_parent_imp (Void)
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
