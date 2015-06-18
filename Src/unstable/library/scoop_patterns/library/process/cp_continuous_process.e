note
	description: "Active objects which never allow other processor to access their data."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_CONTINUOUS_PROCESS

inherit
	CP_PROCESS

feature -- Basic operations

	start
			-- Start the current process.
		do
			from
				setup
			until
				is_stopped
			loop
				step
			end
			cleanup
		end

end
