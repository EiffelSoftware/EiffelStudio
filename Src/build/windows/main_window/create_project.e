indexing
	description: "Command call to create a new project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CREATE_PROJECT

inherit
	EV_COMMAND

	CONSTANTS

	WINDOWS
		redefine
			question_ok_action,
			question_cancel_action
		end

--	SHARED_STORAGE_INFO

	ERROR_POPUPER

feature {OPEN_PROJECT} -- Command

	rescued: BOOLEAN

	execute (arg: EV_ARGUMENT1 [EV_DIRECTORY_SELECTION_DIALOG]; ev_data: EV_EVENT_DATA) is
		do
			create_project (arg.first.directory)
		end

	create_project (txt: STRING) is
		local
			dir: PLAIN_TEXT_FILE
			char: CHARACTER	
			proj_dir: STRING
			storage_file_name: FILE_NAME
		do
			if main_window.project_initialized then
				clear_project
			end
			proj_dir := Environment.project_directory
			proj_dir.wipe_out
			proj_dir.append (txt)
			proj_dir.prune_all (' ')
			if proj_dir.empty then
				handle_error (Messages.empty_project_name_er, Void)
			else
				char := proj_dir.item (proj_dir.count)
				if char = Environment.directory_separator then
					proj_dir.remove (proj_dir.count)
				end	
				if proj_dir.empty then
					handle_error (Messages.empty_project_name_er, Void)
				else
					create storage_file_name.make_from_string (proj_dir)
					storage_file_name.extend (Environment.BUILDGEN_name)
					storage_file_name.extend (Environment.Storage_name)
					storage_file_name.set_file_name 
									(Environment.interface_file_name)
						-- Rudimentary check. See if the interface file
						-- is in the Storage directory.
					create dir.make (storage_file_name)
					if dir.exists then
						question_dialog.popup (Current,
								Messages.project_exists_qu, proj_dir, False)
					else
						create_initial_directories
					end
				end
			end
		end

	question_ok_action is
		do
			Environment.remove_project_directory
			create_initial_directories
		end

	question_cancel_action is
		local
			dialog: EV_DIRECTORY_SELECTION_DIALOG
			cmd: CREATE_PROJECT
			arg: EV_ARGUMENT1 [EV_DIRECTORY_SELECTION_DIALOG]
		do
			create dialog.make_with_text (main_window,
							Widget_names.create_project_window)
			create cmd
			create arg.make (dialog)
			dialog.add_ok_command (cmd, arg)
			dialog.show
		end

feature {NONE} -- Implementation

	create_initial_directories is
			-- Create directories for a project.
		local
--			mp: MOUSE_PTR
--			storer: STORER
			init_storage: BOOLEAN
		do
			if not rescued then
--				!!mp
--				mp.set_watch_shape
				main_window.set_title (Widget_names.create_project_label)
				Environment.setup_project_directory
				app_editor.create_initial_state
--				!!storer.make
--				init_storage := True
--				storer.store (Environment.storage_directory)
--				storer := Void
				display_init_windows
--				mp.restore
				init_main_window (Environment.project_directory)
			else
				rescued := False
				main_window.set_title (Widget_names.main_window)
				if init_storage then
					handle_error (Messages.write_dir_er,
						Environment.storage_directory)
				else
					handle_error (Messages.write_dir_er,
						Environment.project_directory)
				end
			end
		rescue
--			mp.restore
			rescued := True
			retry
		end

	handle_error (arg: STRING; extra_message: STRING) is
		do
			error_dialog.popup (Current, arg, extra_message)
		end

end -- class CREATE_PROJECT

