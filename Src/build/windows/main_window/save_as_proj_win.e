

class SAVE_AS_PROJ_WIN 

inherit

	PROJECT_WINDOW;
	WINDOWS

creation

	make
	
feature {NONE}

	title_name: STRING is
		do
			Result := Widget_names.Save_project_as_window
		end;

	ok_pressed is
			-- Command executed when ok button
			-- is pressed.
		local
			cmd: SAVE_AS_PROJECT;
		do
			!! cmd;
			cmd.execute (selected_file);
		end;

end
