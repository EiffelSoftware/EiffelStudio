indexing
	description: "Objects that represent a Vision2 action sequence class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ACTION_SEQUENCE

feature -- Access

	count: INTEGER is
			-- Number of arguments
		do
			Result := argument_types.count
		end
		
	argument_types: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		deferred
		end

	argument_names: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		deferred
		end

end -- class GB_EV_ACTION_SEQUENCE
