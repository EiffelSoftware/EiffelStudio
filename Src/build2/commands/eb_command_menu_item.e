indexing
	description	: "Menu item for a menuable command"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_COMMAND_MENU_ITEM 

inherit
	EV_MENU_ITEM

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_command: EB_MENUABLE_COMMAND) is
		do
			default_create
			command := a_command
			command.managed_menu_items.extend (Current)
		end

feature -- Cleaning

	recycle is
			-- To be called when the button has became useless.
		do
			command.managed_menu_items.prune_all (Current)
		end

feature {NONE} -- Implementation

	command: EB_MENUABLE_COMMAND
			-- Command associated with Current.

end -- class EB_TOOL_BAR_BUTTON