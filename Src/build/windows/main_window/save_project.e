
class SAVE_PROJECT 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	UNIX_ENV
		export
			{NONE} all
		end;
	ERROR_POPUPER

feature 

	completed: BOOLEAN;
		-- Was the Current save command succesfully completed?
		-- (i.e. has no error occured during the execution
		-- of the Current command)

	rescued: BOOLEAN;

	execute (argument: ANY) is
		local
			storer: STORER;	
			mp: MOUSE_PTR;
			msg: STRING
		do
			if not rescued then
				if main_panel.project_initialized then
					!!mp;
					mp.set_watch_shape;
					make_backup;
					!!storer.make;
					storer.store (Storage_directory);
					storer := Void;
					mp.restore;
					history_window.set_saved_application;
					completed := True
				end
			else
				rescued := False;
				!!msg.make (0);
				msg.append ("Cannot save project to directory%N");
				msg.append (Storage_directory);
				error_box.popup (Current, msg)
			end
		rescue
			-- Check for no more memory
			rescued := True;
			mp.restore;
			retry
		end;

	Backup_directory: STRING is
		do
			!!Result.make (0);
			Result.append (Project_directory);
			Result.append ("/Backup");
		end;

	make_backup is
		do
			copy_file ("/interface");
			copy_file ("/application");
			copy_file ("/groups");
			copy_file ("/namer");
			copy_file ("/states");
			copy_file ("/commands");
		end;

	copy_file (name: STRING) is
		local
			source: UNIX_FILE;
			destination: UNIX_FILE;
			file_name: STRING;
		do
			!!file_name.make (0);
			file_name.append (Storage_directory);
			file_name.append (name);
			!!source.make_open_read (file_name.duplicate);
			file_name.wipe_out;
			file_name.append (Backup_directory);
			file_name.append (name);
			!!destination.make (file_name.duplicate);
			destination.wipe_out;
			source.close;
			destination.append (source);
		end;

end
