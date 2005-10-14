indexing
	description: "Objects that represent a save command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_SAVE_COMMAND
	
inherit
	GB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_XML_HANDLER
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
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			Precursor {GB_STANDARD_CMD}
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
				;(create {GB_GLOBAL_STATUS}).mark_as_clean
			end

end -- class GB_FILE_SAVE_COMMAND
