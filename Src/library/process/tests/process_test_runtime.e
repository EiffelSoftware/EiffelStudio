note
	description: "[
		Test routines testing basic runtime functionality of process library.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PROCESS_TEST_RUNTIME

inherit
	PROCESS_TEST_SET

feature -- Test routines

	test_launch
			-- Test simple {PROCESS} execution.
		note
			testing: "covers/{PROCESS}.launch"
		do
			create_echo_process (Void)
			launch_process
			check_successful_exit
		end

	test_failing
			-- Test launching a non existent executable
		note
			testing: "covers/{PROCESS}.launch"
		local
			l_fail_cell: CELL [BOOLEAN]
			l_process: like current_process
		do
			create l_fail_cell
			create_process ("an_executable_with_this_name_should_not_exist", Void)
			l_process := current_process
			check l_process /= Void end
			l_process.set_on_fail_launch_handler (agent l_fail_cell.put (True))
			l_process.launch
			wait_for_exit
			assert ("exit_code_1", l_process.exit_code = 1)
		end

	test_handlers
			-- Test start, launch, exit handler
		note
			testing: "covers/{PROCESS}.set_on_start_handler"
			testing: "covers/{PROCESS}.set_on_successful_launch_handler"
			testing: "covers/{PROCESS}.set_on_exit_handler"
		local
			l_start_cell, l_launch_cell, l_exit_cell: CELL [BOOLEAN]
			l_process: like current_process
		do
			create l_start_cell
			create l_launch_cell
			create l_exit_cell
			create_echo_process (Void)
			l_process := current_process
			check l_process /= Void end
			l_process.set_on_start_handler (agent l_start_cell.put (True))
			l_process.set_on_successful_launch_handler (agent l_launch_cell.put (True))
			l_process.set_on_exit_handler (agent l_exit_cell.put (True))
			l_process.launch
			check_successful_exit
			assert ("start_handler_called", l_start_cell.item)
			assert ("launch_handler_called", l_launch_cell.item)
			assert ("exit_handler_called", l_exit_cell.item)
		end

	test_terminate
			-- Test process termination and handler
		note
			testing: "covers/{PROCESS}.terminate"
			testing: "covers/{PROCESS}.set_on_terminate_handler"
		local
			l_args: ARRAYED_LIST [STRING]
			l_terminate_cell: CELL [BOOLEAN]
			l_process: like current_process
		do
			create l_terminate_cell
			create l_args.make (1)
			l_args.force ("--stdin")
			create_echo_process (l_args)
			l_process := current_process
			check l_process /= Void end
			l_process.set_on_terminate_handler (agent l_terminate_cell.put (True))
			l_process.launch
			l_process.terminate
			l_process.wait_for_exit_with_timeout (timeout)
			assert ("process_exited", l_process.has_exited)
			assert ("process_terminated", l_process.force_terminated)
			assert ("terminate_handler_called", l_terminate_cell.item)
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
