note
	description: "[
		Provides shared access to a session_manager.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SHARED_SESSION_MANAGER

feature -- Access

	session_manager: XWA_SESSION_MANAGER
			-- Shared access to a session_manager.
		once
			create Result.make
		ensure
			result_attached: attached Result
		end

end
