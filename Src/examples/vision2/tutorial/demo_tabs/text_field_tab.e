indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIELD_TAB

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
		do
		{ANY_TAB} Precursor (Void)
			
	--	create cmd1.make (~set_maximum_text_length)
	--	create cmd2.make (~get_maximum	

		set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Text Field"
		end

	current_widget: EV_TEXT_FIELD
			-- Current feature we are working on.
	
	f1: TEXT_FEATURE_MODIFIER
		-- A feature for viewing and modifying values.

end -- class TEXT_FIELD_TAB
