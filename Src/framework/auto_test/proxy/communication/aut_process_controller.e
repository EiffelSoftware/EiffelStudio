indexing
	description: "[
		Objects providing interface to launch and communicate with process. Separate threads are used
		to terminate process after a given timeout.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	AUT_PROCESS_CONTROLLER

inherit
	THREAD
		rename
			sleep as thread_sleep,
			launch as launch_thread
		export
			{NONE} all
		end

	DT_SHARED_SYSTEM_CLOCK
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		rename
			launch as launch_process
		export
			{NONE} all
		end

	KL_SHARED_OPERATING_SYSTEM
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_executable: STRING; a_args: LIST [STRING]; a_directory: STRING)
			-- Prepare process object
			--
			-- `a_executable': Filename of executable to be launched
			-- `a_args': List of arguments to be passed to process.
			-- `a_directory': Working directory for process
		local
			l_factory: PROCESS_FACTORY
		do
			create mutex.make
			create condition_variable.make
			create l_factory
			process := l_factory.process_launcher (a_executable, a_args, a_directory)
		end

feature {NONE} -- Access

	mutex: MUTEX
			-- Mutex for controlling access to `process', `timeout' and `condition_variable'.

	condition_variable: CONDITION_VARIABLE
			-- Condition variable for timout thread

	process: PROCESS
			-- Actual process object

	timeout: INTEGER
			-- Number of seconds being spent until process is terminated

feature -- Status report

	is_launched: BOOLEAN
			-- Has `process' been launched?

	is_running: BOOLEAN
			-- Is `process' running?
		do
			mutex.lock
			Result := process.is_running
			mutex.unlock
		end

	has_exited: BOOLEAN
			-- Has `process' exited?
		do
			mutex.lock
			Result := process.has_exited
			mutex.unlock
		end

	input_direction: INTEGER_32
			-- Input direction of process
		do
			mutex.lock
			Result := process.input_direction
			mutex.unlock
		end

	force_terminated: BOOLEAN
			-- Has process been terminated by user?
		do
			mutex.lock
			Result := process.force_terminated
			mutex.unlock
		end

feature -- Status setting

	set_timeout (a_timeout: like timeout)
			-- Set `timeout' to `a_timeout'.
		require
			not_a_timeout_negative: a_timeout >= 0
		do
			mutex.lock
			timeout := a_timeout
			if is_launched then
				condition_variable.signal
			end
			mutex.unlock
		end

	reset_timer
			-- Reset any timer currently running to `a_timeout'
		require
			launched: is_launched
		do
			mutex.lock
			condition_variable.signal
			mutex.unlock
		end

	wait_for_exit_with_timeout (a_timeout: INTEGER)
			-- Wait at most `a_timeout' milliseconds for process to exit.
		do
			mutex.lock
			process.wait_for_exit_with_timeout (a_timeout)
			condition_variable.signal
			mutex.unlock
		end

	terminate
			-- Terminate process and wait for it to exit.
		do
			mutex.lock
			terminate_directly
			condition_variable.signal
			mutex.unlock
		end

feature -- Basic operations

	launch (a_output_handler: PROCEDURE [ANY, TUPLE [STRING]])
		require
			not_launched: not is_launched
		do
			is_launched := True
			process.enable_launch_in_new_process_group

				-- Fixme: We should only redirect input and left output and error not redirected.
				-- But maybe due to a bug in process library, if we do this, the launched process
				-- will crash when it tries to use its standard output or error. Jason 2008.10.21
			fixme ("Should only redirect input.")

			process.redirect_input_to_stream
			process.redirect_error_to_same_as_output
			process.redirect_output_to_agent (a_output_handler)

			if operating_system.is_windows then
				process.set_hidden (True)
				process.set_separate_console (False)
			end

			process.launch
			launch_thread
		ensure
			launched: is_launched
		end

feature {NONE} -- Basic operations

	execute
			-- <Precursor>
		local
			l_done, l_exp: BOOLEAN
		do
			from
				mutex.lock
			until
				l_done
			loop
				if timeout > 0 then
					l_exp := condition_variable.wait_with_timeout (mutex, timeout * 1000)
					if not l_exp then
						terminate_directly
					end
				end
				if process.has_exited then
					l_done := True
				else
					if timeout = 0 then
						condition_variable.wait (mutex)
					end
				end
			end
			mutex.unlock
		end

feature {NONE} -- Implementation

	terminate_directly
			-- Terminate process without using mutex
			--
			-- Note: not thread safe
		do
			if process.is_running then
				if not process.force_terminated then
					process.terminate_tree
				end
				process.wait_for_exit
			else
				if process.launched and then not process.has_exited then
					process.wait_for_exit
				end
			end
		end

invariant
	timeout_not_negative: timeout >= 0

end
