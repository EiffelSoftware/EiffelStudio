indexing

	description: 
		"Finalize eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FINALIZE

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_action, perform_compilation
		end;
	SHARED_ERROR_HANDLER

creation

	make, do_nothing

feature -- Initialization

	make (k: BOOLEAN) is
			-- Initialize Current with keep_assertions as `k'
			-- and project `proj'.
		do
			keep_assertions := k;
		ensure
			set: keep_assertions = k
		end;

feature -- Properties

	keep_assertions: BOOLEAN;
			-- Keep assertions in finalize code generation

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

feature {NONE} -- Execution

	loop_action is
			-- Execute Current batch command form -loop.
		local
			answer: STRING
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			elseif 
				command_line_io.confirmed 
						("Finalizing implies some C compilation and linking.%
							%%NDo you want to do it now") 
			then
				io.putstring ("--> Keep assertions (y/n): ");
				command_line_io.wait_for_return;
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
			-- Execute Current batch command.
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						if not Eiffel_project.is_final_code_optimal then
							io.error.putstring 
							("Warning: the finalized system might not be optimal%N%
							%%Tin size and speed. In order to produce an optimal%N%
							%%Texecutable, finalize the system from scratch and do%N%
							%%Tnot use precompilation.%N%N");
						end;
						print_tail;
						prompt_finish_freezing (True);
					end
				end;
			end
		end;

	perform_compilation is
		do
			if
				Workbench.system_defined and then
				System.keep_assertions /= keep_assertions
			then
					-- Force refinalization when user changed is mind since
					-- last time.
				System.set_finalize
			end

			Eiffel_project.finalize (keep_assertions)
		end

end -- class EWB_FINALIZE
