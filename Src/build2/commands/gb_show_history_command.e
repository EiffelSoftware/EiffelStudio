indexing
	description: "Objects that represent a new show project settings command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHOW_HISTORY_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_HISTORY
	
	GB_SHARED_SYSTEM_STATUS

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("History")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_cmd_history)
			set_name ("History")
			set_menu_name ("History")
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only may be executed if the project settings window is
				-- not displayed. There must also be a project open.
			Result := not history.dialog.is_show_requested and not history.is_empty
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			do
					-- Ensure that the appropriate itme is selected.
				history.dialog.select_current_history_position
				history.dialog.show_relative_to_window (system_status.main_window)
				command_handler.update
			end

end -- class GB_SHOW_HISTORY_COMMAND