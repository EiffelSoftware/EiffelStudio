indexing
	description: "Command call to retrieve an old project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class OPEN_PROJECT 

inherit

	COMMAND
	CONSTANTS
	WINDOWS
	SHARED_STORAGE_INFO
	ERROR_POPUPER
	QUEST_POPUPER

feature 

	rescued: BOOLEAN

	to_create_project: BOOLEAN
			-- Create project?

	execute (argument: STRING) is
		local
			dir: PLAIN_TEXT_FILE
			bpdir: DIRECTORY_NAME
			groups_file: PLAIN_TEXT_FILE
			restore_name: FILE_NAME
			storage_name: FILE_NAME
			char: CHARACTER	
			storer: STORER
			restore_file: PLAIN_TEXT_FILE
			storage_file: PLAIN_TEXT_FILE
			proj_dir: STRING
		do
			if main_panel.project_initialized then
				clear_project
			end
			to_create_project := False
			proj_dir := Environment.project_directory
			proj_dir.wipe_out
			proj_dir.append (argument)	
			proj_dir.prune_all (' ')
			char := proj_dir.item (proj_dir.count)
			if char = Environment.directory_separator then
				proj_dir.remove (proj_dir.count)
			end
			if proj_dir.empty then
				handle_error (Messages.empty_project_name_er, Void)
			else	
				!! dir.make (proj_dir)
				if dir.exists then
					!! bpdir.make 
					bpdir.extend (Environment.storage_directory)
					bpdir.extend (Environment.Groups_name)
					!! groups_file.make (bpdir)
					if groups_file.exists then
						!! storage_name.make_from_string (Environment.storage_directory)
						storage_name.set_file_name (Environment.interface_file_name)
						!! storage_file.make (storage_name)

						!! restore_name.make_from_string 
							(Environment.restore_directory)
						restore_name.set_file_name (Environment.interface_file_name)
						!! restore_file.make (restore_name)

						if 
							restore_file.exists and then
							restore_file.date >= storage_file.date 
						then
							question_box.popup (Current, 
								Messages.retrieve_crash_qu, Void)
						else
							retrieve_project (Environment.storage_directory)
							history_window.set_saved_application
						end
					else
						to_create_project := True
						question_box.popup_with_labels (Current,
							Messages.not_eb_project_qu, 
							Environment.project_directory,
							Widget_names.create_name,
							Widget_names.new_choice_name,
							Void)
					end
				else
					handle_error (Messages.eb_project_not_exists_er, proj_dir)
				end
			end
		end

	question_ok_action is
		local
			create_project: CREATE_PROJECT
		do
			if to_create_project then
				!! create_project
				create_project.execute (clone (Environment.project_directory))
			else
				retrieve_project (Environment.restore_directory)
				history_window.set_unsaved_application
			end
		end

	question_cancel_action is
		local
			pw: OPEN_PROJ_WIN
		do
			if to_create_project then
				!! pw.make (main_panel.base)
				pw.popup
			else
				retrieve_project (Environment.storage_directory)
				history_window.set_saved_application
			end
		end	

feature {NONE}

	retrieve_project (dir: STRING) is
		local
			file: PLAIN_TEXT_FILE
			storer: STORER
			mp: MOUSE_PTR
		do
			if not rescued then
				main_panel.set_title 
					(Widget_names.retrieving_project_label)
				!! file.make (dir)
				for_import.set_item (False)
				!!mp
				mp.set_watch_shape
				!!storer.make
				storer.retrieve (dir)
				init_main_panel
				mp.restore
			else
				rescued := False
				handle_error (Messages.retrieve_er, dir)
			end
		rescue
			clear_project
			mp.restore
			rescued := True
			retry
		end

	handle_error (arg: STRING; extra_message: STRING) is
		do
			error_box.popup (Current, arg, extra_message)
		end

	init_main_panel is
			-- Init the main panel after retrieving a project.
		local
			title_string: STRING
		do
			title_string := "ISE EiffelBuild: "
			title_string.append (Environment.project_directory)
--			new_main_panel.set_title (title_string)
			main_panel.set_title (title_string)
			main_panel.set_project_initialized
--			main_panel.set_interface_toggle
		end

	popuper_parent: COMPOSITE is
		do	
			Result := main_panel.base
		end

end	
