note
	description:
		"Mutex synchronization object, allows threads to access global %
		%data through critical sections."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MUTEX

inherit {NONE}

	THREAD_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create mutex.
		do
			create mutex_imp.make
			is_set := True
		ensure
			is_set: is_set
		end

feature -- Access

	owner: like current_thread_id
			-- Debugging facility to know the THREAD owning Current. The `owner' field might be invalid
			-- when Current is used with a condition variable.

feature -- Status report

	is_set: BOOLEAN
			-- Is mutex initialized?

feature -- Status setting

	lock
			-- Lock mutex, waiting if necessary until that becomes possible.
		require
			is_set: is_set
		do
			mutex_imp.wait_one.do_nothing
			owner := current_thread_id
		end

	try_lock: BOOLEAN
			-- Has client been successful in locking mutex without waiting?
		require
			is_set: is_set
		do
			Result := mutex_imp.wait_one (0, True)
			if Result then
				owner := current_thread_id
			end
		end

	unlock
			-- Unlock mutex.
		require
			is_set: is_set
		do
			owner := default_pointer
			mutex_imp.release_mutex
		end

	destroy
			-- Destroy mutex.
		require
			is_set: is_set
		do
			mutex_imp.close
			is_set := False
		ensure
			not_set: not is_set
		end

feature -- Obsolete

	trylock, has_locked: BOOLEAN
			-- Has client been successful in locking mutex without waiting?
		obsolete
			"Use try_lock instead. [2017-05-31]"
		require
			is_set: is_set
		do
			Result := try_lock
		end

feature {NONE} -- Implementation

	mutex_imp: SYSTEM_MUTEX;
			-- .NET reference to the mutex.

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
