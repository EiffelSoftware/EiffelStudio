indexing
	description: "Objects that represent EV_TREE_NODE_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TREE_NODE_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("select_actions")
			Result.extend ("deselect_actions")
			Result.extend ("expand_actions")
			Result.extend ("collapse_actions")

		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when selected.")
			Result.extend ("-- Actions to be performed when deselected.")
			Result.extend ("-- Actions to be performed when expanded.")
			Result.extend ("-- Actions to be performed when collapsed.")
		end

end -- class GB_EV_TREE_NODE_ACTION_SEQUENCES
