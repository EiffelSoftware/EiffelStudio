
indexing
	description: "Objects that represent a new project command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NEW_PROJECT_COMMAND
	
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
			set_tooltip ("New project...")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_new_editor)
			set_name ("New project...")
			set_menu_name ("New project...")
			enable_sensitive
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
				settings: GB_PROJECT_SETTINGS
				dialog: EV_DIRECTORY_DIALOG
			do
				create dialog
				dialog.show_modal_to_window (system_status.main_window)
					-- If a directory was chosen.
				if not dialog.directory.is_empty then
					create settings.make_with_default_values
					settings.set_project_location (dialog.directory)
					system_status.set_current_project (settings)
				end
				command_handler.update
			end

end -- class GB_NEW_PROJECT_COMMAND