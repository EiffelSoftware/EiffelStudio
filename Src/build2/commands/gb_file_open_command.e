indexing
	description: "Objects that represent the open command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_OPEN_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
	
	GB_ACCESSIBLE_XML_HANDLER
	
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_ACCESSIBLE
	
	GB_WIDGET_UTILITIES
	
	GB_ACCESSIBLE_SYSTEM_STATUS

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Open Project...")
			set_name ("Open project...")
			set_menu_name ("Open Project...")
			enable_sensitive
			add_agent (agent execute)
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only can execute if there is no project open.
			Result := not (system_status.project_open)
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				dialog: EV_FILE_OPEN_DIALOG
				project_settings: GB_PROJECT_SETTINGS
			do
				create dialog
				dialog.show_modal_to_window (system_status.main_window)
				if not dialog.file_name.is_empty then
					create project_settings
					project_settings.load (dialog.file_name)
					system_status.set_current_project (project_settings)
					xml_handler.load
					command_handler.update	
				end
			end

end -- class GB_FILE_OPEN_COMMAND
