indexing
	description: "Calls commands outside the eiffel environment."
	date: "$Date$"
	revision: "$Revision$"

class COMMAND_EXECUTOR

inherit
	SHARED_EXEC_ENVIRONMENT

feature -- Command Execution

	execute (command: STRING) is
			-- Execute external `command'.
		require
			valid_command: command /= Void
		do
			Execution_environment.system (command)
		end

	execute_with_args (appl_name, args: STRING) is
			-- Execute external command `appl_name' with following arguments.
		require
			appl_name_not_void: appl_name /= Void
			args_not_void: args /= Void
		local
			command: STRING
		do
			create command.make (appl_name.count + args.count + 1)
			command.append (appl_name)
			command.append_character (' ')
			command.append (args)
			Execution_environment.launch (command)
		end
		
feature -- $EiffelGraphicalCompiler$ specific calls

	link_eiffel_driver (c_code_dir,
				system_name,
				prelink_cmd_name,
				driver_name: STRING) is
			-- Link the driver of the precompilation to
			-- the eiffel project.
		do
			eif_link_driver (c_code_dir.to_c, system_name.to_c,
				prelink_cmd_name.to_c, driver_name.to_c)
		end

	invoke_finish_freezing (c_code_dir, freeze_command: STRING) is
			-- Invoke the `finish_freezing' script.
		do
			eif_call_finish_freezing (c_code_dir.to_c,
				freeze_command.to_c)
		end

feature {NONE} -- Externals

	eif_link_driver (c_code_dir,
			system_name,
			prelink_cmd_name,
			driver_name: ANY) is
		external
			"C"
		end

	eif_call_finish_freezing (c_code_dir, freeze_cmd: ANY) is
		external
			"C"
		end

end -- class COMMAND_EXECUTOR
