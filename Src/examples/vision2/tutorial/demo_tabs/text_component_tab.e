indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_COMPONENT_TAB

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
			but: EV_BUTTON
			item: EV_LIST_ITEM
		do
			{ANY_TAB} Precursor (Void)

			-- Creates the objects and their commands
	
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Text Component"
		end

	current_widget: EV_TEXT_COMPONENT
			-- Current feature we are working on.

feature -- Execution feature  


end -- class TEXT_COMPONENT_TAB


