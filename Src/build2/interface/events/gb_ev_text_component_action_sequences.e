indexing
	description: "Objects that represent EV_TEXT_COMPONENT_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_COMPONENT_ACTION_SEQUENCES
	
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
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when `text' changes.")
		end
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; textable: EV_TEXTABLE) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		local
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			text_component: EV_TEXT_COMPONENT
			spin_button: EV_SPIN_BUTTON
		do
			text_component ?= object
			check
				text_component_not_void: text_component /= Void
			end
			if action_sequence.is_equal ("change_actions") then
				if adding then
					spin_button ?= text_component
					notify_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_NOTIFY_ACTION_SEQUENCE"))
					if spin_button /= Void then
						spin_button.text_change_actions.extend (notify_sequence.display_agent ("text_change_actions", textable))	
					else
						text_component.change_actions.extend (notify_sequence.display_agent (action_sequence, textable))	
					end			
				else
					spin_button ?= text_component
					if spin_button /= Void then
						spin_button.text_change_actions.wipe_out
					else
						text_component.change_actions.wipe_out
					end
				end
			end
		end

end -- class GB_EV_TEXT_COMPONENT_ACTION_SEQUENCES