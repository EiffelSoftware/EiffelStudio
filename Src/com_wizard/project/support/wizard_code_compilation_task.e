indexing
	description: "Task used for compiling Eiffel and C code"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CODE_COMPILATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Access

	title: STRING is "Compiling Code:"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task
		do
			if environment.compile_eiffel then
				Result := 3
			else
				Result := 2 -- C compilations
			end
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		do
			-- Compiling generated C code
			message_output.add_title (Compilation_title_c)
			Env.change_working_directory (environment.destination_folder)
			if not environment.abort then
				progress_report.set_title (C_client_compilation_title)
				compiler.compile_folder ("Client\Clib")
				progress_report.step
			end
			if not environment.abort then
				progress_report.set_title (C_server_compilation_title)
				compiler.compile_folder ("Server\Clib")
				progress_report.step
			end
			if not environment.abort then		
				message_output.add_message (Compilation_Successful)
			
				-- Compiling Eiffel
				if environment.compile_eiffel then
					message_output.add_title (Compilation_title_eiffel)
					if environment.is_client then
						progress_report.set_title (Eiffel_compilation_title)
						compiler.compile_eiffel (Client)
						progress_report.step
					else
						progress_report.set_title (Eiffel_compilation_title)
						compiler.compile_eiffel (Server)
						progress_report.step
					end
				end
			end
			if not environment.abort then		
				message_output.add_title (Compilation_Successful)
			end
		end

feature {NONE} -- Private Access

	Compilation_title_c: STRING is "Compiling Generated C Code"
			-- Compilation message.

	Compilation_title_eiffel: STRING is "Compiling Generated Eiffel Code"
			-- Compilation message.

	C_client_compilation_title: STRING is "Compiling Generated C Client Code"
			-- C compilation message.

	C_common_compilation_title: STRING is "Compiling Generated C Common Code"
			-- C compilation message.

	C_server_compilation_title: STRING is "Compiling Generated C Server Code"
			-- C compilation message.

	Compilation_successful: STRING is "Compilation Completed."
			-- Compilation successful message.

	Compilation_failed: STRING is "Compilation Failed."
			-- Compilation failed message.

	Eiffel_compilation_title: STRING is "Compiling Eiffel Code"
			-- Eiffel compilation message.

end -- class WIZARD_CODE_COMPILATION_TASK
