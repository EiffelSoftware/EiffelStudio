indexing
	description: "Objects that represent a redo command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_REDO_COMMAND
	
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
			set_tooltip ("Redo")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_redo)
			set_name ("Redo")
			set_menu_name ("Redo")
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result :=  history.current_position < history.command_list.count
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			do
				history.redo
				command_handler.update
			end

end -- class GB_REDO_COMMAND
