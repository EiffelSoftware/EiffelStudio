indexing
	description: "Command that may be linked with a toolbar button and a menu item."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMMAND_FEEDBACK

inherit
	EB_COMMAND

feature -- Initialization

	set_button (a_button: like button) is
			-- Set `button' to `a_button'.
		require
			a_button_non_void: a_button /= Void
		do
			button := a_button
			button.select_actions.extend (~execute)
		ensure
			properly_set: button = a_button
		end

	set_menu_item (a_menu_item: like menu_item) is
			-- Set `menu_item' to `a_menu_item'.
		require
			a_menu_item_non_void: a_menu_item /= Void
		do
			menu_item := a_menu_item
			menu_item.select_actions.extend (~execute)
		ensure
			properly_set: menu_item = a_menu_item
		end

feature -- Status setting

	enable_sensitive is
			-- Set both the `associated_button' and
			-- `associated_menu_entry' to be sensitive.
		do
			if button /= Void then
				button.enable_sensitive
			end
			if menu_item /= Void then
				menu_item.enable_sensitive
			end
		end

	disable_sensitive is
			-- Set both the `associated_button' and
			-- `associated_menu_entry' to be insensitive.
		do
			if button /= Void then
				button.disable_sensitive
			end
			if menu_item /= Void then
				menu_item.disable_sensitive
			end
		end

feature -- Access

	button: EV_TOOL_BAR_BUTTON
			-- Button on the toolbar.

	menu_item: EV_MENU_ITEM
			-- Menu entry in the menu.

end -- class EB_COMMAND_FEEDBACK
