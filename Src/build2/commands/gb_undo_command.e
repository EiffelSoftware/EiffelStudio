indexing
	description: "Objects that represent an undo command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_UNDO_COMMAND
	
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
			set_tooltip ("Undo")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_undo)
			set_name ("Undo")
			set_menu_name ("Undo")
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result :=  history.current_position > 0
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			do
				--project_settings_window.show_relative_to_window (system_status.main_window)
				--history.dialog.show_relative_to_window (system_status.main_window)
				history.undo
				command_handler.update
			end

end -- class GB_REDO