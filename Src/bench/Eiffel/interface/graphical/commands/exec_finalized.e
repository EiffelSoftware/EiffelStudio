indexing
	description:
			"Command to execute the finalized code.";
	date: "$Date$";
	revision: "$Revision$"

class EXEC_FINALIZED

inherit

	TOOL_COMMAND
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

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Execute Current.
		local
			appl_name: STRING;
			cmd_exec: COMMAND_EXECUTOR;
			f: RAW_FILE;
			f_name: FILE_NAME;
			make_f: INDENT_FILE;
			mp: MOUSE_PTR;
			system_name: STRING
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				system_name := clone (Eiffel_system.name);
			end;
			if system_name = Void then
				warner (popup_parent).gotcha_call (Warning_messages.w_Must_finalize_first)
			else
				appl_name := Eiffel_system.application_name (False);
				!! f.make (appl_name);
				if not f.exists then
					warner (popup_parent).gotcha_call (Warning_messages.w_Unexisting_system)
				else
					!! f_name.make_from_string (Final_generation_path);
					f_name.set_file_name (Makefile_SH);
					!! make_f.make (f_name);
					if make_f.exists and then make_f.date > f.date then
						warner (popup_parent). gotcha_call (Warning_messages.w_MakefileSH_more_recent)
					else
						!! mp.set_watch_cursor;
						appl_name.extend (' ');
						appl_name.append (current_cmd_line_argument)
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
		do
			Result := Interface_names.f_Run_finalized
		end;
		
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Run_finalized
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

end -- class EXEC_FINALIZED
