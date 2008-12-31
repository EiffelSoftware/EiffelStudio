note
	description: "Task used for compiling Eiffel and C code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	title: STRING = "Compiling code"
			-- Task title

	steps_count: INTEGER
			-- Number of steps involved in task
		do
			if environment.compile_eiffel then
				Result := 5
			else
				Result := 4 -- C compilations
			end
		end

feature {NONE} -- Implementation

	internal_execute
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		do
			-- Compiling generated C code
			message_output.add_title (Compilation_title_c)
			Env.change_working_directory (environment.destination_folder)
			if not environment.abort then
				progress_report.set_title (C_client_compilation_title)
				compiler.compile_folder (environment.destination_folder + "Client\Clib", False)
				progress_report.step
				if not environment.abort then
					progress_report.set_title (C_client_compilation_title_mt)
					compiler.compile_folder (environment.destination_folder + "Client\Clib", True)
					progress_report.step
				end
			end
			if not environment.abort then
				progress_report.set_title (C_server_compilation_title)
				compiler.compile_folder (environment.destination_folder + "Server\Clib", False)
				progress_report.step
				if not environment.abort then
					progress_report.set_title (C_server_compilation_title_mt)
					compiler.compile_folder (environment.destination_folder + "Server\Clib", True)
					progress_report.step
				end
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

	Compilation_title_c: STRING = "Compiling C code"
			-- Compilation message.

	Compilation_title_eiffel: STRING = "Compiling Eiffel code"
			-- Compilation message.

	C_client_compilation_title: STRING = "Compiling C client code"
			-- C compilation message.

	C_common_compilation_title: STRING = "Compiling C common code"
			-- C compilation message.

	C_server_compilation_title: STRING = "Compiling C server code"
			-- C compilation message.

	C_client_compilation_title_mt: STRING = "Compiling multi-threaded C client code"
			-- C compilation message.

	C_common_compilation_title_mt: STRING = "Compiling multi-threaded C common code"
			-- C compilation message.

	C_server_compilation_title_mt: STRING = "Compiling multi-threaded C server code"
			-- C compilation message.

	Eiffel_compilation_title: STRING = "Compiling Eiffel code";
			-- Eiffel compilation message.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_CODE_COMPILATION_TASK

