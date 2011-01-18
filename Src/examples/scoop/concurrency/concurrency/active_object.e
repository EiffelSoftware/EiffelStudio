note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_OBJECT

inherit
	CONCURRENCY

feature -- Command

	live
			-- Body of active object
		do
			do_work
			asynch (agent live)
		end

feature {NONE} -- Implementation

	do_work
			-- Active object's own work
			-- Such as calling servers, doing local work, etc
		deferred
		end

end
