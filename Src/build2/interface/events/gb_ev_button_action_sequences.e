indexing
	description: "Objects that represent EV_BUTTON_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_BUTTON_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("select_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when button is pressed then released.")
		end
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `string_handler'. If no `adding' then `wipe_out' `action_sequence'.
		
		local
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			button: EV_BUTTON
		do
			button ?= object
			check
				button_not_void: button /= Void
			end
			if action_sequence.is_equal ("select_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					button.select_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					button.select_actions.wipe_out
				end
			end
		end

end -- class GB_EV_BUTTON_ACTION_SEQUENCES

