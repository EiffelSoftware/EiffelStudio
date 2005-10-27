indexing
	description: "Objects that represent a close project command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLOSE_PROJECT_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_RECENT_PROJECTS
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		local
			--	acc: EV_ACCELERATOR
			--	key: EV_KEY
		do
			components := a_components
			make
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
			Result := components.system_status.project_open
		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			local
				dialog: EV_QUESTION_DIALOG
			do
				if components.system_status.project_modified then
					create dialog.make_with_text (Save_prompt)
					dialog.set_icon_pixmap (Icon_build_window @ 1)
					dialog.show_modal_to_window (components.tools.main_window)
						-- Do nothing if cancel was pressed.
					if not dialog.selected_button.is_equal (Ev_cancel) then
						if dialog.selected_button.is_equal (Ev_yes) then
							-- Must now save.
							components.commands.save_command.execute
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
				components.object_editors.docked_object_editor.make_empty
				add_project_to_recent_projects
				components.system_status.close_current_project
				components.events.close_project_start_actions.call (Void)
				components.object_editors.destroy_floating_editors

					-- Hide the component viewer.
				if components.tools.component_viewer.is_show_requested then
					components.commands.show_hide_component_viewer_command.execute
				end
					-- Hide the display and builder windows.
				if components.tools.display_window.is_show_requested then
					components.commands.show_hide_display_window_command.execute
				end
				if components.tools.builder_window.is_show_requested then
					components.commands.show_hide_builder_window_command.execute
				end
					-- Hide the constants dialog.
				if components.tools.Constants_dialog.is_show_requested then
					components.commands.Show_hide_constants_dialog_command.execute
				end

					-- Clear the objects. This will also reset the display and builder
					-- windows from the titled window object which is the root of the
					-- layout constructor.
				components.object_handler.clear_all_objects

					-- Clear the component viewer					
				components.tools.component_viewer.clear

					-- Hide the history window.
				if components.tools.history_dialog.is_show_requested then
					components.commands.show_hide_history_command.execute
				end
					-- Remove the history.
				components.history.wipe_out

					-- Restore Id counter to default
				components.id_handler.reset_id_counter

					-- Ensure that the project is not flagged as modified, as no
					-- project will now be open
				components.System_status.disable_project_modified

					-- Now reset all constants.
				components.constants.reset

					-- Ensure there is no longer a root window.
				components.object_handler.remove_root_window

				components.commands.update
				components.events.close_project_finish_actions.call (Void)
			end

end -- class GB_CLOSE_PROJECT_COMMAND
