indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_WINDOW

inherit
	EB_TOOL_WINDOW
		redefine
			make, make_top_level, tool
		end
	NEW_EB_CONSTANTS

creation
	make, make_top_level

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create Current with `name' `a_name'
			-- Create the widgets and show Current on the screen.
		do
			Precursor (par)

			create tool.make (Current)

			initialize_main_menu

			add_close_command (tool.close_cmd, Void)

		ensure then
			created: not destroyed
		end

	make_top_level is
			-- same as make but with no parent
		local
		do
			Precursor
			create tool.make (Current)

			initialize_main_menu

			add_close_command (tool.close_cmd, Void)

		ensure then
			created: not destroyed
		end

	initialize_main_menu is
			-- Create and initialize `menu_bar'.
		do
			create menu_bar.make (Current)
			create file_menu.make_with_text (menu_bar, Interface_names.m_File)
			tool.build_file_menu (file_menu)
			create format_menu.make_with_text (menu_bar, Interface_names.m_Formats)
			tool.build_format_menu (format_menu)
			create windows_menu.make_with_text (menu_bar, Interface_names.m_Windows)
			build_windows_menu (windows_menu)
		end

	build_file_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
			open_cmd: EB_OPEN_SYSTEM_CMD
			save_cmd: EB_SAVE_SYSTEM_CMD
			save_as_cmd: EB_SAVE_SYSTEM_AS_CMD
		do
			create open_cmd.make (tool)
			create i.make_with_text (a_menu, m_Open)
			i.add_select_command (open_cmd, Void)

			create save_cmd.make (tool)
			create i.make_with_text (a_menu, m_Save)
			i.add_select_command (save_cmd, Void)

			create save_as_cmd.make (tool)
			create i.make_with_text (a_menu, m_Save_as)
			i.add_select_command (save_as_cmd, Void)

			create i.make_with_text (a_menu, m_Exit)
			i.add_select_command (tool.close_cmd, Void)

			create i.make_with_text (a_menu, m_Exit_project)
			i.add_select_command (tool.exit_app_cmd, Void)

		end

feature -- Access

	tool: EB_SYSTEM_TOOL
			-- the system tool

	file_menu: EV_MENU

	format_menu: EV_MENU

	windows_menu: EV_MENU
 
end -- class EB_SYSTEM_WINDOW
