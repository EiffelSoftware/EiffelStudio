indexing
	description: "Objects that represent EV_GAUGE_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_GAUGE_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("change_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_VALUE_CHANGE_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when `value' changes.")
		end

end -- class GB_EV_GAUGE_ACTION_SEQUENCES
