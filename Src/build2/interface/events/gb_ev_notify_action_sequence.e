indexing
	description: "Objects that represent EV_NOTIFY_ACTION_SEQUENCE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_NOTIFY_ACTION_SEQUENCE
	
inherit
	GB_EV_ACTION_SEQUENCE
		redefine
			display_agent
		end
		

feature -- Access

	argument_types: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
		end
	
	argument_names: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
		end
		
	display_agent (name: STRING; textable: EV_TEXTABLE): PROCEDURE [ANY, TUPLE []] is
			-- `Result' is agent which will display all arguments passed to an 
			-- action sequence represented by `Current', using name `name' and
			-- outputs to `textable'.
		require
			textable_not_void: textable /= Void
			name_not_void_or_empty: name /= Void and not name.is_empty
		do
			Result := agent output_agent2 (name, textable)
		ensure
			Result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	output_agent2 (name: STRING; textable: EV_TEXTABLE) is
			--
		do
			textable.set_text (name + " fired.")
		end

end -- class GB_EV_NOTIFY_ACTION_SEQUENCE
