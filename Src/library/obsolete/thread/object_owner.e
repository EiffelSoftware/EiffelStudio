indexing
	description:
		"Class meant to record which thread has created a certain %
		%object so that another thread can't call its dispose routine."
	legal: "See notice at end of class."
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




end -- class OBJECT_OWNER

