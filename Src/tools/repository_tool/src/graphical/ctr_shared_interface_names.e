note
	description: "Summary description for {CTR_SHARED_INTERFACE_NAMES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_SHARED_INTERFACE_NAMES

feature -- Access

	names: CTR_INTERFACE_NAMES
		once
			create Result
		end

end
