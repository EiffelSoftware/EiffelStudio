indexing
	description: "Class describing a condition variable."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_VARIABLE

inherit
	DISPOSABLE

create
	make

feature -- Initialization

	make is
			-- Create and initialize condition variable.
		do
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
			a_mutex_not_void: a_mutex /= Void
		do
			eif_thr_cond_wait (cond_pointer, a_mutex.mutex_pointer)
		end

	wait_with_timeout (a_mutex: MUTEX; a_timeout: INTEGER): BOOLEAN is
			-- Block calling thread on current condition variable.
			--| Return `True' is we got the condition variable on time
			--| Otherwise return `False'
		require
			valid_pointer: is_set
			a_mutex_not_void: a_mutex /= Void
			timeout_positive: a_timeout >= 0
		do
			Result := (eif_thr_cond_wait_with_timeout (cond_pointer, a_mutex.mutex_pointer, a_timeout) = 1)
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
			if is_set then
				destroy
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
			"C blocking  use %"eif_threads.h%""
		end

	eif_thr_cond_wait_with_timeout (a_cond_ptr: POINTER; a_mutex_ptr: POINTER; a_timeout: INTEGER): INTEGER is
		external
			"[
				C blocking
				signature (EIF_POINTER, EIF_POINTER, EIF_INTEGER): EIF_INTEGER
				use %"eif_threads.h%"				
			]"
		end

	eif_thr_cond_destroy (a_mutex_ptr: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

end -- class CONDITION_VARIABLE

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

