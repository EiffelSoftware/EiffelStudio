
class EWB_FINALIZE

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_execute
		end

creation

	make, null

feature

	name: STRING is
		do
			Result := finalize_cmd_name
		end;

	help_message: STRING is
		do
			Result := finalize_help
		end;

	abbreviation: CHARACTER is
		do
			Result := finalize_abb
		end;

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
			if confirmed ("Finalizing implies some C compilation and linking.%N%
							%Do you want to do it now") then
				io.putstring ("--> Keep assertions (y/n): ");
				wait_for_return;
				answer := io.laststring;
				answer.to_lower;
				if answer.is_equal ("y") or else answer.is_equal ("yes") then
					keep_assertions := True
				else
					keep_assertions := False;
				end;
				execute
			end
		end;

	execute is
		do
			init;
			if not error_occurred and then Lace.file_name /= Void then
				compile;
				if Workbench.successfull then
						-- Save the project before the finalization in order to
						-- be able to use the project for other melting/freezing
						-- or finalization afterwards.
					terminate_project;
					System.finalized_generation (keep_assertions);
					if System.poofter_finalization then
						io.error.putstring 
							("Warning: the finalized system might not be optimal%N%
								%%Tin size and speed. In order to produce an optimal%N%
								%%Texecutable, finalize the system from scratch and do%N%
								%%Tnot use precompilation.%N%N");
					end;
					print_tail;
					prompt_finish_freezing (True);
					if not System.freezing_occurred then
						link_driver
					end
				end;
			end;
		end;

end
