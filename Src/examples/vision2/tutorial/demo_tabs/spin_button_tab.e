indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPIN_BUTTON_TAB

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
			-- Create the tab and initialise objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			{ANY_TAB} Precursor (Void)
			create cmd1.make (~set_step)
			create cmd2.make (~get_step)
			create f1.make (Current, 0, 0, "Step Value", cmd1, cmd2)
			
		end

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Spin Button"
		end

	current_widget: EV_RANGE

feature -- Access

	
	set_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the step of the spin button
		do
			current_widget.set_step(f1.get_text.to_integer)
		end

	get_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the step of the spin button
		do
			f1.set_text(current_widget.step.out)
		end


	f1: TEXT_FEATURE_MODIFIER

end -- class SPIN_BUTTON_TAB
 

