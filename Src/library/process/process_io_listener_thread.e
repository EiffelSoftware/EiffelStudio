indexing
	description:
		"[
			Thread which is served as a listener to output and error data
			from another launched process.

			It is used when you redirect output or error of a process
			to agent. It listens to process's output/error pipe, if data
			arrives, it will call the agent specified in output_handler or
			error_handler in PROCESS.
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_IO_LISTENER_THREAD

inherit
	THREAD
		export
			{ANY}terminated
		end

feature -- Status setting

	set_exit_signal is
			-- Notify this thread that it should exit.
			-- This feature is called when the launched process has exit.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			mutex.lock
			should_exit_signal := True
			mutex.unlock
		end

	set_sleep_time (interval: INTEGER) is
			-- Set `sleep_time' with `interval' in milliseconds.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			interval_positive: interval > 0
		do
			mutex.lock
			sleep_time := interval
			mutex.unlock
		ensure
			sleep_time = interval
		end

feature -- Status reporting

	should_thread_exit: BOOLEAN is
			-- Should this thread exit?
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			mutex.lock
			Result := should_exit_signal
			mutex.unlock
		end

feature {NONE} -- Implementation

	process_launcher: PROCESS_IMP
			-- process launcher to which this thread is attached.

	should_exit_signal: BOOLEAN
			-- Should this thread exit?

	mutex: MUTEX
			-- `mutex' used to keep critical section safe.

	sleep_time: INTEGER
			-- Time in milliseconds for this thread to sleep when waiting for data

	initial_sleep_time: INTEGER is 10
			-- Initial time in nanosecond for this thread to sleep when waiting for data

invariant
	mutex_not_null: mutex /= Void

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
