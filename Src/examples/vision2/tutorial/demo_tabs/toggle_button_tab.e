indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_TAB

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
		
			create cmd1.make (~get_state_val)		
			create cmd2.make (~set_state_val)
			create f1.make (Current, "State", cmd1, cmd2)
			create cmd1.make (~toggle_button)
			create b1.make_with_text(Current,"Toggle State")
			b1.add_click_command(cmd1, Void)
			b1.set_vertical_resize(False)
	
				-- Creates the objects and their commands
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Toggle Button"
		end


feature -- Execution feature  

	get_state_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) IS
			-- Get the state of the toggle button.
		do
			if current_widget.state=true then
				f1.set_text("True")
			else
				f1.set_text("False")
			end
		end
	
	set_state_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the state of the toggle button.
		do
					
		end

	toggle_button (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggle the state of the button.
		do
			current_widget.toggle
		end
feature -- Access

	current_widget: EV_TOGGLE_BUTTON
	f1: TEXT_FEATURE_MODIFIER	
	b1: EV_BUTTON
end -- class TOGGLE_BUTTON_TAB