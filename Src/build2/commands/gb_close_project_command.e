indexing
	description: "Objects that represent a close project command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLOSE_PROJECT_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_ACCESSIBLE_XML_HANDLER
	
	GB_ACCESSIBLE_SYSTEM_STATUS
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	GB_CONSTANTS
	
	EV_DIALOG_CONSTANTS

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Close")
			--set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_save)
			set_name ("Close")
			set_menu_name ("Close")
			disable_sensitive
			add_agent (agent execute)
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := system_status.project_open
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				dialog: EV_QUESTION_DIALOG
			do
				create dialog.make_with_text (Save_prompt)
				dialog.show_modal_to_window (system_status.main_window)
					-- Do nothing if cancel was pressed.
				if not dialog.selected_button.is_equal (Ev_cancel) then
					if dialog.selected_button.is_equal (Ev_yes) then
						-- Must now save.
						command_handler.save_command.execute
					end
					object_handler.clear_all_objects
					system_status.close_current_project
					command_handler.update	
				end
			end

end -- class GB_CLOSE_PROJECT_COMMAND
