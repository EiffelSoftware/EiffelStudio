indexing
	description: "Objects that represent EV_CHECKABLE_LIST_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_CHECKABLE_LIST_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("check_actions")
			Result.extend ("uncheck_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_LIST_ITEM_CHECK_ACTION_SEQUENCE")
			Result.extend ("EV_LIST_ITEM_CHECK_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when item is checked.")
			Result.extend ("-- Actions to be performed when item is unchecked.")
		end
		
	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `wipe_out' `action_sequence'.
		local
			item_check_sequence: GB_EV_LIST_ITEM_CHECK_ACTION_SEQUENCE
			checkable_list: EV_CHECKABLE_LIST
		do
			checkable_list ?= widget
			check
				checkable_list_not_void: checkable_list /= Void
			end
			if action_sequence.is_equal (names @ 1) then
				if adding then
					create item_check_sequence
					checkable_list.check_actions.extend (item_check_sequence.display_agent (action_sequence, string_handler))
				else
					checkable_list.check_actions.wipe_out
				end
			elseif action_sequence.is_equal (names @ 2) then
				if adding then
					create item_check_sequence
					checkable_list.uncheck_actions.extend (item_check_sequence.display_agent (action_sequence, string_handler))
				else
					checkable_list.uncheck_actions.wipe_out
				end
			end	
		end

end -- class GB_EV_CHECKABLE_LIST_ACTION_SEQUENCES
