indexing
	description: "Shared strings for the interface"
	author: "i18n Team, ETH Zurich"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_NAMES

feature -- Basic Operations

	names: NAMES is
			-- Strings
		once
			create Result
		end

end
