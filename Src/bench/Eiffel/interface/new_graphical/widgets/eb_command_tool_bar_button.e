indexing
	description	: "Toolbar button for a toolbarable toolbar_command"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_COMMAND_TOOL_BAR_BUTTON 

inherit
	EV_TOOL_BAR_BUTTON

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

creation
	make

feature {NONE} -- Initialization

	make (a_command: EB_TOOLBARABLE_COMMAND) is
		do
			default_create
			command := a_command
			command.managed_toolbar_items.extend (Current)
		end

feature -- Cleaning

	recycle is
			-- To be called when the button has became useless.
		do
			command.managed_toolbar_items.prune_all (Current)
			drop_actions.wipe_out
			select_actions.wipe_out
			pick_actions.wipe_out
		end
	
feature {NONE} -- Implementation

	command: EB_TOOLBARABLE_COMMAND
			-- command associated with Current.

end -- class EB_toolbar_command_TOOL_BAR_BUTTON