note
	description: "Control over thread execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_CONTROL

feature -- Basic operations

	yield
			-- The calling thread yields its execution in favor of another
			-- thread for an OS specific amount of time.
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_yield"
		end

	join_all
			-- The calling thread waits for all other threads to terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join_all"
		end

	join
			-- The calling thread waits for the current child thread to
			-- terminate.
		do
			thread_wait (Current)
		end

	native_join (term: POINTER)
			-- Same as `join' except that the low-level architecture-dependant
			-- routine is used. The thread must not be created detached.
		do
			thread_join (term)
		end

feature -- Sleep

	sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		obsolete
			"Use {EXECUTION_ENVIRONMENT}.sleep instead."
		require
			non_negative_nanoseconds: nanoseconds >= 0
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (nanoseconds)
		end

feature {NONE} -- Implementation

	terminated: BOOLEAN
			-- True if the thread has terminated.

	exit
			-- Exit calling thread. Must be called from the thread itself.
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_exit"
		end

feature {NONE} -- Externals

	thread_wait (term: THREAD_CONTROL)
			-- The calling C thread waits for the current Eiffel thread to
			-- terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_wait"
		end

	thread_join (term: POINTER)
			-- The calling thread uses the low-level join routine to
			-- join the current Eiffel thread.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join"
		end

	get_current_id: POINTER
			-- Returns a pointer to the thread-id of the thread.
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_thread_id"
		end

	last_created_thread: POINTER
			-- Returns a pointer to the thread-id of the last created thread.
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_last_thread"
		end

invariant
	thread_capable: {PLATFORM}.is_thread_capable

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

