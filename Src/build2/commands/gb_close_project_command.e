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
		export
			{NONE} all
		end
	
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		end

	GB_RECENT_PROJECTS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
	
	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_ID
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			--	acc: EV_ACCELERATOR
			--	key: EV_KEY
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Close Project")
			set_name ("Close Project")
			set_menu_name ("Close Project")
			disable_sensitive
			add_agent (agent execute)
			
				-- Removed for now, as it clashes with keyboard
				-- cut command.
	--		create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_c)
	--		create acc.make_with_key_combination (key, True, False, False)
	--		set_accelerator (acc)
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
					dialog.show_modal_to_window (main_window)
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
				-- Actually perform the closing of the project.
			do
					-- This must be called before we hide the tools, 
					-- as during this call, we find the parent window
					-- of the `docked_object_editor'.
				docked_object_editor.make_empty
				add_project_to_recent_projects
				system_status.close_current_project
				main_window.update_recent_projects
				main_window.hide_tools
				destroy_floating_editors

					-- Hide the component viewer.
				if component_viewer.is_show_requested then
					command_handler.show_hide_component_viewer_command.execute
				end
					-- Hide the display and builder windows.
				if display_window.is_show_requested then
					command_handler.show_hide_display_window_command.execute
				end
				if builder_window.is_show_requested then
					command_handler.show_hide_builder_window_command.execute
				end
					-- Hide the constants dialog.
				if Constants_dialog.is_show_requested then
					command_handler.Show_hide_constants_dialog_command.execute
				end
					
					-- Now empty `multiple_split_area'.
				multiple_split_area.wipe_out
				
					-- Clear the objects. This will also reset the display and builder
					-- windows from the titled window object which is the root of the
					-- layout constructor.
				object_handler.clear_all_objects
				
					-- Clear the component viewer					
				component_viewer.clear
				
					-- Hide the history window.
				if history.history_dialog.is_show_requested then
					command_handler.show_hide_history_command.execute
				end
					-- Remove the history.
				history.wipe_out
				
					-- Restore Id counter to default
				reset_id_counter
				
					-- Ensure that the project is not flagged as modified, as no
					-- project will now be open
				System_status.disable_project_modified
				
					-- Now reset all constants.
				constants.reset
				
					-- Ensure there is no longer a root window.
				Object_handler.remove_root_window
				
				command_handler.update
			end

end -- class GB_CLOSE_PROJECT_COMMAND
