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
	DISPOSABLE
		redefine
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create is
			-- Create mutex.
		do
			mutex_pointer := eif_thr_mutex_create
		ensure then
			valid_mutex: mutex_pointer /= default_pointer
		end

	make is
			-- Create mutex
		obsolete
			"Use `default_create'"
		do
			default_create
		ensure
			valid_mutex: mutex_pointer /= default_pointer
		end
		
feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := (mutex_pointer /= default_pointer)
		end

feature -- Status setting

	trylock, has_locked: BOOLEAN is
			-- Has client been successful in locking mutex without waiting?
		require
			valid_mutex: is_set
		do
			Result := eif_thr_mutex_trylock (mutex_pointer)
		end

	lock is
			-- Lock mutex, waiting if necessary until that becomes possible.
		require
			valid_mutex: is_set
		do
			eif_thr_mutex_lock (mutex_pointer)
		end

	unlock is
			-- Unlock mutex.
		require
			valid_mutex: is_set
		do
			eif_thr_mutex_unlock (mutex_pointer)
		end

	destroy is
			-- Destroy mutex.
		require
			valid_mutex: is_set
		do
			eif_thr_mutex_destroy (mutex_pointer)
			mutex_pointer := default_pointer
		end


feature {CONDITION_VARIABLE} -- Implementation

	mutex_pointer: POINTER
			-- C reference to the mutex.

feature {NONE} -- Removal

	dispose is
			-- Called by the garbage collector when the mutex is
			-- collected.
		do
			if is_set then
				destroy
			end
		end

feature {NONE} -- Externals

	eif_thr_mutex_create: POINTER is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_mutex_lock (a_mutex_pointer: POINTER) is
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_mutex_unlock (a_mutex_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_mutex_trylock (a_mutex_pointer: POINTER): BOOLEAN is
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_mutex_destroy (a_mutex_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

end -- class MUTEX

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

