indexing
	description: "Objects that represent a new show project settings command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHOW_PROJECT_SETTINGS_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_ACCESSIBLE_XML_HANDLER
	
	GB_ACCESSIBLE_SYSTEM_STATUS
	
	GB_ACCESSIBLE

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Settings...")
			set_pixmaps (<<(create {GB_SHARED_PIXMAPS}).icon_system_window>>)
			set_name ("Settings...")
			set_menu_name ("Settings...")
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only may be executed if the project settings window is
				-- not displayed. There must also be a project open.
			Result := (not project_settings_window.is_show_requested) and 
				system_status.project_open = True
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			do
				project_settings_window.show_modal_to_window (system_status.main_window)
				command_handler.update
			end

end -- class GB_SHOW_PROJECT_SETTINGS_COMMAND