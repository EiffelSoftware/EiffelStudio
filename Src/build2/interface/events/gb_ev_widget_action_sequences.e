indexing
	description: "Objects that represent EV_WIDGET_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET_ACTION_SEQUENCES
	
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
			Result.extend ("pointer_button_release_actions")
			Result.extend ("pointer_enter_actions")
			Result.extend ("pointer_leave_actions")
			Result.extend ("key_press_actions")
			Result.extend ("key_press_string_actions")
			Result.extend ("key_release_actions")
			Result.extend ("focus_in_actions")
			Result.extend ("focus_out_actions")
			Result.extend ("resize_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_POINTER_MOTION_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_KEY_ACTION_SEQUENCE")
			Result.extend ("EV_KEY_STRING_ACTION_SEQUENCE")
			Result.extend ("EV_KEY_ACTION_SEQUENCE")
			Result.extend ("EV_FOCUS_ACTION_SEQUENCE")
			Result.extend ("EV_FOCUS_ACTION_SEQUENCE")
			Result.extend ("EV_GEOMETRY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when screen pointer moves.")
			Result.extend ("-- Actions to be performed when screen pointer button is pressed.")
			Result.extend ("-- Actions to be performed when screen pointer is double clicked.")
			Result.extend ("-- Actions to be performed when screen pointer button is released.")
			Result.extend ("-- Actions to be performed when screen pointer enters widget.")
			Result.extend ("-- Actions to be performed when screen pointer leaves widget.")
			Result.extend ("-- Actions to be performed when a keyboard key is pressed.")
			Result.extend ("-- Actions to be performed when a keyboard press generates a displayable character.")
			Result.extend ("-- Actions to be performed when a keyboard key is released.")
			Result.extend ("-- Actions to be performed when keyboard focus is gained.")
			Result.extend ("-- Actions to be performed when keyboard focus is lost.")
			Result.extend ("-- Actions to be performed when size changes.")
		end

end -- class GB_EV_WIDGET_ACTION_SEQUENCES

