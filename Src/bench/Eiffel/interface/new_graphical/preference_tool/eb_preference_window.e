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

	INTERFACE_NAMES

creation

	make, make_top_level

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create Current with `name' `a_name', and
			-- `screen' `a_screen'.
			-- Create the widgets and show Current on the screen.
		do
			Precursor (par)
			set_size (500, 550)
			forbid_resize

			Create tool.make (Current, Current)

			initialize_main_menu

		ensure then
			created: not destroyed
		end

	make_top_level is
			-- same as make but with no parent
			-- used only for debugging
		do
			Precursor
			Create tool.make (Current, Current)

			initialize_main_menu
--			forbid_resize

			set_size (500, 550)

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
			Create menu_bar.make (Current)

			Create file_menu.make_with_text (menu_bar, "Commands")

			Create i.make_with_text (file_menu, m_Validate)
			i.add_activate_command (tool.validate_cmd, Void)

			Create i.make_with_text (file_menu, m_Save)
			i.add_activate_command (tool.save_cmd, Void)

			Create i.make_with_text (file_menu, m_Ok)
			i.add_activate_command (tool.ok_cmd, Void)

			Create i.make_with_text (file_menu, m_Apply)
			i.add_activate_command (tool.apply_cmd, Void)

			Create i.make_with_text (file_menu, m_Exit)
			i.add_activate_command (tool.exit_cmd, Void)

			Create panel_menu.make_with_text (menu_bar, "Categories")

			pl := tool.panel_list
			from
				pl.start
			until
				pl.after
			loop
				if pl.isfirst then
					Create ri.make_with_text (panel_menu, pl.item.name)
					peer := ri
				else
					Create ri.make_peer_with_text (panel_menu, pl.item.name, peer)
				end
				pl.item.raise_cmd.set_menu_item (ri)
				pl.forth
			end
			

		end


feature -- Display

	close is
			-- Close Current
		do
			hide
		end

feature {NONE} -- Properties

	tool: EB_PREFERENCE_TOOL
			-- the preference tool

	file_menu,
			-- The file menu

	panel_menu,
			-- The panel menu

	help_menu: EV_MENU
			-- The help menu

end -- class EB_PREFERENCE_WINDOW
