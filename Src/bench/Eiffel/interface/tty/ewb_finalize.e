
class EWB_FINALIZE

inherit

	EWB_CMD

creation

	make, null

feature

	make (k: BOOLEAN) is
		do
			keep_assertions := k
		end;

	keep_assertions: BOOLEAN;

	name: STRING is "finalize";

	loop_execute is
		do
			execute
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
				end;
				print_tail;
				prompt_finish_freezing (True);
			end;
		end;

end
