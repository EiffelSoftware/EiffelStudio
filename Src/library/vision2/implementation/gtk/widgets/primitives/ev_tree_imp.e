indexing
	description:
		"EiffelVision Tree, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I

	EV_PRIMITIVE_IMP
		redefine
			destroy,
			destroyed
		end

	EV_TREE_ITEM_HOLDER_IMP
		redefine
			destroy,
			destroyed
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty Tree.
		do
			-- `Vision2 tree' = gtk_scrolled_window + gtk_tree.
			-- We did this to allow the scrolling.

			-- Creating the gtk scrolled window, pointed by `widget':
			widget := gtk_scrolled_window_new (Default_pointer, Default_pointer)
			gtk_object_ref (widget)
			gtk_scrolled_window_set_policy (gtk_scrolled_window (widget), gtk_policy_automatic, gtk_policy_automatic)

			-- Creating the gtk_tree, pointed by `tree_widget':
			tree_widget := gtk_tree_new
			c_gtk_tree_set_single_selection_mode (tree_widget)
			gtk_widget_show (tree_widget)
			gtk_scrolled_window_add_with_viewport (widget, tree_widget)

			-- Creating the array which will contain the tree_items.
			create ev_children.make (0)

			-- Set the `tree_parent_imp' to Current as this
			-- the tree that will contain all the tree items.
			set_tree_parent_imp (Current)
		end

feature -- Access

	selected_item: EV_TREE_ITEM is
			-- Item which is currently selected.
		local
			selected_item_p: POINTER
			local_tree_item_imp: EV_TREE_ITEM_IMP
			items_array: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			tree_item_found: BOOLEAN
		do
			check
				To_be_tested: False
			end

			selected_item_p := c_gtk_tree_selected_item (tree_widget)
			from
				items_array := ev_children
				tree_item_found := False
				items_array.start
			until
				items_array.after or tree_item_found
			loop
				local_tree_item_imp := items_array.item
				if (local_tree_item_imp.widget = selected_item_p) then
					tree_item_found := True
				end
				items_array.forth
			end
			if tree_item_found then
				Result ?= local_tree_item_imp.interface
			else
				Result := Void
			end
			
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			check
				not_yet_implemented: False
			end
		end

	destroyed: BOOLEAN is
			-- Is screen window destroyed?
                do
                        Result := (widget = Default_pointer) and (tree_widget = Default_pointer)
 		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation and EV_LIST_ITEM objects
		do
-- clear_items
			if not destroyed then
	                        gtk_widget_destroy (tree_widget)
	                        gtk_widget_destroy (widget)
			end
			widget := Default_pointer
			tree_widget := Default_pointer
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is	
			-- Make `command' executed when an item is
			-- selected.
		do
			add_command (tree_widget, "selection_changed", a_command, arguments)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_commands (tree_widget, selection_changed_id)
		end

feature {NONE} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item' to the list
		do
			-- Append the item_imp to the `tree_widget':
			gtk_tree_append (tree_widget, item_imp.widget)

			-- Set the `tree_parent_widget' of the tree item:
			item_imp.set_tree_parent_imp (Current)

			-- We need to update the array:
			-- `ev_children' by adding the new tree_item:
			ev_children.force (item_imp)
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item' to the list
		do
			-- remove the gtk_tree_item of the gtk_tree:
			gtk_tree_remove_item (tree_widget, item_imp.widget)

			-- Set the `tree_parent_widget' of the tree item to Void:
			item_imp.set_tree_parent_imp (Void)

			-- Remove the item from the array `ev_children'.
			ev_children.search (item_imp)
			ev_children.remove
		end

feature {EV_TREE_ITEM_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- We need to store the children.

feature {EV_TREE_ITEM_IMP} -- Implementation

	tree_widget: POINTER
			-- Pointer to the gtk_tree because the vision `EV_TREE'
			-- is made of a gtk_scrolled_window (pointed by `widget')
			-- and a gtk_tree (pointed by `tree_widget').
			-- Exported to EV_TREE_ITEM_IMP. 

end -- class EV_TREE_IMP

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
--|---------------------------------------------------------------
 
