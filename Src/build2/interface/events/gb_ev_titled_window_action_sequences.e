indexing
	description: "Objects that represent EV_TITLED_WINDOW_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TITLED_WINDOW_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("minimize_actions")
			Result.extend ("maximize_actions")
			Result.extend ("restore_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when window is minimized.")
			Result.extend ("-- Actions to be performed when window is maximized.")
			Result.extend ("-- Actions to be performed when window leaves `maximized' or `minimized' state.")
		end
		
	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `string_handler'. If no `adding' then `wipe_out' `action_sequence'.
		do
			--| FIXME implement
		end

end -- class GB_EV_TITLED_WINDOW_ACTION_SEQUENCES

