indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMMAND_FEEDBACK

feature -- Initialization

	set_button (a_button: like button) is
			-- Set `button' to `a_button'.
		require
			a_button_non_void: a_button /= Void
		do
			button := a_button
		ensure
			properly_set: button = a_button
		end

	set_menu_item (a_menu_item: like menu_item) is
			-- Set `menu_item' to `a_menu_item'.
		require
			a_menu_item_non_void: a_menu_item /= Void
		do
			menu_item := a_menu_item
		ensure
			properly_set: menu_item = a_menu_item
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Set both `button' and `menu_entry'
			-- to be selected or not, according to `flag'.
		do
			if button /= Void then
				button.set_selected (flag)
			end
			if menu_item /= Void then
				menu_item.set_selected (flag)
			end
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be insensitive or not, according to `flag'.
		do
			if button /= Void then
				button.set_insensitive (flag)
			end
			if menu_item /= Void then
				menu_item.set_insensitive (flag)
			end
		end


feature -- Access

	button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button on the toolbars.

	menu_item: EV_MENU_ITEM
			-- Menu entry in the menus.

end -- class EB_COMMAND_FEEDBACK
