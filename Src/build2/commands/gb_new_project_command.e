
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
	
	GB_CONSTANTS

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
			set_tooltip ("New project...")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_new_editor)
			set_name ("New project...")
			set_menu_name ("New project...")
			enable_sensitive

					-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_n)
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
				settings: GB_PROJECT_SETTINGS
				dialog: EV_DIRECTORY_DIALOG
				raw_file: RAW_FILE
				file_name: FILE_NAME
				shown_once, created_project: BOOLEAN
				conf_dialog: EV_CONFIRMATION_DIALOG
				create_project: BOOLEAN
			do
				from
					create dialog
				until
					(dialog.directory.is_empty and shown_once) or created_project
				loop
					shown_once := True
					create_project := True
					dialog.show_modal_to_window (system_status.main_window)
						-- If a directory was chosen.
					if not dialog.directory.is_empty then
						create file_name.make_from_string (dialog.directory)
						file_name.extend (Project_filename)
						create raw_file.make (file_name)
						if raw_file.exists then
							create conf_dialog.make_with_text (Project_exists_warning)
							conf_dialog.show_modal_to_window (system_status.main_window)
							if not conf_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
								create_project := False
							end
						end
						if create_project then
							created_project := True
							create settings.make_with_default_values
							settings.set_project_location (dialog.directory)
							system_status.set_current_project (settings)
							system_status.main_window.show_tools
							command_handler.update
						end
					end
				end				
			end

end -- class GB_NEW_PROJECT_COMMAND