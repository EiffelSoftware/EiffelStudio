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
	OBJECT_OWNER
	MEMORY
		redefine dispose end

creation
	make

feature -- Initialization

	make (count: INTEGER) is
			-- Create semaphore.
		require
			count_positive:	count >= 0
		do
			record_owner
			sem_pointer := eif_thr_sem_create (count)
		ensure
			valid_semaphore: sem_pointer /= default_pointer
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
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
			if thread_is_owner and is_set then
				eif_thr_sem_destroy (sem_pointer)
			end
		end


feature {NONE} -- Externals

	eif_thr_sem_create (count: INTEGER): POINTER is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_sem_wait (a_sem_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_sem_post (a_sem_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_sem_trywait (a_sem_pointer: POINTER): BOOLEAN is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_sem_destroy (a_sem_pointer: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

end -- class SEMAPHORE


--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

