indexing
	description: "Objects that provide access to the command_handler"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_SHARED_COMMAND_HANDLER


inherit
	ANY	
		undefine
			default_create, copy, is_equal
		end
	
feature {NONE} -- Implementation

	command_handler: GB_COMMAND_HANDLER is
			-- `Result' is the GB_COMMAND_HANDLER used by
			-- the system. There should only be one handler.
			-- Any class that needs access, simply inherits from
			-- this class.
		once
			create Result
		end

end -- class GB_ACCESSIBLE_COMMAND_HANDLER
