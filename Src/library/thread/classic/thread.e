indexing
	description:
		"Class defining an Eiffel thread."
	legal: "See notice at end of class."
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

feature {NONE} -- Implementation

	frozen thr_main is
		do
			thread_id := get_current_id
			execute
		end

feature {NONE} -- Externals

	create_thread (current_obj: THREAD; init_func: POINTER) is
			-- Initialize and start thread.
		external
			"C signature (EIF_OBJECT, EIF_POINTER) use %"eif_threads.h%""
		alias
			"eif_thr_create"
		end

	create_thread_with_args (current_obj: THREAD; init_func: POINTER;
					priority, policy: INTEGER; detach: BOOLEAN) is
			-- Initialize and start thread, after setting its priority
			-- and scheduling policy.
		external
			"C signature (EIF_OBJECT, EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_BOOLEAN) use %"eif_threads.h%""
		alias
			"eif_thr_create_with_args"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class THREAD

