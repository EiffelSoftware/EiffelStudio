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

	EV_TREE_ITEM_HOLDER
		redefine
			implementation
		end

creation
	make,
	make_with_text,
	make_with_pixmap,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the widget with `par' as parent.
		do
			!EV_TREE_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_TREE_ITEM_HOLDER; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_TREE_ITEM_IMP! implementation.make_with_text (txt)
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_pixmap (par: EV_TREE_ITEM_HOLDER; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `pix'
			-- as pixmap.
		do
			!EV_TREE_ITEM_IMP! implementation.make_with_pixmap (pix)
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_all (par: EV_TREE_ITEM_HOLDER; txt: STRING; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `pix' as pixmap.
		do
			!EV_TREE_ITEM_IMP! implementation.make_with_all (txt, pix)
			implementation.set_interface (Current)
			set_parent (par)
		end

feature -- Access

	parent: EV_TREE_ITEM_HOLDER is
			-- Parent of the current item.
		require
			exists: not destroyed
		do
			Result := implementation.parent
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		require
			exists: not destroyed
		do
			Result := implementation.is_selected
		end

	is_expanded: BOOLEAN is
			-- is the item expanded?
		require
			exists: not destroyed
		do
			Result := implementation.is_expanded
		end

feature -- Element change

	set_parent (par: EV_TREE_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		do
			implementation.set_parent (par)
		ensure
			parent_set: parent = par
		end

feature -- Event : command association

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_subtree_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		require
			exists: not destroyed
		do
			implementation.remove_subtree_commands
		end

feature {EV_TREE_ITEM_HOLDER, EV_TREE_ITEM_HOLDER_I} -- Implementation

	implementation: EV_TREE_ITEM_I

end -- class EV_TREE_ITEM

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

