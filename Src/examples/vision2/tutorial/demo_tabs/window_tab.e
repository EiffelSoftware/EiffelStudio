indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOW_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		do
			{ANY_TAB} Precursor (PAR)
		
				-- Creates the objects and their commands
			create cmd2.make (~get_icon_name)
			create f1.make (Current, "Icon Name", Void, cmd2)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Window"
		end

	current_widget: EV_WINDOW
			-- Current widget we are working on.

	f1: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

feature -- Execution feature  

	
	get_icon_name (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the icon name of the window
		do
			f1.set_text(current_widget.icon_name)
		end

end -- class WINDOW_TAB
