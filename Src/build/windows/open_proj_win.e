

class OPEN_PROJ_WIN 

inherit

	PROJECT_WINDOW
		undefine
			init_toolkit
		end;
	WINDOWS

creation

	make
	
feature 

	ok_pressed is
			-- Command executed when ok button
			-- is pressed.
		local
			cmd: OPEN_PROJECT
		do
			if main_panel.project_initialized then
				context_catalog.clear;
				command_catalog.clear;
				command_catalog.initial_pages;
				app_editor.clear;
			end;
			!!cmd;
			if selected_file.empty then
				cmd.execute (directory);
			else
				cmd.execute (selected_file);
			end;
		end;

end	
