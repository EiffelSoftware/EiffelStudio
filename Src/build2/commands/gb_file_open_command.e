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
	
	GB_SHARED_XML_HANDLER
	
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_TOOLS
	
	GB_WIDGET_UTILITIES
	
	GB_CONSTANTS
	
	GB_SHARED_SYSTEM_STATUS

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Open Project...")
			set_name ("Open project...")
			set_menu_name ("Open Project...")
			enable_sensitive
			add_agent (agent execute)

					-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_o)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
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
				opened: BOOLEAN
				file_handler: GB_SIMPLE_XML_FILE_HANDLER
			do
				create dialog
				dialog.set_filter (project_file_filter)
				create file_handler
					-- We do not allow the dialog to close until a valid
					-- file name has been entered or the user clicks the
					-- cancel button.
					-- As the file name is empty before the dialog is shown,
					-- we use `opened' to ensure that it opens the first
					-- time.
				from
				until
					opened and then
					((valid_file_name (dialog.file_name) and file_handler.last_load_successful) or dialog.file_name.is_empty)
				loop
						-- Display the dialog.
					dialog.show_modal_to_window (main_window)
						-- The dialog has now been opened once.
					opened := True
						-- If the ok button was clicked and the file name exists,
						-- then we attempt to open it.
					if not dialog.file_name.is_empty and valid_file_name (dialog.file_name) then
						create project_settings
						project_settings.load (dialog.file_name, file_handler)
						if file_handler.last_load_successful then
							system_status.set_current_project (project_settings)
							xml_handler.load
							main_window.show_tools
							command_handler.update
						end	
					end
				end
			end

feature {NONE} -- Implementation

	valid_file_name (file_name: STRING): BOOLEAN is
			-- Is `file_name' the name of an existing file?
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
		do
			if not file_name.is_empty then
				create file.make (file_name)
				Result := file.exists
			end
		end

end -- class GB_FILE_OPEN_COMMAND
