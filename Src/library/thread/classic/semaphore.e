indexing
	description:
		"Semaphore synchronization object, allows threads to access global %
		%data through critical sections."
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

	make (count: INTEGER) is
			-- Create semaphore.
		require
			count_positive:	count >= 0
		do
			sem_pointer := eif_thr_sem_create (count)
		ensure
			valid_semaphore: sem_pointer /= default_pointer
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is semaphore initialized?
		do
			Result := (sem_pointer /= default_pointer)
		end

feature -- Status setting

	try_wait, trywait: BOOLEAN is
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		require
			valid_semaphore: is_set
		do
			Result := eif_thr_sem_trywait (sem_pointer)
		end

	wait is
			-- Decrement semaphore count, waiting if necessary until 
			-- that becomes possible.
		require
			valid_semaphore: is_set
		do
			eif_thr_sem_wait (sem_pointer)
		end

	post is
			-- Increment semaphore count.
		require
			valid_semaphore: is_set
		do
			eif_thr_sem_post (sem_pointer)
		end

	destroy is
			-- Destroy semaphore.
		require
			valid_semaphore: is_set
		do
			eif_thr_sem_destroy (sem_pointer)
			sem_pointer := default_pointer
		end

feature {NONE} -- Implementation

	sem_pointer: POINTER
			-- C reference to the semaphore.

feature {NONE} -- Removal

	dispose is
			-- Called by the garbage collector when the semaphore
			-- is collected.
		do
			if is_set then
				destroy
			end
		end

feature {NONE} -- Externals

	eif_thr_sem_create (count: INTEGER): POINTER is
		external
			"C use %"eif_threads.h%""
		end

	eif_thr_sem_wait (a_sem_pointer: POINTER) is
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_sem_post (a_sem_pointer: POINTER) is
		external
			"C use %"eif_threads.h%""
		end

	eif_thr_sem_trywait (a_sem_pointer: POINTER): BOOLEAN is
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_sem_destroy (a_sem_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

end -- class SEMAPHORE

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

