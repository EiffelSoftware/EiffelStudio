indexing
	description: "Objects that represent EV_ITEM_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_ITEM_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("pointer_motion_actions")
			Result.extend ("pointer_button_press_actions")
			Result.extend ("pointer_double_press_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_POINTER_MOTION_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when screen pointer moves.")
			Result.extend ("-- Actions to be performed when screen pointer button is pressed.")
			Result.extend ("-- Actions to be performed when screen pointer is double clicked.")
		end

end -- class GB_EV_ITEM_ACTION_SEQUENCES
