indexing
	description: "Objects that represent EV_GEOMETRY_ACTION_SEQUENCE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_GEOMETRY_ACTION_SEQUENCE
	
inherit
	
	GB_EV_ACTION_SEQUENCE

feature -- Access

	argument_types: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
		end
	
	argument_names: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("a_x")
			Result.extend ("a_y")
			Result.extend ("a_width")
			Result.extend ("a_height")
		end
		
	display_agent (name: STRING;  string_handler: ORDERED_STRING_HANDLER): PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]] is
			-- `Result' is agent which will display all arguments passed to an 
			-- action sequence represented by `Current', using name `name' and
			-- outputs to `string_handler'.
		require
			string_handler_not_void: string_handler /= Void
			name_not_void_or_empty: name /= Void and not name.is_empty
		do
			Result := agent internal_display_agent (?, ?, ?, ?, name, string_handler)
		ensure
			Result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	internal_display_agent (x, y, width, height: INTEGER; name: STRING; string_handler: ORDERED_STRING_HANDLER) is
			-- Display all other arguments of `Current' on `textable', prepended
			-- with `name' fired.
		do
			string_handler.record_string (name + " fired.%Nx : " + x.out + " y : " + y.out + " width : " + width.out + " height : " + height.out)
		end

end -- class GB_EV_GEOMETRY_ACTION_SEQUENCE
