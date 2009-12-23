note
	description: "Class defining an Eiffel thread."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	THREAD

inherit
	THREAD_CONTROL

feature -- Access

    frozen thread_id: POINTER
            -- Thread-id of the current thread object.
			--| Updates have to be protected with `launch_mutex'.

	frozen terminated: BOOLEAN
			-- True if the thread has terminated.
			--| Updates have to be protected with `launch_mutex'.

feature -- Basic operations

	execute
			-- Routine executed by new thread.
		deferred
		end

	frozen launch
			-- Initialize a new thread running `execute'.
			-- Set `is_last_launch_successful' to True if successful, False otherwise.			
		require
			thread_capable: {PLATFORM}.is_thread_capable
			is_launchable: is_launchable
		local
			l_attr: THREAD_ATTRIBUTES
		do
			create l_attr.make
			launch_with_attributes (l_attr)
		end

	frozen launch_with_attributes (attr: THREAD_ATTRIBUTES)
			-- Initialize a new thread running `execute', using attributes.
			-- Set `is_last_launch_successful' to True if successful, False otherwise.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			is_launchable: is_launchable
		do
				-- Safe creation of `launch_mutex'.
			global_launch_mutex.lock
			create launch_mutex.make
			global_launch_mutex.unlock

			launch_mutex.lock
			if terminated then
					-- This happens if multiple threads call `launch' or `launch_with_attributes'
					-- on the same THREAD object.
				is_last_launch_successful_cell.put (False)
			else
				create_thread_with_attr (Current, $thr_main, attr.item)
				thread_id := last_created_thread
				is_last_launch_successful_cell.put (True)
			end
			launch_mutex.unlock
		rescue
			is_last_launch_successful_cell.put (False)
			if launch_mutex /= Void then
				launch_mutex.unlock
			end
		end

	exit
			-- Exit calling thread. Must be called from the thread itself.
		require
			is_exit_supported: is_exit_supported
			self: current_thread_id = thread_id
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_exit"
		end

	sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		obsolete
			"Use `{EXECUTION_ENVIRONMENT}.sleep' instead."
		require
			self: current_thread_id = thread_id
			non_negative_nanoseconds: nanoseconds >= 0
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (nanoseconds)
		end

feature -- Status report

	is_exit_supported: BOOLEAN
			-- Can `exit' be called?
		do
				-- True for classic Eiffel, False in .NET
			Result := True
		end

	is_launchable: BOOLEAN
			-- Can we launch a new thread?
		do
			Result := thread_id = default_pointer and not terminated
		end

	is_last_launch_successful: BOOLEAN
			-- Was the last call to `launch' or `launch_with_attributes' in current thread
			-- of execution successful?
		do
			Result := is_last_launch_successful_cell.item
		end

feature -- Synchronization

	join
			-- The calling thread waits for the current child thread to terminate.
		do
				-- Optimization
			if not terminated then
				thread_wait (Current)
			end
		end

	join_with_timeout (a_timeout_ms: NATURAL_64): BOOLEAN
			-- The calling thread waits for the current child thread to
			-- terminate for at most `a_timeout_ms' milliseconds.
			-- True if wait terminate within `a_timeout_ms'.
		do
			if terminated then
				Result := True
			else
				Result := thread_wait_with_timeout (Current, a_timeout_ms)
			end
		end

feature {NONE} -- Implementation

	frozen thr_main
			-- Call thread routine.
		require
			launch_mutex_attached: launch_mutex /= Void
		do
				-- This ensures that `thread_id' has been properly initialized.
			launch_mutex.lock
			launch_mutex.unlock

				-- Execute the thread
			execute

				-- To enable us to restart a new thread using the same object
			launch_mutex.lock
			terminated := True
			thread_id := default_pointer
			launch_mutex.unlock
		rescue
			launch_mutex.lock
			terminated := True
			thread_id := default_pointer
			launch_mutex.unlock
		end

	launch_mutex: detachable MUTEX  note option: stable attribute end
			-- Mutex used to ensure that no two threads call `launch' or `launch_with_attributes'
			-- on the same object. This ensures the validity of querying `thread_id' from
			-- the launch routines.

	global_launch_mutex: MUTEX
			-- Global mutex to lazily initialize `launch_mutex' before a launch.
		note
			once_status: global
		once
			create Result.make
		end

	is_last_launch_successful_cell: CELL [BOOLEAN]
			-- Internal storage for `is_last_launch_successful'.
			-- It is a once per object and not an attribute because if you have multiple threads
			-- calling `launch' on the same object, one will set it to True, and the other will
			-- override the value with False.
		once
			create Result.put (False)
		end

feature {NONE} -- Externals

	create_thread_with_attr (current_obj: THREAD; init_func, attr: POINTER)
			-- Initialize and start thread, after setting its priority
			-- and stack size.
		external
			"C signature (EIF_OBJECT, EIF_PROCEDURE, EIF_POINTER) use %"eif_threads.h%""
		alias
			"eif_thr_create_with_attr"
		end

	thread_wait (term: THREAD)
			-- The calling C thread waits for the current Eiffel thread to
			-- terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_wait"
		end

	thread_wait_with_timeout (term: THREAD; a_timeout_ms: NATURAL_64): BOOLEAN
			-- The calling C thread waits for the current Eiffel thread to
			-- terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_wait_with_timeout"
		end

	last_created_thread: POINTER
			-- Returns a pointer to the thread-id of the last created thread.
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_last_thread"
		end

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

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

