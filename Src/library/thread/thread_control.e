indexing
	description:
		"Control over thread execution."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_CONTROL

feature -- Basic operations

	yield is
			-- The calling thread yields its execution in favor
			-- of another thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_yield"
		end

	join_all is
			-- The calling thread waits for all other threads to
			-- terminate.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_join_all"
		end

end -- class THREAD_CONTROL

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
