note
	description: "Session manager access"
	date: "$Date: 2013-05-21 01:15:17 +0200 (Tue, 21 May 2013) $"
	revision: "$Revision: 92557 $"

class
	DATABASE_SESSION_MANAGER_ACCESS

feature -- Access

	manager: DATABASE_SESSION_MANAGER
			-- The session manager
		once
			create Result
		end

end
