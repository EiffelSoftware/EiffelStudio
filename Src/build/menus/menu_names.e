indexing
	description: "Class containing the names for the different menus."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_NAMES

feature -- Common

	Actions: STRING is "&Actions"
	File: STRING is "&File"
	Help: STRING is "&Help"
	Menu_bar: STRING is "Menu bar"
	View: STRING is "&View"
	Windows: STRING is "&Windows"

feature -- Menus on main panel

		-- Submenus of `File'

	Exit: STRING is "E&xit"
	Exit_tool: STRING is "Exit &tool"
	Generate: STRING is "&Generate Eiffel code"
	Import: STRING is "&Import EiffelBuild code"
	Save: STRING is "&Save	Ctrl+S"
	Save_as: STRING is "Save as..."
	Toolkit: STRING is "Select &Toolkit"

		-- Submenus of `View'

	Context_catalog: STRING is "Context &catalog"
	Context_editor: STRING is "Context &editor"
	Context_tree: STRING is "Context &tree"
	Command_catalog: STRING is "Command &catalog"
	
		-- Submenus of `Windows'
	
	Application_editor: STRING is "&Application editor"
	Editors: STRING is "&Editors"
	History_window: STRING is "&History window"
	Instance_editor: STRING is "Command &tools"
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
