

class SAVE_AS_PROJ_WIN 

inherit

	PROJECT_WINDOW
		export
			{NONE} all;
			{ANY} popup
		end;
	ERROR_POPUPER;
	WINDOWS;
	CONSTANTS

creation

	make
	
feature {NONE}

	title_name: STRING is
		do
			Result := Widget_names.Save_project_as_window
		end;

	rescued: BOOLEAN;

	old_project_name: STRING;

	ok_pressed is
			-- Command executed when ok button
			-- is pressed.
		local
			cmd: SAVE_PROJECT_AS;
			mp: MOUSE_PTR;
			file: PLAIN_TEXT_FILE
		do
			if not rescued then
				!!file.make (Environment.project_directory);
				old_project_name := clone (Environment.project_directory);
				if file.exists then
					if file.is_directory then
						error_box.popup (Current, 
							Messages.cannot_save_dir_er, 
							Environment.project_directory)
					else
						error_box.popup (Current, 
							Messages.cannot_save_file_er, 
							Environment.project_directory)
					end;
				else
					!!mp;
					mp.set_watch_shape;	
					Environment.setup_project_directory;
					!!cmd.make (Current);
					mp.restore;
					cmd.execute (Void);
					main_panel.set_title (clone (selected_file));
					Environment.project_directory.wipe_out;
					Environment.project_directory.append (clone (selected_file));
				end
			else
				rescued := False;
				error_box.popup (Current, 
					Messages.cannot_save_er, Environment.project_directory)
			end
		rescue
			rescued := True;
			mp.restore;
			retry
		end;

	continue_after_error is
			-- Perform actions when an error occurs in 
			-- the command execute by Current
		do
			Environment.project_directory.wipe_out;
			Environment.project_directory.append (old_project_name);
			old_project_name := Void;
			main_panel.set_title (Environment.project_directory);
		end;

	continue_after_popdown (box: ERROR_BOX; ok: BOOLEAN) is
		do
			continue_after_error
		end

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end;

end	
