note
	description:
		"Semaphore synchronization object, allows threads to access global %
		%data through critical sections."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SEMAPHORE

inherit
	DISPOSABLE

create
	make

feature -- Initialization

	make (count: INTEGER)
			-- Create semaphore.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			count_positive:	count >= 0
		do
			sem_pointer := eif_thr_sem_create (count)
		ensure
			is_set: is_set
		end

feature -- Access

	is_set: BOOLEAN
			-- Is semaphore initialized?
		do
			Result := (sem_pointer /= default_pointer)
		end

feature -- Status setting

	try_wait: BOOLEAN
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		require
			valid_semaphore: is_set
		do
			Result := eif_thr_sem_trywait (sem_pointer)
		end

	wait
			-- Decrement semaphore count, waiting if necessary until
			-- that becomes possible.
		require
			valid_semaphore: is_set
		do
			eif_thr_sem_wait (sem_pointer)
		end

	post
			-- Increment semaphore count.
		require
			valid_semaphore: is_set
		do
			eif_thr_sem_post (sem_pointer)
		end

	destroy
			-- Destroy semaphore.
		require
			valid_semaphore: is_set
		do
			eif_thr_sem_destroy (sem_pointer)
			sem_pointer := default_pointer
		end

feature -- Obsolete

	trywait: BOOLEAN
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		obsolete
			"Use try_wait instead"
		require
			valid_semaphore: is_set
		do
			Result := try_wait
		end

feature {NONE} -- Implementation

	sem_pointer: POINTER
			-- C reference to the semaphore.

feature {NONE} -- Removal

	dispose
			-- Called by the garbage collector when the semaphore
			-- is collected.
		do
			if is_set then
				destroy
			end
		end

feature {NONE} -- Externals

	eif_thr_sem_create (count: INTEGER): POINTER
		external
			"C use %"eif_threads.h%""
		end

	eif_thr_sem_wait (a_sem_pointer: POINTER)
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_sem_post (a_sem_pointer: POINTER)
		external
			"C use %"eif_threads.h%""
		end

	eif_thr_sem_trywait (a_sem_pointer: POINTER): BOOLEAN
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_sem_destroy (a_sem_pointer: POINTER)
		external
			"C | %"eif_threads.h%""
		end

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

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

