

class OPEN_PROJ_WIN 

inherit

	PROJECT_WINDOW;
	WINDOWS

creation

	make
	
feature 

	title_name: STRING is
		do
			Result := Widget_names.load_project_window
		end;

	ok_pressed is
			-- Command executed when ok button
			-- is pressed.
		local
			cmd: OPEN_PROJECT
		do
			if main_panel.project_initialized then
				clear_project
			end;
			!!cmd;
			cmd.execute (selected_file);
		end;

end	
