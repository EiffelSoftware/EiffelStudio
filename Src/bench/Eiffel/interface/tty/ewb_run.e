
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
	SHARED_MELT_ONLY

feature

	loop_execute is
			-- Execute the generated application
		local
			appl_name: STRING;
			f_name: FILE_NAME;
			f: RAW_FILE;
			make_f: INDENT_FILE;
			error: BOOLEAN;
			system_name: STRING
		do
			system_name := clone (System.system_name);
			if system_name = Void then
				io.putstring ("You must compile a project first.%N");
			else
			if melt_only then
					-- The application executed is the `driver'
				appl_name := clone (Precompilation_driver)
			else
				system_name.append (Executable_suffix);
				!!f_name.make_from_string (Workbench_generation_path);
				f_name.set_file_name (system_name);
				appl_name := f_name
			end;
			!!f.make (appl_name);
			if not f.exists then
				io.putstring ("The system ");
				io.putstring (appl_name);
				io.putstring (" does not exist.%N");
			else
				if not melt_only then
					!!f_name.make_from_string (Workbench_generation_path);
					f_name.set_file_name (Makefile_SH);
					!!make_f.make (f_name);
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
