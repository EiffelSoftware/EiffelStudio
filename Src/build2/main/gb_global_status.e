indexing
	description: "Objects that provide global access to the updating of the projects modified status."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GLOBAL_STATUS
	
inherit
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end

end -- class GB_GLOBAL_STATUS
