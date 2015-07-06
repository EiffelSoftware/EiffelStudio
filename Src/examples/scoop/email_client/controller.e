note
	description: "Third-party controller used to signal a stop message."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

feature -- Status report

	is_over: BOOLEAN
			-- Should the email client stop its execution?

feature -- Basic operations

	stop
			-- Record request to stop execution.
		do
			is_over := True
		end

end
