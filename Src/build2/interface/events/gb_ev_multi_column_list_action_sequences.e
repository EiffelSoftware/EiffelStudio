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

	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `remove_only_added' `action_sequence'.
		local
			multi_column_row_sequence: GB_EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
			column_action_sequence: GB_EV_COLUMN_ACTION_SEQUENCE
			multi_column_list: EV_MULTI_COLUMN_LIST
		do
			multi_column_list ?= widget
			check
				multi_column_list_not_void: multi_column_list /= Void
			end
			if action_sequence.is_equal (names @ 1) then
				if adding then
					create multi_column_row_sequence
					multi_column_list.select_actions.extend (multi_column_row_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (multi_column_list.select_actions)
				end
			elseif action_sequence.is_equal (names @ 2) then
				if adding then
					create multi_column_row_sequence
					multi_column_list.deselect_actions.extend (multi_column_row_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (multi_column_list.deselect_actions)
				end
			elseif action_sequence.is_equal (names @ 3) then
				if adding then
					create column_action_sequence
					multi_column_list.column_title_click_actions.extend (column_action_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (multi_column_list.column_title_click_actions)
				end
			elseif action_sequence.is_equal (names @ 4) then
				if adding then
					create column_action_sequence
					multi_column_list.column_resized_actions.extend (column_action_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (multi_column_list.column_resized_actions)
				end
			end	
		end
		
end -- class GB_EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES
