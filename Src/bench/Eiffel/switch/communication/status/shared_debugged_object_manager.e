indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SHARED_DEBUGGED_OBJECT_MANAGER

feature {NONE} -- Access

	Debugged_object_manager: DEBUGGED_OBJECT_MANAGER is
		once
			create Result.make
		end

end
