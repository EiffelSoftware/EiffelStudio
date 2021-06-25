note
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_TEST_SET

inherit
	EQA_TEST_SET
		rename
			on_prepare as on_prepare_frozen,
			on_clean as on_clean_frozen
		redefine
			on_prepare_frozen,
			on_clean_frozen
		end

feature {NONE} -- Access

	echo_executable_cache: detachable like echo_executable
			-- Cache for `echo_executable'

	current_process: PROCESS
			-- Process instance currently being used for testing

	last_process_output: PROCESS_OUTPUT
			-- Last created {PROCESS_OUTPUT} instance through `launch_process'

feature {NONE} -- Status report

	is_process_launched: BOOLEAN
			-- Has `current_process' been launched yet?
		do
			Result := current_process.launched
		ensure
			current_process_not_launched: current_process.launched
		end

feature {NONE} -- Status setting

	create_process (a_executable: READABLE_STRING_GENERAL; a_arg_list: detachable LIST [READABLE_STRING_GENERAL])
			-- Initialize `current_process' to launch given executable.
			--
			-- `a_executable': Name of executable to be launched.
			-- `a_arg_list': List of arguments to pass to process, can be Void.
		require
			a_executable_not_empty: not a_executable.is_empty
		local
			l_factory: PROCESS_FACTORY
			l_process: like current_process
		do
			create l_factory
			l_process := l_factory.process_launcher (a_executable, a_arg_list, Void)
			l_process.set_hidden (True)
			l_process.set_separate_console (False)
			current_process := l_process
		ensure
			current_process_new: current_process /= old current_process
			current_process_not_launched: not is_process_launched
		end

	create_echo_process (a_arg_list: detachable LIST [READABLE_STRING_GENERAL])
			-- Initialize `current_process' to launch `echo_executable'.
		local
			l_args: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			if a_arg_list /= Void then
				create l_args.make (a_arg_list.count + 1)
				l_args.extend ("--nologo")
				⟳ c: a_arg_list ¦ l_args.force (c) ⟲
			end
			create_process (echo_executable.name, l_args)
		ensure
			current_process_new: current_process /= old current_process
			current_process_not_launched: not is_process_launched
		end

	launch_process
			-- Launch `current_process' and redirect all output to a new instance of `last_process_output'.
		require
			current_process_not_launched: not is_process_launched
		local
			l_output: like last_process_output
		do
			create l_output.make (current_process)
			current_process.launch
			last_process_output := l_output
		ensure
			last_process_output_attached: last_process_output /= Void
			last_process_output_uses_current_process: last_process_output.process = current_process
			process_launched: is_process_launched
		end

feature {NONE} -- Query

	echo_executable: PATH
			-- Path to `eiffel_echo' executable
			--
			-- Note: by default this is $ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin/eiffel_echo, if
			--       environment variables are missing we check for a Unix layout. Otherwise we assume
			--       `eiffel_echo' is reachable from $PATH.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_ise_eiffel, l_ise_platform: detachable STRING_32
			l_filename: PATH
			l_cached: like echo_executable_cache
		do
			l_cached := echo_executable_cache
			if l_cached = Void then
				create l_env
				l_ise_eiffel := l_env.item (ise_eiffel_env)
				l_ise_platform := l_env.item (ise_platform_env)
				create l_filename.make_empty
				if l_ise_eiffel = Void or l_ise_platform = Void then
					if {PLATFORM}.is_unix then
						l_filename := l_filename.extended ("usr").extended ("bin")
					end
				else
					l_filename := l_filename.extended (l_ise_eiffel).extended ("tools").extended ("spec").extended (l_ise_platform).extended ("bin")
				end
				l_filename := l_filename.extended (eiffel_echo_name)
				echo_executable_cache := l_filename
				l_cached := l_filename
			end
			Result := l_cached
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
		end

feature {NONE} -- Basic functionality

	compare_output (a_expected: READABLE_STRING_8; a_from_errors: BOOLEAN)
			-- Compare output received through `last_process_output' with given string, reaise exception
			-- if they do not match or process did not respond properly.
			--
			-- `a_expected': Output expected from process.
			-- `a_from_errors': If True, characters will be received from error output of `process'.
		require
			last_process_output_attached: last_process_output /= Void
			last_process_output_valid: attached last_process_output as l_out and then
				l_out.process.launched
		local
			l_output: like last_process_output
			l_received: READABLE_STRING_8
			s: STRING_8
		do
			l_output := last_process_output
			if {PLATFORM}.is_windows then
				l_output.receive (a_expected.count + a_expected.occurrences ('%N'), a_from_errors)
				l_received := l_output.last_received
				create s.make_from_string (l_received)
				s.prune_all ('%R')
				l_received := s
			else
				l_output.receive (a_expected.count, a_from_errors)
				l_received := l_output.last_received
			end
			if l_received.count < a_expected.count then
				if l_output.has_timed_out then
					assert ("process_responsive", False)
				else
					assert ("expected_output_before_exit", False)
				end
			elseif not l_received.same_string (a_expected) then
				print ("Expected output:%N>")
				print (a_expected)
				print ("<%N------------------------------%N")
				print ("Recevied output:%N>")
				print (l_received)
				print ("<")
				assert ("expected_output", False)
			end
		end

	wait_for_exit
			-- If launched, wait for `current_process' to exit.
			--
			-- Note: if process does not exit after `timeout', try to terminate it.
		local
			l_process: like current_process
		do
			l_process := current_process
			if l_process.launched and not l_process.has_exited then
				l_process.wait_for_exit_with_timeout (timeout)
				if not l_process.has_exited then
					l_process.terminate
					if not l_process.has_exited then
						l_process.wait_for_exit_with_timeout (timeout)
					end
				end
				assert ("process_exited", l_process.has_exited)
			end
		ensure
			not_running: not current_process.is_running
		end

	check_successful_exit
			-- Check if `current_process' has exited successfully.
		require
			current_process_launched: is_process_launched
		do
			wait_for_exit
			assert ("terminated_normally", not current_process.force_terminated)
			assert ("good_exit_code", current_process.exit_code = 0)
		end

feature {NONE} -- Events

	frozen on_prepare_frozen
			-- <Precursor>
		local
			l_factory: PROCESS_FACTORY
		do
			assert ("multithreaded", {PLATFORM}.is_thread_capable)
			create l_factory
			current_process := l_factory.process_launcher ("test", Void, Void)
			create last_process_output.make (current_process)
			on_prepare
		end

	frozen on_clean_frozen
			-- <Precursor>
		do
			on_clean
			wait_for_exit
		end

	on_prepare
			-- Called after `prepare' has performed all initialization.
		do
		ensure
			prepared: is_prepared
		end

	on_clean
			-- Called before clean performs any cleaning up.
		require
			prepared: is_prepared
		do
		end

feature {NONE} -- Constants

	ise_eiffel_env: STRING = "ISE_EIFFEL"
	ise_platform_env: STRING = "ISE_PLATFORM"
	eiffel_echo_name: STRING
		do
			Result := "eiffel_echo"
			if {PLATFORM}.is_windows then
				Result.append (".exe")
			end
		end

	timeout: INTEGER = 2000
			-- Time in milliseconds we wait for process to send new output

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
