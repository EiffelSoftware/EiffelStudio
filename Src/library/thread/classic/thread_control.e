indexing
	description: "Control over thread execution."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_CONTROL

feature -- Basic operations

	yield is
			-- The calling thread yields its execution in favor of another
			-- thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_yield"
		end

	join_all is
			-- The calling thread waits for all other threads to terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join_all"
		end

	join is
			-- The calling thread waits for the current child thread to
			-- terminate.
		do
			thread_wait (Current)
		end

	native_join (term: POINTER) is
			-- Same as `join' except that the low-level architecture-dependant
			-- routine is used. The thread must not be created detached.
		do
			thread_join (term)
		end

feature -- Sleep

	sleep (nanoseconds: INTEGER_64) is
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
		require
			non_negative_nanoseconds: nanoseconds >= 0
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_sleep"
		end

feature {NONE} -- Implementation

	terminated: BOOLEAN
			-- True if the thread has terminated.

feature {NONE} -- Externals

	thread_wait (term: THREAD_CONTROL) is
			-- The calling C thread waits for the current Eiffel thread to
			-- terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_wait"
		end

	thread_join (term: POINTER) is
			-- The calling thread uses the low-level join routine to
			-- join the current Eiffel thread.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join"
		end

	get_current_id: POINTER is
			-- Returns a pointer to the thread-id of the thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_thread_id"
		end

	last_created_thread: POINTER is
			-- Returns a pointer to the thread-id of the last created thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_last_thread"
		end

	exit is
			-- Exit calling thread. Must be called from the thread itself.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_exit"
		end

end -- class THREAD_CONTROL

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

