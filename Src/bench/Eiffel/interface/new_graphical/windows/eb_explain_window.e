indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_WINDOW

inherit
	EB_TOOL_WINDOW
		redefine
			make, make_top_level, tool,
			set_tool_title, destroy_tool
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
			tool.build_file_menu (file_menu)
			create windows_menu.make_with_text (menu_bar, Interface_names.m_Windows)
			build_windows_menu (windows_menu)
		end


feature -- Access

	tool: EB_EXPLAIN_TOOL
			-- the profile tool

	file_menu: EV_MENU

	windows_menu: EV_MENU
 
feature -- Tool management

	set_tool_title (t: like tool; s: STRING) is
			-- Set `title' to `s'.
		do
			precursor (t, s)
			project_tool.change_explain_entry (t)
		end
 
	destroy_tool (t: like tool) is
		do
			Project_tool.remove_explain_entry (t)			
			precursor (t)
		end

end -- class EB_EXPLAIN_WINDOW
