note
	description: "Objects that execution a command and return the output..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_MISC_IMP

inherit
	PROCESS_MISC_I

feature -- Status report

	last_error: INTEGER

feature -- Redirection

	setup_redirection (p: BASE_PROCESS)
		do
			p.redirect_output_to_stream
			p.redirect_error_to_stream
		end

	get_process_execution_output (p: BASE_PROCESS; a_std_output, a_err_output: STRING_8)
		local
			err_spec, res_spec: SPECIAL [NATURAL_8]
		do
			from
			until
				p.has_exited
			loop
				from
					if res_spec = Void then
						create res_spec.make_filled (0, 1024)
					end
				until
					p.has_exited or p.has_output_stream_closed or p.has_output_stream_error
				loop
					p.read_output_to_special (res_spec)
					append_special_of_natural_8_to_string_8 (res_spec, a_std_output)
				end

				from
					if err_spec = Void then
						create err_spec.make_filled (0, 1024)
					end
				until
					p.has_exited or p.has_error_stream_closed or p.has_error_stream_error
				loop
					p.read_error_to_special (err_spec)
					append_special_of_natural_8_to_string_8 (err_spec, a_err_output)
				end

				p.wait_for_exit_with_timeout (50)
			end
		end

feature -- Factory

	process_launcher (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL): BASE_PROCESS
			-- Returns a process launcher used to launch program `a_file_name' with arguments `args'
			-- and working directory `a_working_directory'.
			-- Use Void for `a_working_directory' if no working directory is specified.
			-- Use Void for `args' if no arguments are required.			
		require
			a_file_name_not_null: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		do
			Result := {BASE_PROCESS_FACTORY}.process_launcher (a_file_name, args, a_working_directory)
		ensure
			process_launched_created: Result /= Void
		end

	process_launcher_with_command_line (a_cmd_line: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL): BASE_PROCESS
			-- Returns a process launcher to launch command line `cmd_line' that specifies an executable and
			-- optional arguments, using `a_working_directory' as its working directory.
			-- Use Void for `a_working_directory' if no working directory is required.		
		require
			command_line_not_null: a_cmd_line /= Void
			command_line_not_empty: not a_cmd_line.is_empty
		do
			Result := {BASE_PROCESS_FACTORY}.process_launcher_with_command_line (a_cmd_line, a_working_directory)
		ensure
			process_launched_created: Result /= Void
		end

feature -- Execution


	output (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		local
			retried: BOOLEAN
			err,res: STRING
		do
			if not retried then
				last_error := 0
				if attached process_launcher (a_file_name, args, a_working_directory) as p then
					p.enable_launch_in_new_process_group
					p.set_separate_console (False)
					p.set_hidden (True)
					p.set_detached_console (True)

					setup_redirection (p)

					p.launch
					if p.launched then
						create res.make (0)
						create err.make (0)
						get_process_execution_output (p, res, err)
						create Result.make (p.exit_code, res, err)
					else
						last_error := 1
					end
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	output_of_command (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		local
			retried: BOOLEAN
			err,res: STRING
		do
			if not retried then
				last_error := 0
				if attached process_launcher_with_command_line (a_cmd, a_working_directory) as p then
					p.enable_launch_in_new_process_group
					p.set_separate_console (False)
					p.set_hidden (True)
					p.set_detached_console (True)
					setup_redirection (p)

					p.launch
					if p.launched then
						create res.make (0)
						create err.make (0)
						get_process_execution_output (p, res, err)
						create Result.make (p.exit_code, res, err)
					else
						last_error := 1
					end
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	command_execution (a_cmd: READABLE_STRING_GENERAL; a_working_directory: detachable READABLE_STRING_GENERAL; a_record_output: BOOLEAN): detachable PROCESS_COMMAND_RESULT
		local
			retried: BOOLEAN
			err,res: STRING
		do
			if not retried then
				last_error := 0
				if attached process_launcher_with_command_line (a_cmd, a_working_directory) as p then
					p.enable_launch_in_new_process_group
					p.set_separate_console (False)
					p.set_hidden (True)
					p.set_detached_console (True)
					if a_record_output then
						setup_redirection (p)
					end
					p.launch
					if p.launched then
						create res.make (0)
						create err.make (0)
						if a_record_output then
							get_process_execution_output (p, res, err)
						end
						create Result.make (p.exit_code, res, err)
					else
						last_error := 1
					end
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

feature -- Helpers

	append_escaped_string_to (a_string: READABLE_STRING_GENERAL; a_output: STRING_32)
		local
			i,n: INTEGER
			ch: CHARACTER_32
		do
			from
				i := 1
				n := a_string.count
			until
				i > n
			loop
				ch := a_string [i]
				inspect ch
				when '`' then
					-- Ignore
					-- TODO find proper escaping solution
				when '%"', '%'' , '\' then
					a_output.extend ('\') -- escape the character
					a_output.extend (ch)
				when '%R' then
					-- Ignore
				else
					a_output.extend (ch)
				end
				i := i + 1
			end
		end

	to_command_line (a_filename: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]): STRING_32
		local
			arg: READABLE_STRING_GENERAL
		do
			create Result.make (a_filename.count)
			if a_filename.has (' ') then
				Result.append_character ('%"')
				Result.append_string_general (a_filename)
				Result.append_character ('%"')
			else
				Result.append_string_general (a_filename)
			end
			if args /= Void then
				across
					args as ic
				loop
					arg := ic.item
					Result.append_character (' ')
					Result.append_character ('%"')
					append_escaped_string_to (arg, Result)
					Result.append_character ('%"')
				end
			end
		end

feature {NONE} -- Implementation

	append_special_of_natural_8_to_string_8 (spec: SPECIAL [NATURAL_8]; a_output: STRING)
		local
			i,n: INTEGER
		do
			from
				i := spec.lower
				n := spec.upper
			until
				i > n
			loop
				a_output.append_code (spec[i])
				i := i + 1
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
