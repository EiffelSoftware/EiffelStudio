indexing
	description: "Objects that represent a new show project settings command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHOW_HIDE_HISTORY_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND

create
	make_with_components

feature {GB_COMMAND_HANDLER} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current'.
		do
			components := a_components
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := Show_hide_history_window_menu_text
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_cmd_history
		end

feature -- Basic operations

	window: EV_DIALOG is
			-- Result is window referenced by
			-- `Current' command.
		do
			Result := components.tools.history_dialog
		end

end -- class GB_SHOW_HIDE_HISTORY_COMMAND
