indexing

	description: 
		"Calls commands outside the eiffel environment.%
		%If a connection has been made then execute the command%
		%as a background process. Otherwize, do a system call";
	date: "$Date$";
	revision: "$Revision $"

class BENCH_COMMAND_EXECUTOR

inherit
	SHARED_STATUS

	SHARED_EXEC_ENVIRONMENT

feature -- Command Execution

	execute (command: STRING) is
			-- Execute external `command'.
		require
			valid_command: command /= Void
		do
			if server_mode then
				request.set_command_name (command);
				request.send
			else
				Execution_environment.system (command)
			end;
		end;

feature -- EiffelBench specific calls

	link_eiffel_driver (c_code_dir, system_name, prelink_cmd_name, driver_name: STRING) is
			-- Link the driver of the precompilation to
			-- the eiffel project.
		do
			if server_mode then
				eif_gr_link_driver (request, c_code_dir.to_c, 
					system_name.to_c, prelink_cmd_name.to_c, 
					driver_name.to_c)
			else
				eif_link_driver (c_code_dir.to_c, system_name.to_c,
					prelink_cmd_name.to_c, driver_name.to_c)
			end
		end;

	invoke_finish_freezing (c_code_dir, freeze_command: STRING) is
			-- Invoke the `finish_freezing' script.
		do
			if server_mode then
				eif_gr_call_finish_freezing (request, c_code_dir.to_c, 
					freeze_command.to_c)
			else
				eif_call_finish_freezing (c_code_dir.to_c, 
					freeze_command.to_c)
			end
		end;

	ebench_command_name: STRING is
		local
			eiffel4, platform: STRING
			ebench_location: FILE_NAME
			a: ANY
		do
			eiffel4 := Execution_environment.get ("EIFFEL4")
			platform := Execution_environment.get ("PLATFORM")
			!! ebench_location.make_from_string (eiffel4)
			ebench_location.extend_from_array (<<"bench","spec",platform,"bin">>)
			ebench_location.set_file_name ("ebench")
			!! Result.make (128)
			a := ebench_location.to_c
			Result.from_c ($a)
		end

feature {NONE} -- Shell

	request: ASYNC_SHELL is
		once
			!! Result;
			Result.pass_address
		end; 

feature {NONE} -- Externals

	eif_link_driver (c_code_dir, system_name, prelink_cmd_name, driver_name: ANY) is
		external
			"C"
		end;

	eif_call_finish_freezing (c_code_dir, freeze_cmd: ANY) is
		external
			"C"
		end;

	eif_gr_call_finish_freezing (rqst: ANY; c_code_dir, freeze_cmd: ANY) is
		external
			"C"
		end;

	eif_gr_link_driver (rqst: ANY; c_code_dir, syst_name, prelink_cmd, driver_name: ANY) is
		external
			"C"
		end

end -- class BENCH_COMMAND_EXECUTOR
