
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
	SHARED_STATUS

feature

	loop_execute is
			-- Execute the generated application
		local
			appl_name: STRING;
			makefile_sh_name: STRING;
			f: RAW_FILE;
			make_f: INDENT_FILE;
			error: BOOLEAN;
			system_name: STRING
		do
			system_name := System.system_name;
			if system_name = Void then
				io.putstring ("You must compile a project first.%N");
			else
			!!appl_name.make (0);
			!!makefile_sh_name.make (0);
			if melt_only then
					-- The application executed is the `driver'
				appl_name := clone (Precompilation_driver)
			else
				appl_name.append (Workbench_generation_path);
				appl_name.extend (Directory_separator);
				appl_name.append (system_name);
				appl_name.append (Executable_suffix);
			end;
			!!f.make (appl_name);
			if not f.exists then
				io.putstring ("The system ");
				io.putstring (appl_name);
				io.putstring (" does not exist.%N");
			else
				if not melt_only then
					!!makefile_sh_name.make (0);
					makefile_sh_name.append (Workbench_generation_path);
					makefile_sh_name.extend (Directory_separator);
					makefile_sh_name.append (Makefile_SH);
					!!make_f.make (makefile_sh_name);
					if make_f.exists and then make_f.date > f.date then
						io.putstring (Makefile_SH);
						io.putstring (" is more recent than the system%N");
						error := True
					end;
				end;
				if not error then
						-- Get the arguments
					appl_name.extend (' ');
					appl_name.append (arguments);
					Execution_environment.put (Workbench_generation_path, "MELT_PATH");
					Execution_environment.system (appl_name);
				end;
			end
			end
		end;

	execute is
			-- This command is available only for the `loop' mode
		do
		end;

end
