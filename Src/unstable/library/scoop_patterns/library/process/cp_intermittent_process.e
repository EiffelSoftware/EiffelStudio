note
	description: "Active objects that allow other processors to access its data after each loop iteration."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_INTERMITTENT_PROCESS

inherit
	CP_PROCESS

	CP_STARTABLE_UTILS

feature -- Basic operations

	start
			-- Start the process.
		do
			setup
			async_start (pacemaker)
		end

	iteration
			-- Do a single iteration of the loop body.
		 do
		 	step
		 	if is_stopped then
		 		cleanup
		 	else
		 		async_start (pacemaker)
		 	end
		 end

feature {NONE} -- Implementation

	pacemaker: separate CP_PACEMAKER
			-- The pacemaker of `Current'.
		attribute
			create Result.make (Current)
		end

end
