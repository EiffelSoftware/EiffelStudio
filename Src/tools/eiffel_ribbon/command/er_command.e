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

	disable
			--
		do
			from
				menu_items.start
			until
				menu_items.after
			loop
				menu_items.item.disable_sensitive
				menu_items.forth
			end

			from
				tool_bar_items.start
			until
				tool_bar_items.after
			loop
				tool_bar_items.item.disable_sensitive
				tool_bar_items.forth
			end
		end

	enable
			--
		do
			from
				menu_items.start
			until
				menu_items.after
			loop
				menu_items.item.enable_sensitive
				menu_items.forth
			end

			from
				tool_bar_items.start
			until
				tool_bar_items.after
			loop
				tool_bar_items.item.enable_sensitive
				tool_bar_items.forth
			end
		end

feature {NONE}  -- Implementation

	menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Managed menu items

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_BUTTON]
			-- Managed tool bar items

end
