indexing
	description: "Objects that provide access to a GB_OBJECT_HANDLER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_OBJECT_HANDLER

feature {NONE} -- Implementation

	object_handler: GB_OBJECT_HANDLER is
			-- `Result' is the GB_OBJECT_HANDLER used by
			-- the system. There should only be one handler.
			-- Any class that needs access, simply inherits from
			-- this class.
		once
			create Result.initialize
		end

end -- class GB_ACCESSIBLE_HANDLER
