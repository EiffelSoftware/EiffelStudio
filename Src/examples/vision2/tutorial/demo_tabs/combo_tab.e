indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMBO_TAB

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
			{ANY_TAB} Precursor (Void)
				
				-- Creates the objects and their commands
			create cmd1.make (~set_extended_height)
			create cmd2.make (~get_extended_height)
			create f1.make(Current, 0, 0,"Extended Height", cmd1, cmd2)
			set_parent(par)
		end


	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Combo"
		end

	set_extended_height (arg:EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the level of the progress bar
		do
			current_widget.set_extended_height(f1.get_text.to_integer)
		end

	get_extended_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the level of the progress bar
		do
			f1.set_text(current_widget.extended_height.out)
		end

	current_widget: EV_COMBO_BOX

	f1: TEXT_FEATURE_MODIFIER

end -- class COMBO_TAB
