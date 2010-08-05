note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_SHARED_PREFERENCES


feature -- Access

	preferences: SVN_PREFERENCES
		once
			create Result
		end

end
