indexing
	description: "Objects that ..."
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

feature 

	trylock: BOOLEAN is
		do
			Result := mutex_imp.wait_one (0, True)
		end

	lock is
		local
			l_lock_succeed: BOOLEAN
		do
			l_lock_succeed := mutex_imp.wait_one
		end

	unlock is
		do
			mutex_imp.release_mutex
		end

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := (mutex_imp /= Void)
		end

	destroy is
			-- Destroy mutex.
		require
			valid_mutex: is_set
		do
			mutex_imp.close
			mutex_imp := Void
		end

feature {NONE} -- Initialization

	mutex_imp: SYSTEM_MUTEX

	default_create is
			-- Initialize `Current'.
		do
			create mutex_imp.make
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


end -- class MUTEX

