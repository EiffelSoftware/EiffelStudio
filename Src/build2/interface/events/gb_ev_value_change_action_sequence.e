indexing
	description: "Objects that represent EV_VALUE_CHANGE_ACTION_SEQUENCE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_VALUE_CHANGE_ACTION_SEQUENCE
	
inherit
	GB_EV_ACTION_SEQUENCE

feature -- Access

	argument_types: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("INTEGER")
		end
	
	argument_names: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("a_value")
		end

end -- class GB_EV_VALUE_CHANGE_ACTION_SEQUENCE
