indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BUTTON_TAB

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
		once
			{ANY_TAB} Precursor (Void)
			
				-- Creates the objects and their commands
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Check Button"
		end


feature -- Execution feature  

feature -- Access

	current_widget: EV_CHECK_BUTTON
	f1: FEATURE_MODIFIER	
	b1: EV_BUTTON
end -- class CHECK_BUTTON_TAB
