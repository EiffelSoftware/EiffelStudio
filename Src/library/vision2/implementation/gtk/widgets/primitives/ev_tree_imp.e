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

	EV_TREE_ITEM_CONTAINER_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty Tree.
		do
			widget := gtk_tree_new
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
			-- Make `command' executed when an item is
			-- selected.
		do
			add_command ("selection_changed", a_command, arguments)
		end

feature {EV_TREE_ITEM} -- Implementation

	add_item (item: EV_TREE_ITEM) is
			-- Add `item' to the list
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			item_imp ?= item.implementation
			check
				correct_imp: item_imp /= Void
			end
			gtk_tree_append (widget, item_imp.widget)
		end

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
 
