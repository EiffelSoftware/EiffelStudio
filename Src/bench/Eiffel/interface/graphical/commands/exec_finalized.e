indexing
	description:
			"Command to execute the finalized code.";
	date: "$Date$";
	revision: "$Revision$"

class EXEC_FINALIZED

inherit
	PIXMAP_COMMAND
		rename
			init as make
		end;
	PROJECT_CONTEXT
		export
			{NONE} all
		end;
	SHARED_EIFFEL_PROJECT

creation
	make

feature -- Properties

	symbol: PIXMAP is
			-- Symbol to represent Current.
		do
		end;

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Execute Current.
		local
			appl_name: STRING;
			cmd_exec: EXTERNAL_COMMAND_EXECUTOR;
			f: RAW_FILE;
			f_name: FILE_NAME;
			make_f: INDENT_FILE;
			mp: MOUSE_PTR;
			system_name: STRING
		do
			system_name := clone (Eiffel_system.name);
			if system_name = Void then
				warner (popup_parent).gotcha_call ("You must finalize ypur project first.")
			else
				appl_name := Eiffel_system.application_name (False);
				!! f.make (appl_name);
				if not f.exists then
					warner (popup_parent).gotcha_call ("The system doesn't exist.")
				else
					!! f_name.make_from_string (Final_generation_path);
					f_name.set_file_name (Makefile_SH);
					!! make_f.make (f_name);
					if make_f.exists and then make_f.date > f.date then
						warner (popup_parent). gotcha_call ("The Makefile.SH is more recent than the system.")
					else
						!! mp.set_watch_cursor;
						appl_name.extend (' ');
						appl_name.append (argument_window.argument_list)
						!! cmd_exec;
						cmd_exec.execute (appl_name);
						mp.restore
					end
				end
			end
		end;

feature {NONE} -- Properties

	name: STRING is
			-- Short description of Current.
			--| TEST
		do
			Result := l_Run_finalized
		end;
		
end -- class EXEC_FINALIZED
