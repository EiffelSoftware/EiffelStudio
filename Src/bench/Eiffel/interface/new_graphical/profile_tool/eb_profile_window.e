indexing
	description:
	"The interface for the profile tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_WINDOW

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
			forbid_resize

			create tool.make (Current, Current)

			initialize_main_menu

				-- a tester
--			add_delete_command (quit_cmd, arg)

		ensure then
			created: not destroyed
		end

	make_top_level is
			-- same as make but with no parent
		local
		do
			Precursor
			create tool.make (Current, Current)

			initialize_main_menu

		ensure then
			created: not destroyed
		end


	initialize_main_menu is
			-- Create and initialize `menu_bar'.
		local
			i: EV_MENU_ITEM
--			generate_cmd: EB_GENERATE_PROFILE_INFO_CMD
			show_pref_cmd: EB_SHOW_PREFERENCE_TOOL
			arg: EV_ARGUMENT1 [EV_CONTAINER]

		do
			create menu_bar.make (Current)

			create file_menu.make_with_text (menu_bar, m_File)
			create i.make_with_text (file_menu, "Close Tool")
			i.add_activate_command (tool.quit_cmd, Void)

			create commands_menu.make_with_text (menu_bar, m_Commands)
			create i.make_with_text (commands_menu, "Generate")

			create window_menu.make_with_text (menu_bar, m_Windows)
			create i.make_with_text (window_menu, "Preferences")
			create show_pref_cmd.make
			create arg.make (Current)
			i.add_activate_command (show_pref_cmd, arg)
			

--			create show_pref_menu_entry.make_default (show_pref_cmd, window_menu)

			create help_menu.make_with_text (menu_bar, m_Help)
		end			

--	fill_menus is
--			-- Fill the menus with commands.
--		local
--			generate_menu_entry: EV_MENU_ITEM
--			generate_cmd: EB_GENERATE_PROFILE_INFO_CMD
--			quit_menu_entry: EB_MENU_ITEM
--			help_cmd: EB_PROFILE_HELP_CMD
--			help_menu_entry: EB_MENU_ITEM
--			show_pref_cmd: EB_SHOW_PREFERENCE_TOOL
--			show_pref_menu_entry: EB_MENU_ITEM
--			menu_entry: EB_MENU_ITEM
--			raise_tool_cmd: EB_RAISE_TOOL_CMD
--			sep: EV_HORIZONTAL_SEPARATOR
--		do
--			create generate_cmd
--			create generate_menu_entry.make_default (generate_cmd, command_menu)
--			create help_cmd
--			create help_menu_entry.make_default (help_cmd, help_menu)
--
--			create menu_entry.make 
--				(Project_tool.class_hole_holder.associated_command, window_menu)
--			create menu_entry.make 
--				(Project_tool.routine_hole_holder.associated_command, window_menu)
--			create menu_entry.make 
--				(Project_tool.object_hole_holder.associated_command, window_menu)
--			create sep.make (Interface_names.t_Empty, window_menu)
--			create show_pref_cmd.make (Profiler_resources)
--			create show_pref_menu_entry.make_default (show_pref_cmd, window_menu)
--			create raise_tool_cmd.make (Project_tool)
--			create menu_entry.make (raise_tool_cmd, window_menu)
--		end


feature {NONE} -- Implementation

	tool: EB_PROFILE_TOOL
			-- the profile tool
	
	file_menu,
			-- The file menu

	commands_menu,
			-- The commands menu

	window_menu,
			-- The window menu

	help_menu: EV_MENU
			-- The help menu

end -- class EB_PROFILE_WINDOW
