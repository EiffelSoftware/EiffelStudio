-- Starts the C compilation in W_code or F_code

deferred class EWB_C_CODE

inherit
	EWB_CMD
		redefine
			loop_execute
		end;
	EIFFEL_ENV

feature

	execute is
		do
		end;

	c_code_directory: STRING is
		deferred
		end;

	loop_execute is
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

end

