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
			cmd_exec: COMMAND_EXECUTOR
		do
			if Eiffel_system = Void or else Eiffel_system.name = Void then
				output_window.put_string (Warning_messages.W_must_compile_first)
				output_window.new_line
			else
				system_name := clone (Eiffel_system.name);
				appl_name := Eiffel_system.application_name (True);
				!! f.make (appl_name);
				if not f.exists then
					output_window.put_string (Warning_messages.w_file_not_exist (appl_name))
					output_window.new_line
				else
					!! f_name.make_from_string (Workbench_generation_path);
					f_name.set_file_name (Makefile_SH);
					!! make_f.make (f_name);
					if make_f.exists and then make_f.date > f.date then
						output_window.put_string (Warning_messages.w_MakefileSH_more_recent)
						output_window.new_line
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
