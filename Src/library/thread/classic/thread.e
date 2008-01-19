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

    frozen thread_id: POINTER
            -- Thread-id of the current thread object.

feature -- Basic operations

	execute is
			-- Routine executed by new thread.
		deferred
		end

	launch is
			-- Initialize a new thread running `execute'.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		local
			l_attr: THREAD_ATTRIBUTES
		do
			create l_attr.make
			launch_with_attributes (l_attr)
		end

	launch_with_attributes (attr: THREAD_ATTRIBUTES) is
			-- Initialize a new thread running `execute', using attributes.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			terminated := False
			create_thread_with_args (Current, $thr_main,
						attr.priority, attr.scheduling_policy, attr.detached)
			thread_id := last_created_thread
		end

feature {NONE} -- Implementation

	frozen thr_main is
			-- Call thread routine.
		do
			thread_id := get_current_id
			execute
		end

feature {NONE} -- Externals

	create_thread_with_args (current_obj: THREAD; init_func: POINTER;
					priority, policy: INTEGER; detach: BOOLEAN) is
			-- Initialize and start thread, after setting its priority
			-- and scheduling policy.
		external
			"C signature (EIF_OBJECT, EIF_PROCEDURE, EIF_INTEGER, EIF_INTEGER, EIF_BOOLEAN) use %"eif_threads.h%""
		alias
			"eif_thr_create_with_args"
		end

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

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

