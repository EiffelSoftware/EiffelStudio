indexing	
	description: 
		"EiffelVision tree item. Item that can be put in a tree.%
		% A tree item is also a tree-item container because if%
		% we create a tree-item with a tree-item as parent, the%
		% parent will become a subtree."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM

inherit
	EV_ITEM
		redefine
			implementation
		end

	EV_TREE_ITEM_CONTAINER
		redefine
			implementation
		end

creation
	make_with_text

feature {NONE} -- Initialization

	make_with_text (par: EV_TREE_ITEM_CONTAINER; txt: STRING) is
			-- Create a tree item and add it to the given parent.
		do
			!EV_TREE_ITEM_IMP! implementation.make_with_text (par, txt)
			implementation.set_interface (Current)
			par.implementation.add_item (Current)
		end

feature -- Status report

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		require
			exists: not destroyed
		do
			Result := implementation.is_expanded
		end

feature -- Event : command association

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make 'cmd' the executed command when the subtree expand
			-- or collapse.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_subtree_command (cmd, arg)
		end

feature {EV_TREE_ITEM_CONTAINER, EV_TREE_ITEM_CONTAINER_I} -- Implementation

	implementation: EV_TREE_ITEM_I

end -- class EV_TREE_ITEM

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
