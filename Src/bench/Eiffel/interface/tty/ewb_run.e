
class EWB_RUN

inherit

	EWB_CMD
		rename
			name as run_cmd_name,
			help_message as run_help,
			abbreviation as run_abb
		redefine
			loop_execute
		end;
	EXECUTION_ENVIRONMENT
		rename
			system as exec_env_system
		end;
	SHARED_STATUS

feature

	loop_execute is
			-- Execute the generated application
		local
			appl_name: STRING;
			args: STRING;
			f: UNIX_FILE;
		do
				-- Get the arguments
			!!appl_name.make (0);
			if melt_only then
					-- The application executed is the `driver'
				appl_name := Precompilation_driver.duplicate;
			else
				appl_name.append (Workbench_generation_path);
				appl_name.append_character (Directory_separator);
				appl_name.append (System.system_name);
			end;
			!!f.make (appl_name);
			if not f.exists then
				io.putstring ("The application ");
				io.putstring (appl_name);
				io.putstring (" does not exist.%N");
			else
				appl_name.append_character (' ');
				io.putstring ("--> Arguments: ");
				wait_for_return;
				appl_name.append (io.laststring);
				put (Workbench_generation_path, "MELT_PATH");
				exec_env_system (appl_name);
			end
		end;

	execute is
			-- This command is available only for the `loop' mode
		do
		end;

end
