indexing
	description:
		"Class describing a condition variable."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_VARIABLE

inherit
	OBJECT_OWNER
	MEMORY
		redefine dispose end

creation
	make

feature -- Initialization

	make is
			-- Create and initialize condition variable.
		do
			record_owner
			cond_pointer := eif_thr_cond_create
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is cond_pointer initialized?
		do
			Result := (cond_pointer /= default_pointer)
		end

feature -- Status setting

	signal is
			-- Unblock one thread blocked on the current condition variable.
		require
			valid_pointer: is_set
		do
			eif_thr_cond_signal (cond_pointer)
		end

	broadcast is
			-- Unblock all threads blocked on the current condition variable.
		require
			valid_pointer: is_set
		do
			eif_thr_cond_broadcast (cond_pointer)
		end

	wait (a_mutex: MUTEX) is
			-- Block calling thread on current condition variable.
		require
			valid_pointer: is_set
		do
			eif_thr_cond_wait (cond_pointer, a_mutex.mutex_pointer)
		end

	destroy is
			-- Destroy condition variable.
		require
			valid_pointer: is_set
		do
			eif_thr_cond_destroy (cond_pointer)
			cond_pointer := default_pointer
		end


feature {NONE} -- Implementation

	cond_pointer: POINTER
			-- C reference to the condition variable.

feature {NONE} -- Removal

	dispose is
			-- Called by the garbage collector when the condition
			-- variable is collected.
		do
			if thread_is_owner and is_set then
				eif_thr_cond_destroy (cond_pointer)
			end
		end


feature {NONE} -- Externals

	eif_thr_cond_create: POINTER is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_cond_broadcast (a_cond_ptr: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_cond_signal (a_cond_ptr: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_cond_wait (a_cond_ptr: POINTER; a_mutex_ptr: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_cond_destroy (a_mutex_ptr: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

end -- class MUTEX


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

