indexing
	description: "Objects that represent a save command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_SAVE_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_ACCESSIBLE_XML_HANDLER
	
	GB_ACCESSIBLE_SYSTEM_STATUS
	
	GB_ACCESSIBLE_OBJECT_EDITOR

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
			set_tooltip ("Save")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_save)
			set_name ("Save")
			set_menu_name ("Save")
			disable_sensitive
			add_agent (agent execute)

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_s)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := system_status.project_open and system_status.project_modified
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			do
				force_name_change_completion_on_all_editors
				system_status.current_project_settings.save
				xml_handler.save
					-- Notify the system that the saved version is now up to date.
				system_status.disable_project_modified
				command_handler.update
			end

end -- class GB_FILE_SAVE_COMMAND
