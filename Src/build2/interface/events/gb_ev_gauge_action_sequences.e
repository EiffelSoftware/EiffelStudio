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
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; textable: EV_TEXTABLE) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `textable'. If not `adding' then `wipe_out' `action_sequence'.
		local
			value_change_sequence: GB_EV_VALUE_CHANGE_ACTION_SEQUENCE
			gauge: EV_GAUGE
		do
			gauge ?= object
			check
				gauge_not_void: gauge /= Void
			end
			if action_sequence.is_equal ("change_actions") then
				if adding then
					value_change_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_VALUE_CHANGE_ACTION_SEQUENCE"))
					gauge.change_actions.extend (value_change_sequence.display_agent (action_sequence, textable))
				else
					gauge.change_actions.wipe_out
				end
			end
		end

end -- class GB_EV_GAUGE_ACTION_SEQUENCES
