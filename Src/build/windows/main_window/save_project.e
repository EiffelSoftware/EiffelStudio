
class SAVE_PROJECT 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	LICENCE_COMMAND
		export
			{NONE} all;
			{ANY} execute
		redefine
			licence_checked
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
	
	licence_lost: BOOLEAN;

	work (argument: ANY) is
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

	licence_checked: BOOLEAN is
		local
			msg: STRING;
		do
			licence.alive;
			if licence.is_alive then
				licence_lost := False;
				Result := True;
			else
				if licence_lost then
					Result := False;
				else
					licence_lost := True;
					Result := True;
					!!msg.make (0);
					msg.append ("You have lost your license.%N");
					msg.append ("This is the last save until you obtain you license back.");
					warning_box.popup (Current, msg);
				end;
			end;
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
			!!source.make_open_read (clone (file_name));
			file_name.wipe_out;
			file_name.append (Backup_directory);
			file_name.append (name);
			!!destination.make (clone (file_name));
			destination.wipe_out;
			source.close;
			destination.append (source);
		end;

end
