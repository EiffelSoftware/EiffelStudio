indexing
	description: "Objects that represent EV_KEY_ACTION_SEQUENCE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_KEY_ACTION_SEQUENCE
	
inherit
	GB_EV_ACTION_SEQUENCE

feature -- Access

	argument_types: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_KEY")
		end
	
	argument_names: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("a_key")
		end
		
	display_agent (name: STRING; textable: EV_TEXTABLE): PROCEDURE [ANY, TUPLE [EV_KEY]] is
			-- `Result' is agent which will display all arguments passed to an 
			-- action sequence represented by `Current', using name `name' and
			-- outputs to `textable'.
		require
			textable_not_void: textable /= Void
			name_not_void_or_empty: name /= Void and not name.is_empty
		do
			Result := agent internal_display_agent (?, name, textable)
		ensure
			Result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	internal_display_agent (a_key: EV_KEY; name: STRING; textable: EV_TEXTABLE) is
			-- Display all other arguments of `Current' on `textable', prepended
			-- with `name' fired.
		do
			textable.set_text (name + " fired.%Nkey : " + a_key.out)
		end

end -- class GB_EV_KEY_ACTION_SEQUENCE