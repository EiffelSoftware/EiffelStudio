indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ICOR_OBJECTS_MANAGER

feature {NONE} -- Initialization

	Icor_objects_manager: ICOR_OBJECTS_MANAGER is
		once
			create Result.make
		end
		
end -- class SHARED_ICOR_OBJECTS_MANAGER
