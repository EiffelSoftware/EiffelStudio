note
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

	invoke_finish_freezing (c_code_dir, freeze_command: STRING_32; asynchronous: BOOLEAN; workbench_mode: BOOLEAN)
			-- Invoke the `finish_freezing' script.
		do
			if is_gui then
				freezing_launcher.prepare_command_line (freeze_command, Void, c_code_dir)
				freezing_launcher.set_hidden (True)
				freezing_launcher.launch (is_gui, False)
				if not asynchronous then
					freezing_launcher.wait_for_exit
				end
			else
				Precursor (freeze_command, c_code_dir, asynchronous, workbench_mode)
			end
		end

	terminate_c_compilation
			-- Terminate running c compilation, if any.
		do
			process_manager.terminate_freezing
			process_manager.terminate_finalizing
		end

end
