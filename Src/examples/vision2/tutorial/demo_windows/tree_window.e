indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TREE_WINDOW

inherit
	EV_TREE
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_TREE} Precursor (par)
			!! tree_item1.make_with_text (Current, "Item")
			!! tree_item2.make_with_text (tree_item1, "Item 2")
			!! tree_item1.make_with_text (Current, "Item 3")
			!! tree_item1.make_with_text (Current, "Item 4")
			!! tree_item3.make_with_text (tree_item1, "Item 5")
			!! tree_item2.make_with_text (tree_item1, "Item 6")
			!! tree_item1.make_with_text (tree_item2, "Click Me !")
			!! cmd.make (~execute1)
			tree_item1.add_activate_command (cmd, Void)
		end

feature -- Access

	tree_item1: EV_TREE_ITEM
			-- an item

	tree_item2: EV_TREE_ITEM
			-- an item

	tree_item3: EV_TREE_ITEM
			-- an item

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execution for an item
		do
			if tree_item1.parent = tree_item2 then
				tree_item1.set_parent (tree_item3)
			elseif tree_item1.parent = tree_item3 then
				tree_item1.set_parent (Current)
			else
				tree_item1.set_parent (tree_item2)
			end
		end

end -- class TREE_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
