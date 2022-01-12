note
	description: "Boogie executable running as a separate process."

deferred class
	E2B_PLATFORM_EXECUTABLE

inherit

	E2B_EXECUTABLE

feature -- Access

	last_output: detachable STRING
			-- <Precursor>
		do
			if attached internal_last_output then
				Result := internal_last_output
			else
				if attached process as l_process and then not l_process.is_running then
					read_output
					Result := internal_last_output
				end
			end
		end

feature -- Status report

	is_running: BOOLEAN
			-- <Precursor>
		do
			if
				attached process as p and then
				p.is_running
			then
				p.wait_for_exit_with_timeout (1)
				Result := p.is_running
			end
		end

feature -- Basic operations

	run
			-- <Precursor>
		do
			internal_last_output := Void
			generate_boogie_file
			launch_boogie (True)
			read_output
			process := Void
		end

	run_asynchronous
			-- <Precursor>
		do
			internal_last_output := Void
			generate_boogie_file
			launch_boogie (False)
		end

	cancel
			-- <Precursor>
		local
			l_id: INTEGER
		do
			if attached process as l_process then
				l_id := l_process.id
				if l_process.is_running then
					l_process.terminate_tree
					l_process.wait_for_exit_with_timeout (1000)
					process := Void
				end
			end
		end

feature {NONE} -- Implementation

	is_disposed: BOOLEAN
			-- Is object already disposed?

	internal_last_output: detachable STRING
			-- Last generated output.

	boogie_file_name: PATH
			-- File name used to generate Boogie file.
		deferred
		end

	boogie_output_file_name: PATH
			-- File name used to generate Boogie file.
		deferred
		end

	boogie_executable: READABLE_STRING_32
			-- Executable name to launch Boogie (including path if necessary).
		deferred
		ensure
			not Result.is_empty
		end

	process: detachable BASE_PROCESS
			-- Process running Boogie.

	generate_boogie_file
			-- Generate Boogie file from input.
		local
			l_output_file: PLAIN_TEXT_FILE
			u: FILE_UTILITIES
		do
			u.create_directory_path (boogie_file_name.parent)
			create l_output_file.make_with_path (boogie_file_name)
			l_output_file.open_write
			if l_output_file.is_open_write then
				append_header (l_output_file)
				across
					input.boogie_files as b
				loop
					append_file_content (l_output_file, b.item)
				end
				l_output_file.put_string ("// Custom content")
				l_output_file.put_new_line
				l_output_file.put_new_line
				across
					input.custom_content as c
				loop
					l_output_file.put_string (c.item)
				end
				l_output_file.close
			else
					-- TODO: error handling
				check False end
			end
		end

	launch_boogie (a_wait_for_exit: BOOLEAN)
			-- Launch Boogie on generated file.
		local
			l_ee: EXECUTION_ENVIRONMENT
			l_arguments: LINKED_LIST [READABLE_STRING_32]
			l_process_factory: BASE_PROCESS_FACTORY
			l_context: E2B_SHARED_CONTEXT
			l_plain_text_file: PLAIN_TEXT_FILE
		do
			create l_context

				-- Prepare command line arguments
			create l_arguments.make
			l_arguments.extend ({STRING_32} "/trace")
			if l_context.options.is_enforcing_timeout then
				l_arguments.extend ({STRING_32} "/z3opt:/T:" + l_context.options.timeout.out)
			end
