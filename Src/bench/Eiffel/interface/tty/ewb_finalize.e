
class EWB_FINALIZE

inherit

	EWB_CMD
		rename
			name as finalize_cmd_name,
			help_message as finalize_help,
			abbreviation as finalize_abb
		end

creation

	make, null

feature

	make (k: BOOLEAN) is
		do
			keep_assertions := k
		end;

	keep_assertions: BOOLEAN;

	loop_execute is
		local
			answer: STRING
		do
			io.putstring ("--> Keep assertions (y/n): ");
			wait_for_return;
			answer := io.laststring;
			answer.to_lower;
			if answer.is_equal ("y") or else answer.is_equal ("yes") then
				keep_assertions := True
			else
				keep_assertions := False;
			end;
			execute;
		end;

	execute is
		do
			if confirmed then
				print_header;
				init_project;
				if not error_occurred then
					if project_is_new then
						make_new_project
					else
						retrieve_project
					end;
				end;
				if not error_occurred then
					compile;
					if System.successfull then
							-- Save the project before the finalization in order to
							-- be able to use the project for other melting/freezing
							-- or finalization afterwards.
						terminate_project;
						System.finalized_generation (keep_assertions);
						if System.poofter_finalization then
							io.error.putstring 
								("Warning: the finalized system might not be optimal%N");
							io.error.putstring
								("%Tin size and speed. In order to produce an optimal%N");
							io.error.putstring
								("%Texecutable, finalize the system from scratch and do%N");
							io.error.putstring
								("%Tnot use precompilation.%N%N");
						end;
						print_tail;
						prompt_finish_freezing (True);
					end;
				end;
			end;
		end;

end
