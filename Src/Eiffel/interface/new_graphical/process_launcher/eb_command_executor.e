indexing
	description: "Call commands outside the eiffel environment. Version for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMMAND_EXECUTOR

inherit
	COMMAND_EXECUTOR
		redefine
			invoke_finish_freezing,
			terminate_c_compilation
		end

	EB_SHARED_MANAGERS

feature -- Command execution

	invoke_finish_freezing (c_code_dir, freeze_command: STRING; asynchronous: BOOLEAN; workbench_mode: BOOLEAN) is
			-- Invoke the `finish_freezing' script.
		local
			cwd: STRING
			f_cmd: STRING
		do
				-- Store current working directory
			cwd := Execution_environment.current_working_directory
			create f_cmd.make_from_string (freeze_command)

			Execution_environment.change_working_directory (c_code_dir)

			if is_gui then
				if asynchronous then
					if workbench_mode then
						freezing_launcher.prepare_command_line (f_cmd, Void, c_code_dir)
						freezing_launcher.set_hidden (True)
						freezing_launcher.launch (is_gui, False)
					else
						finalizing_launcher.prepare_command_line (f_cmd, Void, c_code_dir)
						finalizing_launcher.set_hidden (True)
						finalizing_launcher.launch (is_gui, False)
					end
				else
					if workbench_mode then
						freezing_launcher.prepare_command_line (f_cmd, Void, c_code_dir)
						freezing_launcher.set_hidden (True)
						freezing_launcher.launch (is_gui, False)
						freezing_launcher.wait_for_exit
					else
						finalizing_launcher.prepare_command_line (f_cmd, Void, c_code_dir)
						finalizing_launcher.set_hidden (True)
						finalizing_launcher.launch (is_gui, False)
						finalizing_launcher.wait_for_exit
					end
				end
			else
				if asynchronous then
					Execution_environment.launch (freeze_command)
				else
					Execution_environment.system (freeze_command)
				end
			end
			Execution_environment.change_working_directory (cwd)
		end

	terminate_c_compilation is
			-- Terminate running c compilation, if any.
		do
			process_manager.terminate_freezing
			process_manager.terminate_finalizing
		end

end