--			l_arguments.extend ({STRING_32} "/errorLimit:1")
--			l_arguments.extend ({STRING_32} "/mv:" + safe_file_name (model_file_name))
			l_arguments.extend (boogie_file_name.name)

				-- Launch Boogie
			create l_ee
			create l_process_factory
			if {PLATFORM}.is_windows then
				process := l_process_factory.process_launcher (boogie_executable, l_arguments, l_ee.current_working_path.name)
				process.set_on_fail_launch_handler (agent handle_launch_failed (boogie_executable, l_arguments))
			elseif {PLATFORM}.is_unix then
				process := l_process_factory.process_launcher (boogie_executable, l_arguments, l_ee.current_working_path.name)
				process.set_on_fail_launch_handler (agent handle_launch_failed (boogie_executable, l_arguments))
			else
				check False end
			end

			process.enable_launch_in_new_process_group
			create l_plain_text_file.make_with_path (boogie_output_file_name)
			l_plain_text_file.open_write
			l_plain_text_file.close
			process.redirect_output_to_file (boogie_output_file_name.name)
			process.redirect_error_to_same_as_output
			process.set_on_terminate_handler (agent handle_terminated)
			process.set_on_exit_handler (agent handle_terminated)

			process.launch
			if a_wait_for_exit then
				process.wait_for_exit
			end
		end

	handle_launch_failed (a_executable: READABLE_STRING_32; a_arguments: LINKED_LIST [READABLE_STRING_32])
			-- Handle launch of Boogie failed.
		local
			l_error: E2B_AUTOPROOF_ERROR
		do
			create l_error
			l_error.set_type ("Boogie")
			l_error.set_message (messages.boogie_launch_failed (a_executable))
			if not autoproof_errors.has (l_error) then
				autoproof_errors.extend (l_error)
			end
		end

	handle_terminated
			-- Handle process finished.
		do
			-- if {PLATFORM}.is_windows then
				-- create l_f1.make_open_read (boogie_output_file_name)
				-- if input.context /= Void then
					-- create l_f2.make_open_write ("C:\temp\ap_output-" + input.context + ".txt")
				-- else
					-- create l_f2.make_open_write ("C:\temp\ap_output.txt")
				-- end
				-- from
					-- l_f1.start
				-- until
					-- l_f1.after
				-- loop
					-- l_f1.read_line
					-- l_f2.put_string (l_f1.last_string)
					-- l_f2.put_character ('%N')
				-- end
				-- l_f1.close
				-- l_f2.close
			-- end
		end

	append_header (a_file: PLAIN_TEXT_FILE)
			-- Append header to `a_file'.
		require
			writable: a_file.is_open_write
		local
			l_date_time: DATE_TIME
		do
			create l_date_time.make_now
			a_file.put_string ("// Automatically generated (")
			a_file.put_string (l_date_time.out)
			a_file.put_string (")%N%N")
		end

	append_file_content (a_file: PLAIN_TEXT_FILE; a_file_name: PATH)
			-- Append content of `a_file_name' to `a_file'.
		require
			writable: a_file.is_open_write
		local
			l_input_file: PLAIN_TEXT_FILE
			l_count: INTEGER
			has_error: BOOLEAN
		do
			if has_error then
				if attached l_input_file then
					if l_input_file.is_open_read then
						l_input_file.close
						a_file.put_string ("// Error: unable to read file ")
					else
						a_file.put_string ("// Error: unable to open file ")
					end
					a_file.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_file_name.name))
					a_file.put_new_line
					a_file.put_new_line
				end
			else
				create l_input_file.make_with_path (a_file_name)
				l_count := l_input_file.count
				l_input_file.open_read
				if l_input_file.is_open_read then
					l_input_file.read_stream (l_count)
					a_file.put_string ("// File: ")
					a_file.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_file_name.name))
					a_file.put_new_line
					a_file.put_new_line
					a_file.put_string (l_input_file.last_string)
					l_input_file.close
					a_file.put_new_line
				else
					a_file.put_string ("// Error: unable to open file ")
					a_file.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_file_name.name))
					a_file.put_new_line
					a_file.put_new_line
				end
			end
		rescue
			if not has_error then
				has_error := True
				retry
			end
		end

	safe_file_name (a_file_name: STRING): STRING
			-- Safe version of `a_file_name' in case of special characters.
		do
			if a_file_name.has (' ') then
				Result := "%"" + a_file_name + "%""
			else
				Result := a_file_name
			end
		end

feature {NONE} -- Output capture

	read_output
			-- Read generated output.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create internal_last_output.make (1024)
			create l_file.make_with_path (boogie_output_file_name)
			l_file.open_read
			from
				l_file.start
			until
				l_file.after
			loop
				l_file.read_line
				internal_last_output.append (l_file.last_string)
				internal_last_output.append_character ('%N')
			end
			l_file.close
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010-2015 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2021-2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"
end
