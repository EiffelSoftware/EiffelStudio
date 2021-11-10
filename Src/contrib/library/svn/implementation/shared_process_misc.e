note
	description: "Shared access to an instance of PROCESS_MISC."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PROCESS_MISC

feature -- Access

	process_misc: PROCESS_MISC
		once
			create Result
		end

feature -- Helpers/bridge

	output_of_command (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable PATH): detachable PROCESS_COMMAND_RESULT
		local
			cmd: READABLE_STRING_GENERAL
			s: STRING_32
		do
			if {PLATFORM}.is_unix then
				s := {STRING_32} "/bin/sh -c %""
				process_misc.append_escaped_string_to (a_cmd, s)
				s.append_character ('%"')
				cmd := s
			else
				cmd := a_cmd
			end

			Result := process_misc.output_of_command (cmd, if a_working_directory /= Void then a_working_directory.name else Void end)
		end

	command_execution (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable PATH; a_record_output: BOOLEAN): detachable PROCESS_COMMAND_RESULT
		local
			cmd: READABLE_STRING_GENERAL
			s: STRING_32
		do
			if {PLATFORM}.is_unix then
				s := {STRING_32} "/bin/sh -c %""
				process_misc.append_escaped_string_to (a_cmd, s)
				s.append_character ('%"')
				cmd := s
			else
				cmd := a_cmd
			end

			Result := process_misc.command_execution (cmd, if a_working_directory /= Void then a_working_directory.name else Void end, a_record_output)
		end

	output (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable PATH): detachable PROCESS_COMMAND_RESULT
		local
			cmd: STRING_32
		do
			if {PLATFORM}.is_unix then
				cmd := process_misc.to_command_line (a_file_name, args)
				Result := output_of_command (cmd, a_working_directory)
			else
				Result := process_misc.output (a_file_name, args, if a_working_directory /= Void then a_working_directory.name else Void end)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
