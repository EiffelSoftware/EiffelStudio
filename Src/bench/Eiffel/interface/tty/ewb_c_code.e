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
		local
			d: DIRECTORY;
			cmd, copy_cmd: STRING;
		do
			!!cmd.make (50);
			cmd.append ("cd ");
			cmd.append (c_code_directory);
			cmd.append ("; ");
			cmd.append (Finish_freezing_script);
			!!d.make (c_code_directory);
			if not d.has_entry (Finish_freezing_script) then
				!!copy_cmd.make (50);
				copy_cmd.append ("cp ");
				copy_cmd.append (freeze_command_name);
				copy_cmd.append (" ");
				copy_cmd.append (c_code_directory);
				copy_cmd.append ("; ");
				cmd.prepend (copy_cmd);
			end;
			env_system (cmd);
		end;

end

