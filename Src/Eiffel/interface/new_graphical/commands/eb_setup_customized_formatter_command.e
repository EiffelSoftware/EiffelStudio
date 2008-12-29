note
	description: "Command to popup a dialog to setup customized formatter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SETUP_CUSTOMIZED_FORMATTER_COMMAND

inherit
	EB_SHARED_INTERFACE_TOOLS
	EB_MENUABLE_COMMAND
	EB_CONSTANTS
	EB_SHARED_FORMATTER_DIALOGS

feature -- Access

	menu_name: STRING_GENERAL
			-- Menu entry associated with `Current'.
		do
			Result := Interface_names.t_setup_customized_formatter
		end

feature -- Execution

	execute
		do
			reload_customized_formatter (False)
			popup_formatter_dialog (window_manager.last_focused_development_window)
		end

end
