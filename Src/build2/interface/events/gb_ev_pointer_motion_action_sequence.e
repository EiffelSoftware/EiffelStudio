indexing
	description: "Objects that represent EV_POINTER_MOTION_ACTION_SEQUENCE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_POINTER_MOTION_ACTION_SEQUENCE
	
inherit
	GB_EV_ACTION_SEQUENCE

feature -- Access

	argument_type: ARRAYED_LIST [STRING] is
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
			Result.extend ("DOUBLE")
			Result.extend ("DOUBLE")
			Result.extend ("DOUBLE")
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
		end
	
	argument_name: ARRAYED_LIST [STRING] is
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("a_x")
			Result.extend ("a_y")
			Result.extend ("a_x_tilt")
			Result.extend ("a_y_tilt")
			Result.extend ("a_pressure")
			Result.extend ("a_screen_x")
			Result.extend ("a_screen_y")
		end

end -- class GB_EV_POINTER_MOTION_ACTION_SEQUENCE
