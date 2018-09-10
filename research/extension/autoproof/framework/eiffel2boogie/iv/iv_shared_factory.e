note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_SHARED_FACTORY

feature {NONE} -- Access

	factory: IV_FACTORY
			-- Shared entities.
		once
			create Result
		end

end
