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
		
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_XML_HANDLER
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_OBJECT_EDITORS
	
	GB_SHARED_COMPONENT_VIEWER
	
	GB_SHARED_HISTORY
	
	GB_SHARED_TOOLS
	
	GB_CONSTANTS
	
	EV_DIALOG_CONSTANTS

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Close project")
			set_name ("Close project")
			set_menu_name ("Close project")
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
				if system_status.project_modified then
					create dialog.make_with_text (Save_prompt)
					dialog.show_modal_to_window (system_status.main_window)
						-- Do nothing if cancel was pressed.
					if not dialog.selected_button.is_equal (Ev_cancel) then
						if dialog.selected_button.is_equal (Ev_yes) then
							-- Must now save.
							command_handler.save_command.execute
						end
						perform_close
					end
				else
					perform_close
				end
			end
			
		perform_close is
				-- Actually perfrom the closing of the project.
			do
				object_handler.clear_all_objects
					-- This must be called before we hide the tools, 
					-- as during this call, we find the parent window
					-- of the `docked_object_editor'.
				docked_object_editor.make_empty
				system_status.close_current_project
				system_status.main_window.hide_tools
				destroy_floating_editors

					-- Hide the component viewer.
				if component_viewer.is_show_requested then
					command_handler.show_hide_component_viewer_command.execute
				end
				if display_window.is_show_requested then
					command_handler.show_hide_display_window_command.execute
				end
					-- Hide the display and builder windows.
				if builder_window.is_show_requested then
					command_handler.show_hide_builder_window_command.execute
				end
				
					-- Hide the history window.
				if not command_handler.show_history_command.executable then
					history.dialog.hide
				end
					-- Remove the history.
				history.wipe_out
	
				command_handler.update	
			end

end -- class GB_CLOSE_PROJECT_COMMAND
