indexing
	description: "Objects that represent EV_TEXT_FIELD_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_FIELD_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("return_actions")
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
			Result.extend ("-- Actions to be performed when return key is pressed.")
		end
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `string_handler'. If no `adding' then `wipe_out' `action_sequence'.
		local
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			text_field: EV_TEXT_FIELD
		do
			text_field ?= object
			check
				text_field_not_void: text_field /= Void
			end
			if action_sequence.is_equal ("return_actions") then
				if adding then
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					text_field.return_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					text_field.return_actions.wipe_out
				end
			end
			
		end

end -- class GB_EV_TEXT_FIELD_ACTION_SEQUENCES
