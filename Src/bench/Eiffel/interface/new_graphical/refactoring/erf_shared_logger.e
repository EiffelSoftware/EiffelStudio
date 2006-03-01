indexing
	description: "Shared refactoring logger."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_SHARED_LOGGER

feature {NONE}

	logger: ERF_LOGGER is
			-- Get the logger.
		once
			create Result
		end

end
