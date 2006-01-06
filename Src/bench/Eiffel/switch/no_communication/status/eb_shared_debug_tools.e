indexing
	description: "Objects that are common to several debug facilities."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_DEBUG_TOOLS

feature -- Status report

	debugger_manager: DEBUGGER_MANAGER is
			-- Manager in charge of debugging operations.
		once
			create Result.make
		end

end
