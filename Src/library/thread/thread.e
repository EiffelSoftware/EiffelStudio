indexing
	description:
		"Class defining an eiffel thread."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	THREAD

inherit
	OBJECT_CONTROL

	THREAD_CONTROL

feature -- Basic operations

	execute is
			-- Routine executed by new thread.
		deferred
		end

	launch is
			-- Initialize a new thread running `execute'.
		do
			freeze (Current)
			create_thread (Current, $thr_main)
		end

	exit is
			-- Exit calling thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_exit"
		end

feature {NONE} -- Implementation

	frozen thr_main is
		do
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

end -- class THREAD

--|--------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|--------------------------------------------------------------
