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
			cmd, cp_cmd: STRING;
		do
			!!cmd.make (50);
			cmd.append ("cd ");
			cmd.append (c_code_directory);
			cmd.append ("; ");
			cmd.append (Finish_freezing_script);
			!!d.make (c_code_directory);
			if not d.has_entry (Finish_freezing_script) then
				!!cp_cmd.make (50);
				cp_cmd.append (Copy_cmd);
				cp_cmd.append_character (' ');
				cp_cmd.append (freeze_command_name);
				cp_cmd.append_character (' ');
				cp_cmd.append (c_code_directory);
				cp_cmd.append ("; ");
				cmd.prepend (cp_cmd);
			end;
			env_system (cmd);
		end;

end

