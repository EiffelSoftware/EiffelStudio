
class ASYNC_SHELL 

inherit

	IPC_SHARED

feature 

	send is
			-- Send request to execute shell command
			-- given by `command_name' in background.
		require
			Command_set: command_name /= Void
		local
			ext_str: ANY;
			job_nb: INTEGER
		do
			ext_str := command_name.to_c;
			job_nb := async_shell ($ext_str);
			--if (job_nb /= -1) then
				-- Future version for keeping track
				-- of processes.
				-- sent_jobs.put (command_name, job_nb.out)
			--end
		end;

	command_name: STRING;
			-- Command to be executed
			-- by background shell

	set_command_name (s: STRING) is
			-- Assign `s' to `command_name'.
		require
			Valid_command: not (s = Void)
		do
			command_name := s
		ensure
			command_name = s
		end;

	pass_address is
			-- Send the addresse of `send' and `set_command_name' to
			-- C so that C can send a request
		once
			async_shell_pass_address ($send, $set_command_name);
		end;

feature {NONE} -- External

	async_shell (cmd: POINTER): INTEGER is
		external
			"C"
		end;

	async_shell_pass_address (send_address, set_address: POINTER) is
		external
			"C"
		end;

end
