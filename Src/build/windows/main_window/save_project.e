
class SAVE_PROJECT 

inherit

	CONSTANTS;
	WINDOWS;
	LICENCE_COMMAND
		export
			{NONE} all;
			{ANY} execute
		redefine
			licence_checked
		end;
	ERROR_POPUPER

feature 

	completed: BOOLEAN;
		-- Was the Current save command succesfully completed?
		-- (i.e. has no error occured during the execution
		-- of the Current command)

	rescued: BOOLEAN;
	
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
					!!storer.make;
					storer.store (Environment.storage_directory);
					storer := Void;
					mp.restore;
					history_window.set_saved_application;
					completed := True
				end
			else
				rescued := False;
				!!msg.make (0);
				msg.append ("Cannot save project to directory%N");
				msg.append (Environment.storage_directory);
				error_box.popup (Current, msg)
			end
		rescue
				-- Check for no more memory
			rescued := True;
			mp.restore;
			retry
		end;

	licence_checked: BOOLEAN is
		do
			Result := True;
		end;


end
