indexing
	description:
		"Class defining an Eiffel thread."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	THREAD

inherit
	THREAD_CONTROL

feature -- Access

	thread_id: POINTER
			-- Pointer to the thread-id of the current thread object.

feature -- Basic operations

	execute is
			-- Routine executed by new thread.
		deferred
		end

	launch is
			-- Initialize a new thread running `execute'.
		do
			create_thread (Current, $thr_main)
			thread_id := last_created_thread
		end

	launch_with_attributes (attr: THREAD_ATTRIBUTES) is
			-- Initialize a new thread running `execute', using attributes.
		do
			create_thread_with_args (Current, $thr_main,
						attr.priority, attr.scheduling_policy, attr.detached)
			thread_id := last_created_thread
		end

	exit is
			-- Exit calling thread. Must be called from the thread itself.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_exit"
		end

feature {NONE} -- Implementation

	frozen thr_main is
		do
			thread_id := get_current_id
			execute
		end

feature {NONE} -- Externals

	create_thread (current_obj: like Current; init_func: POINTER) is
			-- Initialize and start thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_create"
		end

	create_thread_with_args (current_obj: like Current; init_func: POINTER;
					priority, policy: INTEGER; detach: BOOLEAN) is
			-- Initialize and start thread, after setting its priority
			-- and scheduling policy.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_create_with_args"
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


end -- class THREAD

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

