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
			cp_cmd, current_dir: STRING;
		do
				-- Change dir to the c_code_directory
			current_dir := Execution_environment.current_working_directory
			Execution_environment.change_working_directory (c_code_directory);

				-- Check to see if Finish_freezing_script is there
				-- copy if not
			!!d.make (".");
			if not d.has_entry (Finish_freezing_script) then
				!!cp_cmd.make (50);
				cp_cmd.append (Copy_cmd);
				cp_cmd.extend (' ');
				cp_cmd.append (freeze_command_name);
				cp_cmd.append (" .");
				Execution_environment.system (cp_cmd);
			end;

				-- Call Finish_freezing_script
			Execution_environment.system (Finish_freezing_script);

				-- Change dir back to original
			Execution_environment.change_working_directory (current_dir);
		end;

end

