indexing
	description:
		"Mutex synchronization object, allows threads to access global %
		%data through critical sections."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MUTEX

inherit
	OBJECT_CONTROL

creation
	make

feature -- Initialization

	make is
			-- Create mutex.
		do
			freeze (Current)
			mutex_pointer := eif_thr_mutex_create
		end

feature -- Status setting

	has_locked: BOOLEAN is
			-- Has client been successful in locking mutex without waiting?
		do
			Result := eif_thr_mutex_trylock (mutex_pointer)
		end

	lock is
			-- Lock mutex, waiting if necessary until that becomes possible.
		do
			eif_thr_mutex_lock (mutex_pointer)
		end

	unlock is
			-- Unlock mutex.
		do
			eif_thr_mutex_unlock (mutex_pointer)
		end

feature {NONE} -- Implementation

	mutex_pointer: POINTER
			-- C reference to the mutex.

feature {NONE} -- Externals

	eif_thr_mutex_create: POINTER is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_mutex_lock (a_mutex_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_mutex_unlock (a_mutex_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_mutex_trylock (a_mutex_pointer: POINTER): BOOLEAN is
		external
			"C | %"eif_threads.h%""
		end

invariant

	valid_mutex: mutex_pointer /= default_pointer

end -- class MUTEX

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
