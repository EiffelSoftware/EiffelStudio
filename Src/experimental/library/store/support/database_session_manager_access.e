note
	description: "Session manager access"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_SESSION_MANAGER_ACCESS

feature -- Access

	manager: DATABASE_SESSION_MANAGER
			-- The session manager
		once
			create Result
		end

end
