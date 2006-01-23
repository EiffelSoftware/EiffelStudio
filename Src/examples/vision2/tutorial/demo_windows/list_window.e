indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd1: EV_ROUTINE_COMMAND
			cmd2: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EV_LIST_ITEM]
		do
			Precursor {EV_LIST} (par)
 			create item1.make_with_text (Current, "This is item1")
 			create item2.make (Current)
 			item2.set_text ("Item 2")
 			create item3.make_with_text (Current, "item 3")
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

	item3: EV_LIST_ITEM;
			-- an item

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class LIST_WINDOW

