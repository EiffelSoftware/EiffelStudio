indexing
	description: "Objects that represent a Vision2 action sequences class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ACTION_SEQUENCES

feature -- Access

	count: INTEGER is
			-- Number of action sequence in Current.
		do
			Result := names.count		
		end
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		deferred
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		deferred
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		deferred
		end
		
invariant
	lists_equal_in_length: (names.count = types.count) and (names.count = comments.count)

end -- class GB_ACTION_SEQUENCES
