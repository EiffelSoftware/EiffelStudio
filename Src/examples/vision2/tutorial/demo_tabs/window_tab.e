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
		once
			{ANY_TAB} Precursor (Void)
		
				-- Creates the objects and their commands
			create cmd2.make (~get_icon_name)
			create f1.make (Current, "Icon Name", Void, cmd2)
			
--			create cmd1.make (~set_spacing_val)
--			create cmd2.make (~get_spacing_val)
--			create f2.make (Current, "Spacing", cmd1, cmd2)

			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Window"
		end


feature -- Execution feature  

	
	get_icon_name (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the icon name of the window
		do
			f1.set_text(current_widget.icon_name)
		end

feature -- Access

	current_widget: EV_WINDOW
	f1,f2:FEATURE_MODIFIER	
end -- class WINDOW_TAB
