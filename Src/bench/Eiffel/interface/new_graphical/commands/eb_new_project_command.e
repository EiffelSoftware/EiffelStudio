indexing
	description	: "Command to create a new project."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_PROJECT_COMMAND

inherit
	EB_COMMAND

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_PROJECT_TOOL_DATA
		export
			{NONE} all
		end

	EB_DEBUG_TOOL_DATA
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end
create
	make,
	make_with_parent

feature {NONE} -- Initialization

	make is
			-- Create the command relative to the last focused window
		do
			internal_parent_window := Void
		end

	make_with_parent (a_window: EV_WINDOW) is
			-- Create the command relative to the parent window `a_window'
		require
			a_window_not_void: a_window /= Void
		do
			internal_parent_window := a_window
		ensure
			internal_parent_window_valid: internal_parent_window /= Void
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Execution

	execute is
			-- Let the user choose the kind of new project he wants to create.
		local
			new_project_dialog: EB_STARTING_DIALOG
		do
			create new_project_dialog.make_without_open_project_frame
			new_project_dialog.show_modal_to_window (parent_window)
		end

feature -- Project initialization

	create_project (dir: STRING; ask_confirmation: BOOLEAN) is
			-- Create a project in directory `dir'.
			-- Ask confirmation before deleting the EIFGEN if `ask_confirmation' is set.
		local
			wd: EV_WARNING_DIALOG
			qd: EV_QUESTION_DIALOG
			curr_directory: DIRECTORY
			epr_file_name: STRING
			epr_full_file_name: FILE_NAME
			epr_file: PROJECT_EIFFEL_FILE
		do
			create project_dir.make (dir, Void)
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (dir)

			if not project_dir.has_base_full_access then
				choose_again := True
				create wd.make_with_text (Warning_messages.w_Cannot_create_project_directory (project_dir.name))
				wd.show_modal_to_window (parent_window)
			else
					-- Look for an "epr" file.
				create curr_directory.make_open_read (dir)
				from
					curr_directory.start
					curr_directory.readentry
				until
					epr_file_name /= Void or else curr_directory.lastentry = Void
				loop
					if (curr_directory.lastentry.substring_index (".epr", 1) /= 0) then
						epr_file_name := clone (curr_directory.lastentry)
					end
					curr_directory.readentry
				end
				
				if ask_confirmation and then epr_file_name /= Void then
					create epr_full_file_name.make_from_string (dir)
					epr_full_file_name.set_file_name (epr_file_name)
					create epr_file.make (epr_full_file_name)
					project_dir.set_project_file (epr_file)
					if project_dir.exists then
						create qd.make_with_text (Warning_messages.w_Project_exists (project_dir.name))
						qd.show_modal_to_window (parent_window)
						if qd.selected_button /= Void and then qd.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_yes) then
							init_project
						end
					else
							-- No "EIFGEN" file -> there is no project... go ahead.
						init_project
					end
				else
						-- No "epr" file or no confirmation asked -> there is no project... go ahead.
					init_project
				end
			end
		end

feature {NONE} -- Implementation

	init_project is
			-- Initialize project.
		local
			msg: STRING
			retried: BOOLEAN
			error_dialog: EV_ERROR_DIALOG
		do
			if not retried then
					-- Create & show the deleting dialog
--				build_deleting_dialog
--				parent_window.disable_sensitive

					-- Create a new project (and delete the content of the
					-- directory if necessarry)
				Eiffel_project.make_new (project_dir, True, agent on_delete_directory, agent on_cancel_operation)

					-- Destroy and forget the "deleting" dialog
				if deleting_dialog /= Void then
					parent_window.enable_sensitive
					deleting_dialog.destroy
					deleting_dialog := Void
				end

				if Eiffel_project.initialized then
					msg := clone (Interface_names.t_New_project)
					msg.append (": ")
					msg.append (project_dir.name)

					Application.set_interrupt_number (interrupt_every_n_instructions)
				end
			else
					-- We were unable to complete the task due to an error
					-- We display an error message asking the user if he
					-- want to abort the initialization of the project or
					-- not.
				if deleting_dialog /= Void then
					parent_window.enable_sensitive
					deleting_dialog.destroy
					deleting_dialog := Void
				end
				create error_dialog.make_with_text (Warning_messages.w_Cannot_create_project_directory (project_dir.name))
				error_dialog.set_buttons (<<Interface_names.b_Abort, Interface_names.b_Retry>>)
				error_dialog.set_default_push_button (error_dialog.button (Interface_names.b_Retry))
				error_dialog.set_default_cancel_button (error_dialog.button (Interface_names.b_Abort))
				error_dialog.show_modal_to_window (parent_window)
				if error_dialog.selected_button.is_equal (Interface_names.b_Retry) then
					init_project -- Restart the initialization of the project
				else
					-- If the user has pressed "Abort", the function will do stop and do nothing.
				end
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	make_new_project is
			-- Create a new project
		do
			
		end
		

	build_deleting_dialog is
			-- Build the dialog displayed to have the user wait during the
			-- deletion of a directory.
		local
			label_font: EV_FONT
			pixmap: EV_PIXMAP
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			pixmap_box: EV_CELL
			button_box: EV_HORIZONTAL_BOX
			cancel_button: EV_BUTTON
		do
				-- Create and display a dialog to have the user wait.
			pixmap := clone ((create {EV_STOCK_PIXMAPS}).Information_pixmap)
			create pixmap_box
			pixmap_box.extend (pixmap)
			pixmap_box.set_minimum_size (pixmap.width, pixmap.height)

			create deleting_dialog_label
			deleting_dialog_label.align_text_left
			deleting_dialog_label.set_text (Interface_names.l_Deleting_dialog_default)
			label_font := deleting_dialog_label.font
			deleting_dialog_label.set_minimum_size (
				label_font.width * Minimum_width_of_Deleting_dialog,
				label_font.height * Minimum_height_of_Deleting_dialog
				)

			create cancel_button.make_with_text (Interface_names.b_Cancel)
			Layout_constants.set_default_size_for_button (cancel_button)
			cancel_button.select_actions.extend (agent on_cancel_button_pushed)

			create hb
			hb.set_border_width (Layout_constants.Default_border_size)
			hb.set_padding (Layout_constants.Default_padding_size)
			hb.extend (pixmap_box)
			hb.disable_item_expand (pixmap_box)
			hb.extend (deleting_dialog_label)

			create button_box
			button_box.set_padding (Layout_constants.Default_padding_size)
			button_box.set_border_width (Layout_constants.Default_border_size)
			button_box.extend (create {EV_CELL})
			button_box.extend (cancel_button)
			button_box.disable_item_expand (cancel_button)
			button_box.extend (create {EV_CELL})

			create vb
			vb.extend (hb)
			vb.extend (button_box)
			vb.disable_item_expand (button_box)

			create deleting_dialog
			deleting_dialog.extend (vb)
			deleting_dialog.set_default_cancel_button (cancel_button)
			deleting_dialog.set_title (Interface_names.t_Deleting_files)
			deleting_dialog.show_relative_to_window (parent_window)
		end

	on_delete_directory (deleted_files: ARRAYED_LIST [STRING]) is
			-- The files in `deleted_files' have just been deleted.
			-- Display 
		local
			ise_directory_utils: ISE_DIRECTORY_UTILITIES
			deleted_file_pathname: STRING
		do
			if deleting_dialog = Void then
				build_deleting_dialog
				parent_window.disable_sensitive
			end
			create ise_directory_utils
			deleted_file_pathname := ise_directory_utils.path_ellipsis (deleted_files.first, Path_ellipsis_width)
			check
				deleting_dialog_label_exists: deleting_dialog_label /= Void
			end
			deleting_dialog_label.set_text (deleted_file_pathname)
			ev_application.process_events
		end

	on_cancel_operation: BOOLEAN is
			-- Has the user pushed the "Cancel" in the deleting dialog?
		do
			Result := cancel_button_pushed
		end
	
	on_cancel_button_pushed is
			-- The user has just pushed the "Cancel" in the deleting dialog.
		do
			cancel_button_pushed := True
		end

