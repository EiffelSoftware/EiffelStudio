indexing
	description: "Objects that represent EV_DRAWING_AREA_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_DRAWING_AREA_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("expose_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_GEOMETRY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when an area needs to be redrawn.")
		end
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; textable: EV_TEXTABLE) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		local
			geometry_sequence: GB_EV_GEOMETRY_ACTION_SEQUENCE
			drawing_area: EV_DRAWING_AREA
		do
			drawing_area ?= object
			check
				drawing_area_not_void: drawing_area /= Void
			end
			if action_sequence.is_equal ("expose_actions") then
				if adding then
					geometry_sequence ?= new_instance_of (dynamic_type_from_string ("GB_EV_GEOMETRY_ACTION_SEQUENCE"))
					drawing_area.expose_actions.extend (geometry_sequence.display_agent (action_sequence, textable))
				else
					drawing_area.expose_actions.wipe_out
				end
			end
		end

end -- class GB_EV_DRAWING_AREA_ACTION_SEQUENCES

