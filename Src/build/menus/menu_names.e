indexing
	description: "Class containing the names for the different menus."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_NAMES

feature -- Common

	Actions: STRING is "&Actions"
	Exit: STRING is "E&xit"
	Exit_tool: STRING is "Exit &tool"
	File: STRING is "&File"
	Generate: STRING is "&Generate Eiffel code"
	Help: STRING is "&Help"
	Menu_bar: STRING is "Menu bar"
	View: STRING is "&View"

feature -- Menus on main panel

		-- Submenus of `File'

	Import: STRING is "&Import EiffelBuild code"

		-- Submenus of `View'

	Application_editor: STRING is "&Application editor"
	Context: STRING is "Con&text"
	Context_catalog: STRING is "Context &catalog"
	Context_editor: STRING is "Context &editor"
	Context_tree: STRING is "Context &tree"
	Command: STRING is "Co&mmand"
	Command_catalog: STRING is "Command &catalog"
	Command_editor: STRING is "Command &text editor"
	Editors: STRING is "&Editors"
	History_window: STRING is "&History window"
	Instance_editor: STRING is "Command &tool"
	Interface: STRING is "&Interface"
	Interface_only: STRING is "Interface &only"
	Class_importer: STRING is "Class im&porter"

		-- Submenus of `Help'

feature -- Menus on command tool

		-- Submenus of `Actions'

	Add_formal_argument: STRING is "&Add a formal argument"
	Create_command: STRING is "&Create new command"
	Remove_formal_argument: STRING is "&Remove a formal argument"

end -- class MENU_NAMES
