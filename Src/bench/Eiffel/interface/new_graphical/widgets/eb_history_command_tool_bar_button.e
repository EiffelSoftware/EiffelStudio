indexing
	description	: "Toolbar button for an history command"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HISTORY_COMMAND_TOOL_BAR_BUTTON 

inherit
	EB_COMMAND_TOOL_BAR_BUTTON 
		redefine
			recycle,
			make,
			command
		end

creation
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
			-- command associated with Current.

end -- class EB_HISTORY_COMMAND_TOOL_BAR_BUTTON