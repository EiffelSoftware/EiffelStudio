indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			Precursor {ANY_TAB} (Void)
			create cmd1.make (agent set_step)
			create cmd2.make (agent get_step)
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
		--	current_widget.set_step(f1.get_text.to_integer)
			f1.set_text("Inapplicable")
		end

	get_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the step of the spin button
		do
			f1.set_text(current_widget.step.out)
		end


	f1: TEXT_FEATURE_MODIFIER;

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


end -- class SPIN_BUTTON_TAB
 


