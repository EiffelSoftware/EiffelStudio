indexing
	description:
		"Mutex synchronization object, allows threads to access global %
		%data through critical sections."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MUTEX

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	default_create is
			-- Create mutex.
		obsolete
			"Use make instead"
		require else
			thread_capable: {PLATFORM}.is_thread_capable
		do
			make
		ensure then
			is_set: is_set
		end

	make is
			-- Create mutex.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			create mutex_imp.make
		ensure
			is_set: is_set
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := (mutex_imp /= Void)
		end

feature -- Status setting

	lock is
			-- Lock mutex, waiting if necessary until that becomes possible.
		require
			is_set: is_set
		local
			l_lock_succeed: BOOLEAN
		do
			l_lock_succeed := mutex_imp.wait_one
		end

	try_lock: BOOLEAN is
			-- Has client been successful in locking mutex without waiting?
		require
			is_set: is_set
		do
			Result := mutex_imp.wait_one (0, True)
		end

	unlock is
			-- Unlock mutex.
		require
			is_set: is_set
		do
			mutex_imp.release_mutex
		end

	destroy is
			-- Destroy mutex.
		require
			is_set: is_set
		do
			mutex_imp.close
			mutex_imp := Void
		end

feature -- Obsolete

	trylock, has_locked: BOOLEAN is
			-- Has client been successful in locking mutex without waiting?
		obsolete
			"Use try_lock instead"
		require
			is_set: is_set
		do
			Result := try_lock
		end

feature {NONE} -- Implementation

	mutex_imp: SYSTEM_MUTEX
			-- .NET reference to the mutex.

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


end -- class MUTEX

