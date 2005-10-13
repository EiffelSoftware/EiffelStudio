indexing
	description: "Calls commands outside the eiffel environment."
	date: "$Date$"
	revision: "$Revision$"

class COMMAND_EXECUTOR

inherit
	SHARED_EXEC_ENVIRONMENT
	
	-- Jason Wei added the following on Aug 31 2005
	EB_SHARED_MANAGERS
	-- Jason Wei added the above on Aug 31 2005

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

	-- Jason Wei modified the following feature on Aug 29 2005
	invoke_finish_freezing (c_code_dir, freeze_command: STRING; asynchronous: BOOLEAN; workbench_mode: BOOLEAN) is
			-- Invoke the `finish_freezing' script.
		local
			cwd: STRING
			--Jason Wei f 8/30/2005
			f_cmd: STRING
			--Jason Wei a 8/30/2005
		do
				-- Store current working directory
			cwd := Execution_environment.current_working_directory
			
			--Jason Wei f 8/30/2005
			create f_cmd.make_from_string (freeze_command)
			f_cmd.append (" -silent")
			--Jason Wei a 8/30/2005			
			
			Execution_environment.change_working_directory (c_code_dir)
			if asynchronous then
				--Jason Wei 9/12/2005
				if workbench_mode then
					freezing_launcher.prepare_command_line (f_cmd, c_code_dir)
					freezing_launcher.set_hidden (True)
					freezing_launcher.launch (True)
				else
					finalizing_launcher.prepare_command_line (f_cmd, c_code_dir)
					finalizing_launcher.set_hidden (True)
					finalizing_launcher.launch (True)
				end
				--Jason Wei 9/12/2005
				--Execution_environment.launch (freeze_command)
			else
				--Execution_environment.system (freeze_command)
				--Jason Wei 9/12/2005
				if workbench_mode then
					freezing_launcher.prepare_command_line (f_cmd, c_code_dir)
					freezing_launcher.set_hidden (True)
					freezing_launcher.launch (True)
					freezing_launcher.wait_for_exit
				else
					finalizing_launcher.prepare_command_line (f_cmd, c_code_dir)
					finalizing_launcher.set_hidden (True)
					finalizing_launcher.launch (True)
					finalizing_launcher.wait_for_exit
				end				
				--Jason Wei 9/12/2005		
			end
			Execution_environment.change_working_directory (cwd)
		end
	-- Jason Wei modified the above feature on Aug 29 2005		

feature {NONE} -- Externals

	eif_link_driver (c_code_dir,
			system_name,
			prelink_cmd_name,
			driver_name: ANY) is
		external
			"C"
		end

end -- class COMMAND_EXECUTOR
