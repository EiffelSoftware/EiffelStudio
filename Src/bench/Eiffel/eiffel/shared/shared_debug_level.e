indexing
	description: "Shared debug levels"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_DEBUG_LEVEL 
	
feature {NONE}

	No_debug: DEBUG_NO_I is
		once
			create Result
		end

	Yes_debug: DEBUG_YES_I is
		once
			create Result
		end

end
