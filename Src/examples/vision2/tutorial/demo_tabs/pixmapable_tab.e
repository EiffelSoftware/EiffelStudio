indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAPABLE_TAB

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
			Result:="Pixmapable"
		end


feature -- Execution feature  
	
feature -- Access

	current_widget: EV_PIXMAPABLE
	f1: FEATURE_MODIFIER	
	b1,b2,b3: EV_BUTTON
end -- class FONTABLE_TAB

 



