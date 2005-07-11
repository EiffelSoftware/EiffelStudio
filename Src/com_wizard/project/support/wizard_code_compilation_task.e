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

	title: STRING is "Compiling code"
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
			
				-- Compiling Eiffel
				if environment.compile_eiffel then
					message_output.add_title (Compilation_title_eiffel)
					progress_report.set_title (Eiffel_compilation_title)
					if environment.is_client then
						compiler.compile_eiffel (Client)
					else
						compiler.compile_eiffel (Server)
					end
					progress_report.step
				end
			end
		end

feature {NONE} -- Private Access

	Compilation_title_c: STRING is "Compiling C code"
			-- Compilation message.

	Compilation_title_eiffel: STRING is "Compiling Eiffel code"
			-- Compilation message.

	C_client_compilation_title: STRING is "Compiling C client code"
			-- C compilation message.

	C_common_compilation_title: STRING is "Compiling C common code"
			-- C compilation message.

	C_server_compilation_title: STRING is "Compiling C server code"
			-- C compilation message.

	Eiffel_compilation_title: STRING is "Compiling Eiffel code"
			-- Eiffel compilation message.

end -- class WIZARD_CODE_COMPILATION_TASK

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
