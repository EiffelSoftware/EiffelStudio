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
			Result := argument_type.count
		end
		
	argument_type: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		deferred
		end

	argument_name: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		deferred
		end

end -- class GB_EV_ACTION_SEQUENCE
