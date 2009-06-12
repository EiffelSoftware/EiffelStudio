note
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

	frozen thread_id: POINTER
            	-- Thread-id of the current thread object.
		do
				-- There are no explicit routines for changing an INTEGER to a POINTER
			Result := Result + internal_thread_id
		end

feature -- Initialization

	execute
			-- Routine executed by new thread.
		deferred
		end

	launch
			-- Initialize a new thread running `execute'.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			create internal_thread_imp.make (create {THREAD_START}.make (Current, $call_execute))
			internal_thread_imp.start
			add_children (Current)
		end

	launch_with_attributes (attr: THREAD_ATTRIBUTES)
			-- Initialize a new thread running `execute', using attributes.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		local
			l_priority: THREAD_PRIORITY
		do
			create internal_thread_imp.make (create {THREAD_START}.make (Current, $call_execute))
				-- Set attributes
			internal_thread_imp.set_priority (l_priority.from_integer (attr.priority))
			internal_thread_imp.set_is_background (attr.detached)
			internal_thread_imp.start
			add_children (Current)
		end

feature {NONE} -- Implementation

	frozen call_execute
			-- Call thread routine.
		do
			internal_thread_id := current_thread_id
			execute
		end

	thread_imp: SYSTEM_THREAD
			-- .NET thread object.
		do
			if attached internal_thread_imp as l_thread_imp then
				Result := l_thread_imp
			else
				Result := Precursor
			end
		end

	internal_thread_imp: detachable SYSTEM_THREAD note option: stable attribute end
			-- Actual storage for current thread.

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class THREAD

