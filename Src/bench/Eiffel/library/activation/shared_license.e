indexing
	description: "Hold information about products license"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LICENSE
	
feature -- Access
	
	license: ACTIVATION_CHECKER is
			-- Information about current license?
		once
			create Result
		end

end -- class SHARED_LICENSE
