indexing
	description: "Command call to retrieve an old project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class OPEN_PROJECT

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

feature {NONE} -- Command

	rescued: BOOLEAN

	to_create_project: BOOLEAN
			-- Create project?
	execute (arg: EV_ARGUMENT1 [EV_DIRECTORY_SELECTION_DIALOG]; ev_data: EV_EVENT_DATA) is
		do
			open_project (arg.first.directory)
		end

	open_project (txt: STRING) is
		local
			dir: PLAIN_TEXT_FILE
			bpdir: DIRECTORY_NAME
			groups_file: PLAIN_TEXT_FILE
			restore_name: FILE_NAME
			storage_name: FILE_NAME
			char: CHARACTER	
			restore_file: PLAIN_TEXT_FILE
			storage_file: PLAIN_TEXT_FILE
			proj_dir: STRING
		do
			if main_window.project_initialized then
				clear_project
			end
			to_create_project := False
			proj_dir := Environment.project_directory
			proj_dir.wipe_out
			proj_dir.append (txt)
			proj_dir.prune_all (' ')
			char := proj_dir.item (proj_dir.count)
			if char = Environment.directory_separator then
				proj_dir.remove (proj_dir.count)
			end
			if proj_dir.empty then
				handle_error (Messages.empty_project_name_er, Void)
			else
				create dir.make (proj_dir)
				if dir.exists then
					create bpdir.make
					bpdir.extend (Environment.storage_directory)
					bpdir.extend (Environment.Groups_name)
					create groups_file.make (bpdir)
					if groups_file.exists then
						create storage_name.make_from_string
										(Environment.storage_directory)
						storage_name.set_file_name
										(Environment.interface_file_name)
						create storage_file.make (storage_name)
						create restore_name.make_from_string
										(Environment.restore_directory)
						restore_name.set_file_name
										(Environment.interface_file_name)
						create restore_file.make (restore_name)
						if restore_file.exists
						and then restore_file.date >= storage_file.date 
						then
							question_dialog.popup (Current, 
									Messages.retrieve_crash_qu, Void, False)
						else
							retrieve_project (Environment.storage_directory)
							history_window.set_saved_application
						end
					else
						to_create_project := True
						question_dialog.popup (Current,
							Messages.not_eb_project_qu, proj_dir, False)
					end
				else
					handle_error (Messages.eb_project_not_exists_er, proj_dir)
				end
			end
		end

	question_ok_action is
		local
			cmd: CREATE_PROJECT
		do
			if to_create_project then
				create cmd
				cmd.create_project (clone (Environment.project_directory))
			else
				retrieve_project (Environment.restore_directory)
				history_window.set_unsaved_application
			end
		end

	question_cancel_action is
		local
			dialog: EV_DIRECTORY_SELECTION_DIALOG
			cmd: OPEN_PROJECT
			arg: EV_ARGUMENT1 [EV_DIRECTORY_SELECTION_DIALOG]
		do
			if to_create_project then
				create dialog.make_with_text (main_window,
								Widget_names.load_project_window)
				create cmd
				create arg.make (dialog)
				dialog.add_ok_command (cmd, arg)
				dialog.show
			else
				retrieve_project (Environment.storage_directory)
				history_window.set_saved_application
			end
		end	

feature {NONE} -- Implementation

	retrieve_project (dir: STRING) is
		local
			file: PLAIN_TEXT_FILE
--			storer: STORER
--			mp: MOUSE_PTR
		do
			if not rescued then
				main_window.set_title (Widget_names.retrieving_project_label)
				create file.make (dir)
--				for_import.set_item (False)
--				!!mp
--				mp.set_watch_shape
--				!!storer.make
--				storer.retrieve (dir)
				init_main_window (Environment.project_directory)
--				mp.restore
			else
				rescued := False
				handle_error (Messages.retrieve_er, dir)
			end
		rescue
			clear_project
--			mp.restore
			rescued := True
			retry
		end

	handle_error (arg: STRING; extra_message: STRING) is
		do
			error_dialog.popup (Current, arg, extra_message)
		end

end	-- class OPEN_PROJECT

