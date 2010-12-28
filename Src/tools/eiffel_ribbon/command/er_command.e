note
	description: "[
						Common ancestor for all commands in ribbon tool
						UI command pattern
																		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_COMMAND

feature {NONE} -- Initialization

	init
			--
		do
			create menu_items.make (1)
			create tool_bar_items.make (1)
		end

feature -- Command

	execute
			--
		deferred
		end

feature {NONE}  -- Implementation

	menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Managed menu items

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Managed tool bar items

end
