indexing
	description: "Objects that represent EV_NOTIFY_ACTION_SEQUENCE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_NOTIFY_ACTION_SEQUENCE
	
inherit
	GB_EV_ACTION_SEQUENCE

feature -- Access

	argument_type: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
		end
	
	argument_name: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
		end

end -- class GB_EV_NOTIFY_ACTION_SEQUENCE
