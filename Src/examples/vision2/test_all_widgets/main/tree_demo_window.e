indexing
	description:
		"TREE_DEMO_WINDOW, demo window to test the tree widget.%
		% Belongs to EiffelVision example.";
	date: "$Date$";
	revision: "$Revision$"

class
	TREE_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end
	
creation
	make

feature -- Access

	main_widget: EV_TREE is
			-- The main widget of the demo
		once
			!! Result.make (Current)
			Result.set_minimum_size(200,200)
		end

	tree_item, tree_item2, tree_item3: EV_TREE_ITEM
			-- Items for the tree
	
feature -- Status setting
        
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			!! tree_item.make_with_text (main_widget, "Item")
			!! tree_item2.make_with_text (tree_item, "Item 2")
			!! tree_item.make_with_text (main_widget, "Item 3")
			!! tree_item.make_with_text (main_widget, "Item 4")
			!! tree_item3.make_with_text (tree_item, "Item 5")
			!! tree_item2.make_with_text (tree_item, "Item 6")
			!! tree_item.make_with_text (tree_item2, "Click Me !")
			!! cmd.make (~execute1)
			tree_item.add_activate_command (cmd, Void)
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Tree demo")
		end

feature -- Comman execution

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execution for an item
		do
			if tree_item.parent = tree_item2 then
				tree_item.set_parent (tree_item3)
			elseif tree_item.parent = tree_item3 then
				tree_item.set_parent (main_widget)
			else
				tree_item.set_parent (tree_item2)
			end
		end

end -- class TREE_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

