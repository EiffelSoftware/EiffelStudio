indexing
	description: "Objects that represent a new show project settings command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHOW_HIDE_HISTORY_COMMAND
	
inherit

	GB_RESTORABLE_WINDOW_COMMAND
		
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_TOOLS
	
	WIZARD_SHARED
		rename
			pixmap as wizard_pixmap,
			history as wizard_history
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			is_selected := history_dialog.is_show_requested
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
			Result := history_dialog
		end

end -- class GB_SHOW_HIDE_HISTORY_COMMAND