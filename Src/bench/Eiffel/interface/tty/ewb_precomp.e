
class EWB_PRECOMP

inherit

	EWB_CMD
		rename
			name as precompile_cmd_name,
			help_message as precompile_help
		end

feature

	name: STRING is "precompile";

	loop_execute is do end;

	execute is
		do
			if confirmed then
				print_header;
				init_project;
				if project_is_new then
					make_new_project;
					if not error_occurred then
						System.set_precompilation (True);
						compile;
						System.save_precompilation_info;
						terminate_project;
						print_tail;
						prompt_finish_freezing (False)
					end;
				else
					io.error.putstring ("The project %"");
					io.error.putstring (project_name);
					io.error.putstring ("%" already exists.%N%
						%It needs to be deleted before a precompilation.%N");
				end
			end
		end;
end
