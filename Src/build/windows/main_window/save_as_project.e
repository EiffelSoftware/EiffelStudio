class SAVE_AS_PROJECT

inherit

	CREATE_PROJECT
		rename
			create_initial_directories as save_project,
			execute as old_execute,
			question_cancel_action as old_question_cancel_action
		redefine
			save_project, clear_current_project
		end;
	CREATE_PROJECT
		rename
			create_initial_directories as save_project
		redefine
			save_project, clear_current_project,
			question_cancel_action, execute
		select
			execute, question_cancel_action
		end;

feature

	old_project_directory: STRING;
			-- Old project directory

	save_project is
		local
			save_proj: SAVE_PROJECT
		do
			Environment.setup_project_directory;
			!! save_proj;
			save_proj.execute (Void);
			if save_proj.completed then
				main_panel.set_title (Environment.project_directory)
			end
		end;

	clear_current_project is
		do
		end;
	
	execute (arg: STRING) is
		do
			old_project_directory := clone (Environment.project_directory);
			old_execute (arg);
		end;

	question_cancel_action is
		do
			Environment.project_directory.wipe_out;
			Environment.project_directory.append (old_project_directory)
			old_question_cancel_action;
		end

end
			
