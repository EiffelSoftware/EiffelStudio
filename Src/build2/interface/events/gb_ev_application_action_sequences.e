indexing
	description: "Objects that represent EV_APPLICATION_ACTION_SEQUENCES."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_APPLICATION_ACTION_SEQUENCES
	
inherit
	
	GB_EV_ACTION_SEQUENCES

feature -- Access
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("post_launch_actions")
			Result.extend ("idle_actions")
			Result.extend ("pick_actions")
			Result.extend ("drop_actions")
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_NOTIFY_ACTION_SEQUENCE")
			Result.extend ("EV_PND_ACTION_SEQUENCE")
			Result.extend ("EV_PND_ACTION_SEQUENCE")
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed just after application `launch'.")
			Result.extend ("-- Actions to be performed when the application is otherwise idle.")
			Result.extend ("-- Actions to be performed when any %"pick%" occurs.")
			Result.extend ("-- Actions to be performed when any %"drop%" occurs.")
		end

end -- class GB_EV_APPLICATION_ACTION_SEQUENCES
