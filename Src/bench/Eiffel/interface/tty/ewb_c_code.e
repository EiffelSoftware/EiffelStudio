indexing

	description: 
		"Starts the C compilation in W_code or F_code.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_C_CODE

inherit
	PROJECT_CONTEXT;
	EWB_CMD
		redefine
			loop_action
		end;
	EIFFEL_ENV

feature {NONE} -- Implementation

	execute is
			-- Do nothing.
		do
		end;

	c_code_directory: STRING is
			-- C code directory to commence C compilation.
		deferred
		ensure
			non_void_result: Result /= Void
		end;

	loop_action is
			-- Execute Current batch command.
		do
			if Project_read_only.item then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else
				eif_call_finish_freezing (c_code_directory.to_c, freeze_command_name.to_c)
			end
		end;

feature {NONE} -- Externals

	eif_call_finish_freezing (c_code_dir, freeze_cmd: ANY) is
		external
			"C"
		end

end -- class EWB_C_CODE
