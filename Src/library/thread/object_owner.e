indexing
	description:
		"Class meant to record which thread has created a certain %
		%object so that another thread can't call its dispose routine."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_OWNER

obsolete
	"Do not use it anymore, it will be removed"

feature {NONE}

	thread_owner: POINTER is
		obsolete
			"Do not use it anymore, it will be removed"
		require
			Do_not_use_obsolete: False
		do
		ensure
			Do_not_use_obsolete: False
		end

feature -- Access

	record_owner is
			-- Record calling thread's id.
		obsolete
			"Do not use it anymore, it will be removed"
		require
			Do_not_use_obsolete: False
		do
		ensure
			Do_not_use_obsolete: False
		end

	thread_is_owner: BOOLEAN is
			-- Is calling thread creator of the object?
		obsolete
			"Do not use it anymore, it will be removed"
		require
			Do_not_use_obsolete: False
		do
		ensure
			Do_not_use_obsolete: False
		end

	has_owner: BOOLEAN is
			-- Is object already associated with a thread?
		obsolete
			"Do not use it anymore, it will be removed"
		require
			Do_not_use_obsolete: False
		do
		ensure
			Do_not_use_obsolete: False
		end
		

end -- class OBJECT_OWNER

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

