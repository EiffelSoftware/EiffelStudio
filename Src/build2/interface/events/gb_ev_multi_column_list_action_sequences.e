indexing
	description: "Objects that represent EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("select_actions")
			Result.extend ("deselect_actions")
			Result.extend ("column_title_click_actions")
			Result.extend ("column_resize_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE")
			Result.extend ("EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE")
			Result.extend ("EV_COLUMN_ACTION_SEQUENCE")
			Result.extend ("EV_COLUMN_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when a row is selected.")
			Result.extend ("-- Actions to be performed when a row is deselected.")
			Result.extend ("-- Actions to be performed when a column title is clicked.")
			Result.extend ("-- Actions to be performed when a column is resized.")
		end

	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; textable: EV_TEXTABLE) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		do
			--| FIXME implement
		end
		
end -- class GB_EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES
