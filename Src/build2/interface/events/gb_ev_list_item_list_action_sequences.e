indexing
	description: "Objects that represent EV_LIST_ITEM_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_LIST_ITEM_LIST_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("select_actions")
			Result.extend ("deselect_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when an item is selected.")
			Result.extend ("-- Actions to be performed when an item is deselected.")
		end

	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		local
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			list_item_list: EV_LIST_ITEM_LIST
		do
			list_item_list ?= widget
			check
				list_item_list_not_void: list_item_list /= Void
			end
			if action_sequence.is_equal (names @ 1) then
				if adding then
					create notify_sequence
					list_item_list.select_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					list_item_list.select_actions.wipe_out
				end
			elseif action_sequence.is_equal (names @ 2) then
				if adding then
					create notify_sequence
					list_item_list.select_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					list_item_list.select_actions.wipe_out
				end
			end	
		end

end -- class GB_EV_LIST_ITEM_LIST_ACTION_SEQUENCES
