indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SHARED_EIFNET_DEBUGGER
	
inherit
	EIFNET_EXPORTER

feature -- Access

	Eifnet_debugger: EIFNET_DEBUGGER is
			-- Initialize `Current'.
		once
			create Result.make
		end

end -- class SHARED_EIFNET_DEBUGGER
