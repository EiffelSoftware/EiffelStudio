indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	THREAD

inherit
	THREAD_CONTROL
		redefine
			thread_imp
		end

feature -- Access

	frozen thread_id: POINTER is
            	-- Thread-id of the current thread object.
		do
				-- There are no explicit routines for changing an INTEGER to a POINTER
			Result := Result + internal_thread_id
		end

feature -- Initialization

	execute is
			-- Routine executed by new thread.
		deferred
		end

	launch is
			-- Initialize a new thread running `execute'.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			create thread_imp.make (create {THREAD_START}.make (Current, $call_execute))
			thread_imp.start
			add_children (Current)
		end

	launch_with_attributes (attr: THREAD_ATTRIBUTES) is
			-- Initialize a new thread running `execute', using attributes.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		local
			l_priority: THREAD_PRIORITY
		do
			create thread_imp.make (create {THREAD_START}.make (Current, $call_execute))
				-- Set attributes
			thread_imp.set_priority (l_priority.from_integer (attr.priority))
			thread_imp.set_is_background (attr.detached)
			thread_imp.start
			add_children (Current)
		end

feature {NONE} -- Implementation

	frozen call_execute is
			-- Call thread routine.
		do
			internal_thread_id := current_thread_id
			execute
		end

	thread_imp: SYSTEM_THREAD;
		-- .NET thread object.

	internal_thread_id: INTEGER
		-- Thread id of `Current'.

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


end -- class THREAD

