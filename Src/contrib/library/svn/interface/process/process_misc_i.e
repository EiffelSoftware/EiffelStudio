note
	description: "Objects that execution a command and return the output..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_MISC_I

feature -- Status report

	last_error: INTEGER
		deferred
		end

feature -- Redirection

	setup_redirection (p: BASE_PROCESS)
		deferred
		end

	get_process_execution_output (p: BASE_PROCESS; a_std_output, a_err_output: STRING_8)
		require
			p.launched
		deferred
		end

feature -- Execution

	output (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		deferred
		end

	output_of_command (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		deferred
		end

	command_execution (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_record_output: BOOLEAN): detachable PROCESS_COMMAND_RESULT
		deferred
		end

feature -- Helpers

	append_escaped_string_to (a_string: READABLE_STRING_GENERAL; a_output: STRING_32)
		deferred
		end

	to_command_line (a_filename: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]): STRING_32
		deferred
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
