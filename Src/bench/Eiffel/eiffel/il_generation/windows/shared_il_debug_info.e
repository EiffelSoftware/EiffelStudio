indexing
	description: "Info shared by all IL_DEBUG_INFO_XYZ objects"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_DEBUG_INFO

feature {NONE}

	Il_debug_info: IL_DEBUG_INFO is
			-- Common information about System used by IL_DEBUG_INFO_XYZ objects
		once
			create Result.make
		end

end
