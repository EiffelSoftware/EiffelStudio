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

		once
			{ANY_TAB} Precursor (Void)
			
				-- Creates the objects and their commands
			create label.make_with_text(Current, "All features are inherited from EV_TOGGLE_BUTTON,%Ntherefore there are no features unique to EV_CHECK_BUTTON to modify")
			set_child_position (label, 0, 0, 1, 1) 
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
	label: EV_LABEL
end -- class CHECK_BUTTON_TAB
