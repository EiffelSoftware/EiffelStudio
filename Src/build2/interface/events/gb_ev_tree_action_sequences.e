indexing
	description: "Objects that represent EV_TREE_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TREE_ACTION_SEQUENCES
	
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
			Result.extend ("-- Actions to be performed when a tree item is selected.")
			Result.extend ("-- Actions to be performed when a tree item is deselected.")
		end
		
	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of 
			-- action sequence and all arguments in `textable'. If no `adding' then `remove_only_added' `action_sequence'.
		local
			notify_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			tree: EV_TREE
		do
			tree ?= widget
			check
				tree_not_void: tree /= Void
			end
			if action_sequence.is_equal (names @ 1) then
				if adding then
					create notify_sequence
					tree.select_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (tree.select_actions)
				end
			elseif action_sequence.is_equal (names @ 2) then
				if adding then
					create notify_sequence
					tree.select_actions.extend (notify_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (tree.select_actions)
				end
			end	
		end

end -- class GB_EV_TREE_ACTION_SEQUENCES


