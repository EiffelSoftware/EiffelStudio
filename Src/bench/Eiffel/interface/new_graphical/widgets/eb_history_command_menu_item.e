indexing
	description	: "Menu item for an history command"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HISTORY_COMMAND_MENU_ITEM 

inherit
	EB_COMMAND_MENU_ITEM 
		redefine
			recycle,
			make,
			command
		end

create
	make

feature {NONE} -- Initialization

	make (a_command: EB_HISTORY_COMMAND) is
		do
			Precursor (a_command)
			command.history_manager.add_observer (Current)
		end

feature -- Cleaning

	recycle is
			-- To be called when the button has became useless.
		do
			Precursor
			command.history_manager.remove_observer (Current)
		end

feature {NONE} -- Implementation

	command: EB_HISTORY_COMMAND
			-- Command associated with Current.

end -- class EB_HISTORY_COMMAND_MENU_ITEM