indexing
	description: "Objects that represent EV_PICK_AND_DROPABLE_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_PICK_AND_DROPABLE_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("pick_actions")
			Result.extend ("pick_ended_actions")
			Result.extend ("conforming_pick_actions")
			Result.extend ("drop_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_PND_START_ACTION_SEQUENCE")
			Result.extend ("EV_PND_FINISHED_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_PND_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when `pebble' is picked up.")
			Result.extend ("-- Actions to be performed when a transport from `Current' ends.")
			Result.extend ("-- Actions to be performed when a pebble that fits here is picked.")
			Result.extend ("-- Actions to be performed when a pebble is dropped here.")
		end
		
	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; textable: EV_TEXTABLE) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		do
			--| FIXME implement
		end

end -- class GB_EV_PICK_AND_DROPABLE_ACTION_SEQUENCES

