class EWB_FREEZE 

inherit

	EWB_CMD
		rename
			name as freeze_cmd_name,
			help_message as freeze_help,
			abbreviation as freeze_abb
		redefine
			loop_execute
		end

feature

	loop_execute is
		do
			if confirmed ("Freezing implies some C compilation%N%
							%and linking. Do you want to do it now") then
				execute
			end
		end;

	execute is
		do
				print_header;
				init_project;
				if not error_occurred then
					if project_is_new then
						make_new_project
					else
						retrieve_project
					end
				end;
				if not error_occurred then
					System.set_freeze (True);
					compile;
					if System.successfull then
						terminate_project;
						print_tail;
						prompt_finish_freezing (False)
					end;
				end;
		end;

end
