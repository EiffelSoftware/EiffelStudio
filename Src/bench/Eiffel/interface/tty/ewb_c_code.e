indexing

	description: 
		"Starts the C compilation in W_code or F_code.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_C_CODE

inherit

	EWB_CMD
		redefine
			loop_action
		end;

feature {NONE} -- Implementation

	execute is
			-- Do nothing.
		do
		end;

	workbench_mode: BOOLEAN is
		do
			Result := True
		end;

	loop_action is
			-- Execute Current batch command.
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else
				Eiffel_project.call_finish_freezing_and_wait (workbench_mode)
			end
		end;

end -- class EWB_C_CODE
