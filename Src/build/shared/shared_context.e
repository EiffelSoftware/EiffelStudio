indexing
	description: "Shared lists of created windows and groups."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_CONTEXT 
	
feature {NONE}

	Shared_window_list: LINKED_LIST [WINDOW_C] is
			-- list of windows
		once
			!!Result.make
		end;

	Shared_group_list: LINKED_LIST [GROUP] is
			-- list of groups
        once
            !!Result.make
        end;

end -- class SHARED_CONTEXT

