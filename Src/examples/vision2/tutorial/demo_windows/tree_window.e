indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TREE_WINDOW

inherit
	DEMO_WINDOW

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
			--tree_item1 := create_item (Current, "Item")
			--tree_item2 := create_item (tree_item1, "Item 2")
			--tree_item1 := create_item (Current, "Item 3")
			--tree_item1 := create_item (Current, "Item 4")
			--tree_item3 := create_item (tree_item1, "Item 5")
			--tree_item2 := create_item (tree_item1, "Item 6")
			--create action_item.make_with_text (tree_item2, "Click Me !")

			-- Once everything done, we expand the sub-tree we want
			--tree_item1.set_expand (True)
			--tree_item2.set_expand (True)

			-- We add a command on an item.
			--create cmd.make (~execute1)
			--action_item.add_select_command (cmd, Void)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend (tree_tab)
			create action_window.make (Current, tab_list)
			tree_tab.set_tree
		end

feature -- Access

	tree_item1: EV_TREE_ITEM
			-- an item

	tree_item2: EV_TREE_ITEM
			-- an item

	tree_item3: EV_TREE_ITEM
			-- an item

	action_item: EV_TREE_ITEM
			-- a tree item that moves.
feature -- Basic operation

	create_item (par: EV_TREE_ITEM_HOLDER; txt: STRING): EV_TREE_ITEM is
				-- Create an item with pick and drop facilities.
		local
			type: EV_PND_TYPE
		do
			create Result.make_with_text (par, txt)

			-- You want pick and drop ?
			Result.activate_pick_and_drop (Void, Void)
			create type.make
			Result.set_data_type (type)
			Result.set_transported_data ("Bonjour")
		end

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
