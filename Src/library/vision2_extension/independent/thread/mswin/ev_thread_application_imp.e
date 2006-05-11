indexing
	description: "Allows non GUI threads to add idle actions to GUI thread%
					%Protect all access to idle actions list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_APPLICATION_IMP

inherit
	EV_APPLICATION_IMP
		redefine
			make,
			lock,
			try_lock,
			unlock
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create mutex and call precursor.
		do
			create idle_action_mutex
			Precursor {EV_APPLICATION_IMP} (an_interface)
		end

feature -- Thread Handling.

	lock is
			-- Lock the Mutex.
		do
			idle_action_mutex.lock
		end

	try_lock: BOOLEAN is
			-- Try to see if we can lock, False means no lock could be attained
		do
			Result := idle_action_mutex.trylock
		end

	unlock is
			-- Unlock the Mutex.
		do
			idle_action_mutex.unlock
		end

feature {NONE} -- Implementation

	idle_action_mutex: MUTEX;
			-- Mutex used to access `idle_actions'

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

end -- class EV_THREAD_APPLICATION_IMP
