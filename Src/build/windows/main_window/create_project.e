indexing
	description: "Command call to create a new project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CREATE_PROJECT 

inherit

	COMMAND
	CONSTANTS
	WINDOWS
	SHARED_STORAGE_INFO
	ERROR_POPUPER
	QUEST_POPUPER
		redefine
			question_help_action
		end

feature 

	rescued: BOOLEAN

	overwrite_project: BOOLEAN
			-- Overwrite existing build project?

	clear_current_project is
		do
			if main_panel.project_initialized then
				clear_project
			end
		end

	execute (argument: STRING) is
		local
			dir: PLAIN_TEXT_FILE
			char: CHARACTER	
			proj_dir: STRING
			storage_file_name: FILE_NAME
		do
			clear_current_project
			overwrite_project := False
			proj_dir := Environment.project_directory
			proj_dir.wipe_out
			proj_dir.append (argument)	
			proj_dir.prune_all (' ')
			if proj_dir.empty then
				error_box.popup (Current, Messages.empty_project_name_er, 
						Void)
			else
				char := proj_dir.item (proj_dir.count)
				if char = Environment.directory_separator then
					proj_dir.remove (proj_dir.count)
				end	
				if proj_dir.empty then
					error_box.popup (Current, Messages.empty_project_name_er, 
						Void)
				else
					!! storage_file_name.make_from_string (proj_dir)
					storage_file_name.extend (Environment.BUILDGEN_name)
					storage_file_name.extend (Environment.Storage_name)
					storage_file_name.set_file_name 
							(Environment.interface_file_name)
						-- Rudementary check. See if the interface file
						-- is in the Storage directory.
					!!dir.make (storage_file_name)
					if dir.exists then
						question_box.popup_with_labels 
								(Current, Messages.project_exists_qu, 
								proj_dir,
								Widget_names.open_name,
								Widget_names.new_choice_name,
								Widget_names.discard_name)
					else
						create_initial_directories
					end
				end
			end
		end

	question_ok_action is
		local
			open_project: OPEN_PROJECT
		do
			if overwrite_project then
				Environment.remove_project_directory
				create_initial_directories
			else
				!! open_project
				open_project.execute (clone (Environment.project_directory))
			end
		end

	question_cancel_action is
		local
			pw: CREATE_PROJ_WIN
		do
			if not overwrite_project then
				!!pw.make (main_panel.base)
				pw.popup	
			end
		end

	question_help_action is
		do
			overwrite_project := True
			question_box.popup (Current, 
					Messages.overwrite_qu, 
					Environment.project_directory)
		end

feature {NONE}

	create_initial_directories is
			-- Create directories for a project.
		local
			mp: MOUSE_PTR
			storer: STORER
			init_storage: BOOLEAN
		do
			if not rescued then
				!!mp
				main_panel.set_title (Widget_names.create_project_label)
				mp.set_watch_shape
				Environment.setup_project_directory
				app_editor.create_initial_state
				!!storer.make
				init_storage := True
				storer.store (Environment.storage_directory)
				storer := Void
				display_init_windows
				mp.restore
				init_main_panel
			else
				rescued := False
				main_panel.set_title (Widget_names.main_panel)
				if init_storage then
					handle_error (Messages.write_dir_er,
						Environment.storage_directory)
				else
					handle_error (Messages.write_dir_er,
						Environment.project_directory)
				end
			end
		rescue
			mp.restore
			rescued := True
			retry
		end

	handle_error (arg: STRING; extra_message: STRING) is
		do
			error_box.popup (Current, arg, extra_message)
		end

	init_main_panel is
			-- Init the main panel after creating a new project.
		local
			title_string: STRING
		do
			title_string := "ISE EiffelBuild: "
			title_string.append (Environment.project_directory)
--			new_main_panel.set_title (title_string)
			main_panel.set_title (title_string)
			main_panel.set_project_initialized
		end

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

end	
