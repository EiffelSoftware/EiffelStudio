
class EWB_FINALIZE

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_execute
		end;
	SHARED_ERROR_HANDLER

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
			if Project_read_only.item then
				io.error.put_string ("Read-only project: cannot compile.%N")
			elseif 
				confirmed ("Finalizing implies some C compilation and linking.%
							%%NDo you want to do it now") 
			then
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
		local
			rescued: BOOLEAN
		do
			if not rescued then
				init;
				if not error_occurred and then Lace.file_name /= Void then
					finalization_compile
				end;
			end
		end;

	finalization_compile is
			-- Finalize the system.
		local
			exit, rescued: BOOLEAN
		do
			from
			until
				exit
			loop
				if rescued then
					if stop_on_error then
						lic_die (-1);
					end;
					if termination_requested then
						--lic_die (0);
						-- es3 -loop does NOT like lic_die(0)
						exit := true
					end;
					rescued := false
				end;
				if not exit then
						-- Do not call the once function `System' directly
						-- since it's value may be replaced during the first
						-- compilation (as soon as we figured out whether the
						-- system describes a Dynamic Class Set or not).
					Workbench.system.set_dle_finalize (true);
					compile;
					if Workbench.successfull then
						-- Save the project before the finalization in order to
						-- be able to use the project for other melting/freezing
						-- or finalization afterwards.
						terminate_project;
						System.finalized_generation (keep_assertions);
						if System.extendible then
							terminate_project
						end;
						if
							System.poofter_finalization and
							not System.is_dynamic
						then
							io.error.putstring 
					("Warning: the finalized system might not be optimal%N%
					%%Tin size and speed. In order to produce an optimal%N%
					%%Texecutable, finalize the system from scratch and do%N%
					%%Tnot use precompilation.%N%N");
						end;
						print_tail;
						prompt_finish_freezing (True);
						if System.is_dynamic then
							dle_link_system
						end;
						if not System.freezing_occurred then
							link_driver
						end
					end;
					exit := true
				end
			end
		rescue
			if Rescue_status.is_error_exception then
					-- A validity error has been detected during the
					-- finalization. This happens with DLE dealing 
					-- with statically bound feature calls.
				Rescue_status.set_is_error_exception (false);
				rescued := true;
				Error_handler.trace;
				System.set_current_class (Void);
				retry
			end
		end;

end
