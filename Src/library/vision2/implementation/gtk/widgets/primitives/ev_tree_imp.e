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

	EV_TREE_ITEM_HOLDER_IMP

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty Tree.
		do
			widget := gtk_tree_new
			gtk_object_ref (widget)
		end

feature -- Access

	selected_item: EV_TREE_ITEM is
			-- Item which is currently selected.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status report

	selected: BOOLEAN is
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is	
			-- Make `command' executed when an item is
			-- selected.
		do
			add_command ("selection_changed", a_command, arguments)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_commands (selection_changed_id)
		end

feature {NONE} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item' to the list
		do
			gtk_tree_append (widget, item_imp.widget)
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item' to the list
		do
			gtk_tree_remove_item (widget, item_imp.widget)
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_TREE_ITEM]
			-- We need to store the children.

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
 
