
class CREATE_PROJECT 

inherit

	COMMAND;
	CONSTANTS;
	WINDOWS;
	SHARED_STORAGE_INFO;
	ERROR_POPUPER;
	QUEST_POPUPER
		redefine
			continue_after_question_popdown
		end;

feature 

	rescued: BOOLEAN;

	execute (argument: STRING) is
		local
			dir: PLAIN_TEXT_FILE;
			char: CHARACTER;	
			proj_dir: STRING
		do
			proj_dir := Environment.project_directory;
			proj_dir.wipe_out;
			proj_dir.append (argument);	
			proj_dir.prune_all (' ');
			char := proj_dir.item (proj_dir.count);
			if char = Environment.directory_separator then
				proj_dir.remove (proj_dir.count)
			end;	
			!!dir.make (proj_dir);
			if dir.exists then
				question_box.popup (Current, Messages.override_qu, 
						proj_dir)
			else
				create_initial_directories
			end
		end;

	continue_after_question_popdown (yes: BOOLEAN) is
		do
			if yes then
				Environment.remove_project_directory;
				create_initial_directories;
			end
		end;	

feature {NONE}

	create_initial_directories is
			-- Create directories for a project.
		local
			mp: MOUSE_PTR;
			storer: STORER;
			init_storage: BOOLEAN
		do
			if not rescued then
				!!mp;
				main_panel.set_title (Widget_names.create_project_label);
				mp.set_watch_shape;
				Environment.setup_project_directory;
				app_editor.create_initial_state;
				!!storer.make;
				init_storage := True;
				storer.store (Environment.storage_directory);
				storer := Void;
				display_init_windows;
				mp.restore;
				init_main_panel;
			else
				rescued := False;
				main_panel.set_title (Widget_names.main_panel);
				if init_storage then
					handle_error (Messages.write_dir_er,
						Environment.storage_directory)
				else
					handle_error (Messages.write_dir_er,
						Environment.project_directory)
				end;
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	handle_error (arg: STRING; extra_message: STRING) is
		do
			error_box.popup (Current, arg, extra_message);
		end;

	init_main_panel is
		do
			main_panel.set_title (Environment.project_directory);
			main_panel.set_project_initialized;
		end;

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

end	
