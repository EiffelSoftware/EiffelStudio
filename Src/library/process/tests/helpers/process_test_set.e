note
	description: "Summary description for {PROCESS_TEST_SET}."
	author: ""
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

	echo_executable_cache: ?like echo_executable
			-- Cache for `echo_executable'

	current_process: ?PROCESS
			-- Process instance currently being used for testing

	last_process_output: ?PROCESS_OUTPUT
			-- Last created {PROCESS_OUTPUT} instance through `launch_process'

feature {NONE} -- Status report

	is_process_launched: BOOLEAN
			-- Has `current_process' been launched yet?
		require
			current_process_attached: current_process /= Void
		local
			l_process: like current_process
		do
			l_process := current_process
			check l_process /= Void end
			Result := l_process.launched
		ensure
			current_process_not_launched: {l_proc: like current_process} current_process and then l_proc.launched
		end

feature {NONE} -- Status setting

	create_process (a_executable: STRING; a_arg_list: ?LIST [STRING])
			-- Initialize `current_process' to launch given executable.
			--
			-- `a_executable': Name of executable to be launched.
			-- `a_arg_list': List of arguments to pass to process, can be Void.
		require
			a_executable_not_empty: not a_executable.is_empty
			args_attached_implies_valid: {l_args: LIST [STRING]} a_arg_list implies not l_args.has (Void)
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
			current_process_attached: current_process /= Void
			current_process_new: current_process /= old current_process
			current_process_not_launched: not is_process_launched
		end

	create_echo_process (a_arg_list: ?LIST [STRING])
			-- Initialize `current_process' to launch `echo_executable'.
		require
			args_attached_implies_valid: {l_args: LIST [STRING]} a_arg_list implies not l_args.has (Void)
		do
			create_process (echo_executable, a_arg_list)
		ensure
			current_process_attached: current_process /= Void
			current_process_new: current_process /= old current_process
			current_process_not_launched: not is_process_launched
		end

	launch_process
			-- Launch `current_process' and redirect all output to a new instance of `last_process_output'.
		require
			current_process_attached: current_process /= Void
			current_process_not_launched: not is_process_launched
		local
			l_process: like current_process
			l_output: like last_process_output
		do
			l_process := current_process
			check l_process /= Void end
			create l_output.make (l_process)
			l_process.launch
			last_process_output := l_output
		ensure
			last_process_output_attached: last_process_output /= Void
			current_process_attached: current_process /= Void
			last_process_output_uses_current_process: {l_out: like last_process_output} last_process_output and then
				{l_proc: like current_process} current_process and then l_out.process = l_proc
			process_launched: is_process_launched
		end

feature {NONE} -- Query

	echo_executable: STRING
			-- Path to `eiffel_echo' executable
			--
			-- Note: by default this is $ISE_EIFFEL/studio/tools/spec/$ISE_PLATFORM/bin/eiffel_echo, if
			--       environment variables are missing we check for a unix layout. Otherwise we assume
			--       `eiffel_echo' is reachable from $PATH.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_ise_eiffel, l_ise_platform: ?STRING
			l_filename: FILE_NAME
			l_cached: like echo_executable_cache
		do
			l_cached := echo_executable_cache
			if l_cached = Void then
				create l_env
				l_ise_eiffel := l_env.get (ise_eiffel_env)
				l_ise_platform := l_env.get (ise_platform_env)
				create l_filename.make
				if l_ise_eiffel = Void or l_ise_platform = Void then
					if {PLATFORM}.is_unix then
						l_filename.extend ("usr")
						l_filename.extend ("bin")
					end
				else
					l_filename.extend (l_ise_eiffel)
					l_filename.extend ("tools")
					l_filename.extend ("spec")
					l_filename.extend (l_ise_platform)
					l_filename.extend ("bin")
				end
				l_filename.extend (eiffel_echo_name)
				l_cached := l_filename
				echo_executable_cache := l_cached
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
			last_process_output_valid: {l_out: like last_process_output} last_process_output and then
				l_out.process.launched
		local
			l_output: like last_process_output
			l_received: READABLE_STRING_8
		do
			l_output := last_process_output
			check l_output /= Void end
			l_output.receive (a_expected.count, a_from_errors)
			l_received := l_output.last_received
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
		require
			current_process_attached: current_process /= Void
		local
			l_process: like current_process
		do
			l_process := current_process
			check l_process /= Void end
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
			not_running: {l_proc: like current_process} current_process and then not l_proc.is_running
		end

	check_successful_exit
			-- Check if `current_process' has exited successfully.
		require
			current_process_attached: current_process /= Void
			current_process_launched: is_process_launched
		local
			l_process: like current_process
		do
			l_process := current_process
			check l_process /= Void end
			wait_for_exit
			assert ("terminated_normally", not l_process.force_terminated)
			assert ("good_exit_code", l_process.exit_code = 0)
		end

feature {NONE} -- Events

	frozen on_prepare_frozen
			-- <Precursor>
		do
			assert ("multithreaded", {PLATFORM}.is_thread_capable)
			on_prepare
		end

	frozen on_clean_frozen
			-- <Precursor>
		local
			l_process: like current_process
		do
			on_clean
			if current_process /= Void then
				wait_for_exit
				current_process := Void
			end
		end

	on_prepare
			-- Called after `prepare' has performed all initialization.	
		require
			has_valid_name: has_valid_name
			has_valid_name: has_valid_name
		do
		ensure
			prepared: is_prepared
		end

	on_clean
			-- Called before clean performs any cleaning up.
		require
			prepared: is_prepared
		do
		ensure
			has_valid_name: has_valid_name
		end

feature {NONE} -- Constants

	ise_eiffel_env: STRING = "ISE_EIFFEL"
	ise_platform_env: STRING = "ISE_PLATFORM"
	eiffel_echo_name: STRING = "eiffel_echo"

	timeout: INTEGER = 2000
			-- Time in milliseconds we wait for process to send new output

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
