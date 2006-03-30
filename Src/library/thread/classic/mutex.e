indexing
	description:
		"Mutex synchronization object, allows threads to access global %
		%data through critical sections."
	legal: "See notice at end of class."
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

feature {NONE} -- Initialization

	default_create is
			-- Create mutex.
		obsolete
			"Use make instead"
		require else
			thread_capable: {PLATFORM}.is_thread_capable
		do
			make
		ensure then
			is_set: is_set
		end

	make is
			-- Create mutex.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			mutex_pointer := eif_thr_mutex_create
		ensure
			is_set: is_set
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := (mutex_pointer /= default_pointer)
		end

feature -- Status setting

	lock is
			-- Lock mutex, waiting if necessary until that becomes possible.
		require
			is_set: is_set
		do
			eif_thr_mutex_lock (mutex_pointer)
		end

	try_lock: BOOLEAN is
			-- Has client been successful in locking mutex without waiting?
		require
			is_set: is_set
		do
			Result := eif_thr_mutex_trylock (mutex_pointer)
		end

	unlock is
			-- Unlock mutex.
		require
			is_set: is_set
		do
			eif_thr_mutex_unlock (mutex_pointer)
		end

	destroy is
			-- Destroy mutex.
		require
			is_set: is_set
		do
			eif_thr_mutex_destroy (mutex_pointer)
			mutex_pointer := default_pointer
		end

feature -- Obsolete

	trylock, has_locked: BOOLEAN is
			-- Has client been successful in locking mutex without waiting?
		obsolete
			"Use try_lock instead"
		require
			is_set: is_set
		do
			Result := try_lock
		end

feature {NONE} -- Removal

	dispose is
			-- Called by the garbage collector when the mutex is
			-- collected.
		do
			if is_set then
				destroy
			end
		end

feature {CONDITION_VARIABLE} -- Implementation

	mutex_pointer: POINTER
			-- C reference to the mutex.

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




end -- class MUTEX

