indexing
	description: "Shared window manager"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_WINDOW_MANAGER

feature -- Access

	window_manager: EB_WINDOW_MANAGER is
			-- Window manager for ebench windows
		once
			create Result.make
		end

end -- class EB_SHARED_WINDOW_MANAGER
