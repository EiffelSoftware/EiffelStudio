indexing
	description: "Objects that represent an undo command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_UNDO_COMMAND
	
inherit
	GB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {GB_STANDARD_CMD}
			set_tooltip ("Undo")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_undo)
			set_name ("Undo")
			set_menu_name ("Undo")
			add_agent (agent execute)
				-- Now add an accelerator for `Current'.
			set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_z),
				True, False, False))
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
				force_name_change_completion_on_all_editors
				if executable then
					history.undo
					command_handler.update
				end
			end

end -- class GB_REDO
