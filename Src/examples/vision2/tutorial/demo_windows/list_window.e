indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	LIST_WINDOW

inherit
	DEMO_WINDOW

	EV_LIST
		redefine
			make
		end
	WIDGET_COMMANDS
	LIST_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd1: EV_ROUTINE_COMMAND
			cmd2: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EV_LIST_ITEM]
		do
			{EV_LIST} Precursor (par)
 			!! item1.make_with_text (Current, "This is item1")
 			!! item2.make (Current)
 			item2.set_text ("Item 2")
 			!! item3.make_with_text (Current, "item 3")
			set_multiple_selection
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "list")
			add_list_commands (Current, event_window, "List")
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend(list_tab)
			create action_window.make (Current, tab_list)
		end

feature -- Access

	item1: EV_LIST_ITEM
			-- an item

	item2: EV_LIST_ITEM
			-- an item

	item3: EV_LIST_ITEM
			-- an item

end -- class LIST_WINDOW

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

