indexing

	description:
		"The interface for the preference tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCE_WINDOW

inherit
	EB_TOOL_WINDOW
		redefine
			make, make_top_level, tool
		end

creation

	make, make_top_level

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create Current with `name' `a_name', and
			-- `screen' `a_screen'.
			-- Create the widgets and show Current on the screen.
		do
			Precursor (par)
--			forbid_resize
			create tool.make (Current)

			initialize_main_menu

		ensure then
			created: not destroyed
		end

	make_top_level is
			-- same as make but with no parent
			-- used only for debugging
		do
			Precursor
			create tool.make (Current)

			initialize_main_menu
--			forbid_resize

		ensure then
			created: not destroyed
		end


	initialize_main_menu is
			-- Create and initialize `menu_bar'.
		local
			i: EV_MENU_ITEM
			ri, peer: EV_RADIO_MENU_ITEM
			pl: EB_PANEL_LIST
		do
			create menu_bar.make (Current)

			create file_menu.make_with_text (menu_bar, "Commands")

			create i.make_with_text (file_menu, m_Validate)
			i.add_select_command (tool.validate_cmd, Void)

			create i.make_with_text (file_menu, m_Save)
			i.add_select_command (tool.save_cmd, Void)

			create i.make_with_text (file_menu, m_Ok)
			i.add_select_command (tool.ok_cmd, Void)

			create i.make_with_text (file_menu, m_Apply)
			i.add_select_command (tool.apply_cmd, Void)

			create i.make_with_text (file_menu, m_Exit)
			i.add_select_command (tool.close_cmd, Void)

			create panel_menu.make_with_text (menu_bar, "Categories")

			pl := tool.panel_list
			from
				pl.start
			until
				pl.after
			loop
				if pl.isfirst then
					create ri.make_with_text (panel_menu, pl.item.name)
					peer := ri
				else
					create ri.make_peer_with_text (panel_menu, pl.item.name, peer)
				end
				pl.item.raise_cmd.set_menu_item (ri)
				pl.forth
			end
			

		end

feature -- Access

	tool: EB_PREFERENCE_TOOL
			-- the preference tool

feature -- Display

	close is
		obsolete
			"use hide or destroy"
			-- Close Current
		do
			hide
		end

feature {NONE} -- Properties

	file_menu,
			-- The file menu

	panel_menu,
			-- The panel menu

	help_menu: EV_MENU
			-- The help menu

end -- class EB_PREFERENCE_WINDOW
