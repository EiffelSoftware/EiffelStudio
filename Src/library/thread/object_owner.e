indexing
	description:
		"Class meant to record which thread has created a certain %
		%object so that another thread can't call its dispose routine."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_OWNER


feature {NONE}

	thread_owner: POINTER


feature -- Access

	record_owner is
			-- Record calling thread's id.
		require
			not_recorded_yet: not has_owner
		do
			thread_owner := get_current_id
			has_owner := True
		end

	thread_is_owner: BOOLEAN is
			-- Is calling thread creator of the object?
		do
			Result := (thread_owner = get_current_id)
		end

	has_owner: BOOLEAN
			-- Is object already associated with a thread?


feature {NONE} -- Externals

	get_current_id: POINTER is
			-- Returns a pointer to the thread-id of the thread.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_thread_id"
		end

end -- OBJECT_OWNER


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

