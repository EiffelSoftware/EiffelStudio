indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_WINDOW

inherit
	EB_TOOL_WINDOW
		redefine
			make, make_top_level, tool,
			set_tool_title, destroy_tool
		end
	NEW_EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS

	INTERFACE_NAMES

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

				-- a tester
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
			build_file_menu
			create windows_menu.make_with_text (menu_bar, Interface_names.m_Windows)
			build_windows_menu
		end

	build_file_menu is
		local
			i: EV_MENU_ITEM
			open_cmd: EB_OPEN_FILE_CMD
			save_cmd: EB_SAVE_FILE_CMD
			save_as_cmd: EB_SAVE_FILE_AS_CMD
			quit_cmd: EB_CLOSE_EDITOR_CMD
		do
			create open_cmd.make (tool)
			create i.make_with_text (file_menu, m_Open)
			i.add_select_command (open_cmd, Void)

			create save_cmd.make (tool)
			create i.make_with_text (file_menu, m_Save)
			i.add_select_command (save_cmd, Void)

			create save_as_cmd.make (tool)
			create i.make_with_text (file_menu, m_Save_as)
			i.add_select_command (save_as_cmd, Void)

			create quit_cmd.make (tool)
			create i.make_with_text (file_menu, m_Exit)
			i.add_select_command (quit_cmd, Void)

			create i.make_with_text (file_menu, m_Exit_project)

		end	

	build_windows_menu is
		local
			i: EV_MENU_ITEM
			create_class_cmd: EB_CREATE_CLASS_CMD
			create_feature_cmd: EB_CREATE_FEATURE_CMD
			create_object_cmd: EB_CREATE_OBJECT_CMD
			show_preferences: EB_SHOW_PREFERENCE_TOOL
			raise_project_tool: EB_RAISE_TOOL_CMD
		do
			create create_class_cmd.make (project_tool)
			create i.make_with_text (windows_menu, m_New_class)
			i.add_select_command (create_class_cmd, Void)

			create create_feature_cmd.make (project_tool)
			create i.make_with_text (windows_menu, m_New_routine)
			i.add_select_command (create_feature_cmd, Void)

			create create_object_cmd.make (project_tool)
			create i.make_with_text (windows_menu, m_New_object)
			i.add_select_command (create_object_cmd, Void)

			create show_preferences.make
			create i.make_with_text (windows_menu, m_Preferences)
			i.add_select_command (show_preferences, Void)

			create raise_project_tool.make (project_tool)
			create i.make_with_text (windows_menu, m_Raise_project)
			i.add_select_command (raise_project_tool, Void)

			create i.make_with_text (windows_menu, m_Raise_project)
		end	

feature -- Access

	tool: EB_CLASS_TOOL
			-- the profile tool

	file_menu: EV_MENU

	windows_menu: EV_MENU

feature -- Tool management

	set_tool_title (t: like tool; s: STRING) is
			-- Set `title' to `s'.
		do
			precursor (t, s)
			project_tool.change_class_entry (t)
		end
 
	destroy_tool (t: like tool) is
		do
			precursor (t)
			tool_supervisor.remove_class (t)
--			select_tool.remove_tool_entry (t)
			Project_tool.remove_class_entry (t)			
		end

end -- class EB_CLASS_WINDOW
