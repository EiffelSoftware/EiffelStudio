
class EWB_COMP

inherit

	EWB_CMD;
	EXECUTION_ENVIRONMENT
		rename
			system as exec_system
		end

feature

	name: STRING is
		do
			Result := melt_cmd_name
		end;

	help_message: STRING is
		do
			Result := melt_help
		end;

	abbreviation: CHARACTER is
		do
			Result := melt_abb
		end;

feature

	init is
		do
			print_header;
			init_project;
			if not error_occurred then
				if project_is_new then
					make_new_project
				else
					retrieve_project;
				end;
			end;
		end;

	execute is
		do
			init;
			if not error_occurred then
				compile;
				if Workbench.successfull then
					terminate_project;
					print_tail;
					if System.freezing_occurred then
						prompt_finish_freezing (False)
					else
						link_driver
					end;
				end;
			end;
		end;

	prompt_finish_freezing (finalized_dir: BOOLEAN) is
		do
			io.error.putstring ("You must now run %"");
			io.error.putstring (Finish_freezing_script);
			io.error.putstring ("%" in:%N%T");
			if finalized_dir then
				io.error.putstring (Final_generation_path)
			else
				io.error.putstring (Workbench_generation_path)
			end;
			io.error.new_line;
		end;

	link_driver is
		local
			arg2: STRING;
			cmd_string: STRING;
			uf: UNIX_FILE
		do
			if System.uses_precompiled then
					-- Target
				arg2 := build_path (Workbench_generation_path, System.system_name);
				!!uf.make (arg2);
				if not uf.exists then
						-- Request
					!!cmd_string.make (200);
					cmd_string.append ("$EIFFEL3/bench/spec/$PLATFORM/bin/prelink ");
					cmd_string.append (Precompilation_driver);
					cmd_string.append (" ");
					cmd_string.append (arg2);
					exec_system (cmd_string);
				end;
			end;
		end;

end
