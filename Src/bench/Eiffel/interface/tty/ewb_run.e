
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
			args: STRING;
			f: UNIX_FILE;
			make_f: UNIX_FILE;
			error: BOOLEAN
		do
				-- Get the arguments
			!!appl_name.make (0);
			!!makefile_sh_name.make (0);
			if melt_only then
					-- The application executed is the `driver'
				appl_name := Precompilation_driver.duplicate;
			else
				appl_name.append (Workbench_generation_path);
				appl_name.append_character (Directory_separator);
				appl_name.append (System.system_name);
				appl_name.append (Executable_suffix);
			end;
			!!f.make (appl_name);
			if not f.exists then
				io.putstring ("The application ");
				io.putstring (appl_name);
				io.putstring (" does not exist.%N");
			else
				if not melt_only then
					!!makefile_sh_name.make (0);
					makefile_sh_name.append (Workbench_generation_path);
					makefile_sh_name.append_character (Directory_separator);
					makefile_sh_name.append (Makefile_SH);
					!!make_f.make (makefile_sh_name);
					if make_f.exists and then make_f.date > f.date then
						io.putstring (Makefile_SH);
						io.putstring (" is more recent than the application%N");
						error := True
					end;
				end;
				if not error then
					appl_name.append_character (' ');
					io.putstring ("--> Arguments: ");
					wait_for_return;
					appl_name.append (io.laststring);
					env_put (Workbench_generation_path, "MELT_PATH");
					env_system (appl_name);
				end;
			end
		end;

	execute is
			-- This command is available only for the `loop' mode
		do
		end;

end
