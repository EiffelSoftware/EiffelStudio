indexing

	description: 
		"Command to run an eiffel application.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_RUN

inherit

	EWB_CMD
		rename
			name as run_cmd_name,
			help_message as run_help,
			abbreviation as run_abb
		redefine
			loop_action
		end;
	SHARED_EXEC_ENVIRONMENT;
	PROJECT_CONTEXT

feature {NONE} -- Implementation

	loop_action is
			-- Execute the generated application
		local
			appl_name: STRING;
			f_name: FILE_NAME;
			f: RAW_FILE;
			make_f: INDENT_FILE;
			error: BOOLEAN;
			system_name: STRING;
			cmd_exec: EXTERNAL_COMMAND_EXECUTOR
		do
			system_name := clone (Eiffel_system.name);
			if system_name = Void then
				io.putstring ("You must compile a project first.%N");
			else
				appl_name := Eiffel_system.application_name (True);
				!! f.make (appl_name);
				if not f.exists then
					io.putstring ("The system ");
					io.putstring (appl_name);
					io.putstring (" does not exist.%N");
				else
					!! f_name.make_from_string (Workbench_generation_path);
					f_name.set_file_name (Makefile_SH);
					!! make_f.make (f_name);
					if make_f.exists and then make_f.date > f.date then
						io.putstring (Makefile_SH);
						io.putstring (" is more recent than the system%N");
						error := True
					end;
					if not error then
							-- Get the arguments
						appl_name.extend (' ');
						appl_name.append (arguments);
						!! cmd_exec;
						cmd_exec.execute (appl_name);
					end;
				end
			end
		end;

	execute is
			-- This command is available only for the `loop' mode
		do
		end;

end -- class EWB_RUN
