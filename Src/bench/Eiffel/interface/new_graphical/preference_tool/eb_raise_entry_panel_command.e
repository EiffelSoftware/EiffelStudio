indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RAISE_ENTRY_PANEL_COMMAND

inherit
	EV_COMMAND
		redefine
			execute
		end

creation
	make

feature {NONE} -- Initialization

	make (a_panel: EB_ENTRY_PANEL) is
			-- Initialize Current.
		require
			a_panel_not_void: a_panel /= Void
		do
			panel := a_panel
		end

feature -- Properties

	panel: EB_ENTRY_PANEL
			-- The associated panel

	leaf: EV_TREE_ITEM

	menu_item: EV_RADIO_MENU_ITEM

	button: EV_BUTTON

feature -- Linking

	set_leaf (l: like leaf) is
		do
			leaf := l
			if l /= void then
				l.add_activate_command(Current, void)
			end
		end

	set_menu_item (m: like menu_item) is
		do
			if m /= void then
				menu_item := m
				m.add_activate_command(Current, void)
			end
		end

	set_button (b: EV_BUTTON) is
			-- links b to Current.
		do
			if b /= void then
				button := b
				button.add_click_command(Current, void)
			end
		end

--	unlink_all is
			-- deletes all links
--		do
--			items.wipe_out
--			leaf := void
--			menu_item := void
--			button := void
--		end


feature -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
	
		require else
			panel_exists: not panel.destroyed
			tool_exists: not panel.tool.destroyed
		do
			panel.tool.display_panel (panel)

--			leaf.set_selected (true)
--			menu_item.set_state (true)
		end



end -- class EB_RAISE_ENTRY_PANEL_COMMAND
