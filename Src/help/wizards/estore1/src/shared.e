indexing
	description: "Proxy to shared references"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED

feature -- Access

	db_manager: DATABASE_MANAGER is
		once
			Create Result
		end

end -- class SHARED
