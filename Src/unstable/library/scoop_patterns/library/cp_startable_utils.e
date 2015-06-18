note
	description: "Helper class to start a separate CP_STARTABLE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_STARTABLE_UTILS

feature -- Basic operations

	async_start (a_startable: separate CP_STARTABLE)
			-- Start the separate `a_startable' object.
		do
			a_startable.start
		end

end