feature {NONE} -- Callbacks

	execute_callback (dialog: EV_DIRECTORY_DIALOG) is
			-- Get callback information from `dialog', then create the project if possible
		local
			wd: EV_WARNING_DIALOG
			dir_name, ebench_name: STRING
			last_char: CHARACTER
		do
			dir_name := dialog.directory
			if dir_name.is_empty then
				choose_again := True
				create wd.make_with_text (Warning_messages.w_directory_not_exist (dir_name))
				wd.show_modal_to_window (parent_window)
			else
					--| Since Vision is returning a directory name with
					--| a directory separator, we need to be sure that we
					--| will remove it
				if dir_name.count > 1 then
					last_char := dir_name.item (dir_name.count)
					if last_char = Operating_environment.Directory_separator then
						dir_name.remove (dir_name.count)
					end
				end
				if not Eiffel_Project.initialized then
					create_project (dir_name, True)
				else
					ebench_name := clone (Ebench_command_name)
					ebench_name.append (" -create ")
					ebench_name.append (dir_name)
					launch_ebench (ebench_name)
				end
			end
		end

	parent_window: EV_WINDOW is
			-- Parent window.
		local
			dev_window: EB_DEVELOPMENT_WINDOW
		do
			if internal_parent_window /= Void then
				Result := internal_parent_window
			else
				dev_window := window_manager.last_focused_development_window
				if dev_window /= Void then
					Result := dev_window.window
				else
					create Result
				end
			end
		ensure
			Result_not_void: Result /= Void
		end
	
	internal_parent_window: EV_WINDOW
			-- Parent window if any, Void if none.
	
feature {NONE} -- Implementation / Private attributes

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory

	deleting_dialog: EV_DIALOG
			-- Dialog displaying that the program is currently deleting
			-- some files.

	deleting_dialog_label: EV_LABEL
			-- Label displaying the file currently being deleted

	choose_again: BOOLEAN
			-- We need to choose again the file

	cancel_button_pushed: BOOLEAN
			-- Has the cancel button beem pushed?

feature {NONE} -- Implementation / Private constants.

	Minimum_width_of_Deleting_dialog: INTEGER is 70
			-- Minimum width of the deleting dialog in characters.

	Minimum_height_of_Deleting_dialog: INTEGER is 2
			-- Minimum height of the deleting dialog in characters.

	Path_ellipsis_width: INTEGER is 
			-- Maximum number of characters per item.
		once	
			Result := Minimum_width_of_Deleting_dialog - 10
		end

end -- class EB_NEW_PROJECT_CMD
