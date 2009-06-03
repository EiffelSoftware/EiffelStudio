note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PROCESS_TEST_IO

inherit
	PROCESS_TEST_SET

feature -- Test routines

	test_stdout_to_agent
			-- Test {PROCESS} output redirection to an agent.
		note
			testing: "covers/{PROCESS}.redirect_output_to_agent"
		local
			l_args: ARRAYED_LIST [STRING]
		do
			create l_args.make (1)
			l_args.force ("ARGUMENT1")
			create_echo_process (l_args)
			launch_process
			compare_output (l_args.first, False)
			check_successful_exit
		end

	test_stderr_to_agent
			-- Test {PROCESS} error redirection to an agent.
		note
			testing: "covers/{PROCESS}.redirect_error_to_agent"
		local
			l_args: ARRAYED_LIST [STRING]
		do
			create l_args.make (2)
			l_args.force ("--stderr")
			l_args.force ("ARGUMENT1")
			create_echo_process (l_args)
			launch_process
			compare_output (l_args.i_th (2), True)
			check_successful_exit
		end

	test_stdout_to_file
			-- Test {PROCESS} output redirection to a file.
		note
			testing: "covers/{PROCESS}.redirect_output_to_file"
		local
			l_args: ARRAYED_LIST [STRING]
			l_process: like current_process
			l_file: like create_temporary_file
		do
			create l_args.make (1)
			l_args.force ("ARGUMENT1")
			create_echo_process (l_args)
			l_process := current_process
			check l_process /= Void end
			l_file := create_temporary_file
			l_process.redirect_output_to_file (l_file.name)
			print (l_file.name)
			l_process.launch
			check_successful_exit
			compare_file_content (l_file, l_args.first)
		end

	test_stderr_to_file
			-- Test {PROCESS} error redirection to a file.
		note
			testing: "covers/{PROCESS}.redirect_error_to_file"
		local
			l_args: ARRAYED_LIST [STRING]
			l_process: like current_process
			l_file: like create_temporary_file
		do
			create l_args.make (2)
			l_args.force ("--stderr")
			l_args.force ("ARGUMENT1")
			create_echo_process (l_args)
			l_process := current_process
			check l_process /= Void end
			l_file := create_temporary_file
			l_process.redirect_error_to_file (l_file.name)
			print (l_file.name)
			l_process.launch
			check_successful_exit
			compare_file_content (l_file, l_args.i_th (2))
		end

	test_stdin_from_file
			-- Test {PROCESS} input redirection from file.
		note
			testing: "covers/{PROCESS}.redirect_input_to_file"
		local
			l_args: ARRAYED_LIST [STRING]
			l_process: like current_process
			l_file: like create_temporary_file
		do
			create l_args.make (2)
			l_args.force ("--stdin")
			create_echo_process (l_args)
			l_process := current_process
			check l_process /= Void end
			l_file := create_temporary_file
			l_file.open_write
			l_file.put_string ("ARGUMENT1%N")
			l_file.put_string ("ARGUMENT2%N")
			l_file.put_string ("quit%N")
			l_file.close
			l_process.redirect_input_to_file (l_file.name)
			launch_process
			compare_output ("ARGUMENT1%N", False)
			compare_output ("ARGUMENT2%N", False)
			check_successful_exit
		end

	test_stdin_from_stream
			-- Test {PROCESS} input redirection from stream.
		note
			testing: "covers/{PROCESS}.redirect_input_to_stream"
		local
			l_args: ARRAYED_LIST [STRING]
			l_process: like current_process
		do
			create l_args.make (2)
			l_args.force ("--stdin")
			create_echo_process (l_args)
			l_process := current_process
			check l_process /= Void end
			l_process.redirect_input_to_stream
			launch_process
			l_process.put_string ("ARGUMENT1%N")
			compare_output ("ARGUMENT1%N", False)
			l_process.put_string ("ARGUMENT2%N")
			compare_output ("ARGUMENT2%N", False)
			l_process.put_string ("quit%N")
			check_successful_exit
		end


feature {NONE} -- Implementation

	create_temporary_file: PLAIN_TEXT_FILE
			-- Create file with temporary name.
		do
			create Result.make (create {FILE_NAME}.make_temporary_name)
			assert ("not_temoporary_file_exists", not Result.exists)
			assert ("temoporary_creatable", Result.is_creatable)
		ensure
			not_result_exists: not Result.exists
			result_creatable: Result.is_creatable
		end

	compare_file_content (a_file: like create_temporary_file; a_expected: READABLE_STRING_8)
			-- Compare file content with given string, raise exception if content does not match or file
			-- could not be read.
		local
			l_last_string: detachable READABLE_STRING_8
		do
			assert ("file_exists", a_file.exists)
			assert ("file_readable", a_file.is_readable)
			a_file.open_read
			a_file.read_stream (a_file.count)
			l_last_string := a_file.last_string
			check l_last_string /= Void end
			assert ("expected_content", a_expected.same_string (l_last_string))
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end


