indexing
	description: "Objects that ..."
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

	try_lock: BOOLEAN is
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

end -- class MUTEX
