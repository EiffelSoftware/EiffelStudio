note
	description: "Objects that execution a command and return the output..."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_MISC

inherit
	PROCESS_MISC_IMP
		redefine
			process_launcher, process_launcher_with_command_line,
			setup_redirection,
			get_process_execution_output
		end

feature -- Factory

	process_launcher (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL): BASE_PROCESS
		do
			Result := {PROCESS_FACTORY}.process_launcher (a_file_name, args, a_working_directory)
		end

	process_launcher_with_command_line (a_cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL): BASE_PROCESS
		do
			Result := {PROCESS_FACTORY}.process_launcher_with_command_line (a_cmd_line, a_working_directory)
		end		

feature -- Redirection

	last_output: detachable TUPLE [standard, error: STRING_8]

	setup_redirection (p: BASE_PROCESS)
		local
			std,err: STRING_8
		do
			if attached {PROCESS} p as l_process then
				create std.make (0)
				create err.make (0)
				last_output := [std, err]
				l_process.redirect_output_to_agent (agent std.append)
				l_process.redirect_error_to_agent (agent err.append)
			else
				Precursor (p)
			end
		end

	get_process_execution_output (p: BASE_PROCESS; a_std_output, a_err_output: STRING_8)
		do
			if attached {PROCESS} p as l_process then
				if attached last_output as d then
					l_process.wait_for_exit
					a_std_output.append (d.standard)
					a_err_output.append (d.error)
					last_output := Void
				end
			else
				Precursor (p, a_std_output, a_err_output)
			end
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
end
