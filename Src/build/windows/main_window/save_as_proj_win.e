

class SAVE_AS_PROJ_WIN 

inherit

	PROJECT_WINDOW
		export
			{NONE} all;
			{ANY} popup
		undefine
			init_toolkit
		end;
	UNIX_ENV
		export
			{NONE} all
		end;
	ERROR_POPUPER
		export
			{NONE} all
		undefine
			continue_after_popdown
		end;
	WINDOWS
		export
			{NONE} all
		end

creation

	make
	
feature 

	rescued: BOOLEAN;

	old_project_name: STRING;

	ok_pressed is
			-- Command executed when ok button
			-- is pressed.
		local
			cmd: SAVE_PROJECT_AS;
			mp: MOUSE_PTR;
			msg: STRING;	
			Noth: ANY;
			file: FILE_NAME
		do
			if not rescued then
				!!file.make (0);
				old_project_name := clone (Project_directory);
				main_panel.set_title (clone (selected_file));
				Project_directory.wipe_out;
				Project_directory.append (clone (selected_file));
				file.from_string (Project_directory);
				if file.exists then
					!!msg.make (0);
					if file.is_directory then
						msg.append ("Directory ");
					else
						msg.append ("File ");
					end;
					msg.append (Project_directory);
					msg.append ("%Nalready exists. Cannot save.");
					error_box.popup (Current, msg)
				else
					!!mp;
					mp.set_watch_shape;	
					create_eb_directories;
					!!cmd.make (Current);
					mp.restore;
					cmd.execute (Noth);
				end
			else
				rescued := False;
				!!msg.make (0);
				msg.append ("Could not save project as%N");
				msg.append (Project_directory);
				error_box.popup (Current, msg)
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
			Project_directory.wipe_out;
			Project_directory.append (old_project_name);
			old_project_name := Void;
			main_panel.set_title (Project_directory);
		end;

	continue_after_popdown (box: ERROR_BOX; ok: BOOLEAN) is
		do
			continue_after_error
		end

end	
