indexing
	description: "Command liked with selectable widgets"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TWO_STATES_COMMAND_FEEDBACK

inherit
	EB_COMMAND_FEEDBACK
		redefine
			button, menu_item
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Set both `button' and `menu_entry'
			-- to be selected or not, according to `flag'.
		do
			if button /= Void and then (button.is_selected /= flag) then
				button.set_selected (flag)
			end
			if menu_item /= Void and then (menu_item.is_selected /= flag) then
				menu_item.set_selected (flag)
			end
		end

feature -- Access

	button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button on the toolbars.

	menu_item: EV_CHECK_MENU_ITEM
			-- Menu entry in the menus.

end -- class EB_TWO_STATES_COMMAND_FEEDBACK
